import unittest
import os
import smartcols

class Table(unittest.TestCase):
    def test_json(self):
        """Test smartcols.Table.json()"""
        table = smartcols.Table()
        column_name = table.new_column("NAME", 0.1)
        column_age = table.new_column("AGE", 2)
        line = table.new_line()
        line[column_name] = "Grandfather Bob"
        line[column_age] = "61"
        self.assertEqual(table.json(),
                         {
                             "": [
                                 {"name": "Grandfather Bob", "age": "61"}
                             ]
                         })

        column_name.tree = True
        line = table.new_line(line)
        line[column_name] = "Father Adam"
        line[column_age] = "38"
        self.assertEqual(table.json(),
                         {
                             "": [
                                 {"name": "Grandfather Bob", "age": "61",
                                  "children": [
                                      {"name": "Father Adam", "age": "38"}
                                  ]}
                             ]
                         })

    @staticmethod
    def read_data(fname):
        fobj = open(os.path.join(os.path.dirname(__file__), "data", fname))
        ret = fobj.read()
        fobj.close()
        return ret

    def test_print(self):
        """Test print(smartcols.Table)"""
        table = smartcols.Table()
        column_name = table.new_column("NAME", 0.1)
        column_age = table.new_column("AGE", 2)
        line = table.new_line()
        line[column_name] = "Grandfather Bob"
        line[column_age] = "61"
        self.assertEqual(str(table), self.read_data("default.txt"))

        # smartcols.Column.hidden
        column_age.hidden = True
        self.assertEqual(str(table), self.read_data("hidden.txt"))
        column_age.hidden = False

        # smartcols.Column.right
        column_age.right = True
        self.assertEqual(str(table), self.read_data("right.txt"))

        # smartcols.Column.tree
        column_name.tree = True
        line = table.new_line(line)
        line[column_name] = "Father Adam"
        line[column_age] = "38"
        self.assertEqual(str(table), self.read_data("tree.txt"))

if __name__ == "__main__":
    unittest.main(verbosity=2)
