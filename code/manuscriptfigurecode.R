# load in the data
redwine <- read.csv(
    "C:/Users/seanm/OneDrive/Documents/STAT 3494W/winequality-red.csv",
                    sep = ",")
data(redwine)

#create a boxplot and a histogram for redwine$quality
par(mfrow = c(1,2))
boxplot(redwine$quality, xlab = "Wine Quality",
        main = "Boxplot of Wine Quality", col = "lightblue")
hist(redwine$quality, xlab = "Wine Quality",
     main = "Histogram of Wine Quality", col = "lightblue", border = "navy")