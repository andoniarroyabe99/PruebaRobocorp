# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Recogida de todos los impuestos forales de Addi
Library         RPA.Browser.Selenium
Library         RPA.FileSystem


*** Keywords ***
Abrir navegador
    Open available browser   https://egoitza.gipuzkoa.eus/WAS/CORP/WATTramiteakWEB/inicio.do?app=PREPO&idioma=C&login=Z&r=0.07048663566337121
    Maximize browser window

*** Keywords ***
Acceder a datos
    Wait Until Element Contains  name:loginForm  Clave de autenticación
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/section[1]/div[1]/div[1]/form[1]/div[2]/div[1]/div[1]/div[1]/div[2]/div[1]/div[2]/div[3]/a[1]
    Wait Until Element Contains  id:flowSelectorForm  Certificados digitales         
    Click element  xpath: /html[1]/body[1]/div[1]/div[2]/div[1]/div[1]/form[1]/div[2]/div[3]/a[1]
    Wait Until Element Contains  name:loginForm  Elegir modo de actuación
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/label[1]
    Click element  xpath: /html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[2]/label[1]
    Click element  name:iniciarSesionEntidadRepresentante
    Wait Until Element Contains  id:wrapper  ADDICONSULTING ASESORES Y ABOGADOS SL
    Click element  xpath: /html[1]/body[1]/div[3]/nav[1]/div[1]/div[1]/ul[1]/li[4]/a[1]
    Wait Until Element Contains  id:wrapper  ADDICONSULTING ASESORES Y ABOGADOS SL
    Click element  xpath: /html[1]/body[1]/div[3]/nav[1]/div[1]/div[1]/ul[1]/li[4]/a[1]

*** Keywords ***
Elegir fecha
    Wait Until Element Contains  id:content  Búsqueda de declaraciones
    Click element  xpath: /html[1]/body[1]/div[3]/div[4]/div[1]/section[1]/div[1]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[2]/div[2]/div[1]/button[1]

*** Keywords ***
Scroll
    execute javascript  window.scroll(0,400)

*** Keywords ***
Descargar archivos
    Click element  xpath: /html[1]/body[1]/div[3]/div[4]/div[1]/section[1]/div[1]/div[4]/div[1]/hidden[1]/div[1]/table[1]/tbody[1]/tr[1]/td[11]/a[2]/span[1]
    Create Directory  ${CURDIR}${/}output${/}archivos

*** Keywords ***
Cerrar navegador
    Close Browser

*** Tasks ***
Impuestos Forales Addi
    Abrir navegador
    Acceder a datos
    Elegir fecha
    Scroll
    Descargar archivos
    sleep  30s
    [Teardown]  Cerrar navegador
