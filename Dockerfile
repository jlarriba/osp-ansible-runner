FROM quay.rdoproject.org/tripleomastercentos9/openstack-tripleo-ansible-ee:b979b304ce5b7f7c85e20db171281a9f

WORKDIR /runner

USER root

# Make Ansible happy with arbitrary UID/GID in OpenShift.
RUN chmod g=u /etc/passwd /etc/group

USER 1001

ADD test.yaml ./project
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
