#!/bin/bash
#SBATCH -t 8-00:00:00
#SBATCH -p production
#SBATCH --nodes=1 #number of machines always keep as 1
#SBATCH --ntasks=16
#SBATCH --mem=150G
#SBATCH -o /share/eisenlab/adwright/th_unicycler/unicycler_assembly_%j.out
#SBATCH -e /share/eisenlab/adwright/th_unicycler/unicycler_assembly_%j.err
#SBATCH --mail-type=END #notifications for job done and fail
#SBATCH --mail-user=adwright@ucdavis.edu # send-to address

eval "$(conda shell.bash hook)"
source activate /share/eisenlab/adwright/software/virtual_envs/th_unicycler_env

#module load bowtie2/2.4.2 

cd /share/eisenlab/adwright/th_unicycler/

cat samples.txt | while read illumina oxford
do
/share/eisenlab/adwright/software/Unicycler/unicycler-runner.py -t 16 --keep 3 --vcf --min_polish_size 2000 -1 ${illumina}_1.fastq.gz -2 ${illumina}_2.fastq.gz -l oxford_seq/${oxford}.raw.fastq.gz -o ${illumina}_unicyclerAssembly_output

done
