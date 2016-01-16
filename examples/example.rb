require 'smartcols'

tb = Smartcols::Table.new("example")

cl_name = Smartcols::Column.new("NAME", 0.1, false, true)
tb.add_column(cl_name)

cl_age = tb.new_column("AGE", 2)
cl_age.right = true

print "Enable colors: ", tb.colors, "\n"
tb.colors = true
print "Enable colors: ", tb.colors, "\n"

ln = gdad = tb.new_line()
ln[cl_name] = "Grandfather Bob"
ln[cl_age] = "61"
ln[cl_age].color = "red"

ln = dad = tb.new_line(ln)
ln[cl_name] = "Father Adam"
ln[cl_age] = "38"

ln = tb.new_line(dad)
ln[cl_name] = "Baby Val"
ln[cl_age] = "9"

ln = tb.new_line(dad)
ln[cl_name] = "Baby Dilbert"
ln[cl_age] = "5"

ln = tb.new_line(gdad)
ln[0] = "Aunt Gaga"
ln[1] = "35"

print tb.json(), "\n"
print tb
