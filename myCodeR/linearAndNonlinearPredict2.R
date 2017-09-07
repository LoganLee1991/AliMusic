rnnpred <- read.csv("C:/Users/LeeHui/Desktop/mars_tianchi_artist_plays_predict-5.23.csv",head=F)
arimapred <- read.csv("C:/Users/LeeHui/Desktop/ARIMA_predict2.csv",head=F)
artistList <- as.vector(unique(rnnpred[,1]))
dateList <- as.vector(unique(rnnpred[,3]))
finalresult <- NULL
for(artist in artistList){
  rnn_play <- rnnpred[rnnpred[,1]==artist,2]
  arima_play <- arimapred[arimapred[,1]==artist,2]
  #wave <- (rnn_play-mean(rnn_play))*mean(arima_play)/mean(rnn_play)#combine_predict.csv
  wave <- rnn_play-mean(rnn_play)#combine_predictV2.csv
  newPred <- arima_play+wave
  print(paste(artist,' mean arima: ',mean(arima_play),' mean newpred: ',mean(newPred)))
  if(min(newPred)<0){newPred <- arima_play}
  finalresult <- rbind(finalresult,cbind(artist,round(newPred,0),dateList))
}
index <- finalresult[,2]<0
finalresult[index,]
finalresult[index,2] <- abs(as.integer(finalresult[index,2]))
write.table(finalresult,"C:/Users/LeeHui/Desktop/combine_predictV2.csv", sep=",",col.names = F, row.names = F,quote = F)


finalresult[finalresult[,2]==0,]
finalresult[finalresult[,1]=='c026b84e8f23a7741d9b670e3d8973f0',]

savePlot(plot(rnnpred[rnnpred[,1]=='2b7fedeea967becd9408b896de8ff903',2],type="l"),filename = artist,type='jpg',device = dev.cur())
plot(rnnpred[rnnpred[,1]=='c026b84e8f23a7741d9b670e3d8973f0',2],type="l")
plot(rnnpred[rnnpred[,1]=='8fb3cef29f2c266af4c9ecef3b780e97',2],type="l")
for(artist in artistList){
  plot(rnnpred[rnnpred[,1]==artist,2],type="l",main = artist)
  
}
