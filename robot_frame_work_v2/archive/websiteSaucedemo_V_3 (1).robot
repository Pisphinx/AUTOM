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
    
    # Run Keyword And Ignore Error    Element Should Be Visible    //input[@placeholder='Password']
    # Run Keyword If    "${PASS_VISIBLE}" == "True"    Log    la page contient le texte Password
    Click Element     //div[@id='login_credentials']
    Click Element    //input[@id='password' and @type='password']
    Input Text    //input[@id='password' and @type='password']    secret_sauce
    Log    2 : Password: standard_user
    
    Click Element    //div[@id='login_button_container']/div/form/input
    Log    3 : 🎉 Bravo logging correct 🎉
    
    Wait Until Page Contains Element    //div[@class='app_logo' and contains(., 'Swag Labs')]    timeout=50s
    Log    --- Element :'Swag Labs' found successfully. 🙌 🙌 ---
    
    Wait Until Page Contains Element    //select[@class='product_sort_container']    timeout=50s
    Log    --- Element :'for filtering' found successfully. 🙌 🙌 ---
    
    Click Element    //select[@class='product_sort_container']
    Sleep    ${DELAY}
    
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
    


    @{options}    Create List    za    az    lohi    hilo
    FOR    ${option}    IN    @{options}
        ${element}  SeleniumLibrary.Get WebElement  //option[@value='${option}']
        Click Element    ${element}
        Sleep    ${DELAY}
    END

    Wait Until Page Contains Element    //button[@id='add-to-cart-sauce-labs-bolt-t-shirt']    timeout=50s
    Log    --- Element :'sauce-labs-bolt-t-shirt' ajouté avec succès. 🙌 🙌 ---
    Click Element    //button[@id='add-to-cart-sauce-labs-bolt-t-shirt'] 
    Wait Until Page Contains Element    //button[@id='add-to-cart-sauce-labs-backpack']    timeout=50s
    Log    --- Element :'sauce-labs-backpack' ajouté avec succès. 🙌 🙌 ---
    Click Element    //button[@id='add-to-cart-sauce-labs-backpack']
    Sleep    ${DELAY}


    Click Element    //div[@id='shopping_cart_container']/a/span
    Log    7 : Cart opened
    
    Wait Until Page Contains Element    //button[text()='Checkout']    timeout=50s
    Log    --- Bouton Checkout trouvé avec succès 🙌 🙌 ---
    
    Wait Until Page Contains Element    //button[text()='Continue Shopping']    timeout=50s
    Log    --- Bouton Continue Shopping trouvé avec succès 🙌 🙌 ---
    
    Click Element    //button[contains(.,'Checkout')]
    Log    8 : Accés au panier réussi 🙌 🙌
    
    Input Text    //input[@id='first-name']    Pape
    Input Text    //input[@id='last-name']    THIAM
    Input Text    //input[@id='postal-code']    44400
    Click Element    //input[@id='continue']
    Click Element    //button[@id='finish']
    
    Wait Until Page Contains Element    //h2[@class="complete-header"]    timeout=50s
    Log    le message d'au revoir 👋👋👋\n\n\n---Thank you for your order! 🤙🙌🙌---
    
    
    Close Browser

    *** Keywords ***
    Run Keyword If    ${condition}
        [Arguments]    ${condition}
        ${value}    Run Keyword If    "${condition}" == "True"    Set Variable    True
        Run Keyword If    "${condition}" == "False"    Set Variable    False
        [Return]    ${value}
