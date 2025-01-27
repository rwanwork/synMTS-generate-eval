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

library (dplyr)


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

"Usage:  deepmito-boxplot.R --input INPUT --output OUTPUT --type IMGTYPE

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

colnames (x) <- c ("Name", "ID", "Method", "Seed", "Protein", "Predicted", "Score", "Length", "GO_ID", "GO_Term", "Comments")

x <- x[x$Method == 4 | x$Method == 7,]

x$Protein <- gsub ("atp8", "Atp8p", x$Protein)
x$Protein <- gsub ("atp9", "Atp9p", x$Protein)
x$Protein <- gsub ("cox2", "Cox2p", x$Protein)
x$Protein <- gsub ("hac1", "Hac1p", x$Protein)

x$Predicted <- as.factor (x$Predicted)

# aggregate (x$Predicted, by=list(Category=x$Protein), FUN=count)
x %>% count (Protein, Predicted)

x %>% count (Protein, GO_Term)


######################################################################
##  Plot the graph
######################################################################

x$Method <- as.factor (x$Method)
x$Gene <- as.factor (x$Protein)
ggplot_obj <- ggplot (x, aes_string ("Protein", "Score"))
# ggplot_obj <- ggplot_obj + geom_boxplot (position="dodge", aes (fill=Protein)) + geom_jitter (height = 0, width = 0.1)

ggplot_obj <- ggplot_obj + geom_violin (aes (fill=Protein)) # (position="dodge", aes (fill=Protein)) + geom_jitter (height = 0, width = 0.1)

# ggplot_obj <- ggplot_obj + facet_wrap(~Protein, scales="free_y")
ggplot_obj <- ggplot_obj + xlab ("Protein") + ylab ("DeepMito Score")
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


