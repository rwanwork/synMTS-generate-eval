#!/usr/bin/env Rscript
#####################################################################
##
##  Plot a set of linegraphs
##
#####################################################################


##############################
##  Read in libraries and modules

#  Load in libraries
library (ggplot2)
library (ggsignif)
library (Cairo)  #  For transparency
library (docopt)  #  See:  https://github.com/docopt/docopt.R

# library (tidyr)


#####################################################################
##  Setup constants
#####################################################################

FIGURE_WIDTH <- 18
FIGURE_HEIGHT <- 12
FIGURE_DPI <- 600


#####################################################################
##  Functions
#####################################################################


#####################################################################
##  Process arguments using docopt
#####################################################################

"Usage:  ranks.R --input INPUT --output OUTPUT --type IMGTYPE

Options:
  --input INPUT  Input file
  --output OUTPUT  Output file
  --type IMGTYPE  Type of graph to output

.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output
IMGTYPE_ARG <- opts$type


######################################################################
##  Read in the data table
######################################################################

in_fn <- INPUT_ARG

x <- read.table (in_fn, sep="\t", header=TRUE)
colnames (x) <- c ("Rank", "Method", "Count")
x$Method <- as.factor (x$Method)


######################################################################
##  Plot the graph
######################################################################

ggplot_obj <- ggplot (data=x, aes(x=Rank, y=Count, group=Method))
ggplot_obj <- ggplot_obj + geom_line (aes (color = Method))
ggplot_obj <- ggplot_obj + geom_point (aes (color = Method))


######################################################################
##  Write out the graph
######################################################################

out_fn <- OUTPUT_ARG
if (IMGTYPE_ARG == "jpg") {
  ggsave (out_fn, plot=ggplot_obj, device="jpg", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
} else if (IMGTYPE_ARG == "eps") {
  ggsave (out_fn, plot=ggplot_obj, device="eps", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
}


