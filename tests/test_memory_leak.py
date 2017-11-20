# -*- coding: utf-8 -*-
"""
| **@created on:** 17/05/17,
| **@author:** Prathyush SP,
| **@version:** v0.0.1
|
| **Description:**
| DL Module Tests
| **Sphinx Documentation Status:** Complete
|
..todo::

"""


from nose import with_setup  # optional
import logging
from pympler import tracker

memory_tracker = tracker.SummaryTracker()

logger = logging.getLogger(__name__)


def setup_module():
    """
    | **@author:** Prathyush SP
    |
    | DL Module Setup - Called when this module is initialized - First Call
    """
    pass


def teardown_module():
    """
    | **@author:** Prathyush SP
    |
    | DL Module Teardown - Called when this module is completed - Last Call
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


class TestMemoryLeak:
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
        print("*********Running Memory Leak Test Cases . . .*********")

    @classmethod
    def teardown_class(cls):
        """
        | **@author:** Prathyush SP
        |
        | Runs after class reference is removed / class test cases are completed
        """
        print("*********Memory Leak Test Cases completed successfully . . .*********")

    def test_memory_leak(self):
        """
        | **@author:** Prathyush SP
        |
        | Tests Sample Method
        """
        # Add your entire project workflow - Add different workflows to test different scenarious
        logger.info('Testing Memory leak after training and predicting a model . . .')
        memory_tracker.diff()
        memory_tracker.diff()
        memory_tracker.diff()
        assert memory_tracker.diff() == []
