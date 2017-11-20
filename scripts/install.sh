#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Install Library
'

function check_install(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Check Installation
'
    echo "Verifying Installation . . ."
    install_state=1
    case $1 in
    "dev") log exec_python "$check_dev_install_script";;
    "prod") log exec_python "$check_prod_install_script";;
    *) echo "Check Install Error"; script_error ;;
    esac
    script_fail ${python_exec_val} 'Installation verification failed . . .'
    cd ~ && log ${PYTHON_COMMAND} -c "import module"; script_fail ${python_exec_val} $? 'Failed to import MODULE'
    script_success
}

function install_dev(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Development Install - PIP Install
'
    echo "Development Install"
    echo "Updating Resources . . ."
    echo "Verifying the build . . ." && log ${PYTHON_COMMAND} -c "import module"; script_fail $? 'Package Verification failed . . .'
    echo "Purging previous versions . . ." && log uninstall_all
    log cd ${SCRIPT_PATH} && exec_python "$pip_delete_script"; script_fail $?
    echo "Installing Library . . ."
    cd .. && log sudo ${PYTHON_PIP} install -e ${PACKAGE_NAME}
    check_install "dev"
}

function install_prod(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Production Install - Cythonized Encrypted Installation - Manual Install
'
    echo "Production Install"
    echo "Updating Resources . . ."
    echo "Verifying the build . . ."
    log ${PYTHON_COMMAND} ${PACKAGE_NAME}/__init__.py
    echo "Purging previous versions . . ." && log uninstall_all
    log cd ${SCRIPT_PATH} && exec_python "$pip_delete_script"; script_fail $1
    sudo rm -rf /tmp/${PROJECT_NAME}
    mkdir /tmp/${PROJECT_NAME}
    cp -r * /tmp/${PROJECT_NAME}
    cd /tmp/${PROJECT_NAME}
    echo "Compiling Library files . . ."
    cd ${PACKAGE_NAME}
    log ${PYTHON_COMMAND} setup.py build_ext --inplace
    echo "Installing Library . . ."
    cd /tmp/${PROJECT_NAME}
    mv ${PROJECT_NAME}/${PACKAGE_NAME} /tmp/${PROJECT_NAME}/tmp_${PACKAGE_NAME}
    sudo rm -rf /tmp/${PROJECT_NAME}/${PACKAGE_NAME}
    mv -f /tmp/${PROJECT_NAME}/tmp_${PACKAGE_NAME} /tmp/${PROJECT_NAME}/${PACKAGE_NAME}
    cd ${SCRIPT_PATH} &&  exec_python "$python_snippet_init_cp"
    cd /tmp/${PROJECT_NAME} && exec_python "$pip_install_script"
    sudo rm -rf /tmp/${PACKAGE_NAME}
    check_install "prod"
}

function install() {
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Installs the library based on configuration
# Supported Configurations:
# 1. dev - Pip install - Hot Code Swapping
# 2. prod - Cythonized Installation - Encrypted
'
    case $1 in
    "dev") install_dev ;;
    "prod") install_prod ;;
    *) script_error ;;
    esac
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi