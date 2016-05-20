#
# file: ui.R
#
# autor:  gilbert maerina
#
# date:   201-05-20
#

library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Effects on Reaction time from days without sleep'),
    sidebarPanel(
      numericInput("daysWithoutSleep", "Provide Days Without Sleep:",0,min=0,max=30, step=1),
      submitButton('Submit')
    ),
    mainPanel(
      h5('Days without sleep:'),
      verbatimTextOutput("inputValue"),
      br(),
      h5('Reaction Time (msecs)'),
      verbatimTextOutput("outputValue"),
      br(),
      br(),
      hr(),
      h4('Documentation'),
      br(),
      p('This application uses data from the study described in Belenky et al.(2003),\
        for the sleep-deprived group and for the first 10 days of the study, up\
        to the recovery period. The User is provides an input between 0-30 days, and the\
        application will calculate the predicted reaction time in milliseconds based on \
        the collected emperical data.'),
      br(),
      br(),
      hr(),
      h4("References"),
      br(),
      em(p('Gregory Belenky, Nancy J. Wesensten, David R. Thorne, Maria L. Thomas,\
           Helen C. Sing, Daniel P. Redmond, Michael B. Russo and Thomas J. Balkin (2003)\
           Patterns of performance degradation and restoration during sleep restriction\
           and subsequent recovery: a sleep dose-response study. Journal of\
           Sleep Research 12, 1-12.'))
    )
)) 