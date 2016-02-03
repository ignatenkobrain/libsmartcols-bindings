/* table.cc
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

Table::Table()
{
  table = scols_new_table();
}

Table::~Table()
{
  scols_unref_table(table);
}

const std::wstring
Table::to_string() const
{
  char *tmp = NULL;
  scols_print_table_to_string(table, &tmp);
  std::wstring ret (s2ws(std::string(tmp)));
  free(tmp);
  return ret;
}

const std::wstring
Table::to_json() const
{
  scols_table_enable_json(table, true);
  const std::wstring ret (to_string());
  scols_table_enable_json(table, false);
  return ret;
}

bool
Table::ascii() const
{
  return (bool) scols_table_is_ascii(table);
}

void
Table::ascii(bool val)
{
  scols_table_enable_ascii(table, (int) val);
}

bool
Table::colors() const
{
  return (bool) scols_table_colors_wanted(table);
}

void
Table::colors(bool val)
{
  scols_table_enable_colors(table, (int) val);
}

bool
Table::maxout() const
{
  return (bool) scols_table_is_maxout(table);
}

void
Table::maxout(bool val)
{
  scols_table_enable_maxout(table, (int) val);
}

bool
Table::noheadings() const
{
  return (bool) scols_table_is_noheadings(table);
}

void
Table::noheadings(bool val)
{
  scols_table_enable_noheadings(table, (int) val);
}

const std::wstring
Table::column_separator() const
{
  return s2ws(std::string(scols_table_get_column_separator(table)));
}

void
Table::column_separator(const std::wstring &wstr)
{
  scols_table_set_column_separator(table, ws2s(wstr).c_str());
}

const std::wstring
Table::line_separator() const
{
  return s2ws(std::string(scols_table_get_line_separator(table)));
}

void
Table::line_separator(const std::wstring &wstr)
{
  scols_table_set_line_separator(table, ws2s(wstr).c_str());
}

Column *
Table::new_column(const std::wstring &name)
{
  Column *cl = new Column(name);
  add_column(cl);
  return cl;
}

Column *
Table::new_column(const std::wstring &name, double whint)
{
  Column *cl = new Column(name);
  cl->whint(whint);
  add_column(cl);
  return cl;
}

void
Table::add_column(Column *cl)
{
  scols_table_add_column(table, cl->column);
}

Line *
Table::new_line()
{
  Line *ln = new Line();
  add_line(ln);
  return ln;
}

Line *
Table::new_line(Line *parent)
{
  Line *ln = new Line(parent);
  add_line(ln);
  return ln;
}

void
Table::add_line(Line *ln)
{
  scols_table_add_line(table, ln->line);
}
