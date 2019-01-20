

tweet_df <- read.csv("D:/R_asiaCCS2019/alltweets.csv", row.names=1)


newCWEstructure<-ToDataFrameTypeCol(CWE_category)
table(newCWEstructure$level_1)
table(newCWEstructure$level_2)
table(newCWEstructure$level_3)
table(newCWEstructure$level_4)
level5<-table(newCWEstructure$level_5)
View(level5)
level6<-table(newCWEstructure$level_6) 
View(level6)
level7<-table(newCWEstructure$level_7)
View(level7)
level8<-table(newCWEstructure$level_8)
View(level8)
level9<-table(newCWEstructure$level_9)
View(level9)
level10<-table(newCWEstructure$level_10)
View(level10)

#all nodes
all_node_and_leaf<-CWE_category$Get("name")
View(all_node_and_leaf)
#unique nodes
unique_node_and_leaf<-table(CWE_category$Get("name"))
View(unique_node_and_leaf)

# find which node has the largest number of tweets
nodes_tweets_number<-table(tweet_df$CWE)
View(nodes_tweets_number)


# appear 3 times subtree\
library(data.tree)
CWEsubtree_CWE74<- Node$new("CWE-74 Injection", tweets_number ="53")
CWE74_tweets<-tweet_df[which(tweet_df$CWE=='CWE-74'),]
nrow(CWE74_tweets) 
       CWE134<-CWEsubtree_CWE74$AddChild("CWE-134 Format String Vulnerability", tweets_number ="154")
       CWE134_tweets<-tweet_df[which(tweet_df$CWE=='CWE-134'),]
       nrow(CWE134_tweets)      
        CWE77<-CWEsubtree_CWE74$AddChild("CWE-77 Command Injection", tweets_number = "566")
        CWE77_tweets<-tweet_df[which(tweet_df$CWE=='CWE-77'),]
        nrow(CWE77_tweets)
        
         CWE78<-CWE77$AddChild("CWE-78 OS Command Injections", tweets_number = "23796")
         CWE78_tweets<-tweet_df[which(tweet_df$CWE=='CWE-78'),]
         nrow(CWE78_tweets)
         
         CWE88<-CWE77$AddChild("CWE-88 Argument Injection or Modification", tweets_number = "0")
         CWE88_tweets<-tweet_df[which(tweet_df$CWE=='CWE-88'),]
         nrow(CWE88_tweets)
         
       CWE79<-CWEsubtree_CWE74$AddChild("CWE-79 Cross-Site Scripting (XSS)", tweets_number = "13155")
       CWE79_tweets<-tweet_df[which(tweet_df$CWE=='CWE-79'),]
       nrow(CWE79_tweets)
       
       CWE91<-CWEsubtree_CWE74$AddChild("CWE-91 XML Injection (aka Blind XPath Injection)", tweets_number = "0")
       CWE91_tweets<-tweet_df[which(tweet_df$CWE=='CWE-91'),]
       nrow(CWE91_tweets)
       
       CWE93<-CWEsubtree_CWE74$AddChild("CWE-93 Improper Neutralization of CRLF Sequences ('CRLF Injection')", tweets_number = "0")
       CWE93_tweets<-tweet_df[which(tweet_df$CWE=='CWE-93'),]
       nrow(CWE93_tweets)
       
       CWE113<-CWE93$AddChild("CWE-113 CWE-113 Improper Neutralization of CRLF Sequences in HTTP Headers ('HTTP Response Splitting')", tweets_number = "0")
       CWE113_tweets<-tweet_df[which(tweet_df$CWE=='CWE-113'),]
       nrow(CWE113_tweets)
       CWE94<-CWEsubtree_CWE74$AddChild("CWE-94 Code Injection", tweets_number = "11602")
       CWE94_tweets<-tweet_df[which(tweet_df$CWE=='CWE-94'),]
       nrow(CWE94_tweets)
       
       CWE943<-CWEsubtree_CWE74$AddChild("CWE-943 Improper Neutralization of Special Elements in Data Query Logic", tweets_number = "0")
       CWE943_tweets<-tweet_df[which(tweet_df$CWE=='CWE-943'),]
       nrow(CWE943_tweets)
        CWE89<-CWE943$AddChild("CWE-89 SQL Injection", tweets_number = "6414")
        CWE89_tweets<-tweet_df[which(tweet_df$CWE=='CWE-89'),]
        nrow(CWE89_tweets)
        
        CWE90<-CWE943$AddChild("CWE-90 Improper Neutralization of Special Elements used in an LDAP Query ('LDAP Injection')", tweets_number = "0")
        
        CWE90_tweets<-tweet_df[which(tweet_df$CWE=='CWE-90'),]
        nrow(CWE90_tweets)
        
       CWE99<-CWEsubtree_CWE74$AddChild("CWE-99 Improper Control of Resource Identifiers ('Resource Injection')", tweets_number = "0")
       CWE99_tweets<-tweet_df[which(tweet_df$CWE=='CWE-99'),]
       nrow(CWE99_tweets) 
        CWE694<-CWE99$AddChild("CWE-694 Use of Multiple Resources with Duplicate Identifier", tweets_number = "0")
        CWE694_tweets<-tweet_df[which(tweet_df$CWE=='CWE-694'),]
        nrow(CWE694_tweets) 
   print(CWEsubtree_CWE74, "tweets_number" )      
   library(networkD3)
   CWEsubtree_CWE74Network <- ToDataFrameNetwork(CWEsubtree_CWE74, "name")
   simpleNetwork( CWEsubtree_CWE74Network[-3], fontSize = 12)
   
   
   library(igraph)
   plot(as.igraph(CWEsubtree_CWE74, directed = TRUE, direction = "climb"))
plot(CWEsubtree_CWE74)   
