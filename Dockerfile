FROM quay.io/tripleomastercentos9/openstack-tripleo-ansible-ee:current-tripleo

ADD test.yaml ./project
ADD settings ./env
