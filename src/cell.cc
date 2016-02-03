/* cell.cc
 *
 * Copyright (C) 2016 Igor Gnatenko <i.gnatenko.brain@gmail.com>
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

const std::wstring
Cell::data() const
{
  return s2ws(std::string(scols_cell_get_data(cell)));
}

void
Cell::data(const std::wstring &wstr)
{
  scols_cell_set_data(cell, ws2s(wstr).c_str());
}

const std::string
Cell::color() const
{
  return std::string(scols_cell_get_color(cell));
}

void
Cell::color(const std::string &str)
{
  scols_cell_set_color(cell, str.c_str());
}
