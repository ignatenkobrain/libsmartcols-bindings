cmake_minimum_required(VERSION 3.4)

project (libsmartcols-bindings CXX)

find_package (PkgConfig REQUIRED)
pkg_check_modules (SCOLS smartcols REQUIRED)
include_directories (${SCOLS_INCLUDE_DIRS})

find_package (SWIG REQUIRED)
include (${SWIG_USE_FILE})

include (CheckSymbolExists)
check_symbol_exists (SCOLS_FL_HIDDEN libmsartcols.h FLAGS_HIDDEN)

set (SWIG_INPUT "${CMAKE_SOURCE_DIR}/smartcols.i")
set_source_files_properties (${SWIG_INPUT} PROPERTIES CPLUSPLUS ON)

foreach (lang "Python"
              "Perl")
  string (TOUPPER "${lang}" LANG)
  option (ENABLE_${LANG} "Enable ${lang} interface" OFF)

  if (ENABLE_${LANG})
    message (STATUS " +++ ${lang} bindings enabled")
  else ()
    message (STATUS " --- ${lang} bindings disabled")
  endif ()
endforeach ()

macro (_enable_language LANG LIBRARIES)
  set (target_name bindings_${LANG})
  set (CMAKE_SWIG_OUTDIR "${CMAKE_BINARY_DIR}/${LANG}")
  swig_add_module (${target_name} ${LANG} ${SWIG_INPUT})
  swig_link_libraries (${target_name} ${LIBRARIES} ${SCOLS_LIBRARIES})
  target_compile_features (${SWIG_MODULE_${target_name}_REAL_NAME} PRIVATE cxx_nonstatic_member_init)
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${LANG}")

  set (_FLAGS CACHE INTERNAL "" FORCE)
  if (FLAGS_HIDDEN)
    set (_FLAGS "${_FLAGS} -DFLAGS_HIDDEN")
  endif ()
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set (_FLAGS "${_FLAGS} -DDEBUG")
  endif ()

  if (NOT _FLAGS STREQUAL "")
    set_source_files_properties (${swig_generated_file_fullname} PROPERTIES COMPILE_FLAGS "${_FLAGS}")
  endif ()
endmacro ()

if (ENABLE_PYTHON)
  find_package (PythonLibs REQUIRED)
  find_package (PythonInterp ${PYTHONLIBS_VERSION_STRING} EXACT REQUIRED)
  include_directories (${PYTHON_INCLUDE_PATH})
  execute_process (COMMAND ${PYTHON_EXECUTABLE} -c "from sys import stdout; from distutils import sysconfig; stdout.write(sysconfig.get_python_lib(True))" OUTPUT_VARIABLE PYTHON_INSTALL_DIR)
  message (STATUS "Python installation dir: ${PYTHON_INSTALL_DIR}")

  _enable_language (python ${PYTHON_LIBRARIES})
  set_target_properties(${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "_smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${PYTHON_INSTALL_DIR})
  install (FILES ${swig_extra_generated_files}
           DESTINATION ${PYTHON_INSTALL_DIR})
endif (ENABLE_PYTHON)

if (ENABLE_PERL)
  find_package (PerlLibs REQUIRED)
  include_directories (${PERL_INCLUDE_PATH})
  message (STATUS "Perl installation dir: ${PERL_VENDORARCH}")

  _enable_language (perl ${PERL_LIBRARY})
  set_target_properties(${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES PREFIX "")
  set_target_properties(${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${PERL_VENDORARCH})
  install (FILES ${swig_extra_generated_files}
           DESTINATION ${PERL_VENDORARCH})
endif (ENABLE_PERL)
