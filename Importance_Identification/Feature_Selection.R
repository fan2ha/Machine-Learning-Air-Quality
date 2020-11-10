setwd("C:/Users/woshi/Desktop/CE_675_Project/")
rm(list = ls(all=TRUE))

set.seed(666)
library(plyr)
library(tidyverse)
library(ggplot2)
library(splines)
library(caret)
library(randomForest)
library(ncdf4)
library(NeuralNetTools)

emis <- nc_open("C:/Users/woshi/Desktop/CE_675_Project/Data/emis_data/emis_mole_all_20160101_4NC3_withbeis_2016fg_16j.ncf")
met <- nc_open("C:/Users/woshi/Desktop/CE_675_Project/Data/met_data/metcro2d.4nc3.35l.160101")
aq <- nc_open("C:/Users/woshi/Desktop/CE_675_Project/Data/aq_conc/CCTM_ACONC_v521_intel2018.2.199_4km_NC_BSP_20160101.nc")


NO = ncvar_get(emis, "NO")
NO2 = ncvar_get(emis, "NO2")
PBL = ncvar_get(met, "PBL")
Q2 = ncvar_get(met, "Q2")
TEMP2 = ncvar_get(met, "TEMP2")
WSPD10 = ncvar_get(met, "WSPD10")
WDIR10_degree = ncvar_get(met, "WDIR10")
WDIR10 = cos(WDIR10_degree/180*pi)
O3 = ncvar_get(aq, "O3")
CH4 = ncvar_get(emis, "CH4")
CH4_INV = ncvar_get(emis, "CH4_INV")
VOC_BEIS = ncvar_get(emis, "VOC_BEIS")
VOC_INV = ncvar_get(emis, "VOC_INV")
# PRSFC = ncvar_get(met, "PRSFC")
# GSW = ncvar_get(met, "GSW")
RN = ncvar_get(met, "RN")
RC = ncvar_get(met, "RC")
CLDB = ncvar_get(met, "CLDB")
WBAR = ncvar_get(met, "WBAR")

NO = as.vector(NO[(160:170), (62:72), (1:24)])
NO2 = as.vector(NO2[(160:170), (62:72), (1:24)])
PBL = as.vector(PBL[(160:170), (62:72), (1:24)])
Q2 = as.vector(Q2[(160:170), (62:72), (1:24)])
TEMP2 = as.vector(TEMP2[(160:170), (62:72), (1:24)])
WSPD10 = as.vector(WSPD10[(160:170), (62:72), (1:24)])
WDIR10 = as.vector(WDIR10[(160:170), (62:72), (1:24)])
O3 = as.vector(O3[(160:170), (62:72), (1:24)])
CH4 = as.vector(CH4[(160:170), (62:72), (1:24)])
CH4_INV = as.vector(CH4_INV[(160:170), (62:72), (1:24)])
VOC_BEIS = as.vector(VOC_BEIS[(160:170), (62:72), (1:24)])
VOC_INV = as.vector(VOC_INV[(160:170), (62:72), (1:24)])
# PRSFC = as.vector(PRSFC[(160:170), (62:72), (1:24)])
# GSW = as.vector(GSW[(160:170), (62:72), (1:24)])
RN = as.vector(RN[(160:170), (62:72), (1:24)])
RC = as.vector(RC[(160:170), (62:72), (1:24)])
CLDB = as.vector(CLDB[(160:170), (62:72), (1:24)])
WBAR = as.vector(WBAR[(160:170), (62:72), (1:24)])

data = data.frame(NO, NO2, PBL, Q2, TEMP2, WSPD10, WDIR10, O3, 
                  CH4, CH4_INV, VOC_BEIS, VOC_INV,
                  RN, RC, CLDB, WBAR)

# Create k-fold
kfolds <- createFolds(data$O3, k = 5, returnTrain = TRUE) 

fold <- kfolds[[1]]
training <- data[fold,]
testing <- data[-fold,]

# train rf
model_rf <- train(
  O3 ~ .,   
  data = training,
  method = "rf",
  trControl = trainControl(method = "oob"),
  importance = TRUE)

# rf importance
caret::varImp(model_rf, scale=FALSE)
plot(caret::varImp(model_rf, scale=FALSE))

# train nn
model_nn <- train(
  O3 ~ .,   
  data = training,
  method = "nnet",
  trControl = trainControl(method = "cv"),
  importance = TRUE)

# Plot neural network
plotnet(model_nn)

# nn importance
olden(model_nn)
garson(model_nn)
lekprofile(model_nn)

a = neuraldat
