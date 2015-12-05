#!/usr/bin/perl

# USAGE: perl sotctransx.pl translate-es.csv translation-es.md 

use strict;
use warnings;

use File::Slurp;

my $separator = "\\[";

my $language_column = 3;

my $translations = $ARGV[0] or die "Need to get TSV row file on the command line\n";

my $template = $ARGV[1] or die "Need to get MD file on the command line\n";

$/ = undef;
my @values = split $separator, read_file($translations);
my $text = read_file($template);

my $i = 1;
foreach my $field (@values) {
    $text =~ s/\{\{$i\}\}/$field/g;
    $i += 1;
}

print $text;
