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
import logging.config
import os
import yaml
import sys


class ErrorFilter(logging.Filter):
    """
    | **@author:** Prathyush SP
    | Error Filter
    """

    def filter(self, record):
        """
        | Filter Method
        :param record: Record Object
        :return: Boolean
        """
        return record.levelno in [logging.ERROR, logging.CRITICAL]


class InfoFilter(logging.Filter):
    """
    | **@author:** Prathyush SP
    | Info Filter
    """

    def filter(self, record):
        """
        | Filter Method
        :param record: Record Object
        :return: Boolean
        """
        return record.levelno in [logging.INFO, logging.DEBUG, logging.WARN]


def setup_logging(default_path='logging.yaml', default_level=logging.INFO, env_key='LOG_CFG'):
    """
    | **@author:** Prathyush SP
    | Logging Setup
    """
    path = default_path
    value = os.getenv(env_key, None)
    if value:
        path = value
    if os.path.exists(path):
        with open(path, 'rt') as f:
            try:
                config = yaml.safe_load(f.read())
                logging.config.dictConfig(config)
                # todo: Prathyush SP - Enable when coloredlogs package supports filters (https://github.com/xolox/python-coloredlogs/issues/32)
                # coloredlogs.install(fmt=config['formatters']['standard']['format'], stream=sys.stdout,
                #                     level=logging.INFO, logger=logging.getLogger().addFilter(InfoFilter()))
            except Exception as e:
                print('Error in Logging Configuration. Using default configs', e)
                logging.basicConfig(level=default_level, stream=sys.stdout)
                # todo: Prathyush SP - Enable when coloredlogs package supports filters (https://github.com/xolox/python-coloredlogs/issues/32)
                # coloredlogs.install(level=default_level, stream=sys.stdout)
    else:
        logging.basicConfig(level=default_level, stream=sys.stdout)
        # todo: Prathyush SP - Enable when coloredlogs package supports filters (https://github.com/xolox/python-coloredlogs/issues/32)
        # coloredlogs.install(level=default_level, stream=sys.stdout)
        print('Failed to load configuration file. Using default configs')