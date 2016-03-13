FASTQ_FILES=fq_files/*.gz
fastqc --extract --outdir fqc_output --nogroup -t 4 $FASTQ_FILES
