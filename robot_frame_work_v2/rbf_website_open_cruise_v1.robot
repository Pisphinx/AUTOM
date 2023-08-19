*** Settings ***
Library  SeleniumLibrary 
Library  BuiltIn

*** Variables *** 
${myURL}       http://opencruise-ok.sogeti-center.cloud/
${myBROWSER}   Firefox 
${DELAY}       3 

*** Test Cases ***
Création d'un compte particulier 
    Open Browser  ${myURL}  ${myBROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element  xpath=//a[@routerlink="/register"]     timeout=5s
    Log  1 L'Element : [Vous n'avez pas de compte ? Créez-en un ici] trouvé avec succès 
    ${register}   Get WebElement  xpath=//a[@routerlink="/register"] 
    Click Element   ${register}
    
    Wait Until Element Is Visible   xpath=//h2[contains(.,"Formulaire d'inscription")]   timeout=2s
    Log  2 L'Element : [Formulaire d'inscription] trouvé avec succès
    Wait Until Element Is Visible   xpath=//label[contains(.,"Particulier")]   timeout=1s
    Log  3 L'Element : [Particulier] trouvé avec succès
    
    Wait Until Page Contains Element  xpath=//input[@type="radio" and @value="1"]     timeout=5s
    Log  4 L'Element : [de type radio] trouvé avec succès
    ${comptePart}  Get WebElement  xpath=//input[@type="radio" and @value="1"]
    Should Be A Radio Button    ${comptePart} 
    Click Element  ${comptePart}
    Wait Until Page Contains Element  xpath=//input[@formcontrolname="prenom"]     timeout=5s
    Log  4 L'Element : [de type radio] trouvé avec succès
    ${comptePart}  Get WebElement  //input[@formcontrolname="prenom"] 
    Click Element  //input[@formcontrolname="prenom"]  papis
    Input Text  //input[@formcontrolname="prenom"]  papis
    Input Text  xpath=//input[@formcontrolname="nom"]  papis
    Close All Browsers
