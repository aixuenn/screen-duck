library(shiny)
library(shinydashboard)
library(proxy)
library(recommenderlab)
library(reshape2)
library(plyr)
library(dplyr)

shinyUI
(
  dashboardPage
  (
    skin = "black",
    dashboardHeader(title = "screenduck"),
    dashboardSidebar
    (
      sidebarMenu
      (
        menuItem("For You", tabName = "foryou", icon = icon("<i class = far fa-smile style = color:white></i>")),
        menuItem("Year", tabName = "year", icon = icon("<i class = far fa-calendar-times style = color:white></i>")),
        menuItem("Rating", tabName = "rating", icon = icon("<i class = far fa-star style = color:white></i>")),
        menuItem("Director", tabName = "director", icon = icon("<i class = fas fa-user style = color:white></i>"))
      )
    ),
    
    dashboardBody
    (
      tabItems
      (
        tabItem
        (
          tabName = "foryou",
          
          # Make three select boxes
          list
          (
            div(style = "display:inline-block",
                selectInput("select1", HTML("<p style = font-size:18px>&nbspPick your top 3 favourite movies:</p>"), choices = movie_list$Movie.Title)),
            div(style = "display:inline-block",
                selectInput("select2", label = "", choices = movie_list$Movie.Title)),
            div(style = "display:inline-block",
                selectInput("select3", label = "", choices = movie_list$Movie.Title)),
            submitButton("Search")
          ),
          
          HTML("<br><br>"),
          h4("Other Movies You Might Like"),
          tableOutput("userRec")
        ),
        
        tabItem
        (
          tabName = "year",
          
          # Make a select box
          selectInput("year", HTML("<p style = font-size:18px>&nbspSearch movie by year:</p>"), 
                      choices = sort(movie_list$Year, decreasing = TRUE), selected = 1),
          submitButton("Search"),
          HTML("<br><br>"),
          tableOutput("yearData")
        ),
        
        tabItem
        (
          tabName = "rating",
              
          # Make a select box
          selectInput("rating", HTML("<p style = font-size:18px>&nbspSearch movie by ratings:</p>"), 
                      choices = list("1.60 - 2.00" = 1, "2.00 - 3.00" = 2,
                                     "3.00 - 4.00" = 3, "4.00 - 5.00" = 4,
                                     "5.00 - 6.00" = 5, "6.00 - 7.00" = 6,
                                     "7.00 - 8.00" = 7, "8.00 - 9.00" = 8,
                                     "9.00 - 9.50" = 9)),
          submitButton("Search"),
          HTML("<br><br>"),
          tableOutput("ratingData")
        ),
        
        tabItem
        (
          tabName = "director",
          
          # Make a text input box
          textInput("director", HTML("<p style = font-size:18px>&nbspSearch movie by director:</p>"), value = "James Cameron"),
          submitButton("Search"),
              
          hr(),
          fluidRow(column(3, verbatimTextOutput("value"))),
          
          tableOutput("nodData")
        )
      )
    )
  )
)