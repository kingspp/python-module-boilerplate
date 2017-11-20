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
from module import Singleton
from collections import OrderedDict
import logging

logger = logging.getLogger(__name__)


class _Store(metaclass=Singleton):
    """
    | **@author:** Prathyush SP
    |
    | Module Store
    """

    def __init__(self):
        self.store = OrderedDict()
        self.meta_data = OrderedDict()

    def initialize(self):
        """
        | **@author:** Prathyush SP
        |
        | Initialize Store
        """
        self.__init__()

    def __repr__(self):
        """
        | **@author:** Prathyush SP
        |
        | Store Object Representation
        :return:
        """
        pass


MODULE_STORE = _Store()
