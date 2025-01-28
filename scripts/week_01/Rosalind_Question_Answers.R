###1 Counting DNA Nucleotides

# A string is simply an ordered collection of symbols selected from some alphabet and formed into a word; the length of a string is the number of symbols that it contains.

# An example of a length 21 DNA string (whose alphabet contains the symbols 'A', 'C', 'G', and 'T') is "ATGCTTCAGAAAGGTCTTACG."

# Given: A DNA string sof length at most 1000 nt.

# AGCTATACGTGGAAGATCGTTTCAGTGGCTTGCCTGGAAACGTGACACCAAGGGTGGTTATAGCTTCTACGCCACCTTCGAGGAAAAGTTGGGGATTAGTTACATAGGCTCCAACTCTTTCGCAAGGAGCTATTTACCTGCACGTCTAGTGATTCTACTCGAGAGCACCCACTTATGGAGCCCCCGCTAATACGTCTAAATCGGGGAGCCCGAACTATACAGAATGAACAGAGCTCTCGATGAAGGGCCATAGTTCAGGAGCAGGCGTACATCAACTCCTCCAACTCTAAGAGCTGCAGACTGCTTTCACTAATTAGCGCTGCGCCGCGCGTCACCTATTAATCGCAGTCTGAGCCAATCCGCCACACCGTTTAGGTGTCGCTGTATCGGGTTCCAGCGTTCTATGACCACTCCATCATATATCGAGTAGATTGCCGGTATTGACCAAAAAGGGTGGAGTGGAGCCGCACCATTGGAGAGCACTCAATTTGTAACACCGGTGTATACGAATGCTGGCGCCTATAATTACGACCTTACGAGCAAGAGCTTTGGTGATACAGGTGAAGACAACTGCCACGCATCCGCCAGTGACACTCTGGCCGGTAACCCCAGACTCCACAAGTCAAGTGGGGCTCAGTATTCTGCCCAGATATCGAATGAACAGGGTATACCCTGATGACGTAAACCTCGCACCTCAAGCGCTGATGATGGTCCGCGGAGCTGCTAGCTACTCCAATGATCCGTCCGTTCCTGATGCTGGGGGGGTATAAAAGATCTGCAAGGGCTTGATCTAACCCTCGAGCGTGCTAAACCCAATCCGGATGGGACTGGGCATACCAAAAGTGGCCGAGTTCAGGTGCTTGTCAGCCAAGTTGCTGTCGAGCCGGGCTTATAAGTGAGCATGCAAGTACGTT

# Return: Four integers (separated by spaces) counting the respective number of times that the symbols 'A', 'C', 'G', and 'T' occur in s

# 232 237 235 210


dna <- 'AGCTATACGTGGAAGATCGTTTCAGTGGCTTGCCTGGAAACGTGACACCAAGGGTGGTTATAGCTTCTACGCCACCTTCGAGGAAAAGTTGGGGATTAGTTACATAGGCTCCAACTCTTTCGCAAGGAGCTATTTACCTGCACGTCTAGTGATTCTACTCGAGAGCACCCACTTATGGAGCCCCCGCTAATACGTCTAAATCGGGGAGCCCGAACTATACAGAATGAACAGAGCTCTCGATGAAGGGCCATAGTTCAGGAGCAGGCGTACATCAACTCCTCCAACTCTAAGAGCTGCAGACTGCTTTCACTAATTAGCGCTGCGCCGCGCGTCACCTATTAATCGCAGTCTGAGCCAATCCGCCACACCGTTTAGGTGTCGCTGTATCGGGTTCCAGCGTTCTATGACCACTCCATCATATATCGAGTAGATTGCCGGTATTGACCAAAAAGGGTGGAGTGGAGCCGCACCATTGGAGAGCACTCAATTTGTAACACCGGTGTATACGAATGCTGGCGCCTATAATTACGACCTTACGAGCAAGAGCTTTGGTGATACAGGTGAAGACAACTGCCACGCATCCGCCAGTGACACTCTGGCCGGTAACCCCAGACTCCACAAGTCAAGTGGGGCTCAGTATTCTGCCCAGATATCGAATGAACAGGGTATACCCTGATGACGTAAACCTCGCACCTCAAGCGCTGATGATGGTCCGCGGAGCTGCTAGCTACTCCAATGATCCGTCCGTTCCTGATGCTGGGGGGGTATAAAAGATCTGCAAGGGCTTGATCTAACCCTCGAGCGTGCTAAACCCAATCCGGATGGGACTGGGCATACCAAAAGTGGCCGAGTTCAGGTGCTTGTCAGCCAAGTTGCTGTCGAGCCGGGCTTATAAGTGAGCATGCAAGTACGTT'



num_A <- lengths(regmatches(dna,gregexec('A', dna)))
num_T <- lengths(regmatches(dna,gregexec('T', dna)))
num_C <- lengths(regmatches(dna,gregexec('C', dna)))
num_G <- lengths(regmatches(dna,gregexec('G', dna)))

print(c(num_A, num_C, num_G, num_T))


###2 Transcribing DNA into RNA

# An RNA string is a string formed from the alphabet containing 'A', 'C', 'G', and 'U'.
# 
# Given a DNA string t corresponding to a coding strand, its transcribed RNA string u is formed by replacing all occurrences of 'T' in t with 'U' in u
# 
# 
# Given: A DNA string t having length at most 1000 nt.
# 
# Return: The transcribed RNA string of t

DNAtoRNA <- function(dnaseq){
  gsub("T", "U", dnaseq)
}

DNAtoRNA('CCTGGACTTGATAATTAAGGTACCGCGTCCCCGTTACTATCGCCCGGTTAAATGCCGAATAAGTCGCCTCCGTAAGGATGACCACGGCGATGAATAGAATACAATCTCG')



###3 Complementing a Strand of DNA

# 
# In DNA strings, symbols 'A' and 'T' are complements of each other, as are 'C' and 'G'.
# 
# The reverse complement of a DNA string s is the string sc formed by reversing the symbols of s, then taking the complement of each symbol (e.g., the reverse complement of "GTCA" is "TGAC")
# 
# Given: A DNA string s of length at most 1000 bp.
# 
# Return: The reverse complement sc of s

dna <- 'GAAATGCCTTGCGATGGTCGAACGCCATCTGAATCTCCCCGGAGATTCTTCGGAAATACTGCTCATTTCAACGTGTCCAGTCTCTGGAGTCACCGAAGCCTACTTTACCATTTTACCC'

dna_list <- strsplit(dna,"")[[1]]

rev_dna <- rev(dna_list)

for(nc in 1:length(rev_dna)){
  if(rev_dna[nc] == 'A'){rev_dna[nc] <- 'T'}
  else if(rev_dna[nc] == 'T'){rev_dna[nc] <- 'A'}
  else if(rev_dna[nc] == 'G'){rev_dna[nc] <- 'C'}
  else if(rev_dna[nc] == 'C'){rev_dna[nc] <- 'G'}
}

print(paste(rev_dna, collapse = ""))

###4 Rabbits and Recurrence Relations


# A sequence is an ordered collection of objects (usually numbers), which are allowed to repeat. Sequences can be finite or infinite. Two examples are the finite sequence (π,−2–√,0,π) and the infinite sequence of odd numbers (1,3,5,7,9,…). We use the notation an to represent the n-th term of a sequence.

# A recurrence relation is a way of defining the terms of a sequence with respect to the values of previous terms. In the case of Fibonacci's rabbits from the introduction, any given month will contain the rabbits that were alive the previous month, plus any new offspring. A key observation is that the number of offspring in any month is equal to the number of rabbits that were alive two months prior. As a result, if Fn represents the number of rabbit pairs alive after the n-th month, then we obtain the Fibonacci sequence having terms Fn that are defined by the recurrence relation Fn=Fn−1+Fn−2(with F1=F2=1 to initiate the sequence). Although the sequence bears Fibonacci's name, it was known to Indian mathematicians over two millennia ago.

#   Given: Positive integers n≤40and k≤5.
# 
#   Return: The total number of rabbit pairs that will be present after n months, if we begin with 1 pair and in each generation, every pair of reproduction-age rabbits produces a litter of k rabbit pairs (instead of only 1 pair).

recRabbits <- function(nk){
  initial = 1

  nk_split <- strsplit(nk, " ")[[1]]
  n = as.integer(nk_split[1])
  k = as.integer(nk_split[2])
  
  rabbits = integer()
  rabbits[1] <- initial
  rabbits[2] <- initial
  
  for (month in 3:n){
    rabbits[month] = rabbits[month-1] + k*rabbits[month-2]
  }  
  options(scipen =20)
  return (rabbits[n])
}


recRabbits('3 3')

recRabbits1 <- function(nk){
  
  nk_split <- strsplit(nk, " ")[[1]]
  n = as.integer(nk_split[1])
  k = as.integer(nk_split[2])
  
  F1 <-  1
  F2 <-  1
  Fn <-  0
  month <-  0
  while (month < (n-2)){
    Fn <-  F2 + F1* k
    F1 <-  F2
    F2 <-  Fn
    month <- month + 1
    }
    return (Fn)
}
recRabbits1('5 3')

###5 Computing GC Content

# The GC-content of a DNA string is given by the percentage of symbols in the string that are 'C' or 'G'. For example, the GC-content of "AGCTATAG" is 37.5%. Note that the reverse complement of any DNA string has the same GC-content.

# DNA strings must be labeled when they are consolidated into a database. A commonly used method of string labeling is called FASTA format. In this format, the string is introduced by a line that begins with '>', followed by some labeling information. Subsequent lines contain the string itself; the first line to begin with '>' indicates the label of the next string.

# In Rosalind's implementation, a string in FASTA format will be labeled by the ID "Rosalind_xxxx", where "xxxx" denotes a four-digit code between 0000 and 9999.
 
# Given: At most 10 DNA strings in FASTA format (of length at most 1 kbp each).
 
# Return: The ID of the string having the highest GC-content, followed by the GC-content of that string. Rosalind allows for a default error of 0.001 in all decimal answers unless otherwise stated; please see the note on absolute error below.


compareGC <- function(fasta){
  rs <- strsplit(fasta, '>')[[1]]
  rs1 <- rs[-1]
  rs2 <- gsub("\n", "", rs1)
  
  seq_name <- c()
  seq_gc <- c()
  for (i in 1:length(rs2)) {
    s1 <- strsplit(rs2[i], NULL)[[1]]
    seqn <- paste(s1[1:13], collapse="")
    seq <- s1[14:length(s1)]
    seqsum <- summary(as.factor(seq))
    gc <- unname(seqsum["G"]) + unname(seqsum["C"])
    seq_gc[i] <- gc/length(seq)*100
    seq_name[i] <- seqn
  }
  names(seq_gc) <- seq_name
  print(noquote(names(seq_gc[which(seq_gc == max(seq_gc))])))
  return(max(seq_gc))
  }
compareGC(">Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
")

library(seqinr)
seqs <- read.fasta("rosalind_gc.txt")
gc_content <- apply(matrix(names(seqs)), 1, function(x)GC(seqs[[x]]))
highest_gc <- which(gc_content == max(gc_content))
print(names(seqs)[highest_gc])
print(paste(signif(gc_content[highest_gc], 7) * 100, "%", sep=""))


###6 Counting Point Mutations

# Given two strings s and t of equal length, the Hamming distance between s and t, denoted dH(s,t), is the number of corresponding symbols that differ in s and t.

# Given: Two DNA strings s and t of equal length (not exceeding 1 kbp).
# 
# Return: The Hamming distance  dH(s,t)


seqs <- 'GTCGCTCAAGGGCGTGATCCTTCTAGTACTTGGGCCTCCACTAGACGCGACCACTAGCCTGCTATACATTTTGTGGCTAGCAGAAGTTGGCTGAGAAAAGTAATCATCGATGTCCTAAGTTGTCTGACTGCGGTGAAGAAGAGTTTACTAGGCCCCATGACGCTAGGACGAGCAGGCCTTGCGTCACGTCATACACTGTTACCTCACGGACTTCTTAGTAGCTGAATTCGGGACACTTAAGTCATCGTATCTGACCGAAGTGGCTTTAGTCCTCCCCGCGATGAGCGTCATCGCTGAGTGTCTATTCTACGAGGCTATCAGACTAAACCCTAATATCGTCTATAGCCGTGACGATATTCCCTGTTGTTTTGTATGCATTGTACTTAAACTGACCTTCCCCGTAACGAATTCTCCTCAGACTCCCACCGCCATCGCACTAGGTTCATGGGCGTCATTGCGTACCGGATTCCAGGAGGCGCGTTACATAGGTAATTCTTAATCACCCTACGTGTCACATGCAGTGGGCCATCCTATAGGAGTAGCTGATGCTAACCCCTTGGCCGCATCGCGGGATTGCGAGCGTCCTGATTATACGACAAATTAGGTCTTAAACCCCCACCGTAGCCCGAGCGTGCAGCCTGTAACGTTTGTGATGAATCGGGCTTTACCGGTTAAACGGAATGTGATAGTCGATTCGTCGGTAAAGATTTTCGACGTCTGCTGGGAGAGATCACAACAAATAAATTCAAGGAATAATGCGTACATGCATGACTCTAGGCCTCGGTCGATCGCGCTTAGAGCTCTCTCGTCTCTCCTACTCCAGAGGTGCAAGGTCCGCACGAGTGGAAGATAGAGCCATTTCAGACCCACATGAACAGAGGGCGTCGTCTAACCTTGTCAATGCAAAACGTCCAATAGCCG
ATTGAACTCGGGCTAGGTTGTTTTATCAGCTTGGCATATGGAAGACGCCCTGGCTAGATCAATATTCTGTTAGTTAATGTAGCAAGGGGGGGCAGTCATTCTAATATCTATGACATGAGACGACGCCCTAACCTGATGCATTGCGTATAAGTGTCCAAGACGCCAAGACGAGAATGACTCGCATCGCCTAATATCCTATTACCTGCTGGTATTCTCTATAACCCCAAGGTTGACACGTACGGAGTGAAGAACGCCTGGAACCGCTATAAACCTACTACACAAGAGCTTCGTTAGTTGGGGTGAGTGGAATAAGCTTTCCAGAGTATACTCTCTCACCGTAGGAGTCTGCGGGAATCCTTCCTTTTCACTTCTCCGTACTGCTCTTTTCCTGATCCTACCCGATACAACCCAAACTGAGAGTACCCCAGTAACCGTCCTAGGTCGAGTGCATACAAACGGTACGTGATTCCCCAACGGATTGTACATGCATCTTATATAATCATCCTCCGGATCTAAGGAAGTCTGCCCTACTATTTCAAGAAGTGGGCCTAACTCACCCGCCGCCATGCCGACTCATGAGCCACAGTAATATACTGCATTATACTCCCTGGAGGCACGTCGTAGCCTACCAGTCTAAGTGCTTACATCCGTGACCGCTCAGGCTATGCCCGATATTTACTTTTGAATAGATGATGCGCCCGTAACCAATCGTAGCGCGCGCGTTGCCAAAGCTCGAGAACTACGGCCTATAAGTCACAATCAACTTCGTGATTCTAGGACAGAGCCCACCCCGTTAATAGGTATTTCCTCTTTCAGACTCCATAGGTCCTGATTCCGCCGATGCTCAAGAAGCCACATTTTAGGATGCGCTTCGAGTGTCGTAGCCGAGAAGCTATGCCAACTAAAATCGTCGCAGGGCAA'
seqs_list <- strsplit(seqs,"\n")[[1]]
seq1 <- strsplit(seqs_list[1],"")[[1]]
seq2 <- strsplit(seqs_list[2],"")[[1]]
length(which(seq1 != seq2))

count = 0
for(i in 1:length(seq1)){
  if (seq1[i] != seq2[i]) {
    count <- count + 1
  }
}
print(count)


###7 Mendel's First Law

# Given: Three positive integers k, m, and n, representing a population containing k+m+n organisms: k individuals are homozygous dominant for a factor, m are heterozygous, and n are homozygous recessive.

# Return: The probability that two randomly selected mating organisms will produce an individual possessing a dominant allele (and thus displaying the dominant phenotype). Assume that any two organisms can mate.


sims <- rep(NA,1000000)
pop <- c(rep('AA', 21), rep('Aa',18), rep('aa',15))
for(i in 1:length(sims)){
  pair <- sample(pop,2)
  sims[i] <- sample(strsplit(pair[1],NULL)[[1]],1) == 'A' | sample(strsplit(pair[2],NULL)[[1]],1) == 'A'
}
sum(sims)/length(sims)

###8 Finding a Motif in DNA

# Given two strings s and t, t is a substring of s if t is contained as a contiguous collection of symbols in s (as a result, t must be no longer than s).

# The position of a symbol in a string is the total number of symbols found to its left, including itself (e.g., the positions of all occurrences of 'U' in "AUGCUUCAGAAAGGUCUUACG" are 2, 5, 6, 15, 17, and 18). The symbol at position i of s is denoted by s[i].

# A substring of s can be represented as s[j:k], where j and k represent the starting and ending positions of the substring in s; for example, if s = "AUGCUUCAGAAAGGUCUUACG", then s[2:5] = "UGCU".

# The location of a substring s[j:k] is its beginning position j; note that t will have multiple locations in s if it occurs more than once as a substring of s (see the Sample below).

# Given: Two DNA strings s and t (each of length at most 1 kbp).

# Return: All locations of t as a substring of s.

input <- "CCTACCTGGAACCTACCTGGACCCTACCTTGCTTCAGGGCCTACCTCCTACCTTCCTACCTCCTACCTTGACCTACCTAACCTACCTCACGCTAACTGTACCGTTCCTACCTGGCCTACCTGTGTCCTACCTGGTCTTCCTACCTACACCTACCTATCCTACCTCGCCTACCTACCTACCTGTTCTCCTACCTCCTACCTCCCCTAC
CCTACCTCC"

seqs_list <- strsplit(input,"\n")[[1]]
seq <- strsplit(seqs_list[1],NULL) [[1]]
target <- strsplit(seqs_list[2],NULL) [[1]]


match_start = c()
for (i in 1:length(seq)){
  end = length(target) - 1 + i
  if(paste(target, collapse = "") == paste(seq[i:end], collapse = "")){
    match_start <- c(match_start, i)
  }
}
paste(match_start,collapse = " ")


###9 Calculating Expected Offspring

# Given: Six non negative integers, each of which does not exceed 20,000. The integers correspond to the number of couples in a population possessing each genotype pairing for a given factor. In order, the six given integers represent the number of couples having the following genotypes:

# 1. AA-AA
# 2. AA-Aa
# 3. AA-aa
# 4. Aa-Aa
# 5. Aa-aa
# 6. aa-aa

# Return: The expected number of offspring displaying the dominant phenotype in the next generation, under the assumption that every couple has exactly two offspring.


num_couples <- '10 35 2 33 12 9'
num_couples <- strsplit(num_couples, " ")[[1]]

probablities_having_dominant <- c(1,1,1, 0.75, 0.5, 0)

total <- sum(2*(as.integer(num_couples)*probablities_having_dominant))
total

###10 Consensus and Profile

# Given: A collection of at most 10 DNA strings of equal length (at most 1 kbp) in FASTA format.

# Return: A consensus string and profile matrix for the collection. (If several possible consensus strings exist, then you may return any one of them.)
alphabet = c("A","C","G","T")
mat <- read.table("../Sample Data/rosalind_cons.txt")

smat <- paste(mat$V1, collapse = "")
smat <- strsplit(smat, ">")
smat <- unlist(smat)
smat <- smat[-1]
smat <- gsub("Rosalind_[0-9]*","",smat)
smat <- cbind(smat)

mat2 <- t(apply(smat, 1, function(x){ strsplit(x, "")[[1]] }))


res=apply(mat2,2,function(x){  a=sum(x=="A"); c=sum(x=="C"); g=sum(x=="G"); t=sum(x=="T"); return(c(a,c,g,t)) })
rownames(res)=c("A:","C:","G:","T:")
consensus = apply(res,2,function(x){  alphabet[which.max(x)] })
consensus = paste(consensus,collapse="")
             