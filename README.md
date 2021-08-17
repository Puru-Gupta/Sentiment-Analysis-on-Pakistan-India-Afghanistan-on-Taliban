# Sentiment-Analysis-on-Pakistan-India-Afghanistan-on-Taliban
# Here i have extracted data from reddit for analysis
---
title: "Sentiment Analysis on Taliban"
author: "Purushottam Gupta"
date: "8/1/2021"
output:
  word_document: default
  
---

```{r}
library(radarchart) #Radar charts are also called Spider or Web or Polar charts

library(tm)   # r data import, corpus handling, preprocessing, metadatamanagement
              #and creation of term-document matrices.

library(RedditExtractoR)#An R wrapper for Reddit API. This package can be used                          
                        #extract data from Reddit and construct structured datasets.

library(syuzhet) #An R package for the extraction of sentiment and sentiment-based plot arcs from text.

library(vosonSML)# R package is a suite of easy to use functions for collecting                    
                 #and generating different types of networks
                  #from social media data. The package supports the collection of                 
                  #data from twitter, youtube and reddit, as well as hyperlinks f                  
                  #from web sites. 
```

```{r}
#Getting Reddit Data Using Reddit Extractor
#No of Page is 40 but you can have more tham 40 for more data
link1 <- reddit_urls(search_terms = 'Afghanistan', page_threshold = 40)

#Here we have use 1st URL... & stored all comment in content1
 content1 <- reddit_content(link1$URL[1])
link2 <- reddit_urls(search_terms = 'r/India', page_threshold = 40)
content2 <- reddit_content(link2$URL[1])

link3 <- reddit_urls(search_terms = 'Chutyapa', page_threshold = 40)
content3 <- reddit_content(link3$URL[1])
```

```{r}
#uSER Network Plot
#This will give Idea from initiation of comment & involvemnt of each authur

user <- user_network(content2, include_author = TRUE, agg = TRUE)
user$plot
#str(user)

#graph <- construct_graph(content2, plot = TRUE)
```

```{r}
#sentiment Analysis
# iCONV This uses system facilities to convert a character vector between encodings
Commt1 <- iconv(content1$comment, to = 'utf-8')
Commt2 <- iconv(content2$comment, to = 'utf-8')
Commt3 <- iconv(content3$comment, to = 'utf-8')
```

```{r}
#Calls the NRC sentiment dictionary to calculate the presence of eight different emotions 
#and their corresponding valence in a text file.
Afghanistan<- get_nrc_sentiment(Commt1)
India <- get_nrc_sentiment(Commt2)
Pakistan <- get_nrc_sentiment(Commt3)
```

```{r}
# Calculating col sum and finding the emotion in percentage term
X1 <- data.frame(100*colSums(Afghanistan)/sum(Afghanistan))
X2 <- data.frame(100*colSums(India)/sum(India))
X3 <- data.frame(100*colSums(Pakistan)/sum(Pakistan))

#Combing Each X into One
Z <- cbind(X1,X2,X3)
```

```{r}
#Radar Chart
colnames(Z) <- c("Afghanistan","India", "Pakistan")
#Extract Row name

lab <- rownames(Z)

#A radar chart is a way of showing multiple data points and the variation between them.
#They are often useful for comparing the points of two or more different data sets.
chartJSRadar(Z, labs = lab, labelSize = 20, main = 'Radar Graph Showing Sentiment in Afghanistan, India, Pakistan citizens
              Data Pulled from perticular group on Reddit(It does not Shows Actual Senario)')
```
![Rplot(Radarplot)](https://user-images.githubusercontent.com/55012359/129714556-5a45150a-4de8-47f0-9613-32fb6eecaca2.png)


```{r}
#Barplot for each country
Bar1 <- 100*colSums(Afghanistan)/sum(Afghanistan)
Bar2 <-100*colSums(India)/sum(India)
Bar3 <-100*colSums(Pakistan)/sum(Pakistan)

barplot(Bar1, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(Afghanistan)')

```
![unnamed-chunk-8-1](https://user-images.githubusercontent.com/55012359/129714357-d627e9e5-b148-40ab-bd6f-5b66276aa32a.png)

```{r}
barplot(Bar2, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(India)')
```
![unnamed-chunk-9-1](https://user-images.githubusercontent.com/55012359/129714450-af10662a-183e-4745-bb6c-a0a937ec0a0a.png)

```{r}
barplot(Bar3, las = 2, col = rainbow(10),
        ylab = '%', main = 'Sentiment Analysis(Pakistan)')
```
![unnamed-chunk-10-1](https://user-images.githubusercontent.com/55012359/129714494-86ec4f9b-68a2-47d8-8212-356d4fbe4aba.png)

