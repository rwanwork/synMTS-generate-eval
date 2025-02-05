#!/usr/bin/env Rscript
#####################################################################
##
##  Plot a set of boxplots
##
#####################################################################


##############################
##  Read in libraries and modules

#  Load in libraries
library (ggplot2)
library (ggsignif)
library (Cairo)  #  For transparency
library (docopt)  #  See:  https://github.com/docopt/docopt.R

library (tidyr)


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

"Usage:  properties-dist.R --input INPUT --output OUTPUT --type IMGTYPE

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


######################################################################
##  Remove unnecessary columns and flatten the data frame
######################################################################

x$ID <- NULL
x$Seed <- NULL
x$Gene <- NULL

#x$Length <- NULL
x$charge_avg <- NULL
x$flexibility_sum <- NULL
x$flexibility_avg <- NULL
x$transmembrane_sum <- NULL
x$transmembrane_avg <- NULL
x$hydropathicity_sum <- NULL
x$hydropathicity_avg <- NULL
x$polarity_sum <- NULL
x$polarity_avg <- NULL
x$bulkiness_sum <- NULL
x$bulkiness_avg <- NULL

x$Method <- as.factor (x$Method)

x_long <- gather (x, key="measure", value="Length", c("Length"))


######################################################################
##  Plot the graph
######################################################################

ggplot_obj <- ggplot (x_long, aes(x=Method, y=Length, group=Method))
ggplot_obj <- ggplot_obj + geom_boxplot (aes (fill=Method))
# ggplot_obj <- ggplot_obj + facet_wrap (~measure, scales="free_y")
ggplot_obj <- ggplot_obj + theme (legend.position = "none")


######################################################################
##  Write out the graph
######################################################################

out_fn <- OUTPUT_ARG
if (IMGTYPE_ARG == "jpg") {
  ggsave (out_fn, plot=ggplot_obj, device="jpg", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
} else if (IMGTYPE_ARG == "eps") {
  ggsave (out_fn, plot=ggplot_obj, device="eps", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
}


