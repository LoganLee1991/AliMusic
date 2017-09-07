require("forecast")
data <- read.csv("C:/Users/LeeHui/Desktop/all_artist_feature.csv",head=TRUE)
artistList <- as.vector(unique(data[,"artist_id"]))
dateList <- c("20150901","20150902","20150903","20150904","20150905","20150906",
              "20150907","20150908","20150909","20150910","20150911","20150912",
              "20150913","20150914","20150915","20150916","20150917","20150918",
              "20150919","20150920","20150921","20150922","20150923","20150924",
              "20150925","20150926","20150927","20150928","20150929","20150930",
              "20151001","20151002","20151003","20151004","20151005","20151006",
              "20151007","20151008","20151009","20151010","20151011","20151012",
              "20151013","20151014","20151015","20151016","20151017","20151018",
              "20151019","20151020","20151021","20151022","20151023","20151024",
              "20151025","20151026","20151027","20151028","20151029","20151030")
finalresult <- NULL
set.seed(777)
bagsize=20#bagging 的次数
for(artist in artistList){
  playdata <- data[data[,1]==artist,]
  playdata$month <- factor(months(as.Date(playdata[,2],'%Y-%m-%d')),levels=c("三月","四月","五月","六月","七月","八月"))
  groups <- split(playdata,playdata$month)
  pred=rep(0,60)
  for(i in c(1:bagsize)){
    sample <- lapply(groups,function(playTrain){
    temp <- playTrain[,'num_play']
      n <- length(temp)
      temp[sample(n,size = n*0.7)]
    })
    playTime_train=as.vector(unlist(sample))
    playSeries <- ts(playTime_train,frequency = 365,start = c(2015,60))
    #-------自回归整合移动平均（ARIMA）-----------
    arimaModel <- auto.arima(playSeries)
    arimaForecast <- forecast.Arima(arimaModel,h=60)
    #plot.forecast(arimaForecast)
    pred_arima <- as.vector(arimaForecast$mean)
    pred=pred+pred_arima
    # print(pred)
  }
  pred=pred/bagsize
  finalresult <- rbind(finalresult,cbind(artist,round(pred,0),dateList))
}
write.table(finalresult,"C:/Users/LeeHui/Desktop/baggingArima.csv", sep=",",col.names = F, row.names = F,quote = F)
