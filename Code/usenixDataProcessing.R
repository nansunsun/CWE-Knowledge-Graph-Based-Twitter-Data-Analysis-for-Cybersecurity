setwd("D:/R_asiaCCS2019")
install.packages("rjson")
library(rjson)
json_data <- fromJSON(paste(readLines("D:/R_asiaCCS2019/usenix_data.json"), collapse=""))


# Convert to data frame
#json_data_frame <- as.data.frame(json_data)
#CVEID<-vector("list", 5914)


# try extract on CVE ID

#CVEID <- attributes(json_data[[1]])$names

#CVEID  

# extract all CVE 
length(json_data)

all_CVE_ID<- vector()

i<-0
for (i in 1:length(json_data)) {
  this_CVEID <-attributes(json_data[[i]])$names
  all_CVE_ID [i] <- this_CVEID
}


#View(all_CVE_ID)



#change json file, change the CVE to a fix number
json_data_category<-json_data

attributes(json_data_category[[1]])$names<-'ID'


json_data_category[[1]]$ID$category


i<-0
for (i in 1:length(json_data)){
  attributes(json_data_category[[i]])$names<-'ID'
}
# get CVE category
category <- vector()
j<-0
for (j in 1:length(json_data)){
  this_category <- json_data_category[[j]]$ID$category
  this_category
  category [j]<- this_category
}
#View(category)


# gets NVD summary
NVD_description <- vector()
tem_num <- vector()
j<-0





for (j in 1:length(json_data)){
  tem_num [j]<- j
  this_NVD_description <- json_data_category[[j]]$ID$nvd$summary
  if(length(this_NVD_description) == 0){
  NVD_description <- c(NVD_description,"NULL")
  }
  else{ NVD_description <- c(NVD_description,this_NVD_description)}
}
#View(tem_num)
#View(NVD_description)


#json_data_category[[3]]$ID$nvd$summary
#get tweets

json_data_tweets<-json_data_category


i<-0
text <- vector()
# get first CVE tweets
#j <- 0
#length(json_data_tweets[[2]]$ID$tweets)
#for (j in 1:length(json_data_tweets[[2]]$ID$tweets)){
#  this_tweet_text <- json_data_tweets[[2]]$ID$tweets[[j]]$text
#  text [j] <-   this_tweet_text
#}

#View(text)
  
# get all CVE tweets



all_tweets<-vector()
each_CVE_tweet_number <- vector()
#???????????????tweets
#???1000???
#length(json_data)
i<-0
for (i in 1:length(json_data)){
  tweet_number<-length(json_data_tweets[[i]]$ID$tweets)
 #Get how many tweets one CVE has
   each_CVE_tweet_number [i]<-tweet_number
  j<-0
  #i<-i
    for (j in 1:tweet_number){
      this_tweet_text <- json_data_tweets[[i]]$ID$tweets[[j]]$text
     
      all_tweets<-c(all_tweets,this_tweet_text)
     
      
     }
    
}
#View(all_tweets)


#retweet count
this_tweet_countnumber<-vector()
all_tweets_countnumber <- vector()
i<-0
for (i in 1:length(json_data)){
  tweet_number<-length(json_data_tweets[[i]]$ID$tweets)
  #Get how many tweets one CVE has
  
  j<-0
  #i<-i
  for (j in 1:tweet_number){
    this_tweet_countnumber <- json_data_tweets[[i]]$ID$tweets[[j]]$retweeted_status
    
    
    all_tweets_countnumber<-c(all_tweets_countnumber,this_tweet_countnumber)
    
    
  }
  
}


View(all_tweets_countnumber)

#???tweet ID
tweets_ID<-vector()

i<-0
for (i in 1:length(json_data)){
  tweet_number<-length(json_data_tweets[[i]]$ID$tweets)
  #Get how many tweets one CVE has
  j<-0
  #i<-i
  for (j in 1:tweet_number){
    this_tweet_ID <- json_data_tweets[[i]]$ID$tweets[[j]]$id
    
    tweets_ID<-c(tweets_ID,this_tweet_ID)
    
    
  }
  
}
#View(tweets_ID)

#place
json_data_place<-json_data_category
tweets_place<-vector()
i<-0
for (i in 1:length(json_data)){
  tweet_number<-length(json_data_place[[i]]$ID$tweets)
  #Get how many tweets one CVE has
  
  j<-0
  #i<-i
  for (j in 1:tweet_number){
    this_tweets_place <- json_data_place[[i]]$ID$tweets[[j]]$coordinate$coordinates 
    if(length(this_tweets_place) != 0){print(this_tweets_place)}
    tweets_place<-c(tweets_place,this_tweets_place)
    
    
  }
  
}

coordinates <- read.table("D:/R_asiaCCS2019/users_tweets/coordinates.txt", quote="\"", comment.char="")

# time
json_data_time<-json_data_category
tweets_time<-vector()
i<-0
for (i in 1:length(json_data)){
  tweet_number<-length(json_data_time[[i]]$ID$tweets)
  #Get how many tweets one CVE has
  
  j<-0
  #i<-i
  for (j in 1:tweet_number){
    this_tweets_time <- json_data_time[[i]]$ID$tweets[[j]]$created_at
    #if(length(this_tweets_time) != 0){}
    tweets_time<-c(tweets_time,this_tweets_time)
    
    
  }
  
}



library(rworldmap)
newmap <- getMap(resolution = "low")
#plot the world map 
plot(newmap, xlim = c(-157, 152), ylim = c(-36, 60), asp = 1)

# Get the frequency counts
dfc <- ddply(coordinates, c("V1", "V2"), "nrow")
#points on the world map
points(dfc$V1, dfc$V2, col = "lightpink2", pch = 19, cex =(dfc$nrow)/5)
points(dfc$V1, dfc$V2, col = "blue4", pch = 19)



# find the exploits and non-exploits tweets
# exploits

json_data_exploits<-json_data_category
tweets_exploits<-factor()
for (j in 1:length(json_data)){
  tem_num [j]<- j
  this_CVE_exploit <- json_data_exploits[[j]]$ID$exploits
  if(length(this_CVE_exploit) == 0){
    tweets_exploits <- c(tweets_exploits,"Unexploited")
  }
  if(length(this_CVE_exploit) == 1){
    tweets_exploits <- c(tweets_exploits,this_CVE_exploit)
  }
  else{
    a<-this_CVE_exploit
    b<-a[1]
    tweets_exploits <- c(tweets_exploits,b)}
}

View(tweets_exploits)



# find the proof-of-concept exploit
json_data_realworld_exploits<-json_data_category
tweets_realworld_exploits<-factor()
for (j in 1:length(json_data)){
  tem_num [j]<- j
  this_realworld_exploits <- json_data_realworld_exploits[[j]]$ID$azips
  if(length( this_realworld_exploits) == 0){
    tweets_realworld_exploits <- c(tweets_realworld_exploits,"Unexploited")
  }

  else{
    tweets_realworld_exploits <- c(tweets_realworld_exploits,"Web attack")}
}

View(tweets_realworld_exploits)


  #assign label
  
  
 each_tweet_label<- vector()
 each_tweet_label<- rep(all_CVE_ID,times=each_CVE_tweet_number)
 View(each_tweet_label)
 
 
 #assign CVE category
 each_tweet_CVE_category<-vector()
 each_tweet_CVE_category<- rep(category,times=each_CVE_tweet_number)
 View(each_tweet_CVE_category)
 
 #assign CVE description 
 each_tweet_CVE_description<-vector()
 each_tweet_CVE_description<- rep(NVD_description,times=each_CVE_tweet_number)
 View(each_tweet_CVE_description)
 
  
 
 #assign CVE PoC exploits
  each_tweet_CVE_PoC_exploit<-vector()
  each_tweet_CVE_PoC_exploit<- rep(tweets_exploits,times=each_CVE_tweet_number)
 

  #assign CVE real world exploits
  each_tweet_CVE_realworld_exploit<-vector()
  each_tweet_CVE_realworld_exploit<- rep(tweets_realworld_exploits,times=each_CVE_tweet_number)
 
  


# <- data.frame("ID" = c(vector), stringsAsFactors = FALSE)
df <- data.frame(ID=matrix(unlist(all_CVE_ID[])), category=matrix(unlist(category[])))

tweet_df <-data.frame(tweet_ID=matrix(unlist(tweets_ID)),tweet=matrix(unlist(all_tweets)),tweet_label =matrix(unlist(each_tweet_label)),tweet_CVE_category =matrix(unlist(each_tweet_CVE_category))
                                      ,tweet_CVE_description =matrix(unlist(each_tweet_CVE_description)), PoC_exploit =matrix(unlist(each_tweet_CVE_PoC_exploit)), 
                                       real_world_exploit = matrix(unlist(each_tweet_CVE_realworld_exploit) ))



#go to NVD_data.R to add CWE, related attack 

#add CWE label  
tweet_df$CWE = CWE_CVE[match(tweet_df$tweet_label, CWE_CVE$CVE),"CWE"]

tweet_df$creation_time =tweets_time


 exploited_data <- subset(tweet_df, PoC_exploit !="Unexploited" | real_world_exploit != "Unexploited" )
 
 #the vulnerabilty is exploited by real world as well as proof of concept
 PoC_real_world_exploited_data <- subset(tweet_df, PoC_exploit !="Unexploited" & real_world_exploit != "Unexploited" )

real_world_exploit <-subset(tweet_df, real_world_exploit !="Unexploited" )



#poc exploit
poc_exploit <- subset(tweet_df, PoC_exploit !="Unexploited")
noinfo<-subset(tweet_df, CWE == "NVD-CWE-noinfo")
table(tweet_df$CWE)

write.csv(exploited_data, file = "D:/R_asiaCCS2019/exploited_data.csv")

write.csv(tweet_df, file ="D:/R_asiaCCS2019/alltweets.csv")

write.csv(noinfo, file = "D:/R_asiaCCS2019/noinfo.csv")
library("fastTextR")


texts <- tolower(tweet_df$tweet_CVE_description)
View(texts)
tmp_file_txt <- tempfile()
tmp_file_model <- tempfile()
writeLines(text = texts, con = tmp_file_txt)
execute(commands = c("skipgram", "-input", tmp_file_txt, "-output", tmp_file_model, "-verbose", 1))
model <- load_model(tmp_file_model)
dict <- get_dictionary(model)
get_word_vectors(model, head(dict, 10))
                 

View(dict)     
View(model)


library(tidyr)


tweet_combine_df<-unite(tweet_df, combine_text_description, c(tweet, tweet_CVE_description), remove=FALSE)
View(tweet_combine_df)
write.csv(tweet_combine_df, file = "C:/Users/mzz/Downloads/combine_tweet.csv")


