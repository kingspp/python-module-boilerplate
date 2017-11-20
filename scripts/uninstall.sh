#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Uninstall Library
'


function check_uninstall(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Check Uninstallation
'
    export PYTHONPATH=''
    log echo "Verifying Installation . . ."
    install_state=0
    log exec_python "$check_dev_install_script"; log exec_python "$check_prod_install_script"
    install_state=${python_exec_val}
    log echo "install state:" ${install_state}
    if [[ ${install_state} == 0 ]]; then echo "Uninstallation Failed. Run with DEBUG=true"; figlet -f slant "Failed"; exit 1;fi
    cd ~ && log ${PYTHON_COMMAND} -c "import $PACKAGE_NAME"
    if [[ $? = 0 ]]; then echo "Uninstallation Failed" ; figlet -f slant "Failed"; exit 1; fi
    export PYTHONPATH=${SCRIPT_PATH}
}

function uninstall_all(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Uninstalls Dev/Prod Installations
'
    cd ${SCRIPT_PATH}/../ && log sudo ${PYTHON_PIP} uninstall ${PACKAGE_NAME} -y
    cd ${SCRIPT_PATH} && exec_python "$pip_delete_script"
    check_uninstall
}

function uninstall() {
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Uninstalls the library based on configuration
'
    echo "Uninstall"
    log uninstall_all
    script_success
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi