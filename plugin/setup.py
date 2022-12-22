from setuptools import setup

setup(
    name='edpm_plugin',
    version='1.0.0',
    py_modules=['edpm_plugin'],
    entry_points={
        'ansible.plugins.inventory': [
            'edpm_plugin = edpm_plugin:EdpmComputeInventory',
        ],
    },
)
