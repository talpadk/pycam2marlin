#!/usr/bin/perl

use strict;

while (<STDIN>) {
    my $line = $_;
    #move command
    if ($line =~ /^G[10]/){
	print $line;
    }
    #dual XY moves
    elsif ($line =~ /^\sX\d+.?\d*\sY\d+.?\d*$/){
	print "G1$line";
    }
    #single XY (Z but hasn't been seen) moves
    elsif ($line =~ /^\s[XYZ]\d+.?\d*$/){
	print "G1$line";
    }
    #comment line
    elsif ($line =~ /^\s*;/){
	print $line;
    }
    else {
	print ";!! Discarded !!$line"
    }
}
