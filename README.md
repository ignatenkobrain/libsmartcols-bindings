Bindings for libsmartcols
=========================

Build Requirements
------------------

* [CMake](https://cmake.org/)
* [SWIG](http://swig.org/)

Requirements
------------

Optional requirements for `json()` function support:
* Perl: [perl-JSON](http://search.cpan.org/dist/JSON/)
* Lua: [lua-json](http://luaforge.net/projects/luajson/)
* Ruby: [rubygem-json](https://rubygems.org/gems/json)

Building and running tests
--------------------------

```
$ mkdir build
$ cd build
$ cmake ../ -G Ninja
$ ninja-build
$ ninja-build test
```

Add one of options to build specific languages:
* Python: `-DENABLE_PYTHON=ON`
* Perl: `-DENABLE_PERL=ON`
* Lua: `-DENABLE_LUA=ON`
* Ruby: `-DENABLE_RUBY=ON`

Forcing python version: `-DPythonLibs_FIND_VERSION=2 -DPythonLibs_FIND_VERSION_MAJOR=2`

To init libsmartcols debug when loading module, add: `-DCMAKE_BUILD_TYPE=Debug`

Running examples
----------------

* Python: `PYTHONPATH=build/python/ python3 examples/example.py`
* Perl: `PERL5LIB=build/perl/ perl examples/example.pl`
* Lua: `LUA_CPATH="$(lua -e 'print(package.cpath)');build/lua/?.so" lua examples/example.lua`
* Ruby: `RUBYLIB="ruby/:build/ruby/" ruby examples/example.rb`
