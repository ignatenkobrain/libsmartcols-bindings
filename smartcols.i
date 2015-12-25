/* smartcols.i
 *
 * Copyright (C) 2015 Igor Gnatenko <i.gnatenko.brain@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

%module(docstring="Python API for the util-linux libsmartcols library") smartcols

%{
#define SWIG_FILE_WITH_INIT
#include <libsmartcols.h>
%}

%init %{
#ifdef DEBUG
    scols_init_debug(0xffff);
#endif
%}

#define PROP_HEADER(class, ...)
#define PROP(param)
#define PROP_RENAME(class, param, type)
#define PROP_FOOTER(class)

#if defined(SWIGPYTHON)
#undef PROP
%define PROP(param)
    %pythoncode %{
        __swig_getmethods__[#param] = param
        __swig_setmethods__[#param] = param
        if _newclass: param = property(param, param)
    %}
%enddef
#elif defined(SWIGPERL)
#undef PROP_RENAME
%define PROP_RENAME(class, param, type)
    %rename("swig_"#param"_get") class::param;
    %rename("swig_"#param"_set") class::param(type);
%enddef
#elif defined(SWIGLUA)
#define SWIG_DOSTRING_FAIL(STR)

#undef PROP_HEADER
%define PROP_HEADER(class, ...)
    %luacode %{
        function __fixup_ ## class()
            local obj = smartcols. ## class(## __VA_ARGS__)
            local mt = getmetatable(obj)
    %}
%enddef

#undef PROP
%define PROP(param)
    %luacode %{
        __ ## param = obj. ## param
        mt[".get"][#param] = __ ## param
        mt[".set"][#param] = __ ## param
    %}
%enddef

#undef PROP_FOOTER
%define PROP_FOOTER(class)
    %luacode %{
        end
        __fixup_ ## class()
    %}
%enddef
#else
#warning "No property header/footer/etc. for target language"
#endif

%include "exception.i"

%inline %{
    /* Handling default return codes */
    #define HANDLE_RC(rc) if (rc != 0) throw std::runtime_error(strerror(rc))
%}

%exception {
    try {
        $action
    } catch(std::runtime_error &err) {
        SWIG_exception(SWIG_RuntimeError, err.what());
    }
}

%newobject *::__str__;
%typemap(newfree) char * "free($1);";

#ifdef SWIGPERL
    %rename("str") __str__;
#endif

%nodefaultctor;
%nodefaultdtor;

%include "symbols.i"
%include "column.i"
%include "line.i"
%include "table.i"
