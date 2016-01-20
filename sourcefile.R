# Start with clean working space
rm(list = ls())

# Reload iris data
data(iris)

# Code chunk to set options

# Load knitr and tidy
library(knitr)
library(tidyr)

# Set knitr options
opts_chunk$set(message = F, fig.align = "center", warning = F, tidy = T, 
               out.width= '6cm', out.height = '6cm', 
               fig.height = 4, fig.width = 4,
               size = "normal",
               tidy.opts = list(width.cutoff = 60, size = "normal"))


# Change this to data directory
opts_knit$set(root.dir = "files/")

par(ps =  5)


# Libraries
# for Module 1-2
library(dplyr)
# for sasxport.get
library(Hmisc)
# for epitab
library(epitools)
# for obtaining contrasts
library(contrast)
# for survival analysis
library(survival)
# for linear mixed effects models
library(lme4)
# for ggplot2
library(ggplot2)
# for adding ggplots
library(gridExtra)
# for more color palettes
library(RColorBrewer)
# for google maps
library(googleVis)
# for reproducible document
library(knitr)
# for tidy code
library(tidyr)
# for av.plots
library(car)
# formatting
library(pander)
# knitr
# add these for rmarkdown
library(htmltools)
library(bitops)
library(caTools)
library(rmarkdown)




# Fix state dataset
state <- data.frame(rownames(state.x77), state.x77)
colnames(state)[1] <- "State"

