# CWE Knowledge Graph Based Twitter Data Analysis for Cybersecurity
Hi there, welcome to this page!

This page contains the code and sample data used in the paper CWE Knowledge Graph Based Twitter Data Analysis for Cybersecurity. The details are presented in the table as follow.

Part of sample data and code used in this study is provided. If you are interested in our project, please contact *** (anonymous now) for more information.
## Sample data


|File Name       | Dataset         |Introduction|
| -------------------- |:----------------:|----------------:| 
|2014Tweets.xlsx|2014 Tweets dataset|Tweets including the keyword "CVE" published in 2014|
|2015Tweets.xlsx|2015 Tweets dataset|Tweets including the keyword "CVE" published in 2015|
|2016Tweets.xlsx|2016 Tweets dataset|Tweets including the keyword "CVE" published in 2016|
|2017Tweets.xlsx|2017 Tweets dataset|Tweets including the keyword "CVE" published in 2017|
|2018Tweets.xlsx|2018 Tweets dataset|Tweets including the keyword "CVE" published in 2018|
|cve.zip|CVE information|Vulnearbility detailed information crawled from [Common Vulnerabilities and Exposures (CVE)](https://cve.mitre.org/) |
|CAPEC.csv|CAPEC information|Attack information crawled from [Common Attack Pattern Enumeration and Classification (CAPEC)](https://capec.mitre.org/)|


## Code
|File Name       |Description|
| -------------------- |---------------:| 
|crawl_username_P2.py|Crawl tweets by user screen name|
|usenixDataProcessing.R|Extract infortion from [Usenix Twitter dataset](https://umd.box.com/s/kk8if8marmekf5t5ghvi0vkwkrdcf7ji) and transfer the format of data from json to csv |
|knowledgegraph.R|Knowledge graph construction|
|investigateTree.R|knowledge graph investigation|
|investigatePoCaswellasrealworld.R|Proof-of-concept(PoC) and real-world exploit vulnearability investigation|
|CWE119_investigate.R|Spotlight node investigation|
