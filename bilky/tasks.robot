# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Template robot main suite
Library         String
Library         RPA.Browser
Library         RPA.Excel.Files
Library         RPA.Email.ImapSmtp


*** Variables ***


*** Keywords ***
Log Out And Close The Browser
    #Click Element   xpath: //*[@id="topbar"]/div/div/div/div[2]/a
    #Click Element   xpath: //*[@id="topnav"]/div/div/div/div/a[2]
    Close Browser

*** Keywords ***
Log In And Go To Recibidos
    Input Text      taxid       B45732211
    Input Password  password    Lui$1982
    Click Element   class: btn-lg
    Click Element   xpath: /html/body/div/div/div/div[2]/div[1]/div/div/div[1]/div/div/div[3]/a
    Sleep   5
    Click Link      xpath: /html/body/div/div[2]/div/div[3]/div/a


*** Keywords ***
Loop Results
    Create Excel Report
    ${lineNumber}     Set Variable  ${1}
    @{subidas}    Get Web Elements     //*[@id="result"]/div[1]/ul/li
    FOR  ${subida}   IN   @{subidas}
        ${match}  Get Regexp Matches    ${subida.text}    .*●.*
        ${count}  Get Length    ${match}
        ${lineNumber}  Run Keyword If  ${count} != 0  Set Variable  ${lineNumber + 1}
        ...            ELSE  Set Variable  ${lineNumber}
        Run Keyword If        ${count} != 0      Download Files   ${lineNumber}    ${subida}  
    END
    Save Workbook

*** Keywords ***
Send Notification Email
    Authorize Smtp  joseferrerh@gmail.com   ferh7536    smtp.gmail.com  587
    Send Message  sender=joseferrerh@gmail.com
    ...           recipients=jferrer@teknei.com
    ...           subject=Message from RPA Robot
    ...           body=RPA Robot message body
    ...           attachments=websitecontents.xlsx


*** Keywords ***
Download Files
    [Arguments]     ${line}     ${subida}
    Set Worksheet Value    ${line}  1   ${subida.text}
    
    Log     ${subida.text}

*** Tasks ***
Minimal task
    Create Excel Report
    Open Available Browser    https://ponter.bilky.es/auth/login
    Log In And Go To Recibidos
    Loop Results
    Send Notification Email
    Log  Done.
    [Teardown]      Log Out And Close The Browser

*** Keywords ***
Create Excel Report
    Create Workbook    websitecontents.xlsx
    Set Worksheet Value    1    1    Content

