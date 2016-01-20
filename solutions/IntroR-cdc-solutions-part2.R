# Part 2 solutions to exercises
# January 28-29, 2016


########
########
# Module 2-1
########
########

# For exercises in module 2-1, make sure working directory is set to 
#where "vlbw.csv" is located
library(dplyr)
library(tidyr)

# Clean data
vlbw <- read.csv("vlbw.csv", stringsAsFactors = F)
vlbw <- select(vlbw, bwt, gest, ivh, delivery, twn, pneumo)
vlbw <- vlbw[complete.cases(vlbw), ]
vlbw <- mutate(vlbw,  id = 1 : nrow(vlbw))

# Generate weights data
set.seed(1807)
n <- nrow(vlbw)
weight1 <- vlbw$bwt + 150 + rnorm(n, sd = 10) 
weight2 <- weight1 + 150 + rnorm(n, sd = 10)
weights <- data.frame(seq(1, nrow(vlbw)), weight1, weight2)
colnames(weights) <- c("id", "weight_1", "weight_2")
weights <- tbl_df(weights)

# Generate restricted vlbw data
vlbw_2 <- filter(vlbw, id < 35)









########
# Exercise 1a

# IDs in weights dataset
m_vlbw <- left_join(vlbw_2, weights)
n_distinct(m_vlbw$id)
m_vlbw <- left_join(weights, vlbw_2)
n_distinct(m_vlbw$id)












########
########
# Module 2-2
########
########


# Necessary for exercises in module 2-2
iris <- mutate(iris, petlencut = cut(Petal.Length, breaks = 4))
aq1 <- mutate(airquality, Month = factor(Month))

iris_spec <- group_by(iris, Species)
iris_sum <- summarise_each(iris_spec, funs(mean), Sepal.Length : Petal.Width)
means <- gather(iris_sum, "Variable", "Mean", 2 : 5)
sds <- summarise_each(iris_spec, funs(sd), Sepal.Length : Petal.Width)
sds <- gather(sds, "Variable", "SD", 2 : 5)

g1 <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, 
   color = Species)) + geom_point()





########
# Exercise 2a
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, 
    color = petlencut)) + geom_point()








########
# Exercise 2b
ggplot(aq1, aes(x = Day, y = Ozone, color = Month)) + 
    geom_line(aes(linetype = Month))









########
# Exercise 2c
CIdat <- full_join(means, sds)
CIdat <- mutate(CIdat, LB = Mean - SD, UB = Mean + SD)









########
# Exercise 2d
ggplot(CIdat, aes(y = Mean, x = Species, color = Species)) +
    geom_errorbar(aes(ymin = LB, ymax = UB), width = 0) + geom_point() +
    facet_wrap(~ Variable, scales = "free_y")










########
########
# Module 2-3
########
########

# For exercises in module 2-3
library(dplyr)
vlbw <- read.csv("vlbw.csv", stringsAsFactors = F)
vlbw <- select(vlbw, bwt, gest, ivh, delivery, twn, pneumo) 
vlbw <- vlbw[complete.cases(vlbw), ]
vlbw <- mutate(vlbw, outcome = 1 * ((ivh %in% c("definite", "possible"))))










########
# Exercise 3a

# Read in data
vlbw2 <- read.csv("vlbw.csv", stringsAsFactors = F)
# Create outcome
vlbw2 <- mutate(vlbw2, outcome = ifelse(ivh %in% c("definite", "possible"), 
     1, ifelse(ivh == "absent", 0, NA)))
# Show table
table(vlbw2$outcome, vlbw2$ivh, exclude = NULL)












########
# Exercise 3b

# Get the names of the predictor variables
vars <- colnames(iris)[2 : 4]
# for each predictor variable
for(i in 2 : 4) {
    #plot
    plot(iris[, i], iris[, "Sepal.Length"], xlab = vars[i],
         ylab = "Sepal.Length")
}







########
# Exercise 3c
lev1 <- levels(iris$Species)
# for loop
m_seplen <- vector()
for(i in 1 : length(lev1)) {
    m_seplen[i] <- mean(iris$Sepal.Length[iris$Species == lev1[i]])
}
# tapply
tapply(iris$Sepal.Length, iris$Species, mean)
# summarise
iris_spec <- group_by(iris, Species)
summarise(iris_spec, mean(Sepal.Length))












########
# Exercise 3d
nicescatter <- function(data = iris, xvar = "Sepal.Length", 
    yvar = "Sepal.Width", colorvar = "Species") {

    plot(data[, xvar], data[, yvar], col = data[, colorvar], pch = 16,
         xlab = xvar, ylab = yvar)
    legend("topright", legend = levels(data[, colorvar]), 
           col = seq(1, length(levels(data[, colorvar]))), pch = 16)
}
nicescatter()







########
########
# Overall exercise 3
########
########


# Load data
data(airquality)
# Create Date variable
airquality <- mutate(airquality, Month = paste0("0", Month), 
                     Day = ifelse(Day < 10, paste0("0", Day), Day))
airquality <- unite_(airquality, "Date", c("Month", "Day"), sep = "-", remove = F)
airquality <- mutate(airquality, Date = as.Date(paste0("1973-", Date)))

# Transform data
airquality <- gather(airquality, "Variable", "Value", Ozone : Temp)

# Plot time series
ggplot(airquality, aes(x = Date, y = Value)) + geom_line() + 
    facet_wrap(~ Variable, scales = "free_y")

# Compute mean, min, max
airquality <- mutate(airquality, Day = as.numeric(Day))
gaq <- group_by(airquality, Day, Variable)
gaq <- summarise(gaq, mn1 = mean(Value, na.rm = T), 
                 min1 = min(Value, na.rm = T), 
                 max1 = max(Value, na.rm = T))

# Plot time series
ggplot(gaq, aes(x = Day, y = mn1)) + 
    geom_line() + ylab("Mean (minimum, maximum)") +
    geom_ribbon(aes(ymin = min1, ymax = max1), alpha = 0.2) +
    facet_wrap(~ Variable, scales = "free_y")




