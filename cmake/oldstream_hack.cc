#include <libsmartcols.h>
int main (void)
{
  struct libscols_table *tb = scols_new_table ();
  scols_table_new_column (tb, "TEST", 1, SCOLS_FL_TREE);

  struct libscols_line *ln = scols_table_new_line (tb, NULL);
  scols_line_set_data (ln, 0, "test");

  char *ret = NULL;
  FILE *old_stream = scols_table_get_stream (tb);
  scols_print_table_to_string (tb, &ret);
  FILE *current_stream = scols_table_get_stream (tb);

  free (ret);
  scols_unref_table (tb);

  return current_stream == old_stream ? 0 : 1;
}
