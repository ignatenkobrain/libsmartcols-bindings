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

%init %{
#ifdef DEBUG
    scols_init_debug(0xffff);
#endif
%}

%{
#include <libsmartcols.h>
%}

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
