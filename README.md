Running examples
================

Python
------

`PYTHONPATH=build/python/ python3 example.py`

Perl
----

`PERL5LIB=build/perl/ perl example.pl`

Lua
---

`LUA_CPATH="`lua -e 'print(package.cpath)'`;build/lua/?.so" lua example.lua`
