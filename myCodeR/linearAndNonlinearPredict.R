rnnPred <- read.csv("C:/Users/1/Desktop/mars_tianchi_artist_plays_predict-5.23.csv",head=FALSE)
arimaPred <- read.csv("C:/Users/1/Desktop/mars_tianchi_artist_plays_predict.csv",head=FALSE)
artistList <- as.vector(unique(rnnPred[,1]))
dateList <- as.vector(unique(rnnPred[,3]))
finalResult <- NULL
for(artist in artistList[c(1,2)]){
  rnnPlayList <- rnnPred[rnnPred[,1]==artist,2]
  arimaPlayList <- arimaPred[arimaPred[,1]==artist,2]
  meanPlay <- mean(rnnPlayList)
  wave <- rnnPlayList-meanPlay
  newPred <- arimaPlayList+wave
  finalResult <- rbind(finalResult,cbind(artist,newPred,dateList))
}
finalResult