# osp-ansible-runner
An ansible runner with the tripleo-ansible packages needed by OSP

1. entrypoint uses contents from entrypoint on ansible-runner repo
2. from is image related to tcib yaml file found in tripleo-common, rebuilds container with :current-tripleo
3. You can run podman run -it <image> bash to enter bash shell
4. If you dont add any args then you'll run the default ansible-runner run command 