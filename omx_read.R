#devtools::install_github("gregmacfarlane/omxr")

library(dplyr)
library(omxr)

omx_file <- "H:/PMT_SERPM7/TAZ_Demand_EA.omx"

matrix_names <- list_omx(omx_file)

matricies <- read_all_omx(omx_file, 
             matrix_names$Matrices$name,
             long = F)

sum_matrix <- Reduce('+', matricies)

sum_matrix <- gather_matrix(sum_matrix,)
