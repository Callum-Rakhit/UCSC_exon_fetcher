#BEGIN 
{
 OFS ="\t"
}
{
    name=$2
    name2=$13
    sens = $4 =="+" ? "forward" : "reverse"
    chrom=$3

    split($10,exon_starts,",")
    split($11,exon_ends,",")


    for (i=1; i<length(exon_starts); i++)
    {
        start = exon_starts[i];
        end   = exon_ends[i];
        print(chrom, start, end, name2,sens, name)
    }

}
