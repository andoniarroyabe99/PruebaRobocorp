*** Settings ***
Library     RPA.Desktop.Windows
Library     String


*** Keywords ***
Write Message
    [Arguments]     ${message}
    ${message}=     Change text  ${message}
    Type Into       class:Edit  ${message}


*** Keywords ***
Change text
    [Arguments]     ${texto}
    ${texto}=       Replace String   ${texto}  ${SPACE}  {espacio}
    ${texto}=       Replace String   ${texto}  \n        {enter}
    [Return]        ${texto}


*** Keywords ***
Font Settings
    [Arguments]     ${style}  ${size}  ${name}
    Menu Select       Formato->Fuente
    Refresh Window
    Mouse Click       name:\'font  style:\' and type:Edit
    Send Keys         ${style}
    Mouse Click       name:Size: and type:Button
    Send Keys         ${size}
    ${font}=          Change Text  ${name} 
    Send Keys         %f${font}
    Mouse Click       name:Aceptar and type:Button
    Wait For Element  class:Edit


*** Tasks ***
Testing Notepad
    Open File       ${CURDIR}${/}prueba.txt  Notepad  wildcard=true
    Font Settings   style=Negrita  size=30  name=Georgia
    Write Message   ^a{espacio}
    Write Message   TITULO\n\n
    Font Settings   style=Normal  size=18  name=Georgia
    Write Message   Texto\n
    Write Message   Test...\n
    sleep  2s
    Menu Select     Archivo->Guardar
    sleep  2s
    Menu Select     Archivo->Salir
    [Teardown]      Close All Applications 
