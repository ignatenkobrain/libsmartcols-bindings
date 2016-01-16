use smartcols;

$tb = new smartcols::Table("example");

sub colors_enabled {
    our $tb = shift;
    return $tb->{colors} ? "True" : "False";
}

$cl_name = new smartcols::Column("NAME", 0.1, tree => 1);
$tb->add_column($cl_name);

$cl_age = $tb->new_column("AGE", 2);
$cl_age->{right} = 1;

print "Enable colors: " . colors_enabled($tb) . "\n";
$tb->{colors} = 1;
print "Enable colors: " . colors_enabled($tb) . "\n";

$ln = $gdad = $tb->new_line();
$ln->set_data($cl_name, "Grandfather Bob");
$ln->set_data($cl_age, "61");
$ln->get_cell($cl_age)->{color} = "red";

$ln = $dad = $tb->new_line($ln);
$ln->set_data($cl_name, "Father Adam");
$ln->set_data($cl_age, "38");

$ln = $tb->new_line($dad);
$ln->set_data($cl_name, "Baby Val");
$ln->set_data($cl_age, "9");

$ln = $tb->new_line($dad);
$ln->set_data($cl_name, "Baby Dilbert");
$ln->set_data($cl_age, "5");

$ln = $tb->new_line($gdad);
$ln->set_data(0, "Aunt Gaga");
$ln->set_data(1, "35");

print JSON->new->encode($tb->json()) . "\n";
print $tb;
