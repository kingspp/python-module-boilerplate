#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Library Tests
'

function run_tests(){
 : '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Run Nosetests
'
    echo "Running Tests . . ." && log nosetests -s --logging-level=INFO --with-xunit --xunit-file=./tests/nosetests.xml tests
    if [[ $? = 1 ]]; then echo "Test cases failed . . ."; figlet -f slant "Failed"; exit 1; fi
    figlet -f slant "Success"
}


function run_coverage(){
 : '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Run Code Coverage
'
    cd ${SCRIPT_PATH}/docs/
    log nosetests --with-coverage --cover-erase --cover-package=${PACKAGE_NAME} --cover-html --cover-branches -s --logging-level=INFO ${SCRIPT_PATH}'/tests/'
    if [[ $? = 1 ]]; then echo "Test cases failed . . ."; figlet -f slant "Failed"; exit 1; fi
    figlet -f slant "Success"
    if contains_element '-o' "$@"; then
        cd cover && open index.html
    fi
}

function test_memory(){
 : '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Test Memory Utils
'
    if [ "$#" -ne 1 ]; then
        script_error
    fi
    if contains_element '-t' "$@"; then
        nosetests -s --logging-level=INFO tests/test_memory_leak.py
        if [[ $? = 1 ]]; then echo "Test cases failed . . ."; figlet -f slant "Failed"; exit 1; fi
    fi
    if contains_element '-a' "$@"; then
        echo "Calculating Addon Memory . . ."
        exec_python "$addon_mem_check_snippet"
        echo ${python_exec_val}' Mb'
    fi
    figlet -f slant "Success"
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi