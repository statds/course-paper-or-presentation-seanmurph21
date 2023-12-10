# get the classification accuracy values
CAV <- as.vector(1 - as.vector(c(0.363,0.446,0.409,0.529,0.484,0.303)))

# make the barplot with the results
barplot(CAV,
main = "CAV by Model",
xlab = "Model",
ylab = "Classification Accuracy Value",
names.arg = c("LDA", "NB", "KNN1", "KNN5", "KNN15", "RF"),
col = "steelblue",
horiz = FALSE)