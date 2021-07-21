library(shiny)
library(qrcode)
librar(rsconnect)


ui <- fluidPage(
  titlePanel("Genera qrcode"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    
    sidebarPanel(width=2,

                 textInput("testo","Inserisci il testo del qrcode",value="Esempio"),

            
             selectInput("correction","Scegli il livello di correzione",choices=c("L","M","Q","H"),selected="M"),
             textInput("colpe","Scegli il colore dell'inchiostro (scrivi in inglese)",value="black"),
             textInput("colsf","Scegli il colore dello sfondo (scrivi in inglese)",value="white"),  
             selectInput("maske","Scegli una maschera",choices=c(0:7),selected="0")
               

               )



      





    ,

    
    mainPanel(width=10,

   
     
   plotOutput("qr")
      )



))


server <- function(input, output,session) {
output$qr<-renderPlot({
  
 a<-qrcode_gen(input$testo,dataOutput = TRUE,as.character(input$correction),wColor=as.character(input$colsf),bColor=as.character(input$colpe),mask=as.numeric(input$maske))
heatmap(a[nrow(a):1, ], Rowv = NA, Colv = NA, scale = "none", col = c(input$colsf, input$colpe), labRow = "", labCol = "")

})
}
# Create Shiny app ----
shinyApp(ui, server)
