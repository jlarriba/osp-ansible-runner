# FROM quay.io/ansible/ansible-runner:stable-2.12-devel
FROM quay.rdoproject.org/tripleowallabycentos8/openstack-tripleo-ansible-ee:9665eae6a3f77672883c91efc7d5fa08

WORKDIR /runner

ADD test.yaml ./project
