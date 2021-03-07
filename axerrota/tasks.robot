# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Recogida de impuestos forales de Axerrota
Library         RPA.Browser.Selenium
Library         RPA.Desktop.Windows
Library         RPA.FileSystem

*** Keywords ***
Abrir navegador
    &{preferences}=
    ...    Create Dictionary
    ...    download.default_directory=c:\\robocorpp\\descargas
    ...    plugins.always_open_pdf_externally=${True}
    ...    restore_on_startup=${False}
    Open available browser  https://apli.bizkaia.net/bizkaibai/Castellano/Aldundia/ogasuna/Seguridad/caLoginBai.asp  preferences=${preferences}
    Maximize browser window
    sleep  2s

*** Keywords ***
Acceder a Pagina
    Wait Until Element Contains  class:listaAccesos   Giltza
    Click element                xpath: /html[1]/body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/div[1]/ul[2]/li[1]
    Wait Until Element Contains  class:authenticationContent   Certificados digitales
    Click element                xpath: /html[1]/body[1]/div[1]/div[2]/div[1]/div[1]/form[1]/div[2]/div[3]/a[1]

*** Keywords ***
Acceder a Datos
    Wait Until Element Contains  id:menuForm   Acceso a Catastro de Bizkaia
    Click element                name:sImagen13
    Wait Until Element Contains  id:contenedor_body  Presentaciones telemáticas tributarias
    Click element                id:Pres
    Wait Until Element Contains  id:contenedor_body  El criterio de selección que usted ha señalado es el siguiente


*** Keywords ***
Recorrer Impuestos
    Sleep  3s
    #@{impuestos}         Get Web Elements    //body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/font[1]/center[1]/form[1]/table[2]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[1]/td[1]/table[1]
    #@{impuestos}
    ${linenumber}        Set Variable  ${2}
    sleep  2s
    FOR  ${linenumber}   IN RANGE  50
        Log  ${linenumber}
        Click element    xpath: /html[1]/body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/font[1]/center[1]/form[1]/table[2]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[${linenumber}]/td[1]
        sleep  2s
        #${ll}           Get WebElement     //body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/blockquote[1]/center[2]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[1]
        #Click element   xpath:  /html[1]/body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/blockquote[1]/center[2]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[1]
        #${enlace}       Get Element Attribute  xpath: /html[1]/body[1]/div[3]/center[1]/table[1]/tbody[1]/tr[1]/td[1]/blockquote[1]/center[2]/table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[1]  href
        Go Back                                        
        Send Keys        {ENTER}
        ${lineNumber}    Set Variable    ${lineNumber + 1}
    END

*** Keywords ***
Cerrar navegador    
    Close Browser

*** Tasks ***
Axerrota
    Abrir navegador
    Acceder a Pagina
    Acceder a Datos
    Recorrer Impuestos
    [Teardown]  Cerrar navegador    
