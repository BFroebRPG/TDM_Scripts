# Functions ----------------------------------------------------------------

### Add functionality for multiple directories

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
                 output_dir,
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
    if(file.exists(script_path) == TRUE){
      file.remove(script_path)
    }
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

#' Set Up
#' These 5 lines set up the function.

#Name of the Script
script_name <- "TDM_SetUp.s"

# Where the script will be saved
script_dir  <- "C:\\Users\\NH2user\\Documents\\"
# Where the MAT files are stored
input_dir   <- "C:\\FSUTMS\\FLSWM_V7.2_Clean\\Base\\SIS2018\\Output\\"

# Where the OMX Files are saved
output_dir  <- "C:\\Users\\NH2user\\Documents\\TDM_Scripts\\" 

# Mat files to convert
# currently the file extensions must be lowercase, 
# i'll be patching this eventually
mat_file    <- c("CONGSKIM.mat")

mat_to_omx_script(mat_file,
                  script_name,
                  script_dir,
                  input_dir,
                  output_dir)

#' To convert MATs from multiple directories, (i.e future and base year)
#' multiple version of `mat_to_omx_script` need to be run. input_dir and 
#' mat_file nee to be redefined before each run as well as setting 
#' overwrite to FALSE.  For some a differnt output director may be desired as 
#' well, especially when MAT files are consistently named in base and future 
#' year scenarious.
#' 
#' See below.
#' 

input_dir   <- "C:\\FSUTMS\\FLSWM_V7.2_Clean\\Base\\SIS2045\\Output\\"
output_dir  <- "C:\\Users\\NH2user\\Documents\\TDM_Scripts\\SIS2045\\" 
mat_file    <- c("CONGSKIM.mat")
mat_to_omx_script(mat_file,
                  script_name,
                  script_dir,
                  input_dir,
                  output_dir,
                  overwrite = FALSE)

