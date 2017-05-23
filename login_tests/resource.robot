*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library

*** Variables ***
${SERVER}         10.1.25.133/v3/index.html
${BROWSER}        Firefox
${DELAY}          5
${VALID USER}     manage
${VALID PASSWORD}    !manage
${LOGIN URL}      http://${SERVER}/ 
${OUTPUTDIR}      Screenshots


*** Keywords ***
Open Browser To Login Page
    Open Browser    http://10.1.25.133/v3/index.html    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Go To Login Page
    Go To    ${LOGIN URL}

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Element    loginButton
	
Welcome Page Should Be Open
    Title Should Be    10.1.25.102 [A] (GL200-Primary)

Navigating to Host tab
	Click Element	 MtopicsIhosts
	
Initiator Creation
	Click Element	css=div.topicAction.buttonPrimary
	Set Selenium Speed    8
	Click Element	 id=MHostsTopicIcreateInit
	Input Text	 ciaId	 21000030d9001888
	Input Text	 ciaNick	 Initiator1
	Set Selenium Speed    8
	Click Element	 xpath=//*[@id='actionDialog']/div/div[2]/div/div/div[1]
	Set Selenium Speed    8
	Click Element	 adp_ok

Disk Group Creation
	Click Element	 id=MtopicsIpools
	#Set Selenium Speed    8
	Click Element	css=div.topicAction.buttonPrimary
	Click Element	 id=MPoolsTopicIaddDiskGroup
	Click Element	 xpath=//*[@id='type']/ul/li[1]/input
	Input Text	 name	 dgA04
	Select From List By Value	 level	 raid5
	#Xpath Should Match 3 Times | //*[@class='widgetContainer disk2U24HPActive diskWidget'] | 1
	#Click Element	 xpath=//*[@class='widgetContainer disk2U24HPActive diskWidget']
	: FOR    ${INDEX}    IN RANGE    1    4
    \    Log    ${INDEX}
	\    Click Element	 xpath=//*[@class='widgetContainer disk2U24HPActive diskWidget']
	Set Selenium Speed    4
	Click Element    xpath=//*[@id='actionDialog']/div/div[2]/div/div/div[1]
	Set Selenium Speed    4
	Click Element    id=adp_ok

Create Volume
    Click Element    MtopicsIvolumes
	Set Selenium Speed    5
	Click Element    css=div.topicAction.buttonPrimary
	Click Element    id=MVolumesTopicIcreateVirtualVolumes
	Input Text    xpath=//*[@id='cvaTable']/tbody/tr/td[1]    Vol01
	Input Text    xpath=//*[@id='cvaTable']/tbody/tr/td[2]    100GB
	Input Text    xpath=//*[@id='cvaTable']/tbody/tr/td[3]    4
	Input Text    xpath=//*[@id='cvaTable']/tbody/tr/td[5]    A
	Click Element    css=div.buttonLarge.buttonHoriz.buttonPrimary
	


	
Capture Screenshot
    ${file1} =	Capture Page Screenshot
    File Should Exist	${OUTPUTDIR}${/}selenium-screenshot-1.png
    Should Be Equal	${file1}	${OUTPUTDIR}${/}selenium-screenshot-1.png

Delete Vdisk
    #Get Element Attribute    xpath=//*[@id='tPoolsPools']/tbody
	size    Get Element Size    xpath=//*[@id='tPoolsPools']/tbody
	
	${elem} =
	: FOR    ${INDEX}    IN RANGE    1    4
    \    Log    ${INDEX}
	\    Click Element	 xpath=//*[@class='widgetContainer disk2U24HPActive diskWidget']