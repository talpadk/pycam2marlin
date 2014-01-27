#!/usr/bin/perl

use strict;

my $rapidSpeed = 1000;
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

    #rapid (non interpolated) move 
    if ($line =~ /^\s*G0[^F]*/){
	$line = "$line F$rapidSpeed";
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
    #Move missng a G type 
    elsif ($line =~ /^\s*[XYZ]\d+.?\d*/){
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
