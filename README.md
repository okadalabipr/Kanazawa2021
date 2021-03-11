# Kanazawa et al., 2021 <br>Cell Shape-Based Chemical Screening Reveals an Epigenetic Network Mediated by Focal Adhesions  

### Introduction

This repository contains the source code for the sequence analysis used in the above paper.  

### Chromatin immunoprecipitation-sequencing (ChIP-seq)  

- ChIP_mapping.sh  

### RNA-sequencing (RNA-seq) analysis  

- RNA_mapping.sh  

### Quantification and normalization of RNA-seq data  

- featureCounts.sh  
- Calculate_scaled_TPM_of_RNA-seq.R  
- Rank_SE_associated_genes_by_expression_levels.R  

### Genomic alignment of ATAC-seq data  

- ATAC_mapping.sh  

### Identification of super-enhancers (SEs), Gene assignment to SEs  

- findPeaks_annotatePeaks.sh  

### Motif enrichment analysis  

- Motif_enrichment_analysis.sh  

### Gene Ontology (GO) enrichment analysis  

- GO_analysis_of_SE_associated_genes.R  

### Author  

Hiroki Michida  

### License  

[MIT](LICENSE)