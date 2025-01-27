#!/usr/bin/env Rscript
#####################################################################
##
##  Plot a boxplot
##
#####################################################################


##############################
##  Read in libraries and modules

#  Load in libraries
library (ggplot2)
library (ggsignif)
library (Cairo)  #  For transparency
library (docopt)  #  See:  https://github.com/docopt/docopt.R


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

"Usage:  mitofates-boxplot.R --input INPUT --output OUTPUT --type IMGTYPE

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

colnames (x) <- gsub ("Gene", "Protein", colnames (x))

x$Protein <- gsub ("atp8", "Atp8p", x$Protein)
x$Protein <- gsub ("atp9", "Atp9p", x$Protein)
x$Protein <- gsub ("cox2", "Cox2p", x$Protein)
x$Protein <- gsub ("hac1", "Hac1p", x$Protein)


######################################################################
##  Plot the graph
######################################################################

x$Method <- as.factor (x$Method)
ggplot_obj <- ggplot (x, aes_string ("Method", "Probability"))
ggplot_obj <- ggplot_obj + geom_boxplot (position="dodge", aes (fill=Method))
# + geom_point (position = "jitter", size=0.05)
ggplot_obj <- ggplot_obj + facet_wrap(~Protein, scales="free_y")
ggplot_obj <- ggplot_obj + xlab ("Method") + ylab ("MitoFates Probability")
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

