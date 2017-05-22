mkdir -p mini_bams
mkdir -p read_ids
for bamfile in <BAM files GLOB or list>
do
    # the sample name:
    sample=$(basename $bamfile _bowtie2_recal.bam) # change suffix as appropriate

    # extract desired regions. 
    # Listed here are 21 repeat expansion loci
    samtools view -b $bamfile \
        chr4:3074504-3078767 \
        chrX:66763059-66767361 \
        chr6:16325765-16330055 \
        chr12:112034654-112038923 \
        chr14:92535255-92539496 \
        chr19:13316573-13320812 \
        chr3:63896261-63900492 \
        chr6:170868895-170873205 \
        chr12:7043780-7048038 \
        chr16:87635789-87640035 \
        chrX:146991455-146995729 \
        chrX:147580059-147584304 \
        chr19:46271363-46275624 \
        chr9:71650101-71654320 \
        chr3:128889320-128893602 \
        chr9:27571383-27575644 \
        chr20:2631279-2635521 \
        chr22:46189135-46193404 \
        chr21:45194224-45198460 \
        chr5:146256191-146260422 \
        chr13:70711416-70715661 \
        > mini_bams/$sample.mini.bam
        
    # extract the read IDs from the mini bams
    samtools view mini_bams/$sample.mini.bam | cut -f1 | sort | uniq \
    > read_ids/$sample.read_ids.txt
done

