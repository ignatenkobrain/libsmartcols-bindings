cmake_minimum_required (VERSION 3.4)

project (libsmartcols-bindings CXX)

foreach (lang "Python"
              "Perl"
              "Lua")
  string (TOUPPER "${lang}" LANG)
  option (ENABLE_${LANG} "Enable ${lang} interface" OFF)

  if (ENABLE_${LANG})
    message (STATUS " +++ ${lang} bindings enabled")
  else ()
    message (STATUS " --- ${lang} bindings disabled")
  endif ()
endforeach ()

find_package (PkgConfig REQUIRED)
pkg_check_modules (SCOLS smartcols REQUIRED)
include_directories (${SCOLS_INCLUDE_DIRS})

find_package (SWIG REQUIRED)
include (${SWIG_USE_FILE})

include (CheckSymbolExists)
check_symbol_exists (SCOLS_FL_HIDDEN libmsartcols.h FLAGS_HIDDEN)

set (SWIG_INPUT "${CMAKE_SOURCE_DIR}/smartcols.i")
set_source_files_properties (${SWIG_INPUT} PROPERTIES CPLUSPLUS ON)

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
  # We need to have some hack till 2.28, otherwise program will crash sometimes
  # https://github.com/karelzak/util-linux/commit/5e8461a53a11b2ed4d4e14a9e912bfad02cb7287
  pkg_check_modules (_SCOLS_OLDSTREAM smartcols>=2.28 QUIET)
  if (NOT _SCOLS_OLDSTREAM_FOUND)
    set (_FLAGS "${_FLAGS} -DOLDSTREAM_HACK")
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
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "_smartcols")

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
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES PREFIX "")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${PERL_VENDORARCH})
  install (FILES ${swig_extra_generated_files}
           DESTINATION ${PERL_VENDORARCH})
endif (ENABLE_PERL)

if (ENABLE_LUA)
  find_package (Lua REQUIRED)
  include_directories (${LUA_INCLUDE_DIR})
  set (LUA_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR})
  message (STATUS "Lua installation dir: ${LUA_INSTALL_DIR}")

  _enable_language (lua "${LUA_LIBRARIES}")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES PREFIX "")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${LUA_INSTALL_DIR})
endif (ENABLE_LUA)
