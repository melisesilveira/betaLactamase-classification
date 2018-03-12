# enzyme-classification
scripts used to identify and classify beta-lactmases

## Tools

- BLASTClust  (can be downloaded from ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/2.2.26/)
	- Copy all files from the BLASTClust program's "date", "bin" and "config_file" directories to the "files_request" directory
- HMMER 3.0 -(can be downloaded from http://hmmer.janelia.org/)

## Samples scripts to run the protocol

1. Make sure that the headers of the protein sequences in the multiFasta file (database) have the following formed at the beginning "> gi | <NUMBER> |". If not, use the script to insert a "fake gi"
	
   - perl insert_gi_single_line.pl [data_set] | grep -v  '^$' > [data_set_gi]
   

2. Now, you can use the profiles HMM available to scan across the sequence database using 'hmmsearch'

| Class  | Command Line |
| ------------- | ------------- |
| SA | hmmsearch --tblout SA.tbl -o SA.out --noali -T 120 --tformat fasta SA.hmm [data_set_gi]  |
| SC | hmmsearch --tblout SC.tbl -o SC.out --noali -T 430 --tformat fasta SC.hmm [data_set_gi]  |
| SD | hmmsearch --tblout SA.tbl -o SA.out --noali -T 120 --tformat fasta SA.hmm [data_set_gi]  |
| MB | hmmsearch --tblout MB.tbl -o MB.out --noali --cut_ga --tformat fasta MB.hmm [data_set_gi] |
| ME | hmmsearch --tblout ME.tbl -o ME.out --noali --cut_ga --tformat fasta ME.hmm [data_set_gi] |


3. Check if there are sequences retrieved by profiles of the classes SC and SD, which returns the file "repeted_SC_SD"

   - perl find_hmm.pl [SC.tbl] [SD.tbl] 

4. Create multiFasta files from search results with each profile

   - perl make_groups_hmmSearch.pl [data_set_gi] [perfil.tbl]

5. Check if the contents of the BLASTClust config_file file is "1e-05"

6. Inside the directory “files_request” run BLASTClust with the argument -L (minimum length cover) and -S (BLAST score density) specific for each class, which returns files with sequences "GI"

| Class  | Command Line | Subclasses |
| --------- | --------- | --------- |
| MB | ./blastclust -i MB.fasta -o [path_where_will_save_result] -c config_file -L 0.7 -S 0.5 -b T -p T  | MB1, MB2


7. Create the multiFasta file from BLASTClust results for each class

   - perl make_groups_blastclust.pl [BLASTClust output] [data_set_gi] [class_name]

8. Inside the directory “files_request” run BLASTClust with the argument -L (minimum length cover) and -S (BLAST score density) specific for each class, which returns files with sequences "GI"

| Class  | Command Line | Subclasses |
| --------- | --------- | --------- |
| SA | ./blastclust -i SA.fasta -o [path_where_will_save_result] -c config_file -L 0.45 -S 0.6 -b T -p T  | SA1, SA2
| SD | ./blastclust -i SD.fasta -o [path_where_will_save_result] -c config_file -L 0.75 -S 0.6 -b T -p T | SD1, SD2
| MB1 | ./blastclust -i MB1.fasta -o [path_where_will_save_result] -c config_file -L 0.75 -S 0.6 -b T -p T | MB1.1, MB1.2


7. Create the multiFasta file from BLASTClust results for each class

   - perl make_groups_blastclust.pl [BLASTClust_output] [sclass].fasta [class_name]
   
8. For each multiFASTA file generated perform BLASTp against NCBI's non-redundant protein database
