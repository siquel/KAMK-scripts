use strict;
use warnings;

my $filename = "/tmp/ruokaa.txt";

open(my $fh, '<:encoding(UTF-8)', $filename) or die "could not open file $filename $!";

# read one line, ignore 11 after that, do it 4 timesa
my $str = "";

for (my $i = 0; $i < 6; ++$i)
{
    $str .= <$fh>;
    for (my $j = 0; $j < 11; ++$j) { <$fh>; }
}
# read monday foods and add them to first
#
my @mondaytuesday;
for (my $i = 0; $i < 2; ++$i)
{
    my $row = <$fh>; 
    push @mondaytuesday, $row;
}
my $row;
while ($row = <$fh>)
{
    last if $row =~ m/Tiistai/;
}

$row = <$fh>;
push @mondaytuesday, $row;
$row = <$fh>;
push @mondaytuesday, $row;

#the line 45 contains the wednesday first food
print join('', @mondaytuesday, $str);
