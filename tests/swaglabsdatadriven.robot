*** Settings ***
Documentation   data driven testing with test tamplate & csv as well
Library  SeleniumLibrary
Library  Collections
Resource  resource.robot

Library  DataDriver     file=resources/logindata.csv    encoding=utf_8      dialect=unix

Test Setup      Open Browser with Test Setup
Test Template   validate login details



*** Variables ***

${error-msg}        xpath:(//div[@class='error-message-container error'])[1]


*** Test Cases ***

Login with CSV data Username ${username} and password ${password}           xyz     123456


*** Keywords ***

validate login details
    [Arguments]     ${username}     ${password}
    Fill The Login Page     ${username}     ${password}
    Wait Until Error msg visible    css:.error-button
    Verify Error Msg


Fill The Login Page
    [Arguments]     ${username}     ${Password}
    Input Text      id:user-name    ${username}
    Input Password  id:password     ${password}
    Click Button    id:login-button

Wait Until Error msg visible
    [arguments]     ${element}
    Element Should Be Visible    ${element}


Verify Error Msg
#    ${result} =  Get Text     xpath:(//div[@class='error-message-container error'])[1]
    Element Text Should Be      ${error-msg}      ${login-error-msg}
