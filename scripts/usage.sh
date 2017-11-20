#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Scripts help documentation
'


function usage(){
# Using a here doc with standard out.
figlet -f slant 'Usage:'
cat <<-END
======================================

   -h | --help
     Display Help
   -v | --version
     Display $PACKAGE_NAME Version

   Installation :
   --------------
   ex: ${SCRIPT_NAME} --install dev

   -i | --install [ dev | prod ]
        dev: Installs development version - Hot code swapping support
        prod: Installs production version - Supports Encryption

   Uninstallation :
   ----------------
   ex: ${SCRIPT_NAME} --uninstall

   -u | --uninstall : Uninstalls any installation type

   Documentation :
   ---------------
   ex: ${SCRIPT_NAME} --docs -v -r -p

   --docs [ -o | -r | -v | -p | --skipt-tests ]
        --docs : Generated Sphinx Docmentation
        -o : Opens dcoumentation in a browser
        -r : Starts a server to serve static documentation
        -v : Generates Documentation for each branch and every release - Sphinx Versioning
        -p : Generates Documentation, pdated $PACKAGE_NAME-docs and push to $PACKAGE_NAME-docs repository
        --skip-tests : Skips code coverage and test cases

   Statistics :
   ------------
   ex: ${SCRIPT_NAME} --stats

   --stats : Generate code statistics using cloc util

   Build Wheel Distribution :
   --------------------------
   ex: ${SCRIPT_NAME} --wheel

   --wheel: Creates a whl distribution of the library

   Build Cython Distribution :
   --------------------------
   ex: ${SCRIPT_NAME} --cython

   --cython: Creates a cython distribution of the library

   Nosetests :
   -----------
   ex: ${SCRIPT_NAME} --tests

   --tests: Run test cases using Nose

   Code Coverage :
   ---------------
   ex: ${SCRIPT_NAME} --coverage -o

   --coverage [ -o ]
        --coverage: Run Code Coverage using coverage module
        -o : Open Coverage resutls in a browser

   Clean Module :
   --------------
   ex: ${SCRIPT_NAME} --clean

   --clean: Refactor / Remove temporary files / folder created by build script

   Memory Leak Test :
   ------------------
   ex: ${SCRIPT_NAME} --mem -t -a

   --mem [ -a | -t ]
        -t : Run Memory Leak Test case
        -a : Fetch memory consumed by the Library in Mb

   Check Dependencies :
   --------------------
   ex: ${SCRIPT_NAME} --check-dep

   --check-dep: Check script dependencies.
END

}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi