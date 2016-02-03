cmake_minimum_required (VERSION 3.0)

project (libsmartcols-bindings VERSION 0.0.2 LANGUAGES CXX)
set (CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

foreach (lang "Python")
  string (TOUPPER "${lang}" LANG)
  option (ENABLE_${LANG} "Enable ${lang} interface" ON)

  if (ENABLE_${LANG})
    message (STATUS " +++ ${lang} bindings enabled")
  else ()
    message (STATUS " --- ${lang} bindings disabled")
  endif ()
endforeach ()
option (BUILD_DOCS "Build documentation" ON)

find_package (PkgConfig REQUIRED)
pkg_check_modules (SCOLS smartcols REQUIRED)
include_directories (${SCOLS_INCLUDE_DIRS})

add_subdirectory (src)

find_package (SWIG REQUIRED)
include (${SWIG_USE_FILE})

add_subdirectory (bindings)

if (BUILD_DOCS)
  add_subdirectory (docs)
endif (BUILD_DOCS)

enable_testing ()
add_subdirectory (tests)
