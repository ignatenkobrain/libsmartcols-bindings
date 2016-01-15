/* symbols.i
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

PROPERTY(Symbols, branch, const char *)
PROPERTY(Symbols, right, const char *)
PROPERTY(Symbols, vertical, const char *)

%inline %{

class Symbols {
    private:
        struct libscols_symbols *sm = NULL;
        char *_branch = NULL;
        char *_right = NULL;
        char *_vertical = NULL;
    public:
        Symbols() {
            this->sm = scols_new_symbols();
        }
        ~Symbols() {
            free(this->_branch);
            free(this->_right);
            free(this->_vertical);
            scols_unref_symbols(this->sm);
        }

        const char *branch() const {
            return this->_branch;
        }
        void branch(const char *branch) {
            this->_branch = strdup(branch);
            HANDLE_RC(scols_symbols_set_branch(this->sm, this->_branch));
        }

        const char *right() const {
            return this->_right;
        }
        void right(const char *right) {
            this->_right = strdup(right);
            HANDLE_RC(scols_symbols_set_right(this->sm, this->_right));
        }

        const char *vertical() const {
            return this->_vertical;
        }
        void vertical(const char *vertical) {
            this->_vertical = strdup(vertical);
            HANDLE_RC(scols_symbols_set_vertical(this->sm, this->_vertical));
        }
};

%}
