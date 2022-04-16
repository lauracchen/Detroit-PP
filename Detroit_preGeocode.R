#adapted from "Seattle Shutoffs - prep for geocoding" by Winn Costantini

#title: Detroit_preGeocode.R
#author: Laura Chen
#date: 3/10/22
#output: "csv file DetroitPP_GeocodeReady.csv"

#this script takes an input xlsx with separated Street Number (redacted), Street Address and outputs a csv file containing only unique addresses.

#set the correct working directory
setwd("C:/Users/laura/Desktop/Detroit PP")
library(data.table)
library(readxl)

##read in data, ensure file is in same folder as working directory
pp<- read_excel("Payment Plan Data 2021.05.31 (redacted).xlsx")

#transform to data table
dt <- data.table(pp)

#replace X's with 0's
dt$ServiceAddressStreetNumber <- str_replace(dt$ServiceAddressStreetNumber, "X", "0")
dt$ServiceAddressStreetNumber <- str_replace(dt$ServiceAddressStreetNumber, "X", "0")

#concatenate street # and street
dt$Address <- paste(dt$ServiceAddressStreetNumber,dt$ServiceAddressStreetName,sep=" ")
#put in city and state
dt$City <- "Detroit"
dt$State <- "Michigan"

#remove duplicate rows
dtUnique <- dt[!duplicated(dt[ , c("Address")]), ]

#save unique rows with count column as csv
write.csv(dtUnique, file = "DetroitPP_GeocodeReady.csv")
