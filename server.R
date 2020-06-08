
shinyServer(function(input, output) {
    
    output$value1 <- renderValueBox({
        top_unit_price <- max(Complete$UnitPrice)
        valueBox(
            top_unit_price,
            "Top of Unit Price",
            icon = icon("tag"),
            color = "purple"
        )
    })
    
    output$value2 <- renderValueBox({
        top_total_amount <- max(Complete$TotalAmount)
        valueBox(
            top_total_amount,
            "Top of Total Amount",
            icon = icon("sort-amount-desc"),
            color = "purple"
        )
    })
    
    output$violin <- renderPlotly({
        Country <- Complete$Country
        Quantity <- Complete$Quantity
        ggplot(Complete, aes(x=Country, y=Quantity, fill=Country)) +
            geom_violin(color="#69b3a2", alpha=0.8) +
            ggtitle("Quantity in Each Country") +
            theme(plot.title = element_text(size=12)) +
            xlab('Country') +
            ylab('Quantity')
    })
    
    output$bar_plot <- renderPlotly({
        ggplot(Complete, aes(x=Complete$City, y=Complete$Quantity) ) +
            geom_bar(stat="identity", fill="red") +
            ggtitle("Quantity in Each City") +
            coord_flip() +
            theme_ipsum() +
            xlab("Country") +
            ylab("City") +
            theme(
                panel.grid.minor.y = element_blank(),
                panel.grid.major.y = element_blank(),
                legend.position="none")  
    })
    
    output$data_table  <- DT::renderDataTable({DT::datatable(Complete)
    })
    
    output$summary  <- renderPrint({summary(Complete)
    })
    
    output$map <- renderPlot({
        countries <- as.data.frame(table(Complete$Country))
        colnames(countries) <- c("country", "value")
        matched <- joinCountryData2Map(countries, joinCode = "NAME", nameJoinColumn = "country")
        mapCountryData(matched, nameColumnToPlot = "value", mapTitle = "Location of Customers", 
                       catMethod = "pretty", colourPalette = c("lightblue", "navy"))
    })
    
})
