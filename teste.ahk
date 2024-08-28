global prints := {}
	prints.imagemArena1N := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 114305.png"
	prints.imagemArena1Ok :="C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 114905.png"
	prints.imagemArena2N := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 133130.png"
	prints.imagemArena2Ok := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 145257.png"
	prints.imagemBtnEntrar := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 113105.png"
	prints.imagemBtnDesafio := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 145712.png"

; Ativa a janela do jogo
	IfWinExist, ahk_exe cabalmain.exe
	{  
		WinActivate, ahk_exe cabalmain.exe
		CoordMode, Pixel, Window
		CoordMode, Mouse, Window
		voice := ComObjCreate("SAPI.SpVoice")
			
			Send, {Space} ;Seleciona o alvo
			Sleep, 500
			Send, 3 ; Ataca
			
			Mover(290, 210, 2)
			Mover(290, 210, 1)
			
		ExitApp  
	}
	else
	{
		MsgBox, O cabal NÃO está ativo!
	}
	
	DanoArea()
	{
		Sleep, 500
		Send, {F1} ;Vai para aba 1
		Sleep, 500
		Send, 3
		Sleep, 2200
		Send, 4
		Sleep, 2500
		Send, 5
		Sleep, 2400
	}
	
	BM3()
	{
		Sleep, 500
		Send, {F3} ;Vai para aba 3
		Sleep, 500
		Send, 6
		Sleep, 500
	}
	
	RolaScrollBack()
	{
		Sleep, 500
		ScrollDown(20)
		Sleep, 3000
	}
	
	ScrollDown(count) 
	{
		Loop, %count%
		{
			Send, {WheelDown}
			Sleep, 100  ; Aguarda um pouco entre as rolagens
		}
	}

	Mover(x,y, tecla)
	{
		MouseMove, x, y
		Sleep, 500
		Send, %tecla%
		Sleep, 500
	}

	EntradaArena()
	{
		Sleep, 1000
		MouseMove, 820, 354
		Sleep, 500
		Click, 820, 354
		Sleep, 1000
	}
	
	MoverPortaoArena()
	{
		Mover(1275, 196, 1)
		Mover(977, 280, 2)
		Mover(1410, 362, 1)
		Sleep, 1000
		Send, 2
		Sleep, 500
		Mover(455, 305, 1)
		Mover(482, 281, 2)
		Mover(548, 314, 1)
	}
; Função para procurar a imagem, clicar e lidar com falhas
    ProcuraImagemClica(imagem, x1, y1, x2, y2) 
	{
        AttemptCount := 0
        Loop
        {
            ImageSearch, x, y, x1, y1, x2, y2, %imagem%
            if (ErrorLevel = 0)
            {
                Sleep, 1000
                MouseMove, %x%, %y%
                Sleep, 500  ; Aguarda um pouco para garantir que o movimento foi registrado
                Click, %x%, %y%
                return true  ; Imagem encontrada
            }
            Sleep, 1000
            AttemptCount++
            if (AttemptCount > 10)  ; Limite de tentativas
            {
                return false  ; Imagem não encontrada após tentativas
            }
        }
    }
	
	; Função para procurar a imagem e lidar com falhas
    ProcuraImagem(imagem, x1, y1, x2, y2) 
	{
        AttemptCount := 0
        Loop
        {
            ImageSearch, x, y, x1, y1, x2, y2, %imagem%
            if (ErrorLevel = 0)
            {
                Sleep, 1000
                return true  ; Imagem encontrada
            }
            Sleep, 1000
            AttemptCount++
            if (AttemptCount > 10)  ; Limite de tentativas
            {
                return false  ; Imagem não encontrada após tentativas
            }
        }
    }
	
	NumeroParaOrdinal(num)
	{
		ordinais := ["primeira", "segunda", "terceira", "quarta", "quinta", "sexta", "sétima", "oitava", "nona", "décima"]
		return ordinais[num]
	}