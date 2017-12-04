#!/usr/bin/env perl

use warnings;
use strict;

# Author: Melise Chaves Silveira
# Year: 2017
# Version 0.9b

# > perl find_hmm.pl [.tbl 1] [.tbl 2]

#Program to find intersections between hmmsearch results of two models
#Input	files .tbl 1 e .tbl 2, outputs of hmmsearch
#Output	print the intersection between two models, repeted file, and all unic sequences, uniq file


#Open the first file .tbl, output from hmmsearch
my $arquivo= $ARGV[0];
open (IN, "<", $arquivo) || die "File 1 .tbl not open\n";

my @ids;

#Read each line of the result file .tbl 1
while (my $row = <IN>) {
	#remove \n of the line end
 	chomp $row;
   	#separate by space to get only the sequences indentifiers that showed match in hmmsearch result
   	my ($target) = split /\s/, $row;
	#not consider lines beging with hash
	if ($target ne "\#") {
	push (@ids, $target);	
	}
}

#Open the second file .tbl, output from hmmsearch
my $arquivo2= $ARGV[1];
open (IN2, "<", $arquivo2) || die "File 2 .tbl not open\n";

#open a file where the repeated IDS will be stored
my $arquivo4 = "repeted_$ARGV[0]_$ARGV[1]";
open (OUT, ">> $arquivo4") or die "Não foi possível abrir o arquivo '$arquivo4' \n";


#Reads each line of the result file 2 .tbl
while (my $row2 = <IN2>) {
	#remove \n of the line end
 	chomp $row2;
   	#separate by space to get only the sequences indentifiers that showed match in hmmsearch result
   	my ($target2) = split /\s/, $row2;
	#not consider lines beging with hash
	if ($target2 ne "\#") {
		#check if the sequence have alread showed match with the fisrt model
		if (grep {$_ eq $target2} @ids) {
			print OUT "$target2\n";
			} 
	}
}
		


close (IN);
close (IN2);
close (OUT);

exit;

