#R ile Twitter analizi

#Twitter paketini yukle
library("twitteR")
library("stringr")

#source("twitter_authorize.R")
#Kendi api anahtarlarinizi kullanabilirsiniz. Asagidakiler ornek
#oauth<-getTwitterOAuth("m7aezBfdgr7TDVk0yarR6A", "jlH5LQRxGUyt5t6ZaYU12w15R08mDLsbyxMbWwv1wQ")
#registerTwitterOAuth(oauth)

#Arama kelimeleri
search_string<-c("elektrikler kesik", "elektrikler","#elektrikkesik","elektrikler gitti")

Twitter_search<-function(keyword){
  search_result<-twListToDF(searchTwitter(keyword, n=1000, since='2013-12-10', until='2013-12-16'))
  data<<-rbind(data,search_result)
  data<<-data[!duplicated(data$text),] #Remove duplicates
}

sapply(search_string, Twitter_search)
write.table(x=data,file="arama_sonuclari.txt")
write.table(x=data$text,file="tvitler.txt")

#Koordinatlari al
latitudes<-na.omit(data$latitude)
longitudes<-na.omit(data$longitude)

#Haritalari yukle
#http://www.students.ncl.ac.uk/keith.newman/r/maps-in-r
library(maps) # Provides functions that let us plot the maps 
library(mapdata) # Contains the hi-resolution points that mark out the countries.

map('worldHires','Turkey', fill=TRUE, col="lightgray")
points(longitudes, latitudes, col="red",lwd=2)