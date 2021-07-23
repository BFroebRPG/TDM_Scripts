#devtools::install_github("gregmacfarlane/omxr")

library(dplyr)
library(omxr)

# OMX Matrix File to Load
omx_file <- "C:\\Users\\NH2user\\Documents\\TDM_Scripts\\CONGSKIM.omx"

#list names of the third axis in the matrix
matrix_names <- list_omx(omx_file)
matrix_names

# loads the matrix. The name argument will read in an individual matrix if blank
# all matrices will be loaded.
matricies <- read_all_omx(omx_file, 
             long = F)

# If multiple matrices need to be combined into one this function will do that
sum_matrix <- Reduce('+', matricies)

# this will convert a single matrix into a long form OD Data Frame that can be 
# saved to CSV
sum_matrix <- gather_matrix(sum_matrix,)

# for multiple matrices use the following
matrixes <- lapply(matricies, gather_matrix)