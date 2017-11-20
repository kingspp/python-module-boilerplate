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
import os
from distutils.core import setup
from fnmatch import fnmatch
from Cython.Build import cythonize

from module import metadata as md

if __name__ == '__main__':
    pattern = "*.py"
    files = [val for val in
             [val for sublist in [[os.path.join(i[0], j) for j in i[2]] for i in os.walk('./')] for val in sublist] if
             fnmatch(val, pattern)]
    files = [file for file in files if not (file.__contains__('__init__.py') or (file.__contains__('metadata.py')) or
                                            (file.__contains__('config_manager.py')) or
                                            (file.__contains__('logging_config_manager.py')))]
    setup(
        name=md.__name__,
        ext_modules=cythonize(files),
    )
