# ---
#   title: "Sentiment Analysis in India, Pakistan, Afghanistan"
# author: "Purushottam Gupta"
# date: "8/1/2021"
# output:R File
# ---

library(radarchart) #Radar charts are also called Spider or Web or Polar charts
library(tm)   # r data import, corpus handling, preprocessing, metadata management
                     #and creation of term-document matrices.
library(RedditExtractoR)#An R wrapper for Reddit API. This package can be used extract data from Reddit and construct structured datasets.
library(syuzhet) #An R package for the extraction of sentiment and sentiment-based plot arcs from text.
library(vosonSML)# R package is a suite of easy to use functions for collecting and generating different types of networks
                  #from social media data. The package supports the collection of data from twitter, youtube and reddit, as well as hyperlinks from web sites. 
library()

#Getting Reddit Data Using Reddit Extractor
#No of Page is 40 but you can have more tham 40 for more data
link1 <- reddit_urls(search_terms = 'Afghanistan', page_threshold = 40)

#Here we have use 1st URL... & stored all comment in content1
 content1 <- reddit_content(link1$URL[1])
link2 <- reddit_urls(search_terms = 'r/India', page_threshold = 40)
content2 <- reddit_content(link2$URL[1])

link3 <- reddit_urls(search_terms = 'Chutyapa', page_threshold = 40)
content3 <- reddit_content(link3$URL[1])

#uSER Network Plot
#This will give Idea from initiation of comment & involvemnt of each authur

user <- user_network(content2, include_author = TRUE, agg = TRUE)
user$plot
str(user)

graph <- construct_graph(content2, plot = TRUE)

#sentiment Analysis
# iCONV This uses system facilities to convert a character vector between encodings
Commt1 <- iconv(content1$comment, to = 'utf-8')
Commt2 <- iconv(content2$comment, to = 'utf-8')
Commt3 <- iconv(content3$comment, to = 'utf-8')

#Calls the NRC sentiment dictionary to calculate the presence of eight different emotions 
#and their corresponding valence in a text file.
Afghanistan<- get_nrc_sentiment(Commt1)
India <- get_nrc_sentiment(Commt2)
Pakistan <- get_nrc_sentiment(Commt3)

# Calculating col sum and finding the emotion in percentage term
X1 <- data.frame(100*colSums(Afghanistan)/sum(Afghanistan))
X2 <- data.frame(100*colSums(India)/sum(India))
X3 <- data.frame(100*colSums(Pakistan)/sum(Pakistan))

#Combing Each X into One
Z <- cbind(X1,X2,X3)
#Radar Chart
colnames(Z) <- c("Afghanistan","India", "Pakistan")
#Extract Row name

lab <- rownames(Z)

#A radar chart is a way of showing multiple data points and the variation between them.
#They are often useful for comparing the points of two or more different data sets.
chartJSRadar(Z, labs = lab, labelSize = 20, main = 'Radar Graph Showing Sentiment in Afghanistan, India, Pakistan citizens
              Data Pulled from perticular group on Reddit(It does not Shows Actual Senario)')

Bar1 <- 100*colSums(Afghanistan)/sum(Afghanistan)
Bar2 <-100*colSums(India)/sum(India)
Bar3 <-100*colSums(Pakistan)/sum(Pakistan)

barplot(Bar1, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(Afghanistan)')
barplot(Bar2, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(India)')
barplot(Bar3, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(Pakistan)')

