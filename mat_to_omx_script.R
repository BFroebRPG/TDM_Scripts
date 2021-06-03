# Functions ----------------------------------------------------------------
## Required Package 
library(stringr)

#' Create a Line for Cube Script for OMX Export
#'
#' @description
#' Creates a single line script for exporting matrix files in Cube to OMX files.
#'  A helper function for mat_to_omx_script
#'
#' @param mat_file The matrix file to be converted to OMX.
#' 
#' @param script_name The Cube script
#' 
#' @param script_dir The directory where the Cube Script should be saved.
#' 
#' @param input_dir The directory where Cube keeps the .mat files.
#' 
#' @param output_dir The directory where the OMX files should be saved.
#' 
#' @param append Should the line be appended to an existing script.
#'  
#' @noRd      
mat_to_omx_line <- function(mat_file,
                            script_name,
                            script_dir,
                            input_dir,
                            output_dir,
                            append = FALSE){
  require(stringr)
  script_path <- paste0(script_dir, script_name)
  
  omx_file <- str_replace(mat_file,
                          ".mat",
                          ".omx")
    
  line <- paste0('CONVERTMAT FROM="',
                 input_dir,
                 mat_file,
                 '" TO="',
                 input_dir,
                 omx_file,
                 '" FORMAT=OMX COMPRESSION=0')
  
  write(line, file = script_path, sep = "\n", append = append)
}
#' Create a  Cube Script for OMX Export
#' 
#' @description
#' Creates a script for exporting matrix files in Cube to OMX files.
#'
#' @param mat_file The matrix file to be converted to OMX.
#' 
#' @param script_name The Cube script
#' 
#' @param script_dir The directory where the Cube Script should be saved.
#' 
#' @param input_dir The directory where Cube keeps the .mat files.
#' 
#' @param output_dir The directory where the OMX files should be saved.
#' 
#' @param overwrite Should the lines be appended to an existing script or should 
#'   the existing script be overwritten with the new lines.
#'
mat_to_omx_script <- function(mat_files,
                              script_name,
                              script_dir,
                              input_dir,
                              output_dir,
                              overwrite = TRUE){
  script_path <- paste0(script_dir, script_name)
  
  if(overwrite == TRUE){
    file.remove(script_path)
  }
  
  for (file in mat_files) {
    mat_to_omx_line(mat_file = file,
                    script_name,
                    script_dir,
                    input_dir,
                    output_dir,
                    append = TRUE)
  }
}


# Testing -----------------------------------------------------------------

script_name <- "testing.s"
script_dir  <- "H:\\PMT_SERPM7\\"
input_dir   <- "C:\\SERPM7\\Output\\Out-2010R\\ctramp\\"
output_dir  <- "H:\\PMT_SERPM7\\" 
mat_file    <- c("TAZ_Demand_EA.mat",
                 "TAZ_Demand_AM.mat",
                 "TAZ_Demand_MD.mat",
                 "TAZ_Demand_PM.mat",
                 "TAZ_Demand_EV.mat")

mat_to_omx_script(mat_file,
                  script_name,
                  script_dir,
                  input_dir,
                  output_dir,
                  overwrite = TRUE)