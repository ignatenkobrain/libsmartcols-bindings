if (ENABLE_PYTHON)
  add_test (test_python ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/test_smartcols.py)
  set_tests_properties (test_python PROPERTIES ENVIRONMENT "PYTHONPATH=${CMAKE_BINARY_DIR}/bindings/python")
endif ()
