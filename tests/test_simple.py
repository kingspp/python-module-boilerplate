# -*- coding: utf-8 -*-
"""
| **@created on:** 16/12/16,
| **@author:** Prathyush SP,
| **@version:** v0.0.1
|
| **Description:**
| Module Tests
| **Sphinx Documentation Status:** Complete
|
..todo::

"""


import importlib
from nose.tools import *
import nose
from collections import OrderedDict
from nose import with_setup  # optional


def setup_module():
    """
    | **@author:** Prathyush SP
    |
    | Module Setup - Called when this module is initialized - First Call
    """
    pass


def teardown_module():
    """
    | **@author:** Prathyush SP
    |
    | Module Teardown - Called when this module is completed - Last Call
    """
    pass


def my_setup_function():
    """
    | **@author:** Prathyush SP
    |
    | Custom Setup function
    """
    pass


def my_teardown_function():
    """
    | **@author:** Prathyush SP
    |
    | Custom Teardown function
    """
    pass


@with_setup(my_setup_function, my_teardown_function)
def test_simple():
    """
    | **@author:** Prathyush SP
    |
    | Test function utilizing custom setup and teardown
    """
    pass


class TestModule:
    """
    | **@author:** Prathyush SP
    |
    | Model Module Test Cases
    """

    def __init__(self):
        """
        | One time class Initialization
        """
        pass

    def setup(self):
        """
        | **@author:** Prathyush SP
        |
        | Runs before a new method in the class is called
        """
        pass

    def teardown(self):
        """
        | **@author:** Prathyush SP
        |
        | Runs after each method is called
        """
        pass

    @classmethod
    def setup_class(cls):
        """
        | **@author:** Prathyush SP
        |
        | Runs during class initialization
        """
        pass

    @classmethod
    def teardown_class(cls):
        """
        | **@author:** Prathyush SP
        |
        | Runs after class reference is removed / class test cases are completed
        """
        pass

    def test_sample_method(self):
        """
        | **@author:** Prathyush SP
        |
        | Tests Sample Method
        """
        pass

    @raises(Exception)
    def test_sample_method_with_exception(self):
        """
        | **@author:** Prathyush SP
        |
        | Tests sample.py method which throws exception
        """
        raise Exception('Raise Exception')
        pass
