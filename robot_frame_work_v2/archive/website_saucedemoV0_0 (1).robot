*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${URL}             https://www.saucedemo.com/
${BROWSER}         Firefox
${DELAY}           2

*** Test Cases ***
Login and Shopping
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    //div[@class='login_logo' and contains(., 'Swag Labs')]    timeout=50s
    Log    ---------------- Element found successfully 🙌 🙌 ----------------
    
    Click Element    //div[@id='login_credentials']
    Click Element    //input[@id='user-name']
    Input Text    //input[@id='user-name']    standard_user
    Log    1 : Username: standard_user
    
    Click Element     //div[@id='login_credentials']
    Click Element    //input[@id='password' and @type='password']
    Input Text    //input[@id='password' and @type='password']    secret_sauce
    Log    2 : Password: secret_sauce
    
    Click Element    //div[@id='login_button_container']/div/form/input
    Log    3 : 🎉 Bravo logging correct 🎉
    
    Wait Until Page Contains Element    //div[@class='app_logo' and contains(., 'Swag Labs')]    timeout=50s
    Log    --- Element :'Swag Labs' found successfully. 🙌 🙌 ---
    
    Wait Until Page Contains Element    //select[@class='product_sort_container']    timeout=50s
    Log    --- Element :'for filtering' found successfully. 🙌 🙌 ---


