global prints := {}
	prints.imagemArena1N := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 114305.png"
	prints.imagemArena1Ok :="C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 114905.png"
	prints.imagemArena2N := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 133130.png"
	prints.imagemArena2Ok := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 145257.png"
	prints.imagemBtnEntrar := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 113105.png"
	prints.imagemBtnDesafio := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 145712.png"
	prints.imagemBtnDesafioFoco := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 170044.png"
	prints.imagemSimboloFaello := "C:\Users\leona\Pictures\Screenshots\Captura de tela 2024-08-28 173758.png"


; Ativa a janela do jogo
	IfWinExist, ahk_exe cabalmain.exe
	{  
		WinActivate, ahk_exe cabalmain.exe
		CoordMode, Pixel, Window
		CoordMode, Mouse, Window
		voice := ComObjCreate("SAPI.SpVoice")
		
		; Criando a GUI
		Gui, Add, Text,, Selecione uma opção:
		Gui, Add, Radio, vOption1, Arena nvl 1
		Gui, Add, Radio, vOption2, Arena nvl 2
		Gui, Add, Button, gOK, OK

		; Mostrando a GUI
		Gui, Show,, Escolha uma Opção
		Return

		; Função para o botão OK
		
		OK:
			; Verificando qual opção foi selecionada
			Gui, Submit

			if (Option1)
			{
				arenaTempSelect := prints.imagemArena1N
				arenaTempSelectN := prints.imagemArena1Ok
			}
			else if (Option2)
			{
				arenaTempSelect := prints.imagemArena2N
				arenaTempSelectN := prints.imagemArena2Ok
			}	
		; Fechando a GUI
		Gui, Destroy
		InputBox, repeticao, Repetição, Quantas vezes você quer repetir o calabouço?  (Max 10),,200,130
		if ErrorLevel
		{
			voice.Speak("Nenhum valor foi informado, macro encerrado")
			ExitApp
		}
		if (repeticao > 10)
		{
			voice.Speak("O valor máximo permitido é 10. Por favor, insira um valor menor ou igual a 10.")
			ExitApp
		}
		
		Loop, %repeticao%
		{
			chaveSelecionadaOk := arenaTempSelectOK
			chaveSelecionadaN := arenaTempSelectN
			
			EntradaArena() ; Clica na entrada da arena
			
			; PROCURA CHAVE
			if !ProcuraImagem(chaveSelecionadaOk, 601, 254, 665, 420) ; Se ta ativo não clica
			{
				if !ProcuraImagemClica(chaveSelecionadaN, 601, 254, 665, 420) ; Se não ta ativo clica
				{
					voice.Speak("Imagem da ARENA não foi encontrada")
					ExitApp  ; Interrompe o script se a imagem não for encontrada
				}		
			}
			
			; PROCURA BOTÃO ENTRAR
			if !ProcuraImagemClica(prints.imagemBtnEntrar, 1044, 866, 1185, 910)
			{
				voice.Speak("Imagem do botão ENTRAR não foi encontrada")
				ExitApp  
			}
			
			; PROCURA BOTÃO DESAFIO
			if !ProcuraImagemClica(prints.imagemBtnDesafio, 755, 740, 890, 783)
			{
				if !ProcuraImagemClica(prints.imagemBtnDesafioFoco, 755, 740, 890, 783)
				{	
					voice.Speak("Imagem do botão DESAFIO não foi encontrada")
					ExitApp 
				}
			}
			 
			RolaScrollBack()	
			
			MoverPortaoArena()
					
			;Seleciona o alvo
			Send, {Space} 
			Sleep, 500
			Send, 3 ; Ataca
			
			Sleep, 360000 ;Espera 6 minutos
			
			Send, {Space} ;Seleciona o alvo
			Sleep, 500
			Send, 3 ; Ataca
			Sleep, 6000
			
			Mover(290, 210, 2)
			Mover(290, 210, 1)
			Mover(290, 210, 2)
			BM3()
			
			ProcuraBoss(prints.imagemSimboloFaello)
			
			Loop
			{
				Send, {Space}
				; PROCURA O ICONE DO BOSS
				if ProcuraImagem(prints.imagemSimboloFaello, 755, 740, 890, 783)
				{
					Send, 3 ; Ataca
					Sleep, 20000
					break
				}
				Send, 3 ; Ataca
			}
			
			ordinal := NumeroParaOrdinal(A_Index)
			voice.Speak(ordinal . " arena finalizada")
		}
			ExitApp 
	}
	else
	{
		MsgBox, O cabal NÃO está ativo!
	}
	
	ProcuraBoss(imagemSimboloBoss)
	{	
		AttemptCount := 0
		Loop
		{
			Send, {Space}
			; PROCURA O ICONE DO BOSS
			if ProcuraImagem(imagemSimboloBoss, 682, 31, 776, 96)
			{
				Send, 3 ; Ataca
				Sleep, 20000
				break
			}
			Send, 3 ; Ataca
			AttemptCount++
			if (AttemptCount > 30)  ; Limite de tentativas
			{
				break
			}
		}
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
	
	AtivaOvers()
	{
		Send, {Alt Down}
		Send, 4    
		Sleep, 1000
		Send, 5 
		Sleep, 500
		Send, {Alt Up}
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
            Sleep, 500
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