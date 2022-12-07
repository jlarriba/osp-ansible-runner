FROM quay.io/tripleomastercentos9/openstack-tripleo-ansible-ee:current-tripleo

USER root

ADD test.yaml ./project

USER root
RUN chmod -R 777 /usr/share/ansible
ADD entrypoint.sh /bin/tripleo_entrypoint
RUN chmod +x /bin/tripleo_entrypoint
USER 1001
