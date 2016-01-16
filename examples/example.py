from __future__ import print_function
from smartcols import *

tb = Table("example")

cl_name = Column("NAME", 0.1, tree=True)
tb.add_column(cl_name)

cl_age = tb.new_column("AGE", 2)
cl_age.right = True

print("Enable colors:", tb.colors)
tb.colors = True
print("Enable colors:", tb.colors)

ln = gdad = tb.new_line()
ln[cl_name] = "Grandfather Bob"
ln[cl_age] = "61"
ln[cl_age].color = "red"

ln = dad = tb.new_line(ln)
ln.set_data(cl_name, "Father Adam")
ln.set_data(cl_age, "38")

ln = tb.new_line(dad)
ln.set_data(cl_name, "Baby Val")
ln.set_data(cl_age, "9")

ln = tb.new_line(dad)
ln.set_data(cl_name, "Baby Dilbert")
ln.set_data(cl_age, "5")

ln = tb.new_line(gdad)
ln[0] = "Aunt Gaga"
ln[1] = "35"

print(tb.json())
print(tb)
