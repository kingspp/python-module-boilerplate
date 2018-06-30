# -*- coding: utf-8 -*-
"""
| **@created on:** 20/05/16,
| **@author:** Prathyush SP,
| **@version:** v0.0.1
|
| **Description:**
| Singleton Class
|
| Sphinx Documentation Status:** Complete
|
..todo::
"""
import os
from module.logging_config_manager import setup_logging
MODULE_PATH = os.path.dirname(os.path.abspath(__file__))

class Singleton(type):
    """
    Singleton Class
    """
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]


# todo: Prathyush SP: Move logging config to logging manager

setup_logging(default_path=os.path.join("/".join(__file__.split('/')[:-1]), 'config', 'module_logging.yaml'))

# todo: Prathyush SP - Debug code breakages due to changing start method
# import multiprocessing
# multiprocessing.context._force_start_method('spawn')

from module.store import MODULE_STORE
from module.config_manager import MODULE_CONFIG, MODULE_CONFIG_DATA
from module.metadata import metadata as md

__version__ = md.__version__

if __name__ == '__main__':
    print('module.__init__ success . . .')
