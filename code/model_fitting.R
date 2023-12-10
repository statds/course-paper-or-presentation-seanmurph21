# partition the data into a training and test set
set.seed(111)
ind <- sample(nrow(redwine),1200)
train <- redwine[ind,]
test <- redwine[-ind,]

# fit the LDA model
library(MASS)
lda_fit <- lda(quality ~ ., data = train)

# obtain the LDA confusion matrix
lda_pred <- predict(lda_fit,test)
lda_class <- lda_pred$class
test_quality <- test$quality
table(lda_class, test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate
(399-(1+132+99+22))/399

# fit the NB model
library(e1071)
nb_fit <- naiveBayes(quality ~ ., data = train)

# obtain the NB confusion matrix
nb_preds <- predict(nb_fit,test)
table(nb_preds,test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate
(399-(1+1+118+85+16))/399

# fit the KNN models with K = 1, K = 5, and K = 15
library(class)
train_X <- cbind(train$fixed.acidity,train$volatile.acidity,train$citric.acid,
                 train$residual.sugar,train$chlorides,train$free.sulfur.dioxide,
                 train$total.sulfur.dioxide,train$density,train$pH,
                 train$sulphates,train$alcohol)
test_X <- cbind(test$fixed.acidity,test$volatile.acidity,test$citric.acid,
                 test$residual.sugar,test$chlorides,test$free.sulfur.dioxide,
                 test$total.sulfur.dioxide,test$density,test$pH,
                 test$sulphates,test$alcohol)
train_quality <- train$quality
set.seed(222)
knn_pred1 <- knn(train_X, test_X, train_quality, k = 1)
knn_pred5 <- knn(train_X, test_X, train_quality, k = 5)
knn_pred15 <- knn(train_X, test_X, train_quality, k = 15)

# obtain the confusion matrix for K = 1
table(knn_pred1, test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate for K = 1
(399-(122+90+24))/399

# obtain the confusion matrix for K = 5
table(knn_pred5, test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate for K = 5
(399-(107+66+15))/399

# obtain the confusion matrix for K = 15
table(knn_pred15, test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate for K = 15
(399-(122+74+10))/399

# fit the random forest model 
library(randomForest)
set.seed(333)
rf_mod <- randomForest(factor(quality) ~ ., data = train,
                          mtry = 4, importance = TRUE, proximity = TRUE)
pred_rf <- predict(rf_mod, newdata = test)
table(pred_rf,test_quality,dnn=c("Predicted", "Actual"))

# calculate the overall error rate for the random forest model
(399-(136+118+24))/399