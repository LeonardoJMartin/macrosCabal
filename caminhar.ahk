#IfWinActive, ahk_exe CabalMain.exe
WinActivate, ahk_exe cabalmain.exe
SendMode Input
SetMouseDelay, -1
SetTitleMatchMode, 2
toggle := false ; Estado de ativação/desativação
global logFile ; Variável global para o caminho do arquivo de log

; Defina o diretório base usando o diretório do script
baseDir := A_ScriptDir . "\logs\"

; Variáveis para armazenar posições do mouse
global startX, startY

; Tecla F6 para iniciar/parar a gravação
F6::
    toggle := !toggle
    if (toggle) {
        ; Ativa a janela do jogo ao iniciar a gravação
        TrayTip, Gravação, Gravação iniciada, 1 ; Mostra notificação na bandeja do sistema
    } else {
        TrayTip, Gravação, Gravação parada, 1 ; Mostra notificação na bandeja do sistema
        
        ; Pergunta ao usuário se deseja salvar o log
        MsgBox, 4,, Deseja salvar o log?
        IfMsgBox, Yes
        {
            ; Solicita ao usuário o nome do arquivo .txt com uma mensagem mais clara
            InputBox, fileName, Nome do Arquivo, Por favor insira o nome do arquivo de log (sem .txt):
            if (!ErrorLevel) ; Se o usuário não cancelar
            {
                ; Define o caminho completo do arquivo de log
                logFile := baseDir . fileName . ".txt"
                ; Salva o log
                SaveLog()
            }
        }
    }
return

~LButton::
~1::
~2::
    if (toggle) {
        ; Código para registrar o evento
        event := ""
        if (A_ThisHotkey = "~LButton")
            event := "MoverMouseClica"
        else if (A_ThisHotkey = "~1"){
            event := "MoverDeslizar"
            tecla := 1
		}
        else if (A_ThisHotkey = "~2"){
            event := "MoverDeslizar"
            tecla := 2
		}
        if (event != "") {
            LogEvent(event, tecla)
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
        ; Verifica se houve movimento significativo antes de registrar o evento
        if (Abs(endX - startX) > 5 || Abs(endY - startY) > 5) {
            LogEvent("ArrastarTela", startX, startY, endX, endY)
        }
    }
return

; Função que registra o evento
LogEvent(event, param1 := "", param2 := "", param3 := "", param4 := "") {
    global logData
    MouseGetPos, xpos, ypos, , Win

    ; Armazena o log em uma variável no novo formato
    if (event = "ArrastarTela") {
        logData .= event . "(" . param1 . ", " . param2 . ", " . param3 . ", " . param4 . ")" . "`r`n"
    } else if (event = "MoverDeslizar") {
        logData .= event . "(" . xpos . ", " . ypos . ", " . param1 . ")" . "`r`n"
    } else if (event = "MoverMouseClica") {
        logData .= event . "(" . xpos . ", " . ypos . ")" . "`r`n"
    }
}

; Função para salvar o log no arquivo
SaveLog() {
    global logFile, logData
    fileHandle := FileOpen(logFile, "w") ; Abre o arquivo no modo de escrita
    if IsObject(fileHandle) {
        fileHandle.Write(logData)
        fileHandle.Close()
        MsgBox, O log foi salvo com sucesso.
    } else {
        MsgBox, Não foi possível salvar o log.
    }
    logData := "" ; Limpa os dados do log após salvar
}
#IfWinActive