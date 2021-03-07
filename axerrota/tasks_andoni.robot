# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Recogida de todos los impuestos forales de Addi
Library         RPA.Browser.Selenium
Library         RPA.Desktop.Windows
Library         RPA.HTTP

*** Variables ***
#${URL_IMPUESTOS}=   https://zergabidea.gipuzkoa.eus
#${URL_IMPUESTOS}=   https://zergabidea.gipuzkoa.eus/WAS/HACI/HGFZergaBideaWEB/login?locale=eu_ES
${URL_IMPUESTOS}=    https://egoitza.gipuzkoa.eus/WAS/CORP/WATTramiteakWEB/inicio.do?app=PREPO&idioma=E&login=Z&r=0.07048663566337121
${PROFILE_PATH}=     %{LOCALAPPDATA}${/}Google${/}Chrome${/}User Data${/}
${DOWNLOAD_DIR}=     c:\\RPA\\output\\

*** Keywords ***
Abrir navegador Old
    Open available browser   https://egoitza.gipuzkoa.eus/WAS/CORP/WATTramiteakWEB/inicio.do?app=PREPO&idioma=E&login=Z&r=0.07048663566337121
    #Maximize browser window
    sleep  2s

*** Keywords ***
Open Impuestos Gipuzkoa
    &{preferences}=
    ...    Create Dictionary
    ...    download.default_directory=${DOWNLOAD_DIR}
    ...    plugins.always_open_pdf_externally=${True}
    ...    restore_on_startup=${False}
    Open Available Browser   
    ...    ${URL_IMPUESTOS}
    ...    use_profile=True    profile_path=${PROFILE_PATH}    profile_name=Default
    ...    preferences=${preferences} 

*** Keywords ***
Abrir navegador
    &{preferences}=
    ...    Create Dictionary
    ...    download.default_directory=${DOWNLOAD_DIR}
    ...    plugins.always_open_pdf_externally=${True}
    ...    restore_on_startup=${False}
    Open available browser   https://egoitza.gipuzkoa.eus/WAS/CORP/WATTramiteakWEB/inicio.do?app=PREPO&idioma=E&login=Z&r=0.07048663566337121
    ...    preferences=${preferences} 
    Maximize browser window
    sleep  2s

*** Keywords ***
Acceder a todas las presentaciones
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/section[1]/div[1]/div[1]/form[1]/div[2]/div[1]/div[1]/div[1]/div[2]/div[1]/div[2]/div[3]/a[1]
    sleep  1s             
    Click element  xpath: /html[1]/body[1]/div[1]/div[2]/div[1]/div[1]/form[1]/div[2]/div[3]/a[1]
    sleep  1s
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/label[1]
    sleep  1s
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[2]/label[1]
    Click element  name:iniciarSesionEntidadRepresentante
    sleep  1s
    Click element  xpath: /html[1]/body[1]/div[3]/nav[1]/div[1]/div[1]/ul[1]/li[4]/a[1]
    sleep  3s
    Send Keys   {END} {ENTER}

*** Keywords ***
Elegir fecha
    # Click element  xpath: /html[1]/body[1]/div[3]/div[4]/div[1]/section[1]/div[1]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]
    # sleep  1s
    # Click element  xpath: /html[1]/body[1]/div[4]/div[1]/table[1]/tbody[1]/tr[4]/td[1]
    sleep  1s
    Click element  xpath: /html[1]/body[1]/div[3]/div[4]/div[1]/section[1]/div[1]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[2]/div[2]/div[1]/button[1]

*** Keywords ***
Scroll
    execute javascript  window.scroll(0,400)

*** Keywords ***
Recorrer Impuestos
    Sleep  5
    
    @{impuestos}    Get Web Elements    //*[@id="lista"]/tbody/tr

    ${lineNumber}     Set Variable  ${1}
    FOR  ${impuesto}   IN   @{impuestos}
        Log     ${impuesto}
        
        # Intentamos descargar de la lista
        ${botonPDF}     Get WebElement     //*[@id="lista"]/tbody/tr[${lineNumber}]/td[11]/a[2]
        Click Link   xpath://*[@id="lista"]/tbody/tr[${lineNumber}]/td[11]/a[2]
        ${enlace}       Get Element Attribute   xpath://*[@id="lista"]/tbody/tr[${lineNumber}]/td[11]/a[2]   href
        # Download    ${enlace}    target_file=impuesto_${lineNumber}.pdf
        Sleep    5
        Send Keys   {ENTER}
        # Close Window
        

        # Viaja a la página detalles
        # Click Link   xpath://*[@id="lista"]/tbody/tr[${lineNumber}]/td[11]/a[1]
        # Sleep    5
        # Click para descargar el PDF
        # Click Link   xpath://*[@id="main"]/hidden/div[11]/div[1]/table[3]/tbody/tr/td/a[2]
        # Click Element   xpath://*[@id="lista"]/tbody/tr[1]/td[11]/a[2]
        # ${enlace}       Get Element Attribute   xpath://*[@id="main"]/hidden/div[11]/div[1]/table[3]/tbody/tr/td/a[2]   href
        # Download    ${enlace}    target_file=impuesto_${lineNumber}.pdf
        # Close Window
        
        # Click en ITXI
        # Click Link    //*[@id="main"]/hidden/div[11]/div[1]/table[1]/tbody/tr/td[4]/a

        ${lineNumber}    Set Variable    ${lineNumber + 1}
    END


*** Keywords ***
Cerrar navegador
    Close Browser

*** Tasks ***
Impuestos Forales Addi
    # Open Impuestos Gipuzkoa
    Abrir Navegador
    Acceder a todas las presentaciones
    Elegir fecha
    Scroll
    Recorrer Impuestos
    sleep  10s
    [Teardown]  Cerrar navegador
