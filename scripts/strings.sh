#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: String Constants
'

config_py=$"#!/usr/bin/env python3.5
# -*- coding: utf-8 -*-
extensions = ['sphinx.ext.autodoc','sphinx_autodoc_typehints','sphinx.ext.todo','sphinx.ext.viewcode','sphinx.ext.coverage']
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
project = '$PACKAGE_NAME'
copyright = '2017, Prathyush SP'
author = 'Prathyush SP'
version = '$MODULE_VERSION'
release = '$MODULE_VERSION'
language = 'en'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store', 'metadata.py', '*setup.*']
pygments_style = 'sphinx'
todo_include_todos = True
html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
htmlhelp_basename = '$PACKAGE_NAMEdoc'
latex_elements = {}
latex_documents = [(master_doc, '$PACKAGE_NAME.tex', '$PACKAGE_NAME Documentation','Prathyush SP', 'manual'),]
man_pages = [(master_doc, '$PACKAGE_NAME', '$PACKAGE_NAME Documentation',[author], 1)]
texinfo_documents = [(master_doc, '$PACKAGE_NAME', '$PACKAGE_NAME Documentation',author, '$PACKAGE_NAME', 'One line description of project.','Miscellaneous'),]
epub_title = project
epub_author = author
epub_publisher = author
epub_copyright = copyright
epub_exclude_files = ['search.html']
autoclass_content = 'both'"

description_install=$'Command: Install
Used to install $PACKAGE_NAME Library
Supports two modes:
1. dev (development) - Creates Egg Link to the current path. The Library is not installed to the dist-utils of Python. Supports Bleeding edge release and testing
2. prod (production) - Converts the python files to so libs and installs in the dist-utils of Python
Usage: build --install <dev/prod>'

description_help=$'Command: Help
Displays Utility Help
Usage: build --help <command_name>'

index_rst=$".. $PACKAGE_NAME documentation master file, created by
   sphinx-quickstart on Wed Dec 21 16:07:28 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root \`toctree\` directive.

Welcome to $PACKAGE_NAME's documentation!
=================================

.. toctree::
   :maxdepth: 10
   :caption: Contents:

   qstart
   install
   config
   $PACKAGE_NAME
   template
   metadata
   samples
   changelog
   Coverage <cover/index.html#http://>
   stats
   Issues <https://github.com/{organization}/{module_name}/issues?q=is%3Aopen+is%3Aissue+label%3Abug>
   Todo <https://github.com/{organization}/{module_name}/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement>
   about


Indices and tables
==================

* :ref:\`genindex\`
* :ref:\`modindex\`
* :ref:\`search\`
"

about_rst=$"
About
=========

:Author: Prathyush SP
:Version: '$MODULE_VERSION' on $CURRENT_DATE
:Github: https://github.com/{organization}/{module_name}
|
| Developers:
| 1. Terry . .
| 2. David . .
|
|
"

stats_rst=$"
Library Stats
=============

"

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi