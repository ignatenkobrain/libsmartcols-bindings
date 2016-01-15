/* table.i
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

%newobject Table::new_column;
%newobject Table::new_line;
%newobject Table::__json;

#if defined(SWIGPYTHON)
    %pythonprepend Table::__json %{
        from json import loads
    %}
    %pythonappend Table::__json %{
        val = loads(val)
    %}
    %rename("json") Table::__json;
#endif

PROPERTY(Table, ascii, bool)
PROPERTY(Table, colors, bool)
PROPERTY(Table, maxout, bool)
PROPERTY(Table, noheadings, bool)
PROPERTY(Table, column_separator, const char *)
PROPERTY(Table, line_separator, const char *)

%inline %{

class Table {
    private:
        struct libscols_table *tb = NULL;
        char *_name = NULL;
        bool json() const {
            return (bool) scols_table_is_json(this->tb);
        }
        void json(bool json) {
            HANDLE_RC(scols_table_enable_json(this->tb, (int) json));
        }

    public:
        Table(const char *name = NULL) {
            this->tb = scols_new_table();
            if (name != NULL)
                this->name(name);
        }
        ~Table() {
            free(this->_name);
            scols_unref_table(this->tb);
        }
        char *__str__() {
            char *data = NULL;
            HANDLE_RC(scols_print_table_to_string(this->tb, &data));
            return data;
        }
        char *__json() {
            this->json(true);
            char *data = this->__str__();
            this->json(false);
            return data;
        }
        const char *name() const {
            return this->_name;
        }
        void name(const char *name) {
            this->_name = strdup(name);
            HANDLE_RC(scols_table_set_name(this->tb, this->_name));
        }
        bool ascii() const {
            return (bool) scols_table_is_ascii(this->tb);
        }
        void ascii(bool ascii) {
            HANDLE_RC(scols_table_enable_ascii(this->tb, (int) ascii));
        }

        bool colors() const {
            return (bool) scols_table_colors_wanted(this->tb);
        }
        void colors(bool colors) {
            HANDLE_RC(scols_table_enable_colors(this->tb, (int) colors));
        }

        bool maxout() const {
            return (bool) scols_table_is_maxout(this->tb);
        }
        void maxout(bool maxout) {
            HANDLE_RC(scols_table_enable_maxout(this->tb, (int) maxout));
        }

        bool noheadings() const {
            return (bool) scols_table_is_noheadings(this->tb);
        }
        void noheadings(bool noheadings) {
            HANDLE_RC(scols_table_enable_noheadings(this->tb, (int) noheadings));
        }

        const char *column_separator() const {
            return scols_table_get_column_separator(this->tb);
        }
        void column_separator(const char *column_separator) {
            HANDLE_RC(scols_table_set_column_separator(this->tb, column_separator));
        }

        const char *line_separator() const {
            return scols_table_get_line_separator(this->tb);
        }
        void line_separator(const char *line_separator) {
            HANDLE_RC(scols_table_set_line_separator(this->tb, line_separator));
        }

        Column *new_column(const char *name, double whint) {
            Column *cl = new Column(name);
            cl->whint(whint);
            this->add_column(cl);
            return cl;
        }
        void add_column(Column *cl) {
            HANDLE_RC(scols_table_add_column(this->tb, cl->get_struct()));
        }
        void remove_columns() {
            scols_table_remove_columns(this->tb);
        }

        Line *new_line(Line *parent = NULL) {
            Line *ln = new Line(parent);
            this->add_line(ln);
            return ln;
        }
        void add_line(Line *ln) {
            HANDLE_RC(scols_table_add_line(this->tb, ln->get_struct()));
        }
        void remove_lines() {
            scols_table_remove_lines(this->tb);
        }
};

%}

%extend Table {
EXT_HEADER(Table)

#if defined(SWIGLUA)
    %luacode %{
        function smartcols.Table:__tojson()
            local json = require('json')
            return json.decode(self:__json())
        end
        mt[".fn"]["json"] = smartcols.Table.__tojson
    %}
#elif defined(SWIGPERL)
    %perlcode %{
        sub json {
            use JSON;
            my $self = shift;
            my $json = decode_json $self->__json();
            return $json;
        }
    %}
#endif

EXT_FOOTER(Table)
}
