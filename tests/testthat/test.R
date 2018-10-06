context("Twitter")

install.packages("twitteR", repos = "http://cran.us.r-project.org")
install.packages("RCurl", repos = "http://cran.us.r-project.org")
install.packages("SnowballC", repos = "http://cran.us.r-project.org")
install.packages("tm", repos = "http://cran.us.r-project.org")
install.packages("wordcloud", repos = "http://cran.us.r-project.org")

#Load library
library(twitteR)
library(RCurl)
library(SnowballC)
library(tm)
library(wordcloud)


df <- TwitterWordCould(word = "Audi", min_freq = 10, max_number = 1000)

test_that("rejects errounous input", {
  expect_error(TwitterWordCould(word = 100, min_freq = 10, max_number = 1000))
  expect_error(TwitterWordCould(word = "water", min_freq = "aaa", max_number = 1000))
  expect_error(TwitterWordCould(word = "water", min_freq = 10,max_number = "aaa"))
  expect_error(TwitterWordCould(word = "water", min_freq = 10, max_number = 1:10))
})


test_that("Input index not make sense", {
  expect_error(TwitterWordCould(word = "water", min_freq = 10, max_number = 2000))
  expect_error(TwitterWordCould(word = "water", min_freq = 1, max_number = 1000))
})


test_that("Output structure", {
  expect_true(class(df) == "data.frame")
  expect_true(dim(df)[2]==2)
})

test_that("Output value", {
  expect_equal(names(df), c("term", "freq"))
  expect_true (typeof(df[,2]) == "double")
})



