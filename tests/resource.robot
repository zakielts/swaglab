*** Settings ***
Documentation   Resource file for all test cased and usable code for entire test
Library     SeleniumLibrary

*** Variables ***
${URL}          https://www.saucedemo.com/
${browser}      Chrome


${wrong-username}       zaki
${wrong-password}       admin123

${right-username}       standard_user
${right-password}       secret_sauce

${login-error-msg}      Epic sadface: Username and password do not match any user in this service
${shop-page-load}       css:.shopping_cart_link

#${actuallist}        Sauce Labs Backpack     Sauce Labs Bike Light   Sauce Labs Bolt T-Shirt     Sauce Labs Fleece Jacket        Sauce Labs Onesie       Test.allTheThings() T-Shirt (Red)
@{element-list}

*** Keywords ***

Open Browser with Test Setup
    Open Browser    ${url}  ${browser}
    sleep   2s
