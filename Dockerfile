FROM quay.rdoproject.org/tripleomastercentos9/openstack-tripleo-ansible-ee:71abe3aa5c8ad3da6d894dc93d9c0273

ADD test.yaml ./project
ADD settings ./env
