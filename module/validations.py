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
import re
from typeguard import typechecked

NAME_REGEX = re.compile('^[A-Za-z0-9_]*$', )


@typechecked
def validate_name(name: str) -> str:
    """
    | **@author:** Prathyush SP
    |
    | Name Validation
    :param name: Name
    :return: String
    """
    if not name == '' and NAME_REGEX.match(name):
        return name
    else:
        raise NameError('Name Exception:  {}  - Supports Alphabets, Numbers and _'.format(name))