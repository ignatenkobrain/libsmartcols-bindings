require 'smartcols'

class Col
  Name = 0
  Age = 1
end

tb = Smartcols::Table.new("example")

cl_name = Smartcols::Column.new("NAME", 0.1, false, true)
tb.add_column(cl_name)

cl_age = tb.new_column("AGE", 2)
cl_age.right = true

print "Enable colors: ", tb.colors, "\n"
tb.colors = true
print "Enable colors: ", tb.colors, "\n"

ln = gdad = tb.new_line()
ln.set_data(Col::Name, "Grandfather Bob")
ln.set_data(Col::Age, "61")

ln = dad = tb.new_line(ln)
ln.set_data(Col::Name, "Father Adam")
ln.set_data(Col::Age, "38")

ln = tb.new_line(dad)
ln.set_data(Col::Name, "Baby Val")
ln.set_data(Col::Age, "9")

ln = tb.new_line(dad)
ln.set_data(Col::Name, "Baby Dilbert")
ln.set_data(Col::Age, "5")

ln = tb.new_line(gdad)
ln.set_data(Col::Name, "Aunt Gaga")
ln.set_data(Col::Age, "35")

print tb.json(), "\n"
print tb
