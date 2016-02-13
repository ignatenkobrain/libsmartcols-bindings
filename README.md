Bindings for libsmartcols
=========================

**DEPRECATED** We wanted to drop dependency from libstdc++ and because we anyway support only Python now it's better to drop usage of SWIG also. [python-smartcols](https://github.com/ignatenkobrain/python-smartcols)

Build Requirements
------------------

* [CMake](https://cmake.org/)
* [SWIG](http://swig.org/)
* C++ compiler (GCC and Clang are tested)

Building and running tests
--------------------------

```
$ mkdir build
$ cd build
$ cmake ../ -G Ninja
$ ninja-build
$ ninja-build test
```

Add option to build bindings for specific language:
* Python: `-DENABLE_PYTHON=ON`

Forcing python version: `-DPythonLibs_FIND_VERSION=2 -DPythonLibs_FIND_VERSION_MAJOR=2`

To init libsmartcols debug when loading module, add: `-DCMAKE_BUILD_TYPE=Debug`

Running examples
----------------

* Python: `PYTHONPATH=build/bindings/python/ python3 examples/example.py`
