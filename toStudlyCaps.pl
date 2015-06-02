#!/usr/bin/perl

# Filename: toStudlyCaps.pl
# Description: A utility script that will remove underscores '_' in PHP classes
#              and filenames. Ex. from Studly_Caps to StudlyCaps
# Author: Rommel Laranjo 

use strict;
use warnings;

my $path = './';
if (defined $ARGV[0]) {
    $path = $ARGV[0];
}

# get list of files
my @files = `cd $path; ls -al *.php | grep ^- | awk '{print \$9}'`;

foreach my $file (@files) {
    # remove newline
    chomp($file);
    # remove file extension
    $file =~ s/\.php//g;
    my $classname = $file;
    # remove underscores
    $classname =~ s/_//g;
    # do changes only when name was changed, else proceed with other files
    if ("$file.php" ne "$classname.php") {
        print "Will change class [$file] to [$classname].\n";
        # change all class name occurences
        `cd $path ; sed -i.bak 's/$file/$classname/g' *.php ; mv $file.php $classname.php`;
    }
}

print "Done.\n";
