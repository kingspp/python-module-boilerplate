# -*- coding: utf-8 -*-
"""
| **@created on:** 17/11/17,
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

import logging

logger = logging.getLogger(__name__)


class SampleError(Exception):
    """
    | **@author:** Prathyush SP
    |
    | Sample Exception
    """

    def __init__(self, message: str, errors=None):
        super(SampleError, self).__init__(message)
        self.errors = errors
