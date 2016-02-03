/* smartcolspp.hh
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

#pragma once

#include <string>
#include <libsmartcols.h>

namespace Smartcols
{
  class Cell
  {
    public:
      struct libscols_cell *cell;

      const std::wstring data  () const;
      void               data  (const std::wstring &wstr);
      const std::string  color () const;
      void               color (const std::string  &str);
  };
  class Column
  {
    public:
      Column(const std::wstring &name);
      ~Column();

      struct libscols_column *column;

      // Flags
      bool               trunc        () const;
      void               trunc        (bool                val);
      bool               tree         () const;
      void               tree         (bool                val);
      bool               right        () const;
      void               right        (bool                val);
      bool               strict_width () const;
      void               strict_width (bool                val);
      bool               noextremes   () const;
      void               noextremes   (bool                val);
      bool               hidden       () const;
      void               hidden       (bool                val);

      const std::wstring name         () const;
      void               name         (const std::wstring &wstr);
      const std::string  color        () const;
      void               color        (const std::string  &str);
      double             whint        () const;
      void               whint        (double              val);

    private:
      void               set_flag     (int                 flag, 
                                       bool                val);
  };
  class Line
  {
    public:
      Line();
      Line(Line *parent);
      ~Line();

      struct libscols_line *line;

      const std::string color    () const;
      void              color    (const std::string  &str);

      const Cell        get_cell (Column             *cl) const;
      const Cell        get_cell (unsigned int        cl) const;
      void              set_data (Column             *cl,
                                  const std::wstring &wstr);
      void              set_data (unsigned int        cl,
                                  const std::wstring &wstr);
  };
  class Symbols
  {
    public:
      Symbols();
      ~Symbols();

      struct libscols_symbols *symbols;

      const std::wstring branch   () const;
      void               branch   (const std::wstring &wstr);
      const std::wstring right    () const;
      void               right    (const std::wstring &wstr);
      const std::wstring vertical () const;
      void               vertical (const std::wstring &wstr);

    private:
      std::wstring branch_;
      std::wstring right_;
      std::wstring vertical_;
  };
  class Table
  {
    public:
      Table();
      ~Table();

      struct libscols_table *table;

      const std::wstring to_string        () const;
      const std::wstring to_json          () const;

      // Flags
      bool               ascii            () const;
      void               ascii            (bool                val);
      bool               colors           () const;
      void               colors           (bool                val);
      bool               maxout           () const;
      void               maxout           (bool                val);
      bool               noheadings       () const;
      void               noheadings       (bool                val);

      const std::wstring column_separator () const;
      void               column_separator (const std::wstring &wstr);
      const std::wstring line_separator   () const;
      void               line_separator   (const std::wstring &wstr);

      Column            *new_column       (const std::wstring &name);
      Column            *new_column       (const std::wstring &name,
                                           double              whint);
      void               add_column       (Column             *cl);
      Line              *new_line         ();
      Line              *new_line         (Line               *parent);
      void               add_line         (Line               *ln);
  };
}
