# FROM quay.io/ansible/ansible-runner:stable-2.12-devel
FROM quay.rdoproject.org/tripleowallabycentos8/openstack-tripleo-ansible-ee:29ea3eab2a25a68e5f5d3481a23b3671

WORKDIR /runner

USER root

# Make Ansible happy with arbitrary UID/GID in OpenShift.
RUN chmod g=u /etc/passwd /etc/group

USER 1001

ADD test.yaml ./project
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
