# Documentation #####
#'
#' @description function create a data fram of the searched tweet including the frequency
#'
#'
#' @param word , is the tweet search word
#' @param min_freq , is the minimum frequency of the tweet search
#' @param max_freq , is the maximum frequency of the tweet search
#'
#' @return df_Tesla , returns a data frame with the term and frequency
#' @export
#'



# Setup ####
# needed packages
install.packages("twitteR", repos = "http://cran.us.r-project.org")
#require(twitteR)
install.packages("RCurl", repos = "http://cran.us.r-project.org")
#require(RCurl)
# part 2
install.packages("SnowballC", repos = "http://cran.us.r-project.org")
#require(SnowballC)
install.packages("tm", repos = "http://cran.us.r-project.org")
#require(tm)
install.packages("wordcloud", repos = "http://cran.us.r-project.org")
#require(wordcloud)


#Load library
library(twitteR)
library(RCurl)
library(SnowballC)
library(tm)
library(wordcloud)


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
  tweets <- searchTwitter(word, lang = "en", n = max_freq)

  #convert to character vector
  tweets_text <- sapply(tweets, function(x) x$getText())

  #create corpus from vector of tweets
  tweets_corpus <- Corpus(VectorSource(tweets_text))

  #lower cases, remove numbers, cut out stopword, remove punctuation
  tweets_clean <- tm_map(tweets_corpus,removePunctuation)
  tweets_clean <- tm_map(tweets_clean,content_transformer(tolower))
  tweets_clean <- tm_map(tweets_clean, removeWords,stopwords("english"))
  tweets_clean <- tm_map(tweets_clean, removeNumbers)
  tweets_clean <- tm_map(tweets_clean, stripWhitespace)
  tweets_clean <- tm_map(tweets_clean, stemDocument)

  #Term Document Matrix
  tdm_tweets <- TermDocumentMatrix(tweets_clean)

  #create data frame
  term_freq_tweets <- rowSums(as.matrix(tdm_tweets))
  term_freq_tweets <- subset(term_freq_tweets, term_freq_tweets >= 1)
  df_tweets <- data.frame(term = names(term_freq_tweets), freq = term_freq_tweets)

  # return the data frame
  return(df_tweets)
}

#TEST
#data <- TwitterWordCould(word = "Audi", min_freq = 10, max_freq = 1000)
#wordcloud(words = data$term, freq = data$freq, min.freq = 20,
#           random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
# plot(data)

#data <- TwitterWordCould("Tesla", 10,100)
#data_test <- data

