use smartcols;

$tb = new smartcols::Table();

use constant {
    name => 0,
    age  => 1,
};

sub colors_enabled {
    our $tb = shift;
    return $tb->{colors} ? "True" : "False";
}

$cl_name = new smartcols::Column("NAME", 0.1, tree => true);
$tb->add_column($cl_name);

$cl_age = $tb->new_column("AGE", 2);
$cl_age->right(true);

print "Enable colors: " . colors_enabled($tb) . "\n";
$tb->{colors} = 1;
print "Enable colors: " . colors_enabled($tb) . "\n";

$ln = $gdad = $tb->new_line();
$ln->set_data(name, "Grandfather Bob");
$ln->set_data(age, "61");

$ln = $dad = $tb->new_line($ln);
$ln->set_data(name, "Father Adam");
$ln->set_data(age, "38");

$ln = $tb->new_line($dad);
$ln->set_data(name, "Baby Val");
$ln->set_data(age, "9");

$ln = $tb->new_line($dad);
$ln->set_data(name, "Baby Dilbert");
$ln->set_data(age, "5");

$ln = $tb->new_line($gdad);
$ln->set_data(name, "Aunt Gaga");
$ln->set_data(age, "35");

print JSON->new->pretty->encode($tb->json()) . "\n";
$tb->print();
