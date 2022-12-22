import os
import yaml
from ansible.plugins.inventory.base import BaseInventoryPlugin

class EdpmComputeInventory(BaseInventoryPlugin):
    NAME = 'edpm-compute'

    def __init__(self):
        self.hosts = []
        self.vars = {}

    def parse(self, inventory, loader, path, cache=True):
        super().__init__()

        # Load the environment variable
        env_var = os.environ['RUNNER_INVENTORY']

        # Parse the environment variable as YAML
        data = yaml.safe_load(env_var)

        # Recursively traverse the data to find the Compute group
        def traverse(data):
            if 'Compute' in data:
                return data['Compute']
            for _, group_data in data.items():
                if 'children' in group_data:
                    compute_group = traverse(group_data['children'])
                    if compute_group:
                        return compute_group
            return None

        compute_group = traverse(data)

        # Extract the hosts and variables from the Compute group
        if compute_group:
            if 'hosts' in compute_group:
                for host_name, host_data in compute_group['hosts'].items():
                    self.hosts.append(host_name)
                    self.vars[host_name] = host_data
            if 'vars' in compute_group:
                for host_name, host_vars in compute_group['vars'].items():
                    self.vars[host_name].update(host_vars)
