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

%module(docstring="Bindings for the util-linux libsmartcols library") smartcols

%{
#define SWIG_FILE_WITH_INIT
#include <libsmartcols.h>
%}

%init %{
#ifdef DEBUG
    scols_init_debug(0xffff);
#endif
%}

%include "attribute.i"

#define EXT_HEADER(class, ...)
#define EXT_FOOTER(class)

%define PROPERTY(class, param, type)
    /* Suppress warnings from redefining function to variables */
    %warnfilter(302) class::param;
    %attribute(class, type, param, param, param)
%enddef

#if defined(SWIGLUA)
#define SWIG_DOSTRING_FAIL(STR)

#undef EXT_HEADER
%define EXT_HEADER(class, ...)
    %luacode %{
        function __fixup_ ## class()
            local obj = smartcols. ## class(## __VA_ARGS__)
            local mt = getmetatable(obj)
    %}
%enddef

#undef EXT_FOOTER
%define EXT_FOOTER(class)
    %luacode %{
        end
        __fixup_ ## class()
    %}
%enddef
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

%nodefaultctor;
%nodefaultdtor;

%include "symbols.i"
%include "column.i"
%include "line.i"
%include "table.i"
