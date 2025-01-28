###  Rosalind Bioinformatics Problems

# https://rosalind.info/problems/tree-view/

# Q1 ----------------------------------------------------------------------
###1 Counting DNA Nucleotides

# A string is simply an ordered collection of symbols selected from some alphabet and formed into a word; the length of a string is the number of symbols that it contains.

# An example of a length 21 DNA string (whose alphabet contains the symbols 'A', 'C', 'G', and 'T') is "ATGCTTCAGAAAGGTCTTACG."

# Given: A DNA string s of length at most 1000 nt.

# AGCTATACGTGGAAGATCGTTTCAGTGGCTTGCCTGGAAACGTGACACCAAGGGTGGTTATAGCTTCTACGCCACCTTCGAGGAAAAGTTGGGGATTAGTTACATAGGCTCCAACTCTTTCGCAAGGAGCTATTTACCTGCACGTCTAGTGATTCTACTCGAGAGCACCCACTTATGGAGCCCCCGCTAATACGTCTAAATCGGGGAGCCCGAACTATACAGAATGAACAGAGCTCTCGATGAAGGGCCATAGTTCAGGAGCAGGCGTACATCAACTCCTCCAACTCTAAGAGCTGCAGACTGCTTTCACTAATTAGCGCTGCGCCGCGCGTCACCTATTAATCGCAGTCTGAGCCAATCCGCCACACCGTTTAGGTGTCGCTGTATCGGGTTCCAGCGTTCTATGACCACTCCATCATATATCGAGTAGATTGCCGGTATTGACCAAAAAGGGTGGAGTGGAGCCGCACCATTGGAGAGCACTCAATTTGTAACACCGGTGTATACGAATGCTGGCGCCTATAATTACGACCTTACGAGCAAGAGCTTTGGTGATACAGGTGAAGACAACTGCCACGCATCCGCCAGTGACACTCTGGCCGGTAACCCCAGACTCCACAAGTCAAGTGGGGCTCAGTATTCTGCCCAGATATCGAATGAACAGGGTATACCCTGATGACGTAAACCTCGCACCTCAAGCGCTGATGATGGTCCGCGGAGCTGCTAGCTACTCCAATGATCCGTCCGTTCCTGATGCTGGGGGGGTATAAAAGATCTGCAAGGGCTTGATCTAACCCTCGAGCGTGCTAAACCCAATCCGGATGGGACTGGGCATACCAAAAGTGGCCGAGTTCAGGTGCTTGTCAGCCAAGTTGCTGTCGAGCCGGGCTTATAAGTGAGCATGCAAGTACGTT

# Return: Four integers (separated by spaces) counting the respective number of times that the symbols 'A', 'C', 'G', and 'T' occur in s

# 232 237 235 210









# Q2 ----------------------------------------------------------------------
###2 Transcribing DNA into RNA

# An RNA string is a string formed from the alphabet containing 'A', 'C', 'G', and 'U'.
# 
# Given a DNA string t corresponding to a coding strand, its transcribed RNA string u is formed by replacing all occurrences of 'T' in t with 'U' in u
# 
# 
# Given: A DNA string t having length at most 1000 nt.

# CCTGGACTTGATAATTAAGGTACCGCGTCCCCGTTACTATCGCCCGGTTAAATGCCGAATAAGTCGCCTCCGTAAGGATGACCACGGCGATGAATAGAATACAATCTCG

# Return: The transcribed RNA string of t

# CCUGGACUUGAUAAUUAAGGUACCGCGUCCCCGUUACUAUCGCCCGGUUAAAUGCCGAAUAAGUCGCCUCCGUAAGGAUGACCACGGCGAUGAAUAGAAUACAAUCUCG





# Q3 ----------------------------------------------------------------------
###3 Complementing a Strand of DNA

# 
# In DNA strings, symbols 'A' and 'T' are complements of each other, as are 'C' and 'G'.
# 
# The reverse complement of a DNA string s is the string sc formed by reversing the symbols of s, then taking the complement of each symbol (e.g., the reverse complement of "GTCA" is "TGAC")
# 
# Given: A DNA string s of length at most 1000 bp.

# GAAATGCCTTGCGATGGTCGAACGCCATCTGAATCTCCCCGGAGATTCTTCGGAAATACTGCTCATTTCAACGTGTCCAGTCTCTGGAGTCACCGAAGCCTACTTTACCATTTTACCC

# Return: The reverse complement sc of s

# GGGTAAAATGGTAAAGTAGGCTTCGGTGACTCCAGAGACTGGACACGTTGAAATGAGCAGTATTTCCGAAGAATCTCCGGGGAGATTCAGATGGCGTTCGACCATCGCAAGGCATTTC


# Q4 ----------------------------------------------------------------------
###4 Rabbits and Recurrence Relations

# https://rosalind.info/media/problems/fib/rabbit_tree.png

# A sequence is an ordered collection of objects (usually numbers), which are allowed to repeat. Sequences can be finite or infinite. Two examples are the finite sequence (π,−2–√,0,π) and the infinite sequence of odd numbers (1,3,5,7,9,…). We use the notation an to represent the n-th term of a sequence.

# A recurrence relation is a way of defining the terms of a sequence with respect to the values of previous terms. In the case of Fibonacci's rabbits from the introduction, any given month will contain the rabbits that were alive the previous month, plus any new offspring. A key observation is that the number of offspring in any month is equal to the number of rabbits that were alive two months prior. As a result, if Fn represents the number of rabbit pairs alive after the n-th month, then we obtain the Fibonacci sequence having terms Fn that are defined by the recurrence relation Fn=Fn−1+Fn−2(with F1=F2=1 to initiate the sequence). Although the sequence bears Fibonacci's name, it was known to Indian mathematicians over two millennia ago.

#   Given: Positive integers n≤40and k≤5.

# 5 3

#   Return: The total number of rabbit pairs that will be present after n months, if we begin with 1 pair and in each generation, every pair of reproduction-age rabbits produces a litter of k rabbit pairs (instead of only 1 pair).

# 19






# Q5 ----------------------------------------------------------------------
###5 Computing GC Content

# The GC-content of a DNA string is given by the percentage of symbols in the string that are 'C' or 'G'. For example, the GC-content of "AGCTATAG" is 37.5%. Note that the reverse complement of any DNA string has the same GC-content.

# DNA strings must be labeled when they are consolidated into a database. A commonly used method of string labeling is called FASTA format. In this format, the string is introduced by a line that begins with '>', followed by some labeling information. Subsequent lines contain the string itself; the first line to begin with '>' indicates the label of the next string.

# In Rosalind's implementation, a string in FASTA format will be labeled by the ID "Rosalind_xxxx", where "xxxx" denotes a four-digit code between 0000 and 9999.

# Given: At most 10 DNA strings in FASTA format (of length at most 1 kbp each).

# >Rosalind_6404
# CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
# TCCCACTAATAATTCTGAGG
# >Rosalind_5959
# CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
# ATATCCATTTGTCAGCAGACACGC
# >Rosalind_0808
# CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
# TGGGAACCTGCGGGCAGTAGGTGGAAT

# Return: The ID of the string having the highest GC-content, followed by the GC-content of that string. Rosalind allows for a default error of 0.001 in all decimal answers unless otherwise stated; please see the note on absolute error below.

# Rosalind_0808
# 60.91954



# Q6 ----------------------------------------------------------------------

###6 Counting Point Mutations

# Given two strings s and t of equal length, the Hamming distance between s and t, denoted dH(s,t), is the number of corresponding symbols that differ in s and t.

# Given: Two DNA strings s and t of equal length (not exceeding 1 kbp).

# GTCGCTCAAGGGCGTGATCCTTCTAGTACTTGGGCCTCCACTAGACGCGACCACTAGCCTGCTATACATTTTGTGGCTAGCAGAAGTTGGCTGAGAAAAGTAATCATCGATGTCCTAAGTTGTCTGACTGCGGTGAAGAAGAGTTTACTAGGCCCCATGACGCTAGGACGAGCAGGCCTTGCGTCACGTCATACACTGTTACCTCACGGACTTCTTAGTAGCTGAATTCGGGACACTTAAGTCATCGTATCTGACCGAAGTGGCTTTAGTCCTCCCCGCGATGAGCGTCATCGCTGAGTGTCTATTCTACGAGGCTATCAGACTAAACCCTAATATCGTCTATAGCCGTGACGATATTCCCTGTTGTTTTGTATGCATTGTACTTAAACTGACCTTCCCCGTAACGAATTCTCCTCAGACTCCCACCGCCATCGCACTAGGTTCATGGGCGTCATTGCGTACCGGATTCCAGGAGGCGCGTTACATAGGTAATTCTTAATCACCCTACGTGTCACATGCAGTGGGCCATCCTATAGGAGTAGCTGATGCTAACCCCTTGGCCGCATCGCGGGATTGCGAGCGTCCTGATTATACGACAAATTAGGTCTTAAACCCCCACCGTAGCCCGAGCGTGCAGCCTGTAACGTTTGTGATGAATCGGGCTTTACCGGTTAAACGGAATGTGATAGTCGATTCGTCGGTAAAGATTTTCGACGTCTGCTGGGAGAGATCACAACAAATAAATTCAAGGAATAATGCGTACATGCATGACTCTAGGCCTCGGTCGATCGCGCTTAGAGCTCTCTCGTCTCTCCTACTCCAGAGGTGCAAGGTCCGCACGAGTGGAAGATAGAGCCATTTCAGACCCACATGAACAGAGGGCGTCGTCTAACCTTGTCAATGCAAAACGTCCAATAGCCG
# ATTGAACTCGGGCTAGGTTGTTTTATCAGCTTGGCATATGGAAGACGCCCTGGCTAGATCAATATTCTGTTAGTTAATGTAGCAAGGGGGGGCAGTCATTCTAATATCTATGACATGAGACGACGCCCTAACCTGATGCATTGCGTATAAGTGTCCAAGACGCCAAGACGAGAATGACTCGCATCGCCTAATATCCTATTACCTGCTGGTATTCTCTATAACCCCAAGGTTGACACGTACGGAGTGAAGAACGCCTGGAACCGCTATAAACCTACTACACAAGAGCTTCGTTAGTTGGGGTGAGTGGAATAAGCTTTCCAGAGTATACTCTCTCACCGTAGGAGTCTGCGGGAATCCTTCCTTTTCACTTCTCCGTACTGCTCTTTTCCTGATCCTACCCGATACAACCCAAACTGAGAGTACCCCAGTAACCGTCCTAGGTCGAGTGCATACAAACGGTACGTGATTCCCCAACGGATTGTACATGCATCTTATATAATCATCCTCCGGATCTAAGGAAGTCTGCCCTACTATTTCAAGAAGTGGGCCTAACTCACCCGCCGCCATGCCGACTCATGAGCCACAGTAATATACTGCATTATACTCCCTGGAGGCACGTCGTAGCCTACCAGTCTAAGTGCTTACATCCGTGACCGCTCAGGCTATGCCCGATATTTACTTTTGAATAGATGATGCGCCCGTAACCAATCGTAGCGCGCGCGTTGCCAAAGCTCGAGAACTACGGCCTATAAGTCACAATCAACTTCGTGATTCTAGGACAGAGCCCACCCCGTTAATAGGTATTTCCTCTTTCAGACTCCATAGGTCCTGATTCCGCCGATGCTCAAGAAGCCACATTTTAGGATGCGCTTCGAGTGTCGTAGCCGAGAAGCTATGCCAACTAAAATCGTCGCAGGGCAA

# Return: The Hamming distance  dH(s,t)

# 459





# Q7 ----------------------------------------------------------------------
###7 Mendel's First Law

# Given: Three positive integers k, m, and n, representing a population containing k+m+n organisms: k individuals are homozygous dominant for a factor, m are heterozygous, and n are homozygous recessive.

# 21 18 15

# Return: The probability that two randomly selected mating organisms will produce an individual possessing a dominant allele (and thus displaying the dominant phenotype). Assume that any two organisms can mate.

# 0.80567


# Q8 ----------------------------------------------------------------------

###8 Finding a Motif in DNA

# Given two strings s and t, t is a substring of s if t is contained as a contiguous collection of symbols in s (as a result, t must be no longer than s).

# The position of a symbol in a string is the total number of symbols found to its left, including itself (e.g., the positions of all occurrences of 'U' in "AUGCUUCAGAAAGGUCUUACG" are 2, 5, 6, 15, 17, and 18). The symbol at position i of s is denoted by s[i].

# A substring of s can be represented as s[j:k], where j and k represent the starting and ending positions of the substring in s; for example, if s = "AUGCUUCAGAAAGGUCUUACG", then s[2:5] = "UGCU".

# The location of a substring s[j:k] is its beginning position j; note that t will have multiple locations in s if it occurs more than once as a substring of s (see the Sample below).

# Given: Two DNA strings s and t (each of length at most 1 kbp).

# CCTACCTGGAACCTACCTGGACCCTACCTTGCTTCAGGGCCTACCTCCTACCTTCCTACCTCCTACCTTGACCTACCTAACCTACCTCACGCTAACTGTACCGTTCCTACCTGGCCTACCTGTGTCCTACCTGGTCTTCCTACCTACACCTACCTATCCTACCTCGCCTACCTACCTACCTGTTCTCCTACCTCCTACCTCCCCTAC
# CCTACCTCC

# Return: All locations of t as a substring of s.

# 40 55 187 194



# Q9 ----------------------------------------------------------------------
###9 Calculating Expected Offspring

# Given: Six non negative integers, each of which does not exceed 20,000. The integers correspond to the number of couples in a population possessing each genotype pairing for a given factor. In order, the six given integers represent the number of couples having the following genotypes:

# 1. AA-AA
# 2. AA-Aa
# 3. AA-aa
# 4. Aa-Aa
# 5. Aa-aa
# 6. aa-aa

# 10 35 2 33 12 9

# Return: The expected number of offspring displaying the dominant phenotype in the next generation, under the assumption that every couple has exactly two offspring.

# 155.5


# Q10 ---------------------------------------------------------------------
###10 Consensus and Profile

# A matrix is a rectangular table of values divided into rows and columns. An m×n matrix has m rows and n columns. Given a matrix A, we write Aij to indicate the value found at the intersection of row i and column j.
 
# Say that we have a collection of DNA strings, all having the same length n. Their profile matrix is a 4×n matrix P in which P1j represents the number of times that 'A' occurs in the j th position of one of the strings, P2j represents the number of times that C occurs in the jth position, and so on (see below).

# A consensus string c is a string of length n formed from our collection by taking the most common symbol at each position; the jth symbol of c therefore corresponds to the symbol having the maximum value in the j-th column of the profile matrix. Of course, there may be more than one most common symbol, leading to multiple possible consensus strings.


# Given: A collection of at most 10 DNA strings of equal length (at most 1 kbp) in FASTA format.

# >Rosalind_1
# ATCCAGCT
# >Rosalind_2
# GGGCAACT
# >Rosalind_3
# ATGGATCT
# >Rosalind_4
# AAGCAACC
# >Rosalind_5
# TTGGAACT
# >Rosalind_6
# ATGCCATT
# >Rosalind_7
# ATGGCACT

# Return: A consensus string and profile matrix for the collection. (If several possible consensus strings exist, then you may return any one of them.)

# ATGCAACT
# A: 5 1 0 0 5 5 0 0
# C: 0 0 1 4 2 0 6 1
# G: 1 1 6 3 0 1 0 0
# T: 1 5 0 0 0 1 1 6
