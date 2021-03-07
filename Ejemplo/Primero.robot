*** Settings ***
Documentation  Abrir y cerrar browser
Library  RPA.browser

*** Keywords ***
abrir
    Open Available Browser  https://robotsparebinindustries.com/
login
    Input Text  id:username  maria
    Input Password  id:password  thoushallnotpass

*** Tasks ***
primero
    abrir
    login
