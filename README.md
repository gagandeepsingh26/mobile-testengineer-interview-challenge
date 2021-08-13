# mobile-testengineer-interview-challenge

## iOS
The iOS project can be found in the `TestEngineerChallenge-iOS` directory. This challenge will test your ability to write unit and UI tests, and identify bugs and quality control issues.

#### Setup
1. Fork this repository to your own GitHub account.
1. Clone the forked repository to your development machine.
1. Complete the assigned [Tasks](#tasks) below, within the time limit given to you.
1. Commit your work to your repository, and push these changes to your remote repository.
1. Make your repository public or provide access to the interviewers' GitHub account.
1. Notify the interviewers when the project is ready for review.
1. UI tests run in the simulator will fail to send keyboard events when the menu option `I/O > Keyboard > Connect Hardware Keyboard` is enabled. Make sure it is disabled. Alternatively, resetting the simulator (`Device > Erase All Content and Settings...`) will also return it to a good state that lasts until you next interact with the simulator keyboard.

#### Tasks
1. Write UI tests for the app with the level of coverage you feel is appropriate for a typical app.
1. Write unit tests for the `Authenticator` struct that cover all input scenarios.
1. Edit this `README.md` file, filling in the [Answers](#answers) section below.
1. **BONUS**: Set up the tests to run with a free CI service such as GitHub Actions.

## Answers
#### Bugs/Improvements
- List here all the bugs you can find in the app and potential improvements to the user experience.

#### Bugs
1. Upon logout username and password not cleared out
    - Steps to reproduce
        - Fill "test" in username text field
        - Fill "pass1234" in password field
        - Tap on Submit
        - Tap on Logout

    - Actual Result 
        - Username text field still have "test"
        - Password Field Still have "pass1234"

    - Expected result
        - Username text field should have "Username"
        - Password field should have "Password" 

1. Placeholder value for password text field have typo
    - Steps to reproduce
        - Analyize Sign-Up page
    
    - Actual text
        - Placeholder value is "Pasword" in password field

    - expected text
        - Placeholder valure should be "Password" in password field

1. Typing password doesnot show "*"
    - Steps to Reproduce
        - Type "pass1234" in password field

    - Actual Result
        - Text field shows "pass1234"

    - Expected Result
        - Text Field should show "*" like "********"
        - Number of * should be same as number characters on password

1. Multiple Taps on Submit cause multiple requests
    - Steps to reproduce
        - Add valid username to username text feild
        - Add valid password to password field
        - Tap on Sumbit Button
        - Tap on Submit Button again 

    - Actual result 
        - Open multiple views
            - View with "Logout"
            - View with "Back"

    - Expected Result
        - Loading sign should appear is request is already made
        - Disable Submiot button, second tap should not happend 
        - Only Submit View should be opened

1. Multiple Users can be created using same Username
    - Steps to reproduce
        - Add "user32" to username text feild
        - Add valid password to password field
        - Tap on Sumbit Button
        - Tap on Logout
        - Add "user32" to username text feild
        - Add valid password to password field
        - Tap on Sumbit Button

    - Actual result 
        - Take to view with logout []

    - Expected Result
        - Should fail as user already created

#### Improvements
1. Add Margin for Username and Password placeholder
1. Bottom Margin for Submit button [looks better right after Password field ]
1. When Username field lose focus validate user name that:
    - It's length is between 3 and 10
    - Verify same user is not already created
1. When Password field get key stroke
    - Show list of validations with green tick and red cross
1. Increase password strength by changin requirements like:
    - Change minimum characters to 8
    - Should have atleast 1 Alphabet
    - Should have atleast 1 Numeric Character
    - Should have atlease 1 Caps Alphabet
    - Should atlease 1 sign like '!@#$%^&*'
1. We could use a welcome message upon Sign Up, no way to verify if Account is created
