configfile: "conda.yml"

SRA, FRR = glob_wildcards("rawQC/{sra}_{frr}.fastq")

rule all:
    input:
        expand("rawQC/{sra}_{frr}_fastqc.zip", sra=SRA, frr=FRR),
        expand("rawQC/{sra}_{frr}_fastqc.html", sra=SRA, frr=FRR),
        expand("trimmedReads/{sra}_1P.fastq", sra=SRA),
        expand("trimmedReads/{sra}_2P.fastq", sra=SRA)

rule quality_check:
    input:    
        rawread="data/{sra}_{frr}.fastq"
    output:
        zip="rawQC/{sra}_{frr}_fastqc.zip",
        html="rawQC/{sra}_{frr}_fastqc.html"
    conda:
        "conda.yml"
    shell:
        "fastqc {wildcards.sra}_{wildcards.frr}_fastqc.html {wildcards.sra}_{wildcards.frr}_fastqc.zip"
