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
ln[cl_age].color = "red"

dad = tb:new_line(ln)
ln = dad
ln[cl_name] = "Father Adam"
ln[cl_age] = "38"

ln = tb:new_line(dad)
ln[cl_name] = "Baby Val"
ln[cl_age] = "9"

ln = tb:new_line(dad)
ln[cl_name] = "Baby Dilbert"
ln[cl_age] = "5"

ln = tb:new_line(gdad)
ln[0] = "Aunt Gaga"
ln[1] = "35"

local json = require('json')
print(json.encode(tb:json()))
print(tb)
