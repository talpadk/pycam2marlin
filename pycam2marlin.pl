#!/usr/bin/perl

use strict;

my $feedSpeed = undef;
my $moveType = "G1";

sub outputMoveLine {
    my $line = $_[0];


    #remove comments
    $line =~ s/;.*//;

    #remove newline
    $line =~ s/\n//;

    #move without feed speed setting
    if ($line =~ /^\s*G1[^F]*/){
	if (defined($feedSpeed)){
	    $line = "$line $feedSpeed";
	}
    } 

    print "$line\n";
}

while (<STDIN>) {
    my $line = $_;
    #move command
    if ($line =~ /^(G[10])/){
	$moveType = $1;
	outputMoveLine($line);
    }
    #feed speed setting
    elsif ($line =~ /^(F\d*.?\d*)/){
	$feedSpeed = $1;
	print ";Feedspeed ($feedSpeed) in line: $line";
    }
    #dual XY moves
    elsif ($line =~ /^\sX\d+.?\d*\sY\d+.?\d*$/){
	outputMoveLine("$moveType$line");
    }
    #single XY (Z but hasn't been seen) moves
    elsif ($line =~ /^\s[XYZ]\d+.?\d*$/){
	outputMoveLine("$moveType$line");
    }
    #comment line
    elsif ($line =~ /^\s*;/){
	print $line;
    }
    else {
	print ";!! Discarded !!$line"
    }
}
