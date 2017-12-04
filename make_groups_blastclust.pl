#!/usr/bin/env perl

use warnings;
use strict;

# Author: Melise Chaves Silveira
# Year: 2017
# Version 0.9b

# > perl make_groups_blastclust.pl [BLASTClust output] [fasta input for BLASTClust] [class_name]

#Program to make multiFasta file from BLASTClust result
#Input	BLASTClust output
#Output	multiFasta file


my $file = $ARGV[0];
	#open the file with BlastClust result 
	open (IN, "<", $file) || die "File cluster result not open\n";

my $output = $ARGV[2];

	my $z = 0;
		while (my $row = <IN>) {
			# remove \n of line end
   			chomp $row;
			my @cluster = split ('\s', $row);
			#print in a multifasta file the sequences
			#clusters number
			$z++;
			my $file2= $ARGV[1];  
			#open the multifasta file with all sequences
			open (IN2, "<", $file2) || die "File sequences not open\n";
					while (my $row2 = <IN2>) {
						chomp $row2;
							foreach my $sequence (@cluster){
								if ($row2 =~m/^>(gi\|$sequence\|.*)/gi){ 
								system <<EOF;
								grep -A 999999 ">gi\|$sequence\|" $file2 | awk 'NR>1 && /^>/{exit} 1' >> $ARGV[2]$z.fasta
EOF
								}
							}
					}
		}
close IN2;

exit;
