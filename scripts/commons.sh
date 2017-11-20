#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Common functions
'


function script_error(){
: '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Script Error
'
    echo "Option Not Supported"
    echo "For more details : ${SCRIPT_NAME} -h" && exit 1
}

function script_fail(){
: '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Script Fail Check
'
    if [[ $1 = 1 ]]; then echo "$2" ; figlet -f slant "Failed"; echo "Check log file or run with DEBUG=true"; exit 1; fi
}

function script_success(){
: '
# @author: Prathyush SP
# @Created on: 21/05/17
# Description: Script Success
'
    figlet -f slant "Success" ; exit 0
}


function log() {
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Logging Function - Supports Debug mode
'
    if ${DEBUG}; then "$@"; else "$@" >> ${MODULE_LOG} 2>&1; fi
}

contains_element() {
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Logging Function - Check if a string exists in bash array
'
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

function write_to_file(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Write string to a file
'
cat <<EOT >> $1
$2
EOT
}

function exec_python(){
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Execute Python snippets
'
python_exec_val=$(
${PYTHON_COMMAND} << END
$1
END
)
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi