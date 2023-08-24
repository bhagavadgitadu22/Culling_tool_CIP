# Aim of the repository 
This Github repository was created to host the culling tool developed by the Collection of bacteria of the Institut Pasteur (CIP, xxx). It was created to suit our specific needs (decide on a list of bacteria to sequence and to discard among our 20000 strains) and requirements (our homemade LIMS (Laboratory Information Management System)). You can use it at your convenience and adapt it to the needs of your collection.

The Github includes 2 main folders: one for SQL scripts and the other one for Python scripts. Most SQL scripts are called by the Python scripts.

# General structure of the files
## SQL folder:
It contains 5 directories:
- 1_groupings contains scripts to subdivide the data in different panels of interest (5 subdirectories ; 30 scripts in total)
- 2_infos_souches to gather the information about a panel of strains (1 script)
- 3_metrics to calculate the scores of a group of strains (5 scripts)
- 4_upset to generate a file usable to built an Upset plot (1 script)
- 5_krona to build a Krona plot of the taxa before and after the culling tool (1 script)

### 1_groupings
It is the biggest directory. It is divided in 5 subdirectories:
- 1_group0 permits to extract only the strains that will be studied from the whole collection: this subset will be used for all further operations (2 scripts)
- 2_natural_producers to import the list of species which are natural producers according to NPAtlas (www.npatlas.org) (1 script)
- 3_extremophiles to compile the list of extremophiles of the collection based on literature and analytic data (8 scripts)
- 4_strains_sequenced to gather strains already sequenced by the collection or anywhere where the same strains are stored (3 scripts)
- 5_groups_constitution to finally build the panels, i.e. temporary SQL tables callable by Python or by hand (16 scripts)

## Python_and_R folder:
It contains 3 directories:
- 1_scores_generation creates the groupings from the SQL scripts 1_groupings, creates the detailed Excel about each group and the resume Excel from the SQL 2_infos_souches and 3_metrics (4 scripts)
- 2_upset_plot generates an Upset plot about the intersections of panels from the result of 4_upset (1 script: R script upset_plot.r)
- 3_krona downloads the most recent taxonomic updates from NCBI and builds a csv Krona input file from the SQL script in 5_krona (2 scripts)
