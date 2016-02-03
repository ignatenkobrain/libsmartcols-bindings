/* symbols.cc
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

Symbols::Symbols()
{
  symbols = scols_new_symbols();
}

Symbols::~Symbols()
{
  scols_unref_symbols(symbols);
}

const std::wstring
Symbols::branch() const
{
  return branch_;
}

void
Symbols::branch(const std::wstring &wstr)
{
  branch_ = std::wstring(wstr);
  scols_symbols_set_branch(symbols, ws2s(branch_).c_str());
}

const std::wstring
Symbols::right() const
{
  return right_;
}

void
Symbols::right(const std::wstring &wstr)
{
  right_ = std::wstring(wstr);
  scols_symbols_set_right(symbols, ws2s(right_).c_str());
}

const std::wstring
Symbols::vertical() const
{
  return vertical_;
}

void
Symbols::vertical(const std::wstring &wstr)
{
  vertical_ = std::wstring(wstr);
  scols_symbols_set_vertical(symbols, ws2s(vertical_).c_str());
}
