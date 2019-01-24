###############################
# Setting Up Your Environment #
###############################
# the following packages will be used
list_of_pkgs <- c(
  "nycflights13",  # provides data we'll use
  "repurrrsive",   # provides data we'll use
  "AmesHousing",   # provides data we'll use
  "tidyverse",     # provides multiple packages we'll use
  "here",          # provides easy path configurations
  "tinytex",       # provides a small Tex operator if you don't already have one,
  "ranger",        # provides random forest model for one example,
  "bench",         # provides benchmarking function for one example
  "Rcpp"           # provides C++ package for one example
)

# run the following line of code to install the packages you currently do not have
new_pkgs <- list_of_pkgs[!(list_of_pkgs %in% installed.packages()[,"Package"])]
if(length(new_pkgs)) install.packages(new_pkgs)