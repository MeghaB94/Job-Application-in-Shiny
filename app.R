# Load required packages
library(shiny)
library(shinyvalidate)

# Define UI
ui <- fluidPage(

    # Define custom CSS styles
    tags$style(
        "body {
            background: linear-gradient(180deg, #fff, #db182a);
            min-height: 100vh
        }
        .container-fluid {
            max-width: 1300px
        }
        .header {
            color: #db182a;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px 0;
        }
        .header img {
            margin-right: 10px;
        }
        .form-container {
            background-color: #fff;
            border-radius: 4px;
            padding: 15px;
        }
        .form-container .form-group {
            width: 100%;
        }
        "
    ),
    fluidRow(
        column(6, offset = 3,
            tags$div(
                class = "header",
                img(src = "logo.png", width = "63px"),
                titlePanel("Job Application Form"),
            )
        )
    ),
    fluidRow(
        column(6, offset = 3,
            class = "form-container",

            # Form inputs
            fluidRow(
                column(6,
                    textInput("name", "Name:", placeholder = "Enter your name..."),
                ),
                column(6,
                    textInput("email", "Email:", placeholder = "Enter your email..."),
                ),
            ),
            fluidRow(
                column(6,
                    textInput("phone", "Phone:", placeholder = "Enter your phone number..."),
                ),
                column(6,
                    selectInput("state", "State:", choices = c(
                        "Alberta", "British Columbia", "Manitoba", "New Brunswick",
                        "Newfoundland and Labrador", "Nova Scotia", "Ontario",
                        "Prince Edward Island", "Quebec", "Saskatchewan",
                        "Northwest Territories", "Nunavut", "Yukon"
                    )),
                ),
            ),
            fluidRow(
                column(6,
                    radioButtons("position", "Job Position:", choices = c(
                      "Data Scientist", "Senior Software Engineer", "Data Engineer",
                      "UI/UX Developer", "Project Manager"
                    )),
                ),
                column(6,
                    fileInput("resume", "Upload Resume:"),
                ),
            ),
            fluidRow(
                column(12,
                    textAreaInput(
                        "cover_letter",
                        "Cover Letter:",
                        rows = 6,
                        resize = "none",
                        placeholder = "Enter your cover letter..."
                    ),
                ),
            ),
            fluidRow(
                column(12, align = "center",
                    actionButton(label = "Submit Application", inputId = "submit"),
                ),
            ),
        ),
    ),
)

# Define server
server <- function(input, output, session) {

    # Create a new instance of the InputValidator class
    iv <- InputValidator$new()
    # Add validation rules for form inputs
    iv$add_rule("name", sv_required())
    iv$add_rule("email", sv_required())
    iv$add_rule("email", sv_email())
    iv$add_rule("phone", sv_required())
    iv$add_rule("phone", sv_regex("^(\\+\\d{1,3}[- ]?)?\\d{10}$", "Invalid Phone number"))
    iv$add_rule("resume", sv_required())

    # Event handler for submit button click
    observeEvent(input$submit, {
        # Enable validation
        iv$enable()

        # Check if all form inputs are valid
        req(iv$is_valid())
        # Process the job application form data here (e.g., save to a database)
        # Access the input values using input$name, input$email, etc.
        # You can also access the uploaded resume using input$resume

        # Show a success message in a modal dialog
        showModal(modalDialog(
            title = "Application Submitted",
            "Thank you for submitting your application!",
            footer = actionButton("dismiss_modal", label = "Done"),
            easyClose = FALSE
        ))
    })

    # Event handler for dismissing the success modal dialog
    observeEvent(input$dismiss_modal, {
        # Reset the form by reloading the page after data is saved
        session$reload()
    })
}

# Run the application
#runApp('.', port = 7732)
shinyApp(ui, server)
