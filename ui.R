# Written by : Yonathan ANggraiwan
# Department of Business statistics, Matana University
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# A. Libraries 
library(shiny)
library(shinydashboard)
library(dplyr)
library(readxl)
library(plotly)
library(rworldmap)
library(ggplot2)
library(hrbrthemes)

# B. Import Data
Complete <- read.csv2("Complete.csv", header = T, sep = ";")

# C. User Interface
shinyUI(
    dashboardPage(
        skin = "red",
        dashboardHeader(title = "Yonathan's Dashboard",
                        dropdownMenu(type = "messages"),
                        tags$li(class = "dropdown",tags$img(src = "Matana.png", height = 48, width = 48))
        ),
        dashboardSidebar(
            sidebarMenu(
                menuItem("Dashboard",
                         tabName = "dashboard",
                         icon = icon("dashboard"),
                         badgeLabel = "New",
                         badgeColor = "blue"),
                menuItem("Data",
                         tabName = "data",
                         icon = icon("database")),
                menuItem("Map",
                         tabName = "map",
                         icon = icon("map")),
                menuItem("Raw Data & Source Code",
                         icon = icon("table"),
                         href = ""),
                menuItem("About Me",
                         icon = icon("user"),
                         menuSubItem("Linked in",
                                     icon = icon("linkedin"),
                                     href = "https://www.linkedin.com/in/yonathan-anggraiwan-3762871a2/"),
                         menuSubItem("Github",
                                     icon = icon("github"),
                                     href = "https://github.com/ayoung345"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(
                    tabName = "dashboard",
                    fluidRow(
                        infoBox("Top Sales in the World",
                                628,"USA (Country)",
                                width = 6,
                                icon = icon("globe-asia"),
                                color = "green"),
                        infoBox("Favourite Product",
                                108, "Raclette Courdavault",
                                width = 6,
                                icon = icon("heart"),
                                color = "blue")
                    ),
                    fluidRow(
                        infoBox("Top Sales in the World",
                                205, "London (City)",
                                width = 6,
                                icon = icon("building"),
                                color = "green"),
                        infoBox("Top Quantity",
                                130,
                                width = 6,
                                icon = icon("bullseye"),
                                color = "blue")
                    ),
                    fixedRow(
                        valueBoxOutput("value1", width = 6),
                        valueBoxOutput("value2", width = 6)
                    ),
                    fluidRow(
                        box(title = "Violin",
                            status = "warning",
                            width = 12,
                            solidHeader = F,
                            collapsible = T,
                            plotlyOutput("violin"))
                    ),
                    fluidRow(
                        box(title = "Bar Plot",
                            status = "info",
                            width = 12,
                            solidHeader = F,
                            collapsible = T,
                            plotlyOutput("bar_plot"))
                    )
                ),
                tabItem(tabName = "data",
                        fluidRow(
                            DT::dataTableOutput("data_table")),
                        fluidRow(
                            verbatimTextOutput("summary"))
                ),
                tabItem(tabName = "map",
                        fluidRow(
                            box(
                                title = "Map",
                                id = "map",
                                status = "info",
                                solidHeader = TRUE,
                                width = 12,
                                plotOutput("map", height = "750px")
                            )
                        )
                )
            )
        )
    )
)