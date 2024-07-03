## Job Application form

This is a Shiny application that creates a job application form with input validation and a submission confirmation modal dialog.

The UI layout for the Shiny application is defined using the `fluidPage` function and creates various form inputs such as text fields, dropdowns, file inputs, and a text area. It also includes custom CSS styles to customize the appearance of the form.

The server logic is defined within the `server` function. It creates an instance of the `InputValidator` class from the `shinyvalidate` package and adds validation rules for the form inputs. It also includes event handlers for the submit button and the dismissal of the success modal dialog.

Overall, this code sets up a job application form with input validation and a confirmation message upon submission.
