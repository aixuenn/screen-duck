library(proxy)
library(recommenderlab)
library(reshape2)

# Load data
movies <- read.csv("movie_list.csv", header = TRUE, stringsAsFactors = FALSE)
ratings <- read.csv("movie_rating.csv", header = TRUE)
result <- movies[-which((movies$Movie.ID %in% ratings$Movie.ID) == FALSE),]

movie_recommendation <- function(input1, input2, input3) 
{
  row_num1 <- which(result[,2] == input1)
  row_num2 <- which(result[,2] == input2)
  row_num3 <- which(result[,2] == input3)
  userSelect <- matrix(NA,length(unique(ratings$Movie.ID)))
  userSelect[row_num1] <- 9 # Hard code first selection to rating 9
  userSelect[row_num2] <- 8 # Hard code second selection to rating 8
  userSelect[row_num3] <- 7 # Hard code third selection to rating 7
  userSelect <- t(userSelect)
  
  ratingmat <- dcast(ratings, User.ID~Movie.ID, value.var = "Rating", na.rm = FALSE)
  ratingmat <- ratingmat[,-1] # To remove User.ID
  colnames(userSelect) <- colnames(ratingmat)
  ratingmat2 <- rbind(userSelect,ratingmat)
  ratingmat2 <- as.matrix(ratingmat2)
  
  # Convert rating matrix into a sparse matrix
  ratingmat2 <- as(ratingmat2, "realRatingMatrix")
  
  # Create Recommender Model
  recommender_model <- Recommender(ratingmat2, method = "UBCF", param = list(method = "Cosine", nn = 30))
  recom <- predict(recommender_model, ratingmat2[1], n = 10)
  recom_list <- as(recom, "list")
  no_result <- data.frame(matrix(NA,1))
  recom_result <- data.frame(matrix(NA,10))
  for(i in c(1:10))
  {
    recom_result[i,1] <- as.character(subset(movies, movies$Movie.ID == as.integer(recom_list[[1]][i]))$Movie.Title)
  }
  colnames(recom_result) <- "Top 10 Recommended Movies"
  return(recom_result)
}