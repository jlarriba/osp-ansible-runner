#!/usr/bin/env bash

# Adding tripleo ansible-runner specific scripts here
# Expand the variables in settings
eval "echo \"$(cat /runner/env/settings)\"" > /runner/env/settings

if [ -n "$RUNNER_STANDALONE_ROLE" ]; then
    echo "---" > /runner/project/standalone-playbook.yaml
    echo "$RUNNER_STANDALONE_ROLE" >> /runner/project/standalone-playbook.yaml
fi

if [ -n "$RUNNER_INVENTORY" ]; then
    echo "---" > /runner/inventory/inventory.yaml
    echo "$RUNNER_INVENTORY" >> /runner/inventory/inventory.yaml
fi

if [ -n "$RUNNER_PLAYBOOK" ]; then
    echo "---" > /runner/project/playbook.yaml
    echo "$RUNNER_PLAYBOOK" >> /runner/project/playbook.yaml
fi

# MY CODE BELOW
if [ -n "$RUNNER_PLUGIN" ]; then
  # install custom edpm plugin, setup/load edpm_inventory.yaml configmap, define inventory.yaml for plugin
  ansible-galaxy collection install cloudguruab.edpm_plugin
fi

# if any of this business fails, we probably want to fail fast
if [ -n "$EP_DEBUG" ]; then
  set -eux
  echo 'hello from entrypoint'
else
  set -e
fi

# current user might not exist in /etc/passwd at all
if ! $(whoami &> /dev/null) || ! getent passwd $(whoami || id -u) &> /dev/null ; then
  if [ -n "$EP_DEBUG" ]; then
    echo "adding missing uid $(id -u) into /etc/passwd"
  fi
  echo "$(id -u):x:$(id -u):0:container user $(id -u):/home/runner:/bin/bash" >> /etc/passwd
  export HOME=/home/runner
fi

MYHOME=`getent passwd $(whoami) | cut -d: -f6`

if [ "$MYHOME" != "$HOME" ] || [ "$MYHOME" != "/home/runner" ]; then
  if [ -n "$EP_DEBUG" ]; then
    echo "replacing homedir for user $(whoami)"
  fi
  # sed -i wants to create a tempfile next to the original, which won't work with /etc permissions in many cases,
  # so just do it in memory and overwrite the existing file if we succeeded
  NEWPW=$(sed -r "s/(^$(whoami):(.*:){4})(.*:)/\1\/home\/runner:/g" /etc/passwd)
  echo "$NEWPW" > /etc/passwd
  # ensure the envvar matches what we just set in /etc/passwd for this session; future sessions set automatically
  export HOME=/home/runner
fi

if [[ -n "${LAUNCHED_BY_RUNNER}" ]]; then
    # Special actions to be compatible with old ansible-runner versions, 2.1.x specifically
    RUNNER_CALLBACKS=$(python3 -c "from ansible_runner.display_callback.callback import awx_display; print(awx_display.__file__)")
    export ANSIBLE_CALLBACK_PLUGINS="$(dirname $RUNNER_CALLBACKS)"

    # old versions split the callback name between awx_display and minimal, but new version just uses awx_display
    export ANSIBLE_STDOUT_CALLBACK=awx_display
fi

if [[ -d ${AWX_ISOLATED_DATA_DIR} ]]; then
    if output=$(ansible-galaxy collection list --format json 2> /dev/null); then
        echo $output > ${AWX_ISOLATED_DATA_DIR}/collections.json
    fi
    ansible --version 2> /dev/null | head -n 1 > ${AWX_ISOLATED_DATA_DIR}/ansible_version.txt
fi

SCRIPT=/usr/local/bin/dumb-init
# NOTE(pabelanger): Downstream we install dumb-init from RPM.
if [ -f "/usr/bin/dumb-init" ]; then
    SCRIPT=/usr/bin/dumb-init
fi

exec $SCRIPT -- "${@}"