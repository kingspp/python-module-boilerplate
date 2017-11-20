#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Library Utils
'

function run_stats(){
 : '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Clean Module
'
    cloc --quiet --exclude-dir=docs,cover .
}

function clean_module(){
 : '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Clean Module
'
    echo "Cleaning $PACKAGE_NAME . . ."
    sudo rm -rf cover docs/_build/* cloc.md .coverage .gitchangelog.rc build about.rst stats.rst
    log sudo find -E . -regex '.*\.(html|out|nosetests|bak|py[co])' -delete
    log sudo find . -type d -name "__pycache__" -delete
    script_fail; figlet -f slant "Success"
}

function check_dependencies(){
: '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Check script dependencies
'
 dependencies=(cloc pandoc figlet)
 for i in "${dependencies[@]}"
    do
        command -v $i >/dev/null 2>&1 || { echo $"ERROR: Missing script dependency - ${i}" >&2; figlet -f slant "Failed"; exit; }
    done
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi