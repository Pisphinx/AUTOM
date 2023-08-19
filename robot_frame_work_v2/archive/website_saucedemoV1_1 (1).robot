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
*** Test Cases ***  
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
*** Test Cases ***
    @{options}    Create List    za    az    lohi    hilo
    FOR EACH    ${option}    IN    @{options}
        ${element}    SeleniumLibrary.Get WebElement    //option[@value='${option}']
        SeleniumLibrary.Click Element    ${element}
        BuiltIn.Sleep    ${DELAY}
    END

    
    ${count}    Set Variable    0
    @{item_ids}    Create List    sauce-labs-backpack    sauce-labs-bike-light    sauce-labs-bolt-t-shirt    sauce-labs-fleece-jacket    sauce-labs-onesie    test.allthethings()-t-shirt-(red)
    FOR    ${item_id}    IN    @{item_ids}
        ${add_to_cart_button}    Run Keyword And Return    Get Element    //button[@id='add-to-cart-${item_id}']
        Run Keyword If    ${add_to_cart_button} != ${None}
            Click Element    ${add_to_cart_button}
            Log    4 : ${item_id.capitalize().replace('-', ' ')} : ajouté au panier
            Sleep    ${DELAY}
            ${count} +=    1
        ...    ELSE
            Log    4 : Erreur lors de l'ajout de l'élément ${item_id}: Element not found
        END
    END
    
    Log    5 : Nombre total d'éléments ajoutés au panier : ${count}
    
    @{item_names_to_remove}    Create List    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
    FOR    ${item_name}    IN    @{item_names_to_remove}
        ${remove_button}    Run Keyword And Return    Get Element    //button[@id='remove-${item_name.replace(' ', '-').lower()}']
        Run Keyword If    ${remove_button} != ${None}
            Click Element    ${remove_button}
            Sleep    ${DELAY}
            Log    5.1 : Supprimé du panier : ${item_name}
        ...    ELSE
            Log    Erreur lors de la suppression de l'élément ${item_name}
        END
    END
    
    @{cart_item_names}    Get WebElements    //div[@class='inventory_item_name']
    Log    6 : liste des articles diponibles :
    FOR    ${item_name}    IN    @{cart_item_names}
        Log    ${item_name.text}
    END
    
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
    
    Run Keyword And Return If    ${BROWSER} == "Firefox"
        ${imgAurevoir}    Get Element    //img[@class="pony_express"]
        Run Keyword If    ${imgAurevoir} != ${None}
            Log    l'image d'au revoir est présente
            ${img_src}    Get Element Attribute    ${imgAurevoir}    src
            Log    Image Source: ${img_src}
        ...    ELSE
            Log    l'image d'au revoir est absente
        END
    Click Element    //button[@id='back-to-products']
    
    Run Keyword And Return If    "${BROWSER}" == "Firefox"
        Click Element    //div[@id='header_container']/div[2]/div/span/select
        Click Element    //button[@id='react-burger-menu-btn']
        Sleep    ${DELAY}
        Click Element    id=logout_sidebar_link
    
    Close Browser
