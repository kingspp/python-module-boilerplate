#!/usr/bin/env bash
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Documentation Script
'

function generate_docs() {
: '
# @author: Prathyush SP
# @Created on: 31/12/1
# Description: Generate Sphinx Documentation
'
    cd ${SCRIPT_PATH}
    rm -rf docs/
    echo "Generating sphinx docs . . ." && log export SPHINXBUILD=python3 && log sphinx-apidoc -d 10 -F -H module -A "Prathyush SP"  -V "0.0.1" -R "0.0.1"  -f -o  docs ${PACKAGE_NAME} ./module/setup.py
    script_fail 'Error running sphinx-apidoc'
    rm -rf gitchangelog.rc && touch .gitchangelog.rc
    echo "Fetching changelog . . ." && gitchangelog > docs/changelog.rst; script_fail 'Gitchangelog Error / Not found'
    cd docs
    rm -rf conf.py && write_to_file conf.py "$config_py"
    rm -rf index.rst  && write_to_file index.rst "$index_rst"
    if ! contains_element '--skip-tests' "$@"; then
        echo "Running coverage . . ." && run_coverage
        echo "Collecting file stats . . ." && cloc --md --quiet --exclude-dir=docs,cover --out=cloc.md ../.; script_fail 'cloc error'
        if [[ $? = 1 ]]; then echo "Test Cases Failed . . ."; figlet -f slant "Failed"; exit 1; fi
        stats_rst="$stats_rst"`pandoc --from=markdown --to=rst cloc.md` && rm cloc.md
    fi
    log exec_python $"$addon_mem_check_snippet"
    stats_rst="$stats_rst"$"
    | Memory Footprint: $python_exec_val Mb
    " ; script_fail 'Memory Snippet error'
    write_to_file stats.rst "$stats_rst"
    write_to_file about.rst "$about_rst"
    sed -i.bak -e 's/module package/Documentation/g' module.rst
    `pandoc  --from=markdown --to=rst --output=install.rst ../INSTALL.md`; script_fail 'Pandoc Error'
    `pandoc --from=markdown --to=rst --output=qstart.rst ../README.md` ; script_fail 'Pandoc Error'
    `pandoc --from=markdown --to=rst --output=samples.rst ../SAMPLES.md` ; script_fail 'Pandoc Error'
    `pandoc  --from=markdown --to=rst --output=config.rst ../CONFIG.md`; script_fail 'Pandoc Error'
    `pandoc  --from=markdown --to=rst --output=template.rst ../TEMPLATE.md`; script_fail 'Pandoc Error'
    `pandoc  --from=markdown --to=rst --output=metadata.rst ../METADATA.md`; script_fail 'Pandoc Error'
    if contains_element '-v' "$@"; then
         cd ${SCRIPT_PATH}
         echo "Creating Version and Branch based documentation . . ." && sphinx-versioning  build docs docs/_build/html -r master; script_fail 'Sphinx-Versioning Error / Not found'
    else echo "Generating html files . . ." && log make html
    fi
    if ! contains_element '--skip-tests' "$@"; then
        log mv ${SCRIPT_PATH}/docs/cover ${SCRIPT_PATH}/docs/_build/html/
        log cp -R ${SCRIPT_PATH}/docs/_build/html/cover ${SCRIPT_PATH}/docs/_build/html/master/
    fi
    if contains_element '-p' "$@"; then
        echo "Pushing Updated documentation to to module-docs repository"
        if [ -z ${MODULE_DOCS_PATH+x} ]; then echo "MODULE_DOCS_PATH is unset. Set MODULE_DOCS_PATH"; figlet -f slant "Failed"; exit 1;fi
        if [ -d "$MODULE_DOCS_PATH" ]; then
            rm -rf ${MODULE_DOCS_PATH}/docs
            cp -R ${SCRIPT_PATH}/docs ${MODULE_DOCS_PATH}/
            cd ${MODULE_DOCS_PATH}
            git add -f docs
            git commit -m "Updated Documentation"
            git push ; script_fail 'Unable to push to Github'
            cd ${SCRIPT_PATH}
        fi
    fi
    if contains_element '-r' "$@"; then
        cd ${SCRIPT_PATH}/docs/_build/html/ && open http://localhost:8121
        python -m SimpleHTTPServer 8121
    else
        if contains_element '-o' "$@"; then
            open ${SCRIPT_PATH}/docs/_build/html/index.html
        fi
    fi
    cd ${SCRIPT_PATH}
}

if [ ! "`basename "$0"`" == "module_manager.sh" ]; then
    figlet -f slant "Failed"
    echo "`basename "$0"` is not a standalone script. Please use module_manager.sh script"
fi