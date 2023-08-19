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

    Click Element  ${comptePart}
    Wait Until Page Contains Element  xpath=//input[@formcontrolname="prenom"]     timeout=5s
    Log  4 L'Element : [de type radio] trouvé avec succès

    Click Element  xpath=//input[@formcontrolname="prenom"]  
    Input Text  xpath=//input[@formcontrolname="prenom"]  Jade
    Click Element  xpath=//input[@formcontrolname="nom"] 
    Input Text  xpath=//input[@formcontrolname="nom"]  Crochet
    Click Element  xpath=//input[@formcontrolname="dateNaissance"]
    Input Text  xpath=//input[@formcontrolname="dateNaissance"]  1993-12-31 
    Click Element  xpath=//input[@formcontrolname="adresse"]
    Input Text  xpath=//input[@formcontrolname="adresse"]  12 rue de la victoire 

    Wait Until Element Is Visible   xpath=//select[@formcontrolname="currentPays" and contains(.,"France")]
    ${pays}   Get WebElement   xpath=//select[@formcontrolname="currentPays" and option[contains(text(),"France")]]
    Click Element  ${pays} 
    Select From List By Label   ${pays}   France

    Wait Until Element Is Visible   xpath=//select[@formcontrolname="ville" and option[contains(text(),"Nice")]] 
    ${ville} Get WebElement  xpath=//select[@formcontrolname="ville" and option[contains(text(),"Nice")]]  
    Click Element  ${ville}
    Select From List By Label   ${ville}   Nice


    Close All Browsers


