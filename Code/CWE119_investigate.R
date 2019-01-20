
# code reference https://rpubs.com/cosmopolitanvan/timelineanalytics
library(ggplot2)
library(lubridate)
library(scales)
library(tm)
library(stringr)
library(wordcloud)
library(syuzhet)
library(reshape2)
library(dplyr)
library(twitteR)
library(scales)
#subset CWE-119
CWE119_tweets<-tweet_df[which(tweet_df$CWE=='CWE-119'),]
View(CWE119_tweets)

CWE119_CVE<-table(CWE119_tweets$tweet_label)
View(CWE119_CVE)
CWE119_tweet_CVE_category<-data.frame(table(CWE119_tweets$tweet_CVE_category))

# change time
Sys.setlocale("LC_TIME", "English")
CWE119_tweets$creation_time<-as.POSIXct(CWE119_tweets$creation_time, format="%a %b %d %H:%M:%S +0000 %Y", tz="GMT")
library(lubridate)
library('ggplot2')
install.packages("ggplot")
library(ggplot)
ggplot(data = CWE119_tweets, aes(x = month(creation_time, label = TRUE))) +
  geom_bar(aes(fill = ..count..)) +
  theme(legend.position = "none") +
  xlab("Month") + ylab("Number of tweets") +
  scale_fill_gradient(low = "gray71", high = "gray8")

#April 
April_CWE119 <- CWE119_tweets[ which(month(CWE119_tweets$creation_time) == "4" ), ]

ggplot(data = April_CWE119, aes(x = day(creation_time))) +
  geom_bar(aes(fill = ..count..)) +
  theme(legend.position = "none") +
  xlab("Day") + ylab("Number of tweets in April, 2014") +
  scale_fill_gradient(low = "gray71", high = "gray8")

# by day
#extract days
Day_CWE119 <- CWE119_tweets[ which(day(CWE119_tweets$creation_time) == "8" ), ]
Day_CWE119$timeonly <- as.numeric(Day_CWE119$creation_time - trunc(Day_CWE119$creation_time, "days"))
class(Day_CWE119$timeonly) <- "POSIXct"

ggplot(data = Day_CWE119, aes(x = timeonly)) +
  geom_histogram(aes(fill = ..count..)) +
  theme(legend.position = "none") +
  xlab("Time") + ylab("Number of tweets") + 
  scale_x_datetime(breaks = date_breaks("2 hours"), 
                   labels = date_format("%H:00")) +
  scale_fill_gradient(low = "midnightblue", high = "aquamarine4")

#wordcloud
nohandles <- str_replace_all(April_CWE119$tweet, "@\\w+", "") 
wordCorpus <- Corpus(VectorSource(nohandles)) 
wordCorpus <- tm_map(wordCorpus, removePunctuation) 
wordCorpus <- tm_map(wordCorpus, content_transformer(tolower)) #converted to lower case
wordCorpus <- tm_map(wordCorpus, removeWords, stopwords("english")) #remove stopwords
wordCorpus <- tm_map(wordCorpus, removeWords, c("amp", "2yo", "3yo", "4yo"))
wordCorpus <- tm_map(wordCorpus, stripWhitespace)

pal <- brewer.pal(9,"YlGnBu")
pal <- pal[-(1:4)]
set.seed(123)
wordcloud(words = wordCorpus, scale=c(4,0.3), max.words=200, random.order=FALSE, 
          rot.per=0.35, use.r.layout=FALSE, colors=pal)

#sentiment
April_CWE119$clean_tweet <- str_replace_all(April_CWE119$tweet, "@\\w+", "")
Sentiment <- get_nrc_sentiment(April_CWE119$clean_tweet)
alltweets_senti <- cbind(April_CWE119, Sentiment)

sentimentTotals <- data.frame(colSums(alltweets_senti[,c(9:16)]))
names(sentimentTotals) <- "count"
sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
rownames(sentimentTotals) <- NULL

ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Tweets")

# positive and negative sentiment over time
posnegtime <- alltweets_senti %>% 
  group_by(creation_time = cut(creation_time, breaks="2 days")) %>%
  summarise(negative = mean(negative),
            positive = mean(positive)) %>% melt
names(posnegtime) <- c("timestamp", "sentiment", "meanvalue")
posnegtime$sentiment = factor(posnegtime$sentiment,levels(posnegtime$sentiment)[c(2,1)])

ggplot(data = posnegtime, aes(x = as.Date(timestamp), y = meanvalue, group = sentiment)) +
  geom_line(size = 1.5, alpha = 0.7, aes(color = sentiment)) +
  geom_point(size = 0.3) +
  ylim(0, NA) + 
  scale_colour_manual(values = c("springgreen4", "firebrick3")) +
  theme(legend.title=element_blank(), axis.title.x = element_blank()) +
  scale_x_date(breaks = date_breaks(width = "3 days"), 
               labels = date_format("%m-%d")) +
  ylab("Average sentiment score") + 
  ggtitle("Sentiment Over Time")


# all tweets change time
Sys.setlocale("LC_TIME", "English")
tweet_df$creation_time<-as.POSIXct(tweet_df$creation_time, format="%a %b %d %H:%M:%S +0000 %Y", tz="GMT")
library(lubridate)
library('ggplot2')
install.packages("ggplot")
library(ggplot)
ggplot(data = tweet_df, aes(x = month(creation_time, label = TRUE))) +
  geom_bar(aes(fill = ..count..)) +
  theme(legend.position = "none") +
  xlab("Month") + ylab("Number of tweets") +
  scale_fill_gradient(low = "gray71", high = "gray8")




X5yearsCWEcategory <- read_excel("D:/R_asiaCCS2019/5yearsCWEcategory.xlsx")
#load libraries
library(sqldf)
library(readxl)
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}
row.names(X5yearsCWEcategory) <- X5yearsCWEcategory$`CWE category`
X5yearsCWEcategory <- X5yearsCWEcategory[,2:6]
head(X5yearsCWEcategory,3)  
X5yearsCWEcategory_matrix<-data.matrix(X5yearsCWEcategory)
X5yearsCWEcategory_matrix<-heatmap(X5yearsCWEcategory_matrix, Rowv=NA, Colv=NA, col =                   brewer.pal(9,"Oranges"),
                         scale="column",  main=" CWE heatmap")
