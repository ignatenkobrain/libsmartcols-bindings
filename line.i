/* line.i
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

PROPERTY(Line, color, const char *)

%inline %{

class Line {
private:
    struct libscols_line *ln = NULL;
public:
    Line(Line *parent = NULL) {
        this->ln = scols_new_line();
        if (parent != NULL)
            scols_line_add_child(parent->get_struct(), this->ln);
    }
    ~Line() {
        scols_unref_line(this->ln);
    }
    libscols_line *get_struct() {
        return this->ln;
    }

    const char *color() const {
        return scols_line_get_color(this->ln);
    }
    void color(const char *color) {
        HANDLE_RC(scols_line_set_color(this->ln, color));
    }

    void set_data(int column, const char *data) {
        HANDLE_RC(scols_line_set_data(this->ln, column, data));
    }
};

%}
