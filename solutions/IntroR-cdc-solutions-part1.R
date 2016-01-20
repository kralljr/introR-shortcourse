# Part 1 solutions to exercises
# January 28-29, 2016


########
########
# Module 1-1
########
########

# items needed for module 1-1
vectorstring <- c("R", "is", "useful", "for", "data", "analysis")








########
# Exercise 1a
# Create a sequence of odd numbers
seqodd <- seq(1, length(vectorstring), by = 2)
seqodd
# Subset vectorstring by seqodd
vectorstring[seqodd]
# Equivalent
vectorstring[seq(1, length(vectorstring), by = 2)]




















########
# Exercise 1b
# Draw 100 normals
draw100 <- rnorm(100)
# Get summary statistics
sum100 <- summary(draw100)
sum100
# Obtain 1st quartile, median, 3rd quartile
# Save results as new vector
sum3 <- sum100[c(2, 3, 5)]
sum3











########
# Exercise 1c

# NOTE: solutions will be dependent on user and computer
# Example for Mac
#setwd("/Users/jennakrall/Dropbox/IntrotoREpi/introR-cdc/")
# Example for PC
#setwd("C:/Users/Desktop")

# Shows items in working directory.  Should include "diabetes.csv"
list.files()
# Shows items in current R environment.  
# If you completed exercise 1a, should include the object vectorstring
ls()









########
########
# Module 1-2
########
########


# For exercises in module 1-2
library(dplyr)






########
# Exercise 2a

# Filter the data so petal width is <= 0.5
newiris <- filter(iris, Petal.Width <= 0.5)
# Select only certain columns
newiris <- select(newiris, Sepal.Length, Sepal.Width, Petal.Length)
head(newiris)










########
# Exercise 2b


iris2 <- mutate(iris, 
    stdseplen = (Sepal.Length - mean(Sepal.Length)) / sd(Sepal.Length))
head(iris2)









########
# Exercise 2c

# Group by species
iris_spec <- group_by(iris, Species)
# Use summarise each to obtain all means and sd
iris_sum <- summarise_each(iris_spec, funs(mean, sd))
data.frame(iris_sum)



















########
########
# Module 1-3
########
########



# For exercises in module 1-3
library(dplyr)





########
# Exercise 3a
plot(x = iris$Sepal.Width, y = iris$Petal.Width, 
     xlab = "Sepal width",
     ylab = "Petal width", pch = 2, col = "dodgerblue",
     main = "Scatterplot of Iris data")













########
# Exercise 3b

# Plot sepal width against sepal length
plot(x = iris$Sepal.Length, y = iris$Sepal.Width)
# Group by species
iris_spec <- group_by(iris, Species)
# Find mean by species
mn1 <- summarise(iris_spec, mean1 = mean(Sepal.Width))
# Add horizontal lines to plot
abline(h = mn1$mean1)










########
# Exercise 3c

# Group by species
iris_spec <- group_by(iris, Species)  
# Find mean sepal width by species
iris_sum <- summarise(iris_spec, mean1 = mean(Sepal.Width))

# Plot sepal width vs. sepal length, colored by species
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, 
     col = iris$Species)
# Add lines for the mean, color same as main plot
abline(h = mn1$mean1, col = 1 : 3)
# Add legend
legend("topright", legend = c("setosa", "versicolor", "virginica"), 
     col = 1 : 3, lty = 1)
















########
########
# Overview exercise 1
########
########

# Look at data
head(airquality)

# Compute means of each numeric variable
gaq <- group_by(airquality, Month)
sum1 <- summarise_each(gaq, funs(mean), Ozone : Temp)
# Ozone has missing values in all months, solar is missing in May and August

# Histogram
hist(airquality$Ozone, xlab = "Ozone (ppb)", main = "Histogram of ozone")


#png("overallex1.png")
plot(Ozone ~ Temp, data = airquality, col = airquality$Month,
     xlab = "Temperature (degrees F)", ylab = "Ozone (ppb)", main = "")
legend("topleft", legend = c("May", "June", "July", "August", "September"),
       col = 5 : 9, pch = 1, lty = 1)

# Find mean temperature for each month
abline(v = sum1$Temp, col = 5 : 9)
#dev.off()











########
########
# Module 1-4
########
########

# For Exercises in module 4, be sure your working directory 
# is set to where all the data files are







########
# Exercise 4a
vlbw <- read.csv("vlbw.csv", stringsAsFactors = F)
















########
# Exercise 4b

# Draw 10 random normals 
vec1 <- rnorm(10)
# Subset vector
vec1[vec1 > 0]











########
# Exercise 4c

# Draw 20 random normals
x <- rnorm(20)
# Create a matrix based on 20 values
mat1 <- matrix(x, nrow = 4, ncol = 5)
mat1
# Subset matrix
mat1[3, ]
mat1[4, 2]










########
# Exercise 4d

# Read in txt dataset (note: header = F by default)
flumiss <- read.table("googleflumissing.txt", header = T)
# How many missing/non-missing observations
table(complete.cases(flumiss))
# Subset data to create a complete case dataset
flucomplete <- flumiss[complete.cases(flumiss), ]
# Save the complete case data
write.table(flucomplete, "googleflucomplete.txt", row.names = F)













########
########
# Module 1-5
########
########


# For exercises in module 1-5, make sure working directory is set to 
#where "vlbw.csv" is located
library(dplyr)

# Read in data
vlbw <- read.csv("vlbw.csv", stringsAsFactors = F)
# Extract relevant variables
vlbw <- select(vlbw, ivh, bwt, gest, pneumo, delivery, twn)
# Remove missing observations
vlbw <- vlbw[complete.cases(vlbw), ]
# Create outcome variable
vlbw <- mutate(vlbw, outcome = 1 * ((ivh %in% c("definite", "possible"))))
# Make sure ivh is a factor
vlbw$ivh <- factor(vlbw$ivh)
# Fit model
lm1 <- lm(gest ~ ivh + bwt, data = vlbw)




########
# Exercise 5a
t.test(vlbw$gest ~ vlbw$outcome, var.equal = T, alternative = "greater" )









########
# Exercise 5b

# Perform chi2 test
chi2 <- chisq.test(vlbw$outcome, vlbw$pneumo)
# Extract out p-value
chi2$statistic










########
# Exercise 5c
power.t.test(n = 10, delta = 2, sd = 2, sig.level = 0.1, 
             type = "two.sample", alternative = "two.sided")








########
# Exercise 5d

# Find residuals
head(lm1$resid)
# Make histogram of residuals
hist(lm1$resid)











########
# Exercise 5e

# Create new dataframe for new data
newdat1 <- data_frame("definite", 1300)
colnames(newdat1) <- c("ivh", "bwt")
# Predict based on lm1
predict(lm1, newdata = newdat1)
















########
# Exercise 5f
glm1 <- glm(outcome ~ delivery, data = vlbw, family = "binomial")











########
########
# Overview exercise 2
########
########

# Read in data
diab <- read.csv("diabetes.csv")
# Fit glm
lm1 <- glm(diab1 ~ chol + hdl + age + gender + height + weight + 
    waist + hip, data = diab, family = "binomial")
# Compute OR and 95% CI, removing intercept
or <- exp(lm1$coef[-1])
ci1 <- exp(confint(lm1)[-1, ])
