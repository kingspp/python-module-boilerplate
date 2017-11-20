# -*- coding: utf-8 -*-
"""
| **@created on:** 09/08/17,
| **@author:** prathyushsp,
| **@version:** v0.0.1
|
| **Description:**
| 
|
| **Sphinx Documentation Status:** Complete
|
..todo::
    --
"""

from typeguard import typechecked
from collections import OrderedDict
import os
from typing import Union
import logging
import json
from . import setup_logging
from module import Singleton
from module import string_constants as constants

logger = logging.getLogger(__name__)


class CommonConfig(object):
    """
    | **@author:** Prathyush SP
    | Common Configuration
    """

    # todo: Prathyush SP: Convert keys to string constants
    @typechecked
    def __init__(self, common_config: dict):
        try:

            self.LOG_LEVEL = common_config['log_level']
            self.PATH_LOG = common_config['path']['logs']
            self._GLOBAL_LOGGING_CONFIG_FILE_PATH = os.path.join("/".join(__file__.split('/')[:-1]), 'config',
                                                                 'module_logging.yaml')
            self.PYTHON_OPTIMISE = common_config['python_optimise']
            os.environ['PYTHONOPTIMIZE'] = str(self.PYTHON_OPTIMISE)
        except KeyError as ke:
            raise Exception('Key Error. Config Error', ke)


class MetadataConfig(object):
    """
    | **@author:** Prathyush SP
    |
    | Metadata Configuration Manager
    """

    @typechecked
    def __init__(self, metadata_config: Union[dict, OrderedDict]):
        self.METADATA = metadata_config


class ConfigManager(metaclass=Singleton):
    """
    | **@author:** Prathyush SP
    |
    | DL Configuration Manager
    """

    @typechecked
    def __init__(self, config_file_path: str):
        # todo: Test Support for multiple dl frameworks
        global MODULE_CONFIG_DATA
        try:
            MODULE_CONFIG_DATA = json.load(open(config_file_path), object_pairs_hook=OrderedDict)
        except Exception as e:
            logger.critical(
                'Configuration file path error. Please provide configuration file path: {}'.format(config_file_path))
            raise Exception(
                'Configuration file path error. Please provide configuration file path: ' + config_file_path, e)
        try:
            self.CommonConfig = CommonConfig(MODULE_CONFIG_DATA['common_config'])
            self.MetadataConfig = MetadataConfig(MODULE_CONFIG_DATA['metadata_config'])
        except KeyError as ke:
            raise Exception('Key not found. ', ke)

    def get_config_manager(self):
        """
        | **@author:** Prathyush SP
        |
        | Get Configuration Manager
        :return: Configuration Manager
        """
        return self

    @typechecked
    def update_config_manager(self, config_file_path: str):
        """
        | **@author:** Prathyush SP
        |
        | Update Configuration Manager
        :param config_file_path: Configuration file path
        """
        logger.info("Updating Module Configuration - Config File: {}".format(config_file_path))
        self.__init__(config_file_path=config_file_path)

    def update_logging_config_manager(self, config_file_path: str):
        """
        | **@author:** Prathyush SP
        |
        | Update Logging Configuration
        :param config_file_path: Configuration file path
        """
        logger.info("Updating Library Logging configuration - Config File:{}".format(config_file_path))
        setup_logging(default_path=config_file_path)
        self.CommonConfig._GLOBAL_LOGGING_CONFIG_FILE_PATH = config_file_path


ConfigPath = os.path.join("/".join(__file__.split('/')[:-1]), 'config', 'module_config.json')
MODULE_CONFIG = ConfigManager(config_file_path=ConfigPath).get_config_manager()
MODULE_CONFIG_DATA = OrderedDict()
