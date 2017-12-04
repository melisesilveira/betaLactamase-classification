#!/usr/bin/env perl

use warnings;
use strict;

# Author: Melise Chaves Silveira
# Year: 2017
# Version 0.9b

# > perl make_groups_hmmSearch.pl [data_set imput for hmmsearch] [file.tbl]

#Program to make multifasta file corresponding to MaxCluster groups
#Input	multifasta file with all seqs
#Output	multifastafile corresponding to the groups

my $arquivo= $ARGV[0];

#open de multifasta file with all sequences, after CDHIT
open (IN, "<", $arquivo) || die "File $arquivo not open\n";

#put the database in a array
my @database;
while (<IN>){
	chomp $_;
	if ($_ =~ m/^>(.*)/){
		my @headers = split (/\s/,$1);
		push @database, $headers[0];
	} else {push @database, $_;}

}

#open the output of hmmsearch

my @tbl = $ARGV[1]; 

foreach my $tbl_outs (@tbl) {
	chomp $tbl_outs;
	open (IN2, "<", $tbl_outs) || die "File $tbl_outs not open\n";
	my @extractname1 = split (/\./, $tbl_outs);
	my $arquivo2 = "./$extractname1[0]\.fasta";
	open (OUT, ">", $arquivo2) || die "File $arquivo2 not open\n";
	
	#read the cluster file 
	#my $count = 0; #create a gi
	while (my $row = <IN2>) {
		# remove \n of line end
   		chomp $row;
		#read the row saying which cluster sequences belong
		if (!($row=~m/#/gi)){
			my @ids = split (/\s-\s/,$row);
			my @ids2 = split (/\s/,$ids[0]);
			my $print = $ids2[0];
				if (grep {$_ eq $print} @database){
				my $search_for = "$print";
				my( $index )= grep { $database[$_] eq $search_for } 0..$#database;
				my $seq = $index + 1;
				print OUT ">$print\n$database[$seq]\n";
				} 			
		}
	}
	close IN2;
}


close IN;

exit;

