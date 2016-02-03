/* smartcols.i
 *
 * Copyright (C) 2015-2016 Igor Gnatenko <i.gnatenko.brain@gmail.com>
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

/* Suppress warnings from redefining function to variables */
#pragma SWIG nowarn=302

%{
#include <smartcolspp.hh>
%}

%begin %{
#define SWIG_PYTHON_2_UNICODE
%}

%init %{
#ifdef DEBUG
  scols_init_debug(0xffff);
#endif
%}

%include <attribute.i>
%include <exception.i>
%include <std_string.i>
%include <std_wstring.i>

/* Cell */
%extend Smartcols::Cell {
  const std::wstring __str__() const {
    return $self->data();
  }
}
%attributestring(Smartcols::Cell, std::wstring, data, data, data)
%attributestring(Smartcols::Cell, std::string, color, color, color)

/* Column */
%extend Smartcols::Column {
  Column(const std::wstring &name,
                 double              whint = -1,
                 bool                trunc = false,
                 bool                tree = false,
                 bool                right = false,
                 bool                strict_width = false,
                 bool                noextremes = false,
                 bool                hidden = false) {
    Smartcols::Column *cl = new Smartcols::Column(name);
    if (whint >= 0)
      cl->whint(whint);
    cl->trunc(trunc);
    cl->tree(tree);
    cl->right(right);
    cl->strict_width(strict_width);
    cl->noextremes(noextremes);
    cl->hidden(hidden);
    return cl;
  }
}
%attribute(Smartcols::Column, bool, trunc, trunc, trunc)
%attribute(Smartcols::Column, bool, tree, tree, tree)
%attribute(Smartcols::Column, bool, right, right, right)
%attribute(Smartcols::Column, bool, strict_width, strict_width, strict_width)
%attribute(Smartcols::Column, bool, noextremes, noextremes, noextremes)
%attribute(Smartcols::Column, bool, hidden, hidden, hidden)
%attributestring(Smartcols::Column, std::wstring, name, name, name)
%attributestring(Smartcols::Column, std::string, color, color, color)
%attribute(Smartcols::Column, double, whint, whint, whint)

/* Line */
%rename("__getitem__") Smartcols::Line::get_cell;
%rename("__setitem__") Smartcols::Line::set_data;
%attributestring(Smartcols::Line, std::string, color, color, color)

/* Symbols */
%attributestring(Smartcols::Symbols, std::wstring, branch, branch, branch)
%attributestring(Smartcols::Symbols, std::wstring, right, right, right)
%attributestring(Smartcols::Symbols, std::wstring, vertical, vertical, vertical)

/* Table */
%rename("__str__") Smartcols::Table::to_string;
#if defined(SWIGPYTHON)
  %pythonprepend Smartcols::Table::to_json %{
      from json import loads
  %}
  %pythonappend Smartcols::Table::to_json %{
      val = loads(val)
  %}
  %rename("json") Smartcols::Table::to_json;
#endif
%attribute(Smartcols::Table, bool, ascii, ascii, ascii)
%attribute(Smartcols::Table, bool, colors, colors, colors)
%attribute(Smartcols::Table, bool, maxout, maxout, maxout)
%attribute(Smartcols::Table, bool, noheadings, noheadings, noheadings)
%attributestring(Smartcols::Table, std::wstring, column_separator, column_separator, column_separator)
%attributestring(Smartcols::Table, std::wstring, line_separator, line_separator, line_separator)
%newobject Smartcols::Table::new_column;
%newobject Smartcols::Table::new_line;

%include <smartcolspp.hh>
