#!/usr/bin/env python
# encoding: utf-8

import tweepy #https://github.com/tweepy/tweepy
import csv
import pprint
import pandas as pd
import re
import nltk
#Twitter API credentials

consumer_key = "e1K2vzj8afa3eAi7sfYBNHazW"
consumer_secret = "1ebnzIiQTdQXv7bKkc2ythnKdczxroIltcMLAsp9gLWNmhPiSQ"
access_key = "1019820673907154944-YhYe62AGArcAxXvgJeSMTIXNMclZ1A"
access_secret = "iyRxT9jZnN9rzl8t5woUjsb7CpTqv1IVxVHYyziMCHteM"
STOP_WORDS = nltk.corpus.stopwords.words()

def clean_sentence(val):
    "remove chars that are not letters or numbers, downcase, then remove stop words"
    regex = re.compile('([^\s\w]|_)+')
    sentence = regex.sub('', val).lower()
    sentence = sentence.split(" ")
    
    for word in list(sentence):
        if word in STOP_WORDS:
            sentence.remove(word)  
            
    sentence = " ".join(sentence)
    return sentence


def clean_dataframe(data):
    "drop nans, then apply 'clean_sentence' function to tweet and tweet_CVE_description"
    data = data.dropna(how="any")
    data = data.apply(clean_sentence)
    
    return data

def get_all_tweets(screen_name):
	#Twitter only allows access to a users most recent 3240 tweets with this method
	
	#authorize twitter, initialize tweepy
        auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
        auth.set_access_token(access_key, access_secret)
        api = tweepy.API(auth)
	
	#initialize a list to hold all the tweepy Tweets
        alltweets = []	
        try:
            #make initial request for most recent tweets (200 is the maximum allowed count)
            new_tweets = api.user_timeline(screen_name = screen_name,count=200)
        except Exception as e:
            print('except:', e)
        else:
            #save most recent tweets
            alltweets.extend(new_tweets)
            
            #save the id of the oldest tweet less one
            oldest = alltweets[-1].id - 1
            
            #keep grabbing tweets until there are no tweets left to grab
            while len(new_tweets) > 0:
                    print "getting tweets before %s" % (oldest)
                    
                    #all subsiquent requests use the max_id param to prevent duplicates
                    new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
                    
                    #save most recent tweets
                    alltweets.extend(new_tweets)
                    
                    #update the id of the oldest tweet less one
                    oldest = alltweets[-1].id - 1
                    
                    print "...%s tweets downloaded so far" % (len(alltweets))
            pp = pprint.PrettyPrinter(indent=4)
            
            #transform the tweepy tweets into a 2D array that will populate the csv	
            outtweets = [[tweet.id_str, tweet.text.encode("utf-8"), tweet.created_at, screen_name] for tweet in alltweets]
            outtweets_df = pd.DataFrame(data=outtweets)
            pp.pprint(outtweets_df[:10])
            pp.pprint(clean_dataframe(outtweets_df.loc[:,1]))



                      
            
            
            outtweets_df.loc[:,1] = clean_dataframe(outtweets_df.loc[:,1])
            pp = pprint.PrettyPrinter(indent=4)
            pp.pprint(outtweets[:10])
            pp.pprint(outtweets_df[:10])
            outtweets_df.to_csv('users_tweets/%s_tweets.csv' % screen_name, encoding='utf-8')
        
        #write the csv	
	#with open('users_tweets/%s_tweets.csv' % screen_name, 'wb') as f:
		#writer = csv.writer(f)
		#writer.writerow(["id","text","created_at"])
		#writer.writerows(outtweets_df)
	
	#pass
        

#if __name__ == '__main__':
	#pass in the username of the account you want to download
#get_all_tweets("1337tr0lls")
#get_all_tweets("Sec2017")
#get_all_tweets("PiratePartyINT")
#get_all_tweets("1337tr0lls")
#get_all_tweets("1337tr0lls")


userArray =[]


with open('new.csv', 'rb') as csvfile:
       
        userNameReader = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for row in userNameReader:
                #print ', '.join(row)
                print row[0]
                get_all_tweets(row[0])


        




	




