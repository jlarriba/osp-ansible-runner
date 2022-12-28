FROM quay.io/tripleomastercentos9/openstack-tripleo-ansible-ee:current-tripleo

USER root

# Test
ADD plugin/ ./plugin
ADD ping.yaml ./project

USER root
RUN chmod -R 777 /usr/share/ansible
RUN chmod +x /runner/plugin/edpm_plugin.py
ADD entrypoint.sh /bin/tripleo_entrypoint
RUN chmod +x /bin/tripleo_entrypoint
USER 1001
