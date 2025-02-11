# Unix Problem Set

useful commands
=========================

| command         | description                              |
| --------------- | ---------------------------------------- |
| `man <command>` | manual page for the command e.g. `man ls` to get the man page for `ls` |
| `cd`            | change directory                         |
| `cp`            | copy files                               |
| `curl`          | transfer a URL |
| `cut`           | cut out selected portions of each line of a file |
| `date`          | returns the current date and time        |
| `grep`          | filnds the lines that contain a pattern  |
| `head`          | prints the top few lines to the terminal window |
| `ls`            | list directory contents                  |
| `mkdir`         | make a directory                         |
| `mv`            | move files                               |
| `pwd`           | return working directory name            |
| `rm`            | remove, or delete files and directories. Use caution, it is easy to delete more that you want. |
| `scp`           | remote secure copy                       |
| `sort`          | sorts the lines                          |
| `ssh`           | remote login                             |
| `tail`          | prints the last few lines to the terminal window |
| `uniq`          | prints the unique lines                  |
| `wc`            | counts the number of lines, characters and words |
| `~`             | shortcut for your home directory         |


1. What is the full path to your home directory?

2. Go up one directory?
    - How many files does it contain?
    - How many directories?

3. Make a directory called `hackyhour_problemset` in your home directory.

4. Navigate into this new directory called problemsets. Verify that you are in the correct directory by using `pwd`.

5. Use `curl -O` to copy <https://raw.githubusercontent.com/BinghamtonBioHackyHours/Spring_2025/refs/heads/main/data/week_03/sequences.nt.fa> from the web into your problemsets directory. If `curl` is not available on your system, use `wget` as an alternative. (Note '-O' is the letter O not the number Zero 0)

6. Without using a text editor, use unix commands to find these qualities for the file `sequences.nt.fa`.
  This file can be found here <https://raw.githubusercontent.com/BinghamtonBioHackyHours/Spring_2025/refs/heads/main/data/week_03/sequences.nt.fa>
      - How many lines does this file contain?   
      - How many characters?    (Hint: check out the options of wc)
      - What is the first line of this file?    (Hint: read the man page of head)
      - What are the last 3 lines?    (Hint: read the man page of tail)
      - How many sequences are in the file?    (Hint: use grep) (Note: The start of a sequence is indicated by a `>` character.)    

7. Rename `sequences.nt.fa` to `cancer_genes.fasta`. (Hint: read the man page for mv)
   
8. Copy/download `cuffdiff.txt`, to your problemset directory using `curl`. Here is the url you can use: <https://raw.githubusercontent.com/BinghamtonBioHackyHours/Spring_2025/refs/heads/main/data/week_03/cuffdiff.txt>. Use `-O` is the letter O not the number zero 0.



9. Do the following to `cuffdiff.txt`. The descriptions of each column in the file are in the table below.
    - Look at the first few lines of the file
    - Sort the file by log fold change 'log2(fold_change)', from highest to lowest, and save in a new file in your directory called sorted.cuffdiff.out
    - Sort the file (log fold change highest to lowest) then print out only the first 100 lines. Save in a file called `top100.sorted.cuffdiff.out`.
    - Sort the file by log fold change, print out the top 100, print only first column  (Hint: read the man page for `cut`). This will be a list of the top 100 genes with the largest change in expression. Make sure your list is sorted by gene name and is unique. Save this curated list in a file called `differentially.expressed.genes.txt`.

__Cuffdiff file format__

| Column number | Column name       | Example              | Description                              |
| ------------- | ----------------- | -------------------- | ---------------------------------------- |
| 1             | Tested id         | XLOC_000001          | A unique identifier describing the transcipt, gene, primary transcript, or CDS being tested |
| 2             | Tested id         | XLOC_000001          | A unique identifier describing the transcipt, gene, primary transcript, or CDS being tested |
| 3             | gene              | Lypla1               | The gene_name(s) or gene_id(s) being tested |
| 4             | locus             | chr1:4797771-4835363 | Genomic coordinates for easy browsing to the genes or transcripts being tested. |
| 5             | sample 1          | Liver                | Label (or number if no labels provided) of the first sample being tested |
| 6             | sample 2          | Brain                | Label (or number if no labels provided) of the second sample being tested |
| 7             | Test status       | NOTEST               | Can be one of OK (test successful), NOTEST (not enough alignments for testing), LOWDATA (too complex or shallowly sequenced), HIDATA (too many fragments in locus), or FAIL,  when an ill-conditioned covariance matrix or other numerical exception prevents testing. |
| 8             | FPKMx             | 8.01089              | FPKM of the gene in sample x             |
| 9             | FPKMy             | 8.551545             | FPKM of the gene in sample y             |
| 10            | log2(FPKMy/FPKMx) | 0.06531              | The (base 2) log of the fold change y/x  |
| 11            | test stat         | 0.860902             | The value of the test statistic used to compute significance of the observed change in FPKM |
| 12            | p value           | 0.389292             | The uncorrected p-value of the test statistic |
| 13            | q value           | 0.985216             | The FDR-adjusted p-value of the test statistic |
| 14            | significant       | no                   | Can be either "yes" or "no", depending on whether p is greater then the FDR after Benjamini-Hochberg correction for multiple-testing |
