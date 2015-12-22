Bindings for libsmartcols
=========================

Building
--------

```
$ mkdir build
$ cd build
$ cmake ../ -G Ninja
$ ninja-build
```

Add one of options to build specific languages:
* Python: `-DENABLE_PYTHON=ON`
* Perl: `-DENABLE_PERL=ON`
* Lua: `-DENABLE_LUA=ON`

Forcing python version: `-DPythonLibs_FIND_VERSION=2 -DPythonLibs_FIND_VERSION_MAJOR=2`

To init libsmartcols debug when loading module, add: `-DCMAKE_BUILD_TYPE=Debug`

Running examples
----------------

* Python: `PYTHONPATH=build/python/ python3 example.py`
* Perl: `PERL5LIB=build/perl/ perl example.pl`
* Lua: `LUA_CPATH="$(lua -e 'print(package.cpath)');build/lua/?.so" lua example.lua`
