library(shiny)
library(ggplot2)
load("df_ru.Rda")

ui <- fluidPage(
    selectInput("rows", label = h3("Choose State"), 
                choices = unique(df_ru$Provider.State)
    ),
    plotOutput(outputId = "plot")
)

server <- function(input, output) {
    rVals = reactiveValues()
    rVals[['data']] = df_ru
    output$plot <- renderPlot({

        render.data = rVals[['data']][rVals[['data']][['Provider.State']] %in% c(rVals[['baseline']],input$rows),]


        ggplot(data=render.data, 
               aes(x=Total.Resident.COVID.19.Deaths.Per.1.000.Residents, y = as.numeric(Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents))
        ) + geom_point() +
            labs(x="Total COVID Deaths per 1,000 Residents", y="Total COVID Cases Per 1,000 Residents")
    })
}
shinyApp(ui, server)
