## split training data into train batch and test batch
set.seed(23)
training.rows <- createDataPartition(df.train$Survived,p = 0.8, list = FALSE)
train.batch <- df.train.munged[training.rows, ]
test.batch <- df.train.munged[-training.rows, ]

Titanic.logit.1 <- glm(Fate ~ Sex + Class + Age + Family + Embarked + Fare,
data = train.batch, family=binomial("logit"))

Titanic.logit.2 <- glm(Fate ~ Sex + Class + Age + Family + Embarked,
                       data = train.batch, family=binomial("logit"))


glm.tune.1 <- train(Fate ~ Sex + Class + Age + Family + Embarked,
data = train.batch,
method = "glm",
metric = "ROC",
trControl = cv.ctrl)

glm.tune.1

summary(glm.tune.1)

set.seed(35)
glm.tune.2 <- train(Fate ~ Sex + Class + Age + Family + I(Embarked=="S"),
data = train.batch, method = "glm",
metric = "ROC", trControl = cv.ctrl)
summary(glm.tune.2)

set.seed(35)
glm.tune.3 <- train(Fate ~ Sex + Class + Title + Age 
                    + Family + I(Embarked=="S"), 
                    data = train.batch, method = "glm",
                    metric = "ROC", trControl = cv.ctrl)

summary(glm.tune.3)

glm.tune.4 <- train(Fate ~ Class + I(Title=="Mr") + I(Title=="Noble") 
                    + Age + Family + I(Embarked=="S"), 
                    data = train.batch, method = "glm",
                    metric = "ROC", trControl = cv.ctrl)

summary(glm.tune.4)

set.seed(35)

glm.tune.5 <- train(Fate ~ Class + I(Title=="Mr") + I(Title=="Noble") 
                    + Age + Family + I(Embarked=="S") 
                    + I(Title=="Mr"&Class=="Third"), 
                    data = train.batch, 
                    method = "glm", metric = "ROC", 
                    trControl = cv.ctrl)

summary(glm.tune.5)


## note the dot preceding each variable
ada.grid <- expand.grid(.iter = c(50, 100),
                        .maxdepth = c(4, 8),
                        .nu = c(0.1, 1))
ada.tune


