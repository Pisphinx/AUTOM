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


    Wait Until Element Is Visible  xpath=//select[@formcontrolname="currentPays" and contains(.,"France")]
    ${pays}  Get WebElement  xpath=//select[@formcontrolname="currentPays" and option[contains(text(),"France")]]
    Click Element  ${pays} 
    Select From List By Label  ${pays}  France

    Wait Until Element Is Visible  xpath=//select[@formcontrolname="ville" and option[contains(text(),"Nice")]] 
    ${ville}  Get WebElement  xpath=//select[@formcontrolname="ville" and option[contains(text(),"Nice")]]  
    Click Element  ${ville}
    Select From List By Label  ${ville}  Nice
    Click Element  xpath=//input[@formcontrolname="codePostal"]
    Input Text  xpath=//input[@formcontrolname="codePostal"]  44000
    Click Element  xpath=//input[@formcontrolname="passport"]
    Input Text  xpath=//input[@formcontrolname="passport"]  898899897
    Click Element  xpath=//input[@formcontrolname="cin"]
    Input Text  xpath=//input[@formcontrolname="cin"]  798799798
    Click Element  xpath=//input[@formcontrolname="username"]
    Input Text  xpath=//input[@formcontrolname="username"]  pispaseven@pispa.pb
    Click Element  xpath=//input[@formcontrolname="tel"]
    Input Text  xpath=//input[@formcontrolname="tel"]  +33679748009
    Click Element  xpath=//input[@formcontrolname="password"]
    Input Text  xpath=//input[@formcontrolname="password"]  Matyththb7
    Click Element  xpath=//input[@formcontrolname="confirmPassword"]
    Input Text  xpath=//input[@formcontrolname="confirmPassword"]  Matyththb7
    Click Element  xpath=//input[@formcontrolname="nomConjoint"]
    Input Text  xpath=//input[@formcontrolname="nomConjoint"]  De la Roche 
    Click Element  xpath=//input[@formcontrolname="prenomConjoint"]   
    Input Text  xpath=//input[@formcontrolname="prenomConjoint"]  Chloé 
    Click Element  xpath=//input[@formcontrolname="dateNaissanceConjoint"]   
    Input Text  xpath=//input[@formcontrolname="dateNaissanceConjoint"]  2001-11-28  
    Wait Until Page Contains Element  xpath=//button[@class="btn btn-primary" and contains(normalize-space(), "Créer votre compte")]
    Log  5 L'Element : [Créer votre compte] trouvé avec succès
    ${creataccompte}  Get WebElement  xpath=//button[@class="btn btn-primary" and contains(normalize-space(), "Créer votre compte")]
    Click Element  ${creataccompte} 
Login compte admin
    Open Browser  ${myURL}  ${myBROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible  xpath=//label[@for="username" and contains(text(), "Identifiant")]  timeout=5s
    Log  7 L'Element : [Identifiant] trouvé avec succès
    Click Element  xpath=//input[@formcontrolname="username"]
    Input Text  xpath=//input[@formcontrolname="username"]  admin@test.com
    Wait Until Page Contains Element  xpath=//label[@for="password" and contains(text(), "Mot de passe")]  timeout=5s
    Log  8 L'Element : [Mot de passe] trouvé avec succès
    Click Element  xpath=//input[@formcontrolname="password"]
    Input Text  xpath=//input[@formcontrolname="password"]  IBCegos01
    Wait Until Page Contains Element  xpath=//button[@class="btn btn-primary" and contains(text(), "Connexion")]  timeout=5s
    Log  9 L'Element : [Connexion] trouvé avec succès
    Log  10 Administrateur connecté avec succès
    ${connexion}  Get WebElement  xpath=//button[@class="btn btn-primary" and contains(text(), "Connexion")] 
    Click Element  ${connexion}
Activation d'un compte utilisateur 

    Wait Until Page Contains Element  xpath=//mat-icon[@data-toggle="dropdown" and contains(.,"settings")]  timeout=5s
    Log  12 L'Element : [Connexion] trouvé avec succès
    ${settings}  Get WebElement  xpath=//mat-icon[@data-toggle="dropdown" and contains(.,"settings")]  
    Click Element  ${settings}
    Click Element  xpath=//a[@href="/admin/utilisateur" and contains(.,"Utilisateurs")]   
    Click Element  xpath=//div[@class="mat-step-label mat-step-label-active"]
    Wait Until Element Is Visible  xpath=//mat-icon[@data-toggle="dropdown" and contains(.,"settings")]  timeout=5s
    Log  13 L'Élement : [settings] trouvé avec succès

    Wait Until Element Is Visible  xpath=//span[contains(., "pispaseven@pispa.pb")] timeout=5s
    Log  14 L'Email : [pispaseven@pispa.pb] trouvé avec succès
    Wait Until Page Contains Element  xpath=//mat-icon[contains(text(), "Approuver")] timeout=5s
    ${tr_element}  Get WebElement    xpath=//span[contains(., "pispaseven@pispa.pb")]
    ${approve_icon}    Get WebElement    xpath=//mat-icon[contains(text(), "Approuver")]
    Click Element     ${tr_element}${approve_icon}
    Log    Le compte avec l'email : [pispaseven@pispa.pb] approuvé avec succès

    
 
  

