#!/bin/bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Command: ./build.sh --install <env name{dev, prod}>
#
# execute python in bash:
# var_name = $(python -c "" 2>&1)
#
# execute bash in python
# import os
# os.system("")
'

############################################################################################################################################################
# Constants
############################################################################################################################################################
DEBUG=true
PYTHON_COMMAND=python3
PYTHON_PIP=pip3
PROJECT_NAME=module
PACKAGE_NAME=module
MODULE_DOCS_PATH=`pwd`/../module-docs/
SCRIPT_PATH=`pwd`
python_exec_val=''
MODULE_LOG=${SCRIPT_PATH}/module.log
SCRIPT_NAME=$(basename "$0")
export PYTHONPATH=$PWD
CURRENT_DATE=`date +%d/%m/%Y`
MODULE_VERSION=`grep -o '"__version__": *"[^"]*"' ${PACKAGE_NAME}/metadata.json  | grep -o '"[^"]*"$' | cut -d '"' -f 2`

function init_scripts(){
: '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Initialize all the scripts [Note: Do not change the source order]
'
    source ${SCRIPT_PATH}/scripts/strings.sh
    source ${SCRIPT_PATH}/scripts/python_snippets.sh
    source ${SCRIPT_PATH}/scripts/usage.sh
    source ${SCRIPT_PATH}/scripts/commons.sh
    source ${SCRIPT_PATH}/scripts/utils.sh
    source ${SCRIPT_PATH}/scripts/docs.sh
    source ${SCRIPT_PATH}/scripts/install.sh
    source ${SCRIPT_PATH}/scripts/uninstall.sh
    source ${SCRIPT_PATH}/scripts/build.sh
    source ${SCRIPT_PATH}/scripts/tests.sh


}
############################################################################################################################################################


############################################################################################################################################################
# Main
############################################################################################################################################################
echo "Initializing scripts . . ." && init_scripts
echo "Checking script dependencies . . ." && check_dependencies


case $1 in
"--install" | "-i") install $2 ;;
"--uninstall" | "-u") uninstall ;;
"--docs" | "-d") generate_docs $@ ;;
"--help" | "-h") usage ;;
"--version"| "-v") echo ${MODULE_VERSION} ;;
"--py") exec_python $2 ;;
"--tests" | "-t") run_tests ;;
"--coverage") run_coverage $2 ;;
"--clean") clean_module ;;
"--stats") run_stats ;;
"--wheel") generate_wheel_dist ;;
"--cython") generate_cython_dist ;;
"--mem") test_memory $2 ;;
"--check-dep") check_dependencies;;
*) script_error ;;
esac
