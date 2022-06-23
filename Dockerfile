FROM quay.io/ansible/ansible-runner:stable-2.12-devel

RUN git clone https://opendev.org/openstack/tripleo-ansible.git ./project/tripleo-ansible

ADD test.yaml ./project
