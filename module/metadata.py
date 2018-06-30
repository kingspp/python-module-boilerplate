# -*- coding: utf-8 -*-
"""
| **@created on:** 29/06/18,
| **@author:** prathyushsp,
| **@version:** v0.0.1
|
| **Description:**
|
|
| **Sphinx Documentation Status:** --
|
..todo::
"""

import json
import munch

metadata = munch.Munch(json.load(open('/'.join(str(__file__).split('/')[:-1]) + '/metadata.json')))
