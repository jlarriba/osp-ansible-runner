FROM quay.io/tripleomastercentos9/openstack-tripleo-ansible-ee:current-tripleo

USER root

ADD plugin/ ./plugin
ADD ping.yaml ./plugin

# ADD custom-inventory-plugin/ ./csv_plugin
# ADD custom-inventory-plugin/csv_inventory/myinventory.csv ./inventory
# ADD custom-inventory-plugin/inventory_plugins/my_csv_plugin.py ./inventory
# ADD custom-inventory-plugin/csv_inventory.yaml ./inventory
# ADD custom-inventory-plugin/playbook.yaml ./project


USER root
RUN chmod -R 777 /usr/share/ansible
RUN chmod +x ./plugin/edpm_plugin.py
ADD entrypoint.sh /bin/tripleo_entrypoint
RUN chmod +x /bin/tripleo_entrypoint
USER 1001
