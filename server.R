library(shiny)
library(proxy)
library(recommenderlab)
library(reshape2)
source("algorithm.R")

movies <- read.csv("movie_list.csv", header = TRUE, stringsAsFactors = FALSE)
ratings <- read.csv("movie_rating.csv", header = TRUE)

shinyServer
(
  function(input, output) 
  {
    # -- Table filtered according to genre -- #
    output$userRec <- renderTable({
      movie_recommendation(input$select1, input$select2, input$select3)
  })
  
    # -- Table filtered according to year -- #
    output$yearData <- renderTable({
      yearFilter <- subset(select(movie_list, "Movie.Title", "Year", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"), 
                           movie_list$Year == input$year)
  })
  
    # -- Table filtered according to rating -- #
    output$ratingData <- renderTable({
      if(input$rating == 1)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score <= 2.00)
      }
      else if(input$rating == 2)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 2.00 & movie_list$IMDB.Score <= 3.00)
      }
      else if(input$rating == 3)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 3.00 & movie_list$IMDB.Score <= 4.00)
      }
      else if(input$rating == 4)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 4.00 & movie_list$IMDB.Score <= 5.00)
      }
      else if(input$rating == 5)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 5.00 & movie_list$IMDB.Score <= 6.00)
      }
      else if(input$rating == 6)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 6.00 & movie_list$IMDB.Score <= 7.00)
      }
      else if(input$rating == 7)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 7.00 & movie_list$IMDB.Score <= 8.00)
      }
      else if(input$rating == 8)
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 8.00 & movie_list$IMDB.Score <= 9.00)
      }
      else
      {
        ratingFilter <- subset(select(movie_list, "Movie.Title", "IMDB.Score", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                               movie_list$IMDB.Score >= 9.00)
      }
  })
  
    # -- Table filtered according to director -- #
    output$nodData <- renderTable({
      nodFilter <- subset(select(movie_list, "Movie.Title", "Director", "Actor.1", "Actor.2", "Actor.3", "Language", "Country"),
                          movie_list$Director == input$director)
  })
}
)

