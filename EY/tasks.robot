# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Acceso a un mail de teknei.es
Library         RPA.Excel.Files
Library         RPA.Email.ImapSmtp  


*** Variables ***
${cuenta}       marketing@teknei.es 
${pass}         Marketing16
${remitente}  
${asunto}       Finanzas       

*** Keywords ***  
Acceder Buzon Email
    Authorize Imap     ${cuenta}  ${pass}  imap.serviciodecorreo.es   993

*** Keywords ***
Recuperar Mensajes
    [Arguments]  ${asunto}
    
    ${lineNumber}   Set Variable    ${2}
    @{emails}   List Messages  Subject ${asunto}  INBOX
    FOR     ${email}  IN  @{emails} 
        Log  ${email}[Subject]
        
        Log  ${email}[Has-Attachments]
        
        Set Worksheet Value    ${lineNumber}    1    ${email}[Subject].text
        Set Worksheet Value    ${lineNumber}    2    ${email}[From].text
        Set Worksheet Value    ${lineNumber}    3    ${email}[Date].text
        Set Worksheet Value    ${lineNumber}    4    ${email}[Received].text
        Set Worksheet Value    ${lineNumber}    5    ${email}[To].text
        
        ${lineNumber}   Set Variable    ${lineNumber + 1}
    END
    [Return]    @{emails}

*** Keywords ***
Crear Excel
    Create Workbook  excelprueba.xlsx
    Set Worksheet Value    1    1    Asunto
    Set Worksheet Value    1    2    From
    Set Worksheet Value    1    3    Date
    Set Worksheet Value    1    4    Received
    Set Worksheet Value    1    5    To

*** Tasks ***
Intentar recoger mensajes
    Acceder Buzon Email
    @{folders}  Get Folder List
    Log Many    ${folders}
    Crear Excel
    Recuperar Mensajes    ${asunto}
    Save Workbook

