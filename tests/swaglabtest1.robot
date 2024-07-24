*** Settings ***
Documentation   Testing swaglab website for login & cards matching
Library  SeleniumLibrary
Library  Collections
Resource  resource.robot

Test Setup  Open Browser with Test Setup
Test Teardown   Close Browser


*** Variables ***
${error-msg}        xpath:(//div[@class='error-message-container error'])[1]


*** Test Cases ***

#Validate Unsuccessful Login
#    Fill The Login Page     ${wrong-username}     ${wrong-password}
#    Wait Until Error msg visible       css:.error-button
#    Verify Error Msg

Validate Successfull Login
    Fill The Login Page     ${right-username}       ${right-password}
    Wait Until Error msg visible    ${shop-page-load}
    sleep   1s
    Verify Cards Titles in page
    Select the card        Sauce Labs Bike Light



*** Keywords ***


#Generic keyword
Fill The Login Page
    [Arguments]     ${username}     ${Password}
    Input Text      id:user-name    ${username}
    Input Password  id:password     ${password}
    Click Button    id:login-button


#generic keyword for element visibility check
Wait Until Error msg visible
    [arguments]     ${element}
    Element Should Be Visible    ${element}


Verify Error Msg
#    ${result} =  Get Text     xpath:(//div[@class='error-message-container error'])[1]
    Element Text Should Be      ${error-msg}      ${login-error-msg}

Verify Cards Titles in page
    @{expectedlist} =   Create List  Sauce Labs Backpack     Sauce Labs Bike Light   Sauce Labs Bolt T-Shirt     Sauce Labs Fleece Jacket        Sauce Labs Onesie       Test.allTheThings() T-Shirt (Red)
    Log     ${expectedlist}
    @{elementsonpage} =     Get WebElements      css:.inventory_item_name
    Log     ${elementsonpage}

    FOR     ${element}  IN  @{elementsonpage}
            Log     ${element.text}
            Append To List  ${element-list}     ${element.text}
    END

    Log     ${element-list}

    Lists Should Be Equal   ${element-list}     ${expectedlist}


Select the card
    [arguments]     ${elementname}
    @{elementsonpage} =     Get WebElements      css:.inventory_item_name
    ${index}=   Set Variable    1
    FOR     ${element}   IN      @{elementsonpage}
       Exit For Loop If     '${element.text}'=='${elementname}'
       ${index}=    Evaluate     ${index} + 1
    END

    Click Button    xpath:/html/body/div[1]/div/div/div[2]/div/div/div/div[${index}]/div[2]/div[2]/button

    Log     ${index}
    sleep   5s
    sleep   5s

