# Setup ####
# needed packages
install.packages("twitteR")
library(twitteR)
require(twitteR)
install.packages("RCurl")
library(RCurl)
require(RCurl)
# part 2
install.packages("tm")
library(tm)
require(tm)
install.packages("wordcloud")
library(wordcloud)
require(wordcloud)

#setup autorisierung ####
consumer_key <- "uYqdnmEfQdo8UCihFdYAKMST0"
consumer_secret <- "DzJ7xkxx0XBbj0uuW8tWsqqTdgdm8r8L4JrbrKch6pP41mwhuK"
access_token <- "864101367014711296-kzlQkr0oPj0793pAX3c4mPYtlvlX7Qw"
access_secret <-"vPLJXprEMI3MlBUAXBpVvbOaeoPFVDxZwqUT0wRNF4fjQ"


# Example Tesla ####
setup_twitter_oauth(consumer_key, consumer_secret, access_token,access_secret)

# --- Used input ####
user_input <- readline()
Tesla
Tesla_tweets <- searchTwitter(user_input, lang = "en", n = 1000)

Tesla_tweets_text <- Tesla_tweets[1:1000]

#convert to character vector
Tesla_tweets_text <- sapply(Tesla_tweets, function(x) x$getText())
str(Tesla_tweets_text)

#create corpus from vector of tweets
Tesla_corpus <- Corpus(VectorSource(Tesla_tweets_text))
inspect(Tesla_corpus[1])

#lower cases, remove numbers, cut out stopword, remove punctuation
Tesla_clean <- tm_map(Tesla_corpus,removePunctuation)
Tesla_clean <- tm_map(Tesla_clean,content_transformer(tolower))
Tesla_clean <- tm_map(Tesla_clean, removeWords,stopwords("english"))
Tesla_clean <- tm_map(Tesla_clean, removeNumbers)
Tesla_clean <- tm_map(Tesla_clean, stripWhitespace)
Tesla_clean <- tm_map(Tesla_clean, stemDocument) 

#Term Document Matrix
tdm_Tesla <- TermDocumentMatrix(Tesla_clean)

#create data frame ####
term_freq_Tesla <- rowSums(as.matrix(tdm_Tesla)) 
term_freq_Tesla <- subset(term_freq_Tesla, term_freq_Tesla >= 1) 
df_Tesla <- data.frame(term = names(term_freq_Tesla), freq = term_freq_Tesla)


#create data frame - with min 15 as frequency
# term_freq_AXA2 <- rowSums(as.matrix(tdm_AXA)) 
# term_freq_AXA2 <- subset(term_freq_AXA2, term_freq_AXA2 >= 15) 
# df_AXA2 <- data.frame(term = names(term_freq_AXA2), freq = term_freq_AXA2)

#inspect frequent words
freq_terms_Tesla <- findFreqTerms(tdm_Tesla, lowfreq = 10) 
length(freq_terms_Tesla)

#create a wordcloud ####
#wordcloud 1
wordcloud(Tesla_clean, random.order = FALSE, min.freq = 15, scale = c(2,1))
#wordclod 2
wordcloud(Tesla_clean, random.order = FALSE, min.freq = 15, scale = c(2,1),  colors=brewer.pal(6, "Dark2"))
#wordclod 3
wordcloud(words = df_Tesla$term, freq = df_Tesla$freq, min.freq = 10,
          random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


