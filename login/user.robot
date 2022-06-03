*** Settings ***
Library       SeleniumLibrary
Library       String

Test Setup        New Session
Test Teardown     Close Session


*** Variables ***
${url}            https://www.saucedemo.com/                


*** Test Cases ***
access to web page

    Title Should Be     Swag Labs   
    Sleep               5
    
access username and password
    [Tags]                  usersucess
 
    Input Text              css:#user-name       standard_user
    Input Text              css:#password        secret_sauce
    Click Element           css:#login-button
    
    Should Be Title Case    Swag Labs
    Sleep                   5

access username and password plus choice combobox
    [Tags]                          combobox
  
    Input Text                      css:#user-name       standard_user
    Input Text                      css:#password        secret_sauce
    Click Element                   css:#login-button
    Should Be Title Case            Swag Labs  
    
    Select From List By Label       class:product_sort_container        Price (low to high)
    ${select}=                      Get Selected List Value             class:product_sort_container
    Should Be Equal                 ${select}                           lohi
    Sleep                           5


access username and password plus choice combobox and logout
    [Tags]                          logout
  
    Input Text                      css:#user-name       standard_user
    Input Text                      css:#password        secret_sauce
    Click Element                   css:#login-button
    Should Be Title Case            Swag Labs  
    
    Select From List By Label       class:product_sort_container        Price (low to high)
    ${select}=                      Get Selected List Value             class:product_sort_container
    Should Be Equal                 ${select}                           lohi
    Sleep                           5

    Click Element                          css:#react-burger-menu-btn       
    Get Element Attribute                  xpath://*[@id="menu_button_container"]/div/div[2]/div[1]/nav    Logout


*** Keywords ***
New Session         
     Open Browser          ${url}                 chrome 
Close Session        
    Capture Page Screenshot        
    Close Browser 
