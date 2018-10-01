# Setup ####
# needed packages
install.packages("twitteR")
require(twitteR)
install.packages("RCurl")
require(RCurl)
# part 2
install.packages("tm")
require(tm)
install.packages("wordcloud")
require(wordcloud)
install.packages(SnowballC)
require(SnowballC)

#Load library
library(twitteR)
library(RCurl)
library(tm)
library(wordcloud)
library(SnowballC)

# the function ####
TwitterWordCould <- function(word, min_freq, max_freq){

  #setup autorisierung ####
  reqURL <- "https://api.twitter.com/oauth/request_token"
  accessURL <- "http://api.twitter.com/oauth/access_token"
  authURL <- "http://api.twitter.com/oauth/authorize"

  consumer_key <- "uYqdnmEfQdo8UCihFdYAKMST0"
  consumer_secret <- "DzJ7xkxx0XBbj0uuW8tWsqqTdgdm8r8L4JrbrKch6pP41mwhuK"
  access_token <- "864101367014711296-kzlQkr0oPj0793pAX3c4mPYtlvlX7Qw"
  access_secret <-"vPLJXprEMI3MlBUAXBpVvbOaeoPFVDxZwqUT0wRNF4fjQ"

  # setup
  setup_twitter_oauth(consumer_key, consumer_secret, access_token,access_secret)

  # search Twitter, just english language, max frequency - max_freq (max is 1500 Tweets)
  Tesla_tweets <- searchTwitter(word, lang = "en", n = max_freq)

  #convert to character vector
  Tesla_tweets_text <- sapply(Tesla_tweets, function(x) x$getText())

  #create corpus from vector of tweets
  Tesla_corpus <- Corpus(VectorSource(Tesla_tweets_text))

  #lower cases, remove numbers, cut out stopword, remove punctuation
  Tesla_clean <- tm_map(Tesla_corpus,removePunctuation)
  Tesla_clean <- tm_map(Tesla_clean,content_transformer(tolower))
  Tesla_clean <- tm_map(Tesla_clean, removeWords,stopwords("english"))
  Tesla_clean <- tm_map(Tesla_clean, removeNumbers)
  Tesla_clean <- tm_map(Tesla_clean, stripWhitespace)
  Tesla_clean <- tm_map(Tesla_clean, stemDocument)

  #Term Document Matrix
  tdm_Tesla <- TermDocumentMatrix(Tesla_clean)

  #create data frame
  term_freq_Tesla <- rowSums(as.matrix(tdm_Tesla))
  term_freq_Tesla <- subset(term_freq_Tesla, term_freq_Tesla >= 1)
  df_Tesla <- data.frame(term = names(term_freq_Tesla), freq = term_freq_Tesla)

  return(df_Tesla)
}

#TEST
# data <- TwitterWordCould(word = "Audi", min_freq = 10, max_freq = 1000)
#wordcloud(words = data$term, freq = data$freq, min.freq = 20,
#           random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
# plot(data)

#data <- TwitterWordCould("Tesla", 10,100)
#data_test <- data
#data_test <- sort(data_test$freq, decreasing = TRUE)

