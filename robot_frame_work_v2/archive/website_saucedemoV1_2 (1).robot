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
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    [Teardown]    Close Browser
    
    Login
    Select Products
    Add Items To Cart
    Remove Items From Cart
    Checkout Process
    Complete Order

*** Keywords ***
Login
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

Select Products
    Wait Until Page Contains Element    //div[@class='app_logo' and contains(., 'Swag Labs')]
    Log    --- Element :'Swag Labs' found successfully. 🙌 🙌 ---

    Wait Until Page Contains Element    //select[@class='product_sort_container']
    Log    --- Element :'for filtering' found successfully. 🙌 🙌 ---

    Click Element    //select[@class='product_sort_container']
    Sleep    ${DELAY}
    
Add Items To Cart
    @{item_ids}    Create List    sauce-labs-backpack    sauce-labs-bike-light    sauce-labs-bolt-t-shirt
    FOR    ${item_id}    IN    @{item_ids}
        ${add_to_cart_button}    Get Element    //button[@id='add-to-cart-${item_id}']
        Run Keyword If    ${add_to_cart_button} != ${None}
            Click Element    ${add_to_cart_button}
            Log    ${item_id.capitalize().replace('-', ' ')} : ajouté au panier
            Sleep    ${DELAY}
        END
    END

Remove Items From Cart
    @{item_names_to_remove}    Create List    Sauce Labs Fleece Jacket    Sauce Labs Onesie
    FOR    ${item_name}    IN    @{item_names_to_remove}
        ${remove_button}    Get Element    //button[@id='remove-${item_name.replace(' ', '-').lower()}']
        Run Keyword If    ${remove_button} != ${None}
            Click Element    ${remove_button}
            Sleep    ${DELAY}
            Log    Supprimé du panier : ${item_name}
        END
    END

Checkout Process
    Click Element    //div[@id='shopping_cart_container']/a/span
    Log    Cart opened
    
    Wait Until Page Contains Element    //button[text()='Checkout']
    Log    --- Bouton Checkout trouvé avec succès 🙌 🙌 ---

    Wait Until Page Contains Element    //button[text()='Continue Shopping']
    Log    --- Bouton Continue Shopping trouvé avec succès 🙌 🙌 ---

    Click Element    //button[contains(.,'Checkout')]
    Log    Accès au panier réussi 🙌 🙌

    Input Text    //input[@id='first-name']    Pape
    Input Text    //input[@id='last-name']    THIAM
    Input Text    //input[@id='postal-code']    44400
    Click Element    //input[@id='continue']
    Click Element    //button[@id='finish']

Complete Order
    Wait Until Page Contains Element    //h2[@class="complete-header"]
    Log    Merci pour votre commande! 🤙🙌🙌

    Run Keyword If    "${BROWSER}" == "Firefox"
        Run Keyword And Return    Verify Goodbye Image

    Click Element    //button[@id='back-to-products']
    
    Run Keyword If    "${BROWSER}" == "Firefox"
        Logout

Verify Goodbye Image
    ${imgAurevoir}    Get Element    //img[@class="pony_express"]
    Run Keyword If    ${imgAurevoir} != ${None}
        Log    L'image d'au revoir est présente
        ${img_src}    Get Element Attribute    ${imgAurevoir}    src
        Log    Image Source: ${img_src}
    ELSE
        Log    L'image d'au revoir est absente

Logout
    Click Element    //div[@id='header_container']/div[2]/div/span/select
    Click Element    //button[@id='react-burger-menu-btn']
    Sleep    ${DELAY}
    Click Element    id=logout_sidebar_link
    Close Browser
