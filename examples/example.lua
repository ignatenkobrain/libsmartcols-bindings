require("smartcols")

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
ln[cl_name] = "Grandfather Bob"
ln[cl_age] = "63"

dad = tb:new_line(ln)
ln = dad
ln:set_data(cl_name, "Father Adam")
ln:set_data(cl_age, "38")

ln = tb:new_line(dad)
ln:set_data(cl_name, "Baby Val")
ln:set_data(cl_age, "9")

ln = tb:new_line(dad)
ln:set_data(cl_name, "Baby Dilbert")
ln:set_data(cl_age, "5")

ln = tb:new_line(gdad)
ln[0] = "Aunt Gaga"
ln[1] = "35"

local json = require('json')
print(json.encode(tb:json()))
print(tb)
