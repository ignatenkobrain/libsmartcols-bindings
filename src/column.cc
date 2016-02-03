/* column.cc
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

#include "smartcolspp.hh"
#include "util.hh"

using namespace Smartcols;

Column::Column(const std::wstring &name)
{
  column = scols_new_column();
  this->name(name);
}

Column::~Column()
{
  scols_unref_column(column);
}

void
Column::set_flag(int flag, bool v)
{
  int flags = scols_column_get_flags(column);
  bool current = (bool) (flags & flag);
  if (!current && v)
    scols_column_set_flags(column, flags | flag);
  else if (current && !v)
    scols_column_set_flags(column, flags ^ flag);
}

bool
Column::trunc() const
{
  return (bool) scols_column_is_trunc(column);
}

void
Column::trunc(bool val)
{
  set_flag(SCOLS_FL_TRUNC, val);
}

bool
Column::tree() const
{
  return (bool) scols_column_is_tree(column);
}

void
Column::tree(bool val)
{
  set_flag(SCOLS_FL_TREE, val);
}

bool
Column::right() const
{
  return (bool) scols_column_is_right(column);
}

void
Column::right(bool val)
{
  set_flag(SCOLS_FL_RIGHT, val);
}

bool
Column::strict_width() const
{
  return (bool) scols_column_is_strict_width(column);
}

void
Column::strict_width(bool val)
{
  set_flag(SCOLS_FL_STRICTWIDTH, val);
}

bool
Column::noextremes() const
{
  return (bool) scols_column_is_noextremes(column);
}

void
Column::noextremes(bool val)
{
  set_flag(SCOLS_FL_NOEXTREMES, val);
}

bool
Column::hidden() const
{
  return (bool) scols_column_is_hidden(column);
}

void
Column::hidden(bool val)
{
  set_flag(SCOLS_FL_HIDDEN, val);
}

bool
Column::wrap() const
{
  return (bool) scols_column_is_wrap(column);
}

void
Column::wrap(bool val)
{
  set_flag(SCOLS_FL_WRAP, val);
}

const std::wstring
Column::name() const
{
  return s2ws(std::string(scols_cell_get_data(scols_column_get_header(column))));
}

void
Column::name(const std::wstring &wstr)
{
  scols_cell_set_data(scols_column_get_header(column), ws2s(wstr).c_str());
}

const std::string
Column::color() const
{
  return std::string(scols_column_get_color(column));
}

void
Column::color(const std::string &str)
{
  scols_column_set_color(column, str.c_str());
}

double
Column::whint() const
{
  return scols_column_get_whint(column);
}

void
Column::whint(double val)
{
  scols_column_set_whint(column, val);
}
