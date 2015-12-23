require("smartcols")

name = 0
age = 1

tb = smartcols.Table("example")

cl_name = smartcols.Column("NAME", 0.1)
cl_name.tree = true
tb:add_column(cl_name)

cl_age = tb:new_column("AGE", 2)
cl_age.right = true

print("Enable colors:", tb.colors)
tb.colors = true
print("Enable colors:", tb.colors)

gdad = tb:new_line()
ln = gdad
ln:set_data(name, "Grandfather Bob")
ln:set_data(age, "63")

dad = tb:new_line(ln)
ln = dad
ln:set_data(name, "Father Adam")
ln:set_data(age, "38")

ln = tb:new_line(dad)
ln:set_data(name, "Baby Val")
ln:set_data(age, "9")

ln = tb:new_line(dad)
ln:set_data(name, "Baby Dilbert")
ln:set_data(age, "5")

ln = tb:new_line(gdad)
ln:set_data(name, "Aunt Gaga")
ln:set_data(age, "35")

print(tb:json())
print(tb)
