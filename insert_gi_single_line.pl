#!/usr/bin/perl -w
use strict;

# Author: Melise Chaves Silveira
# Year: 2017
# Version 0.9b

# > perl insert_gi_single_line.pl <file>

#Program to insert a imaginary GI
#Input	multifasta file
#Output	multifastafile with GI

#open the multifasta file
my $input_fasta=$ARGV[0];
open(IN,"<$input_fasta") || die ("Error opening $input_fasta $!");

my $x= 0;

while (my $line = <IN>){
	chomp $line;
	if ($line=~m/(^>)(.*)/) { 
		$x= $x+1;
		print "\n",$1,"gi|$x|",$2,"\n"; }
	else { print $line; }
}

print "\n";
exit;
