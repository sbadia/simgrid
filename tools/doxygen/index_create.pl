#!/usr/bin/perl -w

($#ARGV >= 1) or die "Usage: index_create.pl <input-tag-file> <output-doc-file>";

my($type) = "";
my($name) = "";
my(%database);

$input  = $ARGV[0];
$output = $ARGV[1];
open FILE,$input;
while($line=<FILE>) {
    chomp $line;
    if($line=~/compound kind=/) {
	$type = $line;
	$type =~ s/^[^\"]*\"//;
	$type =~ s/\".*$//;
	$line=<FILE>;chomp $line;
    }
    if($line=~/member kind=/) {
	$type = $line;
	$type =~ s/^[^\"]*\"//;
	$type =~ s/\".*$//;
	$line=<FILE>;chomp $line;
    }
    if($line=~/<name>/) {
	$name = $line;
	$name =~ s/.*<name>//;
	$name =~ s/<\/name>.*//;
	$database{$type}{$name} = 1;
	$type = "";
	$name = "";
	next;
    }
}
close FILE;

open OUTPUT,"> $output";
print OUTPUT <<EOF;
/** \\defgroup API_index Index of the API
  * \\ingroup SimGrid_API
  * \\brief The alphabetical list of all functions, macros and types 
  *  defined by SimGrid
  *
  * List of all functions, variables, defines, enums, and typedefs with
  * links to the files they belong to.

EOF

foreach $type qw(define enumeration enumvalue function typedef) {
    if(defined $database{$type}) {
	print OUTPUT "<h2>$type</h2> \n  <ul>\n";
	foreach $name (sort keys %{$database{$type}}) {
	    if($type eq "function") {
		print OUTPUT "\t<LI> $name()</LI>\n";
	    } else {
		print OUTPUT "\t<LI> #$name</LI>\n";
	    }
	}
	print OUTPUT "\n  </ul>\n";
    }
}
print OUTPUT "*/";
close OUTPUT;

