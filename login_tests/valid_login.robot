*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    manage
    Input Password    !manage
    Submit Credentials
	
    #Welcome Page Should Be Open
	#Host tab id
	#Initiator Creation
	#Disk Group Creation
	[Teardown]    Close Browser


