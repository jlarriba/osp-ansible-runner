FROM quay.rdoproject.org/tripleomastercentos9/openstack-tripleo-ansible-ee:b979b304ce5b7f7c85e20db171281a9f

ADD test.yaml ./project
ADD settings ./env
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
