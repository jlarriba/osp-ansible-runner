#!/usr/bin/env bash

# Adding tripleo ansible-runner specific scripts here
# Expand the variables in settings
eval "echo \"$(cat /runner/env/settings)\"" > /runner/env/settings

if [ -n "$RUNNER_STANDALONE_ROLE" ]; then
    echo "---" > /runner/project/standalone-playbook.yaml
    echo "$RUNNER_STANDALONE_ROLE" >> /runner/project/standalone-playbook.yaml
fi


# MY CODE BELOW

# NOTE: using this to test image - what we'd set in the operator
# Inventory object
# export RUNNER_INVENTORY="
# plugin: edpm_plugin                    # Name of the plugin
# path_to_inventory: /runner/inventory      # Directory location of CSV
# inventory_file: edpm_inventory.yaml    # Name of the inventory file 
# "

# Config map object
# export RUNNER_EDPM="
# allovercloud:
#   children:
#     overcloud:
#         children:
#           Compute:
#             hosts:
#               # Add additional computes here, and optionally drop localhost.
#               # Add host vars under the host_vars dir.
#               192.168.122.139:
#                 ansible_ssh_user: root
#                 ctlplane_ip: 192.168.24.100
#                 internal_api_ip: 192.168.24.2
#                 tenant_ip: 192.168.24.2
#                 fqdn_internal_api: '{{ ansible_fqdn }}'
#             vars:
#               chrony_ntp_servers:
#                 - clock.redhat.com
#                 - clock2.redhat.com
#               service_net_map:
#                 nova_api_network: internal_api
#                 nova_libvirt_network: internal_api
#               # tripleo_network_config
#               # Default nic config template for a TripleO compute node
#               # These vars are tripleo_network_config role vars
#               tripleo_network_config_template: templates/net_config_bridge.j2
#               tripleo_network_config_hide_sensitive_logs: false
#               #
#               # These vars are for the network config templates themselves and are
#               # considered TripleO network defaults.
#               neutron_physical_bridge_name: br-ex
#               neutron_public_interface_name: eth0
#               ctlplane_subnet_cidr: 24
#               ctlplane_gateway_ip: 192.168.122.1
#               # tripleo_nodes_validation
#               tripleo_nodes_validation_validate_controllers_icmp: false
#               tripleo_nodes_validation_validate_gateway_icmp: false
#               # 99-standalone-vars
#               ctlplane_dns_nameservers:
#               - 192.168.122.1
#               dns_search_domains: []
#               tripleo_nova_compute_DEFAULT_transport_url: rabbit://guest:ar3TXOAYMaznW29fRLj2ILXKs@standalone.ctlplane.localdomain:5672/?ssl=0
#               tripleo_nova_compute_cache_memcache_servers: standalone.ctlplane.localdomain:11211
#               tripleo_nova_compute_cinder_auth_url: http://192.168.24.3:5000/v3
#               tripleo_nova_compute_cinder_password: ip3VDO3mq6JObAQqfekzt85kp
#               tripleo_nova_compute_config_overrides:
#                 DEFAULT:
#                   oslo_messaging_notifications_transport_url: rabbit://guest:ar3TXOAYMaznW29fRLj2ILXKs@standalone.ctlplane.localdomain:5672/?ssl=0
#                   transport_url: rabbit://guest:ar3TXOAYMaznW29fRLj2ILXKs@standalone.ctlplane.localdomain:5672/?ssl=0
#                 cache:
#                   memcache_servers: standalone.ctlplane.localdomain:11211
#                 cinder:
#                   auth_url: http://192.168.24.3:5000/v3
#                   password: ip3VDO3mq6JObAQqfekzt85kp
#                 neutron:
#                   auth_type: v3password
#                   auth_url: http://192.168.24.3:5000/v3
#                   password: viaNg9cyAqS8N1ydQe7n3XkuM
#                   project_domain_name: Default
#                   project_name: service
#                   region_name: regionOne
#                   user_domain_name: Default
#                   username: neutron
#                 placement:
#                   auth_type: password
#                   auth_url: http://192.168.24.3:5000
#                   password: Tnqq58zC6mD9O2jaC8xfiyt3M
#                   project_domain_name: Default
#                   project_name: service
#                   region_name: regionOne
#                   user_domain_name: Default
#                   username: placement
#                   valid_interfaces: internal
#                 service_user:
#                   auth_type: password
#                   auth_url: http://192.168.24.3:5000
#                   password: 59CnvTwMZcJfxCF9NU8bGWrcd
#                   project_domain_name: Default
#                   project_name: service
#                   region_name: regionOne
#                   send_service_user_token: 'True'
#                   user_domain_name: Default
#                   username: nova
#                 vnc:
#                   novncproxy_base_url: http://192.168.24.3:6080
#               tripleo_nova_compute_neutron_auth_type: v3password
#               tripleo_nova_compute_neutron_auth_url: http://192.168.24.3:5000/v3
#               tripleo_nova_compute_neutron_password: viaNg9cyAqS8N1ydQe7n3XkuM
#               tripleo_nova_compute_neutron_project_domain_name: Default
#               tripleo_nova_compute_neutron_project_name: service
#               tripleo_nova_compute_neutron_region_name: regionOne
#               tripleo_nova_compute_neutron_user_domain_name: Default
#               tripleo_nova_compute_neutron_username: neutron
#               tripleo_nova_compute_oslo_messaging_notifications_transport_url: rabbit://guest:ar3TXOAYMaznW29fRLj2ILXKs@standalone.ctlplane.localdomain:5672/?ssl=0
#               tripleo_nova_compute_placement_auth_type: password
#               tripleo_nova_compute_placement_auth_url: http://192.168.24.3:5000
#               tripleo_nova_compute_placement_password: Tnqq58zC6mD9O2jaC8xfiyt3M
#               tripleo_nova_compute_placement_project_domain_name: Default
#               tripleo_nova_compute_placement_project_name: service
#               tripleo_nova_compute_placement_region_name: regionOne
#               tripleo_nova_compute_placement_user_domain_name: Default
#               tripleo_nova_compute_placement_username: placement
#               tripleo_nova_compute_placement_valid_interfaces: internal
#               tripleo_nova_compute_service_user_auth_type: password
#               tripleo_nova_compute_service_user_auth_url: http://192.168.24.3:5000
#               tripleo_nova_compute_service_user_password: 59CnvTwMZcJfxCF9NU8bGWrcd
#               tripleo_nova_compute_service_user_project_domain_name: Default
#               tripleo_nova_compute_service_user_project_name: service
#               tripleo_nova_compute_service_user_region_name: regionOne
#               tripleo_nova_compute_service_user_send_service_user_token: true
#               tripleo_nova_compute_service_user_user_domain_name: Default
#               tripleo_nova_compute_service_user_username: nova
#               tripleo_nova_compute_vnc_novncproxy_base_url: http://192.168.24.3:6080
#               tripleo_ovn_dbs:
#               - 192.168.24.1
#         vars:
#             tripleo_ovn_controller_image: quay.io/tripleomastercentos9/openstack-ovn-controller:current-tripleo
#             gather_facts: false
#             enable_debug: false
#             # SELinux module
#             tripleo_selinux_mode: enforcing
#             undercloud_hosts_entries: []
#             # tripleo_hosts_entries role
#             extra_hosts_entries: []
#             vip_hosts_entries: []
#             hosts_entries: []
#             hosts_entry: []
#             plan: overcloud
# "

if [ -n "$RUNNER_INVENTORY" ]; then
    echo "---" > /runner/inventory/inventory.yaml
    echo "$RUNNER_INVENTORY" >> /runner/inventory/inventory.yaml

    # Add configmap to inventory 
    echo "$RUNNER_EDPM" >> /runner/inventory/edpm_inventory.yaml
fi

if [ -n "$RUNNER_PLAYBOOK" ]; then
    echo "---" > /runner/project/playbook.yaml
    echo "$RUNNER_PLAYBOOK" >> /runner/project/playbook.yaml
fi

# # Plugin object
# export RUNNER_PLUGIN="
# #!/usr/bin/env python3
# from __future__ import (absolute_import, division, print_function)
# __metaclass__ = type

# from ansible.plugins.inventory import BaseInventoryPlugin
# from ansible.errors import AnsibleError, AnsibleParserError

# import os
# import yaml
# import json


# DOCUMENTATION = r'''
#     name: edpm_plugin
#     plugin_type: inventory
#     short_description: Returns Ansible inventory from yaml file.
#     description: Returns Ansible inventory from yaml file.
#     options:
#       plugin:
#           description: Name of the plugin
#           required: true
#           choices: ['edpm_plugin']
#       path_to_inventory:
#         description: Directory location of the yaml edpm inventory
#         required: true
#       inventory_file:
#         description: File name of the yaml inventory file
#         required: true
# '''

# class InventoryModule(BaseInventoryPlugin):
#     NAME = 'edpm_plugin'

#     def __init__(self):
#         self.hosts = []
#         self.vars = {}
#         # super().__init__()
  
#     def verify_file(self, path):
#         valid = True
#         if super(InventoryModule, self).verify_file(path):
#             #base class verifies that file exists 
#             #and is readable by current user
#             if path.endswith(('inventory.yaml',
#                               'inventory.yml', 'edpm_inventory.yaml', 'edpm_inventory.yml')):
#                 valid = True
#         return valid

#     def _get_structured_inventory(self, inventory_file):
    
#         #Initialize a dict
#         # inventory_data = {}
#         # Load the environment variable Running into bug here
#         # env_var = os.environ['RUNNER_INVENTORY']
#         # # Parse the environment variable as YAML
#         # data = yaml.safe_load(env_var)
        
#         # Load the YAML file
#         with open(inventory_file, 'r') as f:
#             data = yaml.safe_load(f)
#         return data

#     def _populate(self):
#         self.inventory_file = self.inv_dir + '/' + self.inv_file
#         self.myinventory = self._get_structured_inventory(self.inventory_file)
        
#         # Recursively traverse the data to find the Compute group
#         def traverse(data):
#             if 'Compute' in data:
#                 return data['Compute']
#             for _, group_data in data.items():
#                 if 'children' in group_data:
#                     compute_group = traverse(group_data['children'])
#                     if compute_group:
#                         return compute_group
#             return None

#         compute_group = traverse(self.myinventory)

#         # Extract the hosts and variables from the Compute group
#         if compute_group:
#             if 'hosts' in compute_group:
#                 for host_name, host_data in compute_group['hosts'].items():
#                     self.hosts.append(host_name)
#                     self.vars[host_name] = host_data
#             if 'vars' in compute_group:
#                 for host_name, host_vars in compute_group['vars'].items():
#                     try:
#                         self.vars[host_name].update(host_vars)
#                     except KeyError:
#                         self.vars[host_name] = host_vars       

#     def parse(self, inventory, loader, path, cache=True):
#         super(InventoryModule, self).parse(inventory, loader, path, cache=True)
#         # Read the inventory YAML file
#         self._read_config_data(path)
#         try:
#             # Store the options from the YAML file
#             self.plugin = self.get_option('plugin')
#             self.inv_dir = self.get_option('path_to_inventory')
#             self.inv_file = self.get_option('inventory_file')
#         except Exception as e:
#             raise AnsibleParserError(
#                 'All correct options required: {}'.format(e))

#         # Call our internal helper to populate the dynamic inventory
#         self._populate()
        
#         self.inventory.add_group('compute')
#         for host_name, host_vars in self.vars.items():
#             if host_name not in self.hosts:
#                 self.inventory.set_variable('compute', host_name, host_vars)
#             else:
#                 self.inventory.add_host(host_name, group='compute')
#                 self.inventory.set_variable(host_name, 'vars', host_vars)
# "

if [ -n "$RUNNER_PLUGIN" ]; then
  # set plugin module path for ansible 
  mkdir plugin
  touch plugin/edpm_plugin.py
  export ANSIBLE_INVENTORY_PLUGINS=/runner/plugin
  echo "$RUNNER_PLUGIN" >> /runner/plugin/edpm_plugin.py
  chmod +x /runner/plugin/edpm_plugin.py
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