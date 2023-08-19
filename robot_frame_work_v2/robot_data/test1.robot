*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn

*** Variables ***
${myURL}           http://opencruise-ok.sogeti-center.cloud/
${myBROWSER}       Firefox
${DELAY}           3

*** Test Cases ***
Création d'un compte particulier
    Open Browser   ${myURL}   ${myBROWSER}
    Maximize Browser Window
    Go To Registration Page
    Fill Registration Form
    Click Create Account Button
    Log In As Administrator
    Open User Activation Page
    Approve User Account
    Logout Administrator

*** Keywords ***
Go To Registration Page
    Wait Until Page Contains Element    xpath=//a[@routerlink="/register"]    timeout=5s
    Click Element    xpath=//a[@routerlink="/register"]

Fill Registration Form
    Wait Until Element Is Visible    xpath=//h2[contains(., "Formulaire d'inscription")]    timeout=2s
    Input Text    xpath=//input[@formcontrolname="prenom"]    Jade
    Input Text    xpath=//input[@formcontrolname="nom"]    Crochet
    Input Text    xpath=//input[@formcontrolname="dateNaissance"]    1993-12-31
    # Fill in other form fields as needed

Click Create Account Button
    Click Element    xpath=//button[contains(., "Créer votre compte")]

Log In As Administrator
    Input Text    xpath=//input[@formcontrolname="username"]    admin@test.com
    Input Text    xpath=//input[@formcontrolname="password"]    IBCegos01
    Click Element    xpath=//button[contains(., "Connexion")]

Open User Activation Page
    Click Element    xpath=//mat-icon[@data-toggle="dropdown" and contains(., "settings")]
    Click Element    xpath=//a[@href="/admin/utilisateur" and contains(., "Utilisateurs")]
    Click Element    xpath=//div[@class="mat-step-label mat-step-label-active"]

Approve User Account
    # Implement approving user account steps here

Logout Administrator
    Click Element    xpath=//button[@class="btn dropdown-toggle" and contains(., "Bienvenue ADMIN TEST")]
    Click Element    xpath=//button[@class="dropdown-item" and contains(., "Se déconnecter")]
