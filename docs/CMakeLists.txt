find_package (Sphinx REQUIRED)

set (SPHINX_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/_build")
 
set (SPHINX_CACHE_DIR "${CMAKE_CURRENT_BINARY_DIR}/_doctrees")
 
set (SPHINX_HTML_DIR "${SPHINX_BUILD_DIR}/html")
 
configure_file (
    "${CMAKE_CURRENT_SOURCE_DIR}/conf.py.in"
    "${SPHINX_BUILD_DIR}/conf.py"
    @ONLY)
 
add_custom_target(docs_html ALL
    ${SPHINX_EXECUTABLE}
        -q -b html
        -c "${SPHINX_BUILD_DIR}"
        -d "${SPHINX_CACHE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}"
        "${SPHINX_HTML_DIR}"
    COMMENT "Building HTML documentation with Sphinx")
