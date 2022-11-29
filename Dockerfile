FROM quay.io/tripleomastercentos9/openstack-tripleo-ansible-ee:current-tripleo

USER root

ADD test.yaml ./project
ADD entrypoint.sh ./bin/entrypoint.sh

# Base in custom image for ansibleee
ADD playbook.yaml ./project
ADD standalone-playbook.yaml ./project

# Test script 
# ADD ping.yaml ./project

# Inventory plugin specific
# ADD aws_ec2.yml ./inventory
# ADD requirements.txt ./project
# COPY ansible.cfg /etc/ansible/ansible.cfg

# Inventory plugin specific
# ENV AWS_KEY="AKIAWWTVCXECOR57KAW2"
# ENV AWS_SECRET="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"

RUN pip install --upgrade pip

# Inventory plugin specific
# RUN pip install -r ./project/requirements.txt

RUN chmod +x ./bin/entrypoint.sh
USER 1001

ENTRYPOINT ["./bin/entrypoint.sh"]
