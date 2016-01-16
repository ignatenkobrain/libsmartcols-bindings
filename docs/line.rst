Line
====

.. py:class:: smartcols.Line(parent=None)

   :param smartcols.Line parent: Parent line

   .. py:attribute:: color

      The color for data cells in line.

   .. py:function:: set_data(column, data)

      Set data for cell which reffering to the column.

      :param smartcols.Column column: Column
      :param str data: Data


Operations with cells
---------------------

Get cell
^^^^^^^^

   After following code `cell` will be :py:class:`smartcols.Cell`.

   .. code-block:: python

      tb = smartcols.Table()
      cl = tb.new_column("FOO", 1)
      cell = ln[cl]

Set data
^^^^^^^^

   After following code data for cell in line `ln` which reffering to column
   `FOO` will be set to `bar`.

   .. code-block:: python

      tb = smartcols.Table()
      cl = tb.new_column("FOO", 1)
      ln = tb.new_line()
      ln[cl] = "bar"

   .. seealso:: attribute :py:attr:`smartcols.Cell.data`
