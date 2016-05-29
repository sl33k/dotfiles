#!/bin/perl
use strict;
use warnings;
use utf8;
binmode STDOUT, ":utf8";

my $output = `acpi`;
$output =~ /(\w+), ([0-9]+)%,? ?([0-9:]+)?/;
my $charge_status = $1 eq "Charging" ? "\x{26a1} " : "";
my $percent = $1 eq "Full" ? "100" : $2;
my $time_remaining = $3 // "fully charged";


my $full = "\${execbar echo " . $percent . "} ". "\${voffset -3.5}" . $charge_status . "rem: \${color2} " . $time_remaining . "\${color}\${voffset 3.5}";
print $full;
