install.packages("Amelia")
require(Amelia)
missmap(df.train, main="Titanic Training Data - Missings Map",col=c("yellow", "black"), legend=FALSE)
