require("forecast")
data <- read.csv("C:/Users/LeeHui/Desktop/all_artist_feature.csv",head=TRUE)
artistList <- as.vector(unique(data[,"artist_id"]))
trainSize <- 123 #训练序列长度
for(artist in artistList[c(7:11)]){
    playTime <- data[data[,1]==artist,"num_play"]
    print(playTime)
    lenSerie <- length(playTime)#序列总长度
    playTime_train <- playTime[c(1:trainSize)]
    playTime_test <- playTime[c((trainSize+1):lenSerie)]
    #births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
    playSeries <- ts(playTime_train,frequency = 365,start = c(2015,60))
    #-------自回归整合移动平均（ARIMA）-----------
    arimaModel <- auto.arima(playSeries)
    arimaForecast <- forecast.Arima(arimaModel,h=(lenSerie-trainSize))
    #plot.forecast(arimaForecast)
    pred_arima <- round(as.vector(arimaForecast$mean),0)
    
    #-------指数平滑法(HoltWinters)-------------
    #plot.ts(playSeries)
    HoltWinModel <- HoltWinters(playSeries,gamma=FALSE)
    #plot(HoltWinModel)
    HWForecast <- forecast.HoltWinters(HoltWinModel,h=(lenSerie-trainSize))
    #plot.forecast(HWForecast)
    pred_holtw <- round(as.vector(HWForecast$mean),0)
    #-------指数平滑法(hw)-------------
    hwModel_1 <- hw(playSeries,h=(lenSerie-trainSize),seasonal = "multiplicative")
    pred_hw1 <- round(as.vector(hwModel_1$mean),0)
    hwModel_2 <- hw(playSeries,h=(lenSerie-trainSize),seasonal = "additive")
    pred_hw2 <- round(as.vector(hwModel_2$mean),0)
    #-----结果评估-----
    print(artist)
    print("arima")
    print(mean(abs(pred_arima-playTime_test)/playTime_test))
    print("holt winters")
    print(mean(abs(pred_holtw-playTime_test)/playTime_test))
    print("hw1")
    print(mean(abs(pred_hw1-playTime_test)/playTime_test))
    print("hw2")
    print(mean(abs(pred_hw2-playTime_test)/playTime_test))
}

cbind(playTime_test,pred_arima,pred_hw)
#-------局部加权回归法(STL)-------------
playSeriesComp <- stlm(playSeries,s.window = 'periodic')
plot(playSeriesComp)
