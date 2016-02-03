set (SWIG_INPUT smartcols.i)
set_source_files_properties (${SWIG_INPUT} PROPERTIES CPLUSPLUS ON)

macro (enable_language LANG LIBRARIES)
  set (target_name bindings_${LANG})
  set (CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/${LANG})
  include_directories (${CMAKE_SOURCE_DIR}/src)
  swig_add_module (${target_name} ${LANG} ${SWIG_INPUT})
  swig_link_libraries (${target_name} ${LIBRARIES} smartcolspp)
  #target_compile_features (${SWIG_MODULE_${target_name}_REAL_NAME} PRIVATE cxx_nonstatic_member_init)
  # ARGV2 is an additional tree output directory (e.g. used in Ruby for customizing module with Ruby code)
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${LANG}/${ARGV2})
endmacro ()

if (ENABLE_PYTHON)
  find_package (PythonLibs REQUIRED)
  find_package (PythonInterp ${PYTHONLIBS_VERSION_STRING} EXACT REQUIRED)
  include_directories (${PYTHON_INCLUDE_PATH})
  execute_process (COMMAND ${PYTHON_EXECUTABLE} -c "from sys import stdout; from distutils import sysconfig; stdout.write(sysconfig.get_python_lib(True))" OUTPUT_VARIABLE PYTHON_INSTALL_DIR)
  message (STATUS "Python installation dir: ${PYTHON_INSTALL_DIR}")

  enable_language (python ${PYTHON_LIBRARIES})
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

  enable_language (perl ${PERL_LIBRARY})
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

  enable_language (lua "${LUA_LIBRARIES}")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES PREFIX "")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${LUA_INSTALL_DIR})
endif (ENABLE_LUA)

if (ENABLE_RUBY)
  find_package (Ruby REQUIRED)
  include_directories (${RUBY_INCLUDE_DIRS})
  set (RUBY_LIB_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}/ruby/vendor_ruby/smartcols)
  set (RUBY_MOD_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/share/ruby/vendor_ruby)
  message (STATUS "Ruby library installation dir: ${RUBY_LIB_INSTALL_DIR}")
  message (STATUS "Ruby module installation dir: ${RUBY_MOD_INSTALL_DIR}")

  enable_language (ruby "${RUBY_LIBRARY}" "smartcols")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES PREFIX "")
  set_target_properties (${SWIG_MODULE_${target_name}_REAL_NAME} PROPERTIES OUTPUT_NAME "smartcols")

  install (TARGETS ${SWIG_MODULE_${target_name}_REAL_NAME}
           DESTINATION ${RUBY_LIB_INSTALL_DIR})
  install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/ruby/smartcols.rb
           DESTINATION ${RUBY_MOD_INSTALL_DIR})
endif (ENABLE_RUBY)
