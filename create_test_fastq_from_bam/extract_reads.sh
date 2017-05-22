# set -eu

# base directory of the fastq files
fastqdirbase=../../rawdata/

# temporary directory
TempDir=/usr/local/work/$USER/tmp

# output of the mini fastq files
outdir=mini_fastq

# Set as "samplename" = directory for original fastq. Modify this and the fastqin variable assignment as needed
# Example is given
declare -A fastqdir
fastqdir["WGSrpt_02"]=161125_FR07919749
fastqdir["WGSrpt_04"]=161124_FR07919750
fastqdir["WGSrpt_05"]=161124_FR07934365
fastqdir["WGSrpt_07"]=161124_FR07934373
fastqdir["WGSrpt_08"]=161124_FR07934381
fastqdir["WGSrpt_09"]=161124_FR07934389
fastqdir["WGSrpt_10"]=161124_FR07934396
fastqdir["WGSrpt_11"]=161124_FR07934397
fastqdir["WGSrpt_12"]=161124_FR07934404
fastqdir["WGSrpt_13"]=161124_FR07934405
fastqdir["WGSrpt_14"]=161124_FR07934412
fastqdir["WGSrpt_15"]=161124_FR07934413
fastqdir["WGSrpt_16"]=161124_FR07934420
fastqdir["WGSrpt_17"]=161124_FR07934421
fastqdir["WGSrpt_18"]=161124_FR07934428
fastqdir["WGSrpt_19"]=161124_FR07934429
fastqdir["WGSrpt_20"]=161124_FR07934436
fastqdir["WGSrpt_21"]=161124_FR07934437


###  Run  ###

# create directories
mkdir -p $outdir
mkdir -p $TempDir

dictvar=fastqdir
declare -a 'keys=("${!'"$dictvar"'[@]}")'

for sample in ${keys[@]}
do
    echo "Script working on sample $sample" 1>&2
    # NOTE: modify this next line as required:
    for fastqin in $fastqdirbase/${fastqdir[$sample]}/inputFastq/*fastq.gz
    do
        echo "  on file: $fastqin" 1>&2
        if [ -f extract_dwreads.sh ]; then
            output=$outdir/$(basename $fastqin fastq.gz)mini.fastq.gz
            # ~/software/seqtk/seqtk-1.2/seqtk subseq $fastqin read_ids/${sample}_F.read_ids.txt | gzip -c > $output 2> $output.stderr.txt &
            sleep 1
        else 
            echo "  File not found: $fastqin" 1>&2
            break 2
        fi
    done
done

echo -e "\nJobs working in background.\nCheck with command: jobs\nor wait with: wait" 1>&2

