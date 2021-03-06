from __future__ import print_function, unicode_literals

from smartcols import *

if __name__ == "__main__":
    tb = Table()

    cl_name = Column("NAME", 0.2, tree=True)
    tb.add_column(cl_name)

    cl_age = tb.new_column("AGE", 0.1)
    cl_age.right = True

    print("Enable colors:", tb.colors)
    tb.colors = True
    print("Enable colors:", tb.colors)

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

    print(tb.json())
    print(tb)
