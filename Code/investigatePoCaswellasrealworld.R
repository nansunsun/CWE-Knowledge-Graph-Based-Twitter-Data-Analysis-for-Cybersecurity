PoC_real_world_exploited_data <- subset(tweet_df, PoC_exploit !="Unexploited" & real_world_exploit != "Unexploited" )
table(PoC_real_world_exploited_data$tweet_CVE_category)
paste(prop.table(table(PoC_real_world_exploited_data$tweet_CVE_category))*100, "%", sep = "")
pie(table(PoC_real_world_exploited_data$tweet_CVE_category), labels = paste(round(prop.table(table(PoC_real_world_exploited_data$tweet_CVE_category))*100), "%", sep = ""), 
    col = heat.colors(5), main = "Vulnerability category")
