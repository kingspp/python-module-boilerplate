#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Python Snippets
'

increment_version_snippet=$"
import json
from collections import OrderedDict
path = '$SCRIPT_PATH/$PACKAGE_NAME/metadata.json'
def increment_version(version: str):
    num = [int(ver) for ver in version.split('.')]
    if num[-1] >= 9:
        num[-1] = 0
        num[-2] += 1
    else:
        num[-1] += 1
    if num[-2] >= 9:
        num[-2] = 0
        num[-3] += 1
    return '.'.join([str(ver) for ver in num])
md = json.load(open(path), object_pairs_hook=OrderedDict)
md['__version__'] = increment_version(md['__version__'])
json.dump(md, open(path, 'w'), indent=2)
"

python_snippet_init_cp=$"
import os
from fnmatch import fnmatch
from shutil import copyfile
patterns = ['*__init__.py', '*.json', '*.yaml', '*metadata.py', '*config_manager.py']
def pattern_match(val):
 for pat in patterns:
    if fnmatch(val, pat):
        return True
 return False
files = [val for val in
         [val for sublist in [[os.path.join(i[0], j) for j in i[2]] for i in os.walk('./$PACKAGE_NAME')] for val in sublist] if pattern_match(val)]
[copyfile(file, '/tmp/$PROJECT_NAME'+file.replace('./','/')) for file in files]"

pip_install_script=$"
import site
import os
package_name = '$PACKAGE_NAME'
path = site.getsitepackages()[0]
os.system('sudo rm -rf  ' + path +'/'+package_name)
os.system('sudo cp -r  $PACKAGE_NAME '+ path)"

pip_delete_script=$"
import site
import os
package_name = '$PACKAGE_NAME'
path = site.getsitepackages()[0]
os.system('sudo rm -rf  ' + path +'/'+package_name)
"

dev_delete_script=$"
import $PACKAGE_NAME, os
path = $PACKAGE_NAME.__path__[0].split('/')
os.system('sudo rm -rf '+ ('/').join(path[:-1])+ '/'+path[-2]+'.egg-info')
"

check_dev_install_script=$"
import glob
import site
if len(glob.glob(site.getsitepackages()[0]+'/$PACKAGE_NAME.egg-link')) >= 1:
    print(0)
else:
    print(1)
"

check_prod_install_script=$"
import glob
import site
import os
if len(glob.glob(site.getsitepackages()[0]+'/$PACKAGE_NAME')) >= 1:
    if any(fname.endswith('.so') for fname in os.listdir(glob.glob(site.getsitepackages()[0]+'/$PACKAGE_NAME/config/')[0])):
        print(0)
    else:
        print(1)
else:
    print(1)
"

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi