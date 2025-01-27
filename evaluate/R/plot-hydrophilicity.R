#!/usr/bin/env Rscript
#####################################################################
##
##  Plot bargraphs
##
#####################################################################


##############################
##  Read in libraries and modules

#  Load in libraries
library (ggplot2)
library (ggsignif)
library (Cairo)  #  For transparency
library (docopt)  #  See:  https://github.com/docopt/docopt.R

library(dplyr)


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

"Usage:  plot-hydrophilicity.R --input INPUT --output OUTPUT --type IMGTYPE

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
##  Plot the graph
######################################################################

ggplot_obj <- ggplot (x, aes (x=Position, y=Hydrophilicity, fill=Colour))
ggplot_obj <- ggplot_obj + geom_bar (stat="identity")
ggplot_obj <- ggplot_obj + theme (legend.position="none")
ggplot_obj <- ggplot_obj + scale_fill_identity (guide = "none") + xlab ("Position")
ggplot_obj <- ggplot_obj + theme (axis.ticks.x = element_blank()) + theme_classic () + scale_y_continuous(limits = c(-3.5, 3.5))
ggplot_obj <- ggplot_obj + geom_hline (yintercept = 0)
# ggplot_obj <- ggplot_obj + scale_x_continuous (limits = c(1, length (x$Base) + 1))
# ggplot_obj <- ggplot_obj + scale_x_continuous (breaks=seq(1,length (x$Base),1), labels = x$Base)


######################################################################
##  Write out the graph
######################################################################

out_fn <- OUTPUT_ARG
if (IMGTYPE_ARG == "jpg") {
  ggsave (out_fn, plot=ggplot_obj, device="jpg", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
} else if (IMGTYPE_ARG == "eps") {
  ggsave (out_fn, plot=ggplot_obj, device="eps", width = FIGURE_WIDTH, height = FIGURE_HEIGHT, dpi = FIGURE_DPI, units = "cm")
}


