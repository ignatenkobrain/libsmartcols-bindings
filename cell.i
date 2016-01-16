/* cell.i
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

PROPERTY(Cell, data, const char *)
PROPERTY(Cell, color, const char *)

%inline %{

class Cell {
    public:
        struct libscols_cell *_cell;

        char *__str__() {
            return strdup(this->data());
        }

        const char *data() const {
            return scols_cell_get_data(this->_cell);
        }
        void data(const char *data) {
            HANDLE_RC(scols_cell_set_data(this->_cell, data));
        }

        const char *color() const {
            return scols_cell_get_color(this->_cell);
        }
        void color(const char *color) {
            HANDLE_RC(scols_cell_set_color(this->_cell, color));
        }
};

%}
