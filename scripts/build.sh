#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Build Script
'

function generate_wheel_dist(){
 : '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Generate Wheel Distribution
'
    cd ${SCRIPT_PATH} && log sudo ${PYTHON_COMMAND} ./setup.py bdist_wheel; script_fail "Failed to Generate Wheel Distribution"
    figlet -f slant "Success"
}

function generate_cython_dist(){
 : '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Generate Cython Distribution
'
    rm -rf /tmp/${PROJECT_NAME}
    mkdir /tmp/${PROJECT_NAME}
    cp -r * /tmp/${PROJECT_NAME}
    cd /tmp/${PROJECT_NAME}
    echo "Compiling Library files . . ."
    cd ${PACKAGE_NAME}
    log ${PYTHON_COMMAND} setup.py build_ext --inplace
    echo "Installing Library . . ."
    cd /tmp/${PROJECT_NAME}
    mv ${PROJECT_NAME}/${PACKAGE_NAME} /tmp/${PROJECT_NAME}/tmp_${PACKAGE_NAME}
    rm -rf /tmp/${PROJECT_NAME}/${PACKAGE_NAME}
    mv -f /tmp/${PROJECT_NAME}/tmp_${PACKAGE_NAME} /tmp/${PROJECT_NAME}/${PACKAGE_NAME}
    cd ${SCRIPT_PATH} &&  exec_python "$python_snippet_init_cp"
    tmp_dir=/tmp/${PROJECT_NAME}
    mkdir -p ${tmp_dir}/module_package
    cp -r ${tmp_dir}/module requirements.txt ${tmp_dir}/module_package/
    cd ${tmp_dir}/module_package/
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
    tar -cJvf ${SCRIPT_PATH}/dist/module-ct-${MODULE_VERSION}.tar.xz ./*
    rm -rf ${tmp_dir}
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi
