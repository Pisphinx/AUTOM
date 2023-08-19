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
    Log    2 : Password: standard_user
    
    Click Element    //div[@id='login_button_container']/div/form/input
    Log    3 : 🎉 Bravo logging correct 🎉

Vérification de la page ciblée

    Wait Until Page Contains Element    //div[@class='app_logo' and contains(., 'Swag Labs')]    timeout=50s
    Log    --- Element :'Swag Labs' found successfully. 🙌 🙌 ---
    
    Wait Until Page Contains Element    //select[@class='product_sort_container']    timeout=50s
    Log    --- Element :'for filtering' found successfully. 🙌 🙌 ---
    
    Click Element    //select[@class='product_sort_container']
    Sleep    ${DELAY}

Extraire le contenu de la page d'accueil contenant les articles    
    @{name_elements}    Get WebElements    //div[@class='inventory_item_name']
    @{desc_elements}    Get WebElements    //div[@class='inventory_item_desc']
    @{price_elements}    Get WebElements    //div[@class='inventory_item_price']



    Log    Contenu de la liste des noms d'articles:
    FOR    ${name_element}    IN    @{name_elements}
        Log    ${name_element.text}
    END
    Log    Contenu de la liste des descriptions d'articles:
    FOR    ${desc_element}    IN    @{desc_elements}
       Log    ${desc_element.text}
    END 
    Log    Contenu de la liste des prix d'articles:
    FOR    ${price_element}    IN    @{price_elements}
       Log    ${price_element.text}
    END 
    ${output_folder}    Set Variable    C:\\Users\\IB\\Desktop\\PapeDocs\\SELENIUM_WEBDRIVER\\TPscripts\\export
    Create Directory    ${output_folder}
    
    FOR    ${index}    IN RANGE    0    ${name_elements.__len__()}
        ${name}    Get Text    ${name_elements[${index}]}
        ${description}    Get Text    ${desc_elements[${index}]}
        ${price}    Get Text    ${price_elements[${index}]}
        Append To File    ${output_folder}\\articles.txt    Article ${index + 1}:\nNom: ${name}\nDescription: ${description}\nPrix: ${price}\n\n
    END
    

Vérification des différentes options de tri 

    @{options}    Create List    za    az    lohi    hilo
    FOR    ${option}    IN    @{options}
        ${element}  SeleniumLibrary.Get WebElement  //option[@value='${option}']
        Click Element    ${element}
        Sleep    ${DELAY}
    END
Ajouter des élements dans le panier : 
    *** Settings ***
Documentation     Example test with a loop

*** Test Cases ***
Add Items to Cart
    ${items}    Create List    sauce-labs-bolt-t-shirt    sauce-labs-backpack    sauce-labs-bike-light    sauce-labs-fleece-jacket    sauce-labs-onesie    test.allthethings()-t-shirt-(red)
    FOR    ${item}    IN    @{items}
        Wait Until Page Contains Element    //button[@id='add-to-cart-${item}']    timeout=50s
        Log    --- Element :'${item}' ajouté avec succès. 🙌 🙌 ---
        Click Element    //button[@id='add-to-cart-${item}']
    END


Enlever des articles du panier

    Wait Until Page Contains Element    //button[@id='remove-sauce-labs-fleece-jacket']    timeout=20s
    Log    --- Element :'sauce-labs-fleece-jacket :' retiré avec succès. 🙌 🙌 ---
    Click Element    //button[@id='remove-sauce-labs-fleece-jacket'] 
    
    Wait Until Page Contains Element      //button[@id='remove-sauce-labs-backpack']    timeout=20s
    Log    --- Element 'sauce-labs-backpack :' retiré avec succès. 🙌 🙌 ---
    Click Element      //button[@id='remove-sauce-labs-backpack'] 


Vérification de la page ciblée

    Click Element    //div[@id='shopping_cart_container']/a/span
    Log    7 : Cart opened
    
    Wait Until Page Contains Element    //button[text()='Checkout']    timeout=30s
    Log    --- Bouton Checkout trouvé avec succès 🙌 🙌 ---
    
    Wait Until Page Contains Element    //button[text()='Continue Shopping']    timeout=30s
    Log    --- Bouton Continue Shopping trouvé avec succès 🙌 🙌 ---
    
    Click Element    //button[contains(.,'Checkout')]
    Log    8 : Accés au panier réussi 🙌 🙌
    
Finaliser la commande 

    Input Text    //input[@id='first-name']    Pape
    Input Text    //input[@id='last-name']    THIAM
    Input Text    //input[@id='postal-code']    44400
    Click Element    //input[@id='continue']
    Click Element    //button[@id='finish']
    
    Wait Until Page Contains Element    //h2[@class="complete-header"]    timeout=30s
    Log    le message d'au revoir 👋👋👋\n\n\n---Thank you for your order! 🤙🙌🙌---
    Close Browser

