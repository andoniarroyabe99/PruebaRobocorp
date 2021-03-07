*** Settings ***
Documentation   Abrir browser
Library           RPA.Browser
Library           RPA.HTTP
Library           RPA.Excel.Files
Library           RPA.PDF


*** Keywords ***
Abrir
    Open Available Browser  https://robotsparebinindustries.com/


*** Keywords ***
Login
    Input Text  id:username  maria
    Input Password  id:password  thoushallnotpass
    Submit Form
    Wait Until Page Contains Element    id:sales-form


*** Keywords ***
Meter datos de una persona
    [Arguments]    ${sales_rep}
    Input Text    firstname    ${sales_rep}[First Name]
    Input Text    lastname    ${sales_rep}[Last Name]
    Input Text    salesresult    ${sales_rep}[Sales]
    ${target_string}=    Convert To String    ${sales_rep}[Sales Target]
    Select From List By Value    salestarget    ${target_string}
    Click Button    Submit


*** Keywords ***
Excel
    Download    https://robotsparebinindustries.com/SalesData.xlsx


*** Keywords ***
Llenar tabla con Excel
    Open Workbook    SalesData.xlsx
    ${sales_reps}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${sales_rep}    IN    @{sales_reps}
        Meter datos de una persona    ${sales_rep}
    END


*** Keywords ***
Pantallazo
    Screenshot  css:div.sales-summary  ${CURDIR}${/}output${/}sumario.png


*** Keywords ***
PDF
    Wait Until Element Is Visible    id:sales-results
    ${sales_results_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_results_html}    ${CURDIR}${/}output${/}sales_results.pdf


*** Keywords ***
Cerrar
    Click button  Log out
    Close Browser


*** Tasks ***
Open/Login Browser
    Abrir
    Login
    Excel
    Llenar tabla con Excel
    Pantallazo
    PDF
    [Teardown]  Cerrar
