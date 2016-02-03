/* line.cc
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

Line::Line()
{
  line = scols_new_line();
}

Line::Line(Line *parent)
{
  line = scols_new_line();
  scols_line_add_child(parent->line, line);
}

Line::~Line()
{
  scols_unref_line(line);
}

const std::string
Line::color() const
{
  return std::string(scols_line_get_color(line));
}

void
Line::color(const std::string &str)
{
  scols_line_set_color(line, str.c_str());
}

const Cell
Line::get_cell(Column *cl) const
{
  Cell cell;
  cell.cell = scols_line_get_column_cell(line, cl->column);
  return cell;
}

const Cell
Line::get_cell(unsigned int cl) const
{
  Cell cell;
  cell.cell = scols_line_get_cell(line, (int) cl);
  return cell;
}

void
Line::set_data(Column *cl, const std::wstring &wstr)
{
  scols_line_set_column_data(line, cl->column, ws2s(wstr).c_str());
}

void
Line::set_data(unsigned int cl, const std::wstring &wstr)
{
  scols_line_set_data(line, (int) cl, ws2s(wstr).c_str());
}
