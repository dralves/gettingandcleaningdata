README
========

CodeBook.md contains information about the data and transformations required to tidy the original data set and to obtain the new, smaller tidy dataset.

Replication and Code
=================

The code used to produce both the tidy version of the original dataset and the new tidy dataset mentioned in the section above can be found in `run_analysis.R` and to replicate the process all that is needed is to execute, in an R shell:

```R
source("run_analisys.R")
```

The code will dowload the dataset for you if it hasn't been downloaded already.

The tidy data set can be found stored in variable `tidy` and new grouped averages tidy dataset will be stored in variable `tidy_subset` and also writted to disk under the name `tidy_subset.txt`.