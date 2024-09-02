SendMode Input
SetMouseDelay, -1
#IfWinActive, ahk_exe CabalMain.exe
SetTitleMatchMode, 2
toggle := false ; Estado de ativação/desativação
logFile := "C:\Users\leona\Desktop\scripts\log.txt" ; Caminho para o arquivo de log

; Variáveis para armazenar posições do mouse
global startX, startY

; Tecla F6 para iniciar/parar a gravação
F6::
    toggle := !toggle
    if (toggle) {
        TrayTip, Gravação, Gravação iniciada, 1 ; Mostra notificação na bandeja do sistema
    } else {
        TrayTip, Gravação, Gravação parada, 1 ; Mostra notificação na bandeja do sistema
    }
return

~LButton::
~1::
~2::
    if (toggle) {
        ; Código para registrar o evento
        event := ""
        if (A_ThisHotkey = "~LButton")
            event := "Botão Esquerdo"
        else if (A_ThisHotkey = "~1")
            event := "Tecla 1"
        else if (A_ThisHotkey = "~2")
            event := "Tecla 2"

        if (event != "") {
            LogEvent(event)
        }
    }
return

~RButton::
    if (toggle) {
        ; Registra a posição inicial ao pressionar o botão direito
        MouseGetPos, startX, startY
    }
return

~RButton Up::
    if (toggle) {
        ; Registra a posição final ao soltar o botão direito
        MouseGetPos, endX, endY
        LogEvent("Botão Direito (Arraste)", startX, startY, endX, endY)
    }
return

; Função que registra o evento
LogEvent(event, x1 := "", y1 := "", x2 := "", y2 := "") {
    global logFile
    MouseGetPos, xpos, ypos, , Win

    ; Abre o arquivo para escrita (cria se não existir)
    fileHandle := FileOpen(logFile, "a") ; Abre o arquivo no modo de anexação
    if !IsObject(fileHandle) {
        MsgBox, Não foi possível abrir o arquivo de log.
        return
    }
    
    ; Registra eventos normais e de arraste
    if (event = "Botão Direito (Arraste)") {
        fileHandle.Write(event . " - Posição Inicial: (" . x1 . ", " . y1 . "), Posição Final: (" . x2 . ", " . y2 . ")" . "`r`n")
    } else {
        fileHandle.Write(event . " - Posição do Mouse (Janela): (" . xpos . ", " . ypos . ")" . "`r`n")
    }
    
    fileHandle.Close()
}
#IfWinActive
