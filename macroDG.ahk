global voice := ComObjCreate("SAPI.SpVoice")
global limiteRepeticao := 5
global comandos := {}
comandos.deslizar := "1"
comandos.teleporte := "2"
comandos.atkArea1 := "3"
comandos.atkArea2 := "4"
comandos.atkArea3 := "5"
comandos.bm3Ataca := "8"
comandos.bm3Invoca := "9"
comandos.aura := "0"
comandos.buff := "-"
comandos.hp := "="
comandos.pegarItem := "z"
comandos.target := "Space"

; Ativa a janela do jogo
	IfWinExist, ahk_exe cabalmain.exe
	{  
		WinActivate, ahk_exe cabalmain.exe
		CoordMode, Pixel, Window
		CoordMode, Mouse, Window
		
		; Criando a GUI
		Gui, Add, Text,, Selecione uma opção:
		Gui, Add, Radio, vOption1, Arena do caos
		Gui, Add, Radio, vOption2, Parte do mapa
		Gui, Add, Radio, vOption3, 1ss
		Gui, Add, Radio, vOption4, Selo
		Gui, Add, Radio, vOption5, 2ss
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
				dgSelect := 1
			}
			else if (Option2)
			{
				dgSelect := 2
			}
			else if (Option3)
			{
				dgSelect := 3
			}
			else if (Option4)
			{
				dgSelect := 4
			}
			else if (Option5)
			{
				dgSelect := 5
			}			
		; Fechando a GUI
		Gui, Destroy
		InputBox, repeticao, Repetição, Quantas vezes você quer repetir o calabouço? ,,250,150
		if (ErrorLevel)
		{
			voice.Speak("Nenhum valor foi informado, macro encerrado")
			ExitApp
		}
		if (repeticao > limiteRepeticao)
		{
			voice.Speak("O valor máximo de repetições permitidas é" limiteRepeticao " vezes. Por favor, insira um valor menor.")
			ExitApp
		}
		
		dgSelecionada := dgSelect
		
		Loop, %repeticao%
		{		
			RolaScrollBack()
			Buff()
			
			if(dgSelecionada = 1) ; ARENA DO CAOS
			{
				ClicaEntradaArena() 
				ClicaListaDG(1)
				ProcuraBtnEntrar()			
				ProcuraBtnDesafio()
				RolaScrollBack()
				MoverPortaoArena()
				ComandosArena()
			}
			
			if(dgSelecionada = 2) ; PARTE DO MAPA
			{
				ClicaEntradaParteMapa()
				ClicaListaDG(2)				
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
			}
			
			if(dgSelecionada = 3) ; 1SS
			{
				ClicaEntrada1ss()
				ClicaListaDG(1)				
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
			}
			
			if(dgSelecionada = 4) ; SELO
			{
				ClicaEntradaSelo()
				ClicaListaDG(1)
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
			}
			
			if(dgSelecionada = 5) ; 2SS
			{
				ClicaEntrada2ss()
				ClicaListaDG(2)
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
			}
			 	
			ordinal := NumeroParaOrdinal(A_Index)
			voice.Speak(ordinal . " DG finalizada")
		}
		ExitApp 
	}
	else
	{
		MsgBox, O cabal NÃO está ativo!
	}	
	
	ComandosArena()
	{						
		SelecionarAlvo()
		DanoArea()
		
		Sleep, 360000 ;Espera 6 minutos
		
		SelecionarAlvo()
		DanoArea()
		
		AtivarBM3()
		
		MoverCentroArena()
		Send, 7 ;Usa aura
		ProcuraBoss(prints.imagemSimboloFaello)
		
	}
		
	ProcuraBoss(imgSimboloBoss)
	{	
		AttemptCount := 0
		Loop
		{
			Send, {Space}
			Sleep, 500
			Send, 3 ; Ataca
			PegarBau()
			Send, = ; Pota
			Sleep, 200
			AttemptCount++
			if (AttemptCount > 15)  ; Limite de tentativas
			{
				break
			}
		}
	}
	
	PegarBau()
	{
		x := comandos.pegarItem	
		Loop, 10
		{
			Send, %x%
			Sleep, 300
		}
	}
	
	SelecionarAlvo()
	{
		x := comandos.target
		Send, %x%
		Sleep, 300
	}
	
	Buff()
	{
		x := comandos.buff
		Send, %x%
		Sleep, 1200
	}
	
	DanoArea()
	{
		x := comandos.atkArea1
		y := comandos.atkArea2
		z := comandos.atkArea3
		
		Send, %x%
		Sleep, 2300
		Send, %y%
		Sleep, 2600
		Send, %z%
		Sleep, 2500
		return
	}
	
	AtivaOvers()
	{
		Send, {Alt Down}
		Send, 4    
		Sleep, 1000
		Send, 5 
		Sleep, 500
		Send, {Alt Up}
		return
	}
	
	AtivarBM3()
	{
		Send, {F3} ;Vai para aba 3
		Sleep, 500
		Send, 6
		Sleep, 500
		return
	}
	
	RolaScrollBack()
	{
		ScrollDown(20)
		Sleep, 300
		return
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
		return
	}
	
	ClicaListaDG(valor)
	{
		if(valor == 1)
		{
			x := 621
			y := 275
		}
		else if(valor == 2)
		{
			x := 622
			y := 302
		}
		else if(valor == 3)
		{
			x := 620
			y := 327
		}
		else if(valor == 4)
		{
			x := 620
			y := 355
		}
		else
		{
			voice.Speak("Valor informado na lista de DG inválido, encerrando macro")
			ExitApp
		}
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1000
	}

	ClicaEntradaArena()
	{
		x := 820
		y := 354
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1300
		return
	}
	
	ClicaEntradaParteMapa()
	{
		x := 600
		y := 580
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1300
		return
	}
	
	ClicaEntrada1ss()
	{
		x := 981
		y := 374
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1300
		return
	}
	
	ClicaEntradaSelo()
	{	
		x := 1025
		y := 453
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1300
		return
	}
	
	ClicaEntrada2ss()
	{
		x := 981
		y := 374
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1300
		return
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
		return
	}
	
	MoverCentroArena()
	{
		Mover(290, 210, 2)
		Mover(290, 210, 1)
		Mover(290, 210, 2)
		return
	}
	
	ProcuraBtnDesafio()
	{
		x1 := 777
		y1 := 740
		x2 := 861
		y2 := 784
		color := 0xe8e8e8
		MaxAttempts := 3
		
		; Tenta encontrar a cor no intervalo de tentativas
		if (BuscarPixel(x1, y1, x2, y2, color, MaxAttempts))
		{
			Sleep, 1000
			return  ; Imagem encontrada
		}
		
		; Se não for encontrado após todas as tentativas
		voice.Speak("Botão desafio não foi encontrado, encerrando macro")
		ExitApp
	}
	
	ProcuraBtnEntrar()
	{
		x1 := 1055
		y1 := 876
		x2 := 1155
		y2 := 905
		color := 0xFFFFFF
		
		MaxAttempts := 3
		
		; Tenta encontrar a primeira cor no intervalo de tentativas
		if (BuscarPixel(x1, y1, x2, y2, color, MaxAttempts))
		{
			Sleep, 1000
			return  ; Imagem encontrada
		}
		
		; Se não encontrou a primeira cor, tenta a segunda cor
		color := 0xFF0000
		; A segunda cor não executará nenhuma ação se encontrada
		if (BuscarPixel(x1, y1, x2, y2, color, MaxAttempts, false)) ; mandou false, não vai clicar se achar
		{
			voice.Speak("Você não tem entradas desta DG ou já fez o máximo diário, encerrando macro")
			ExitApp
		}
		; Se nenhuma das cores for encontrada após todas as tentativas
		voice.Speak("Nenhum botão foi encontrado, encerrando macro")
		ExitApp
	}

	BuscarPixel(x1, y1, x2, y2, color, MaxAttempts, performAction := true) ;Se não mandar nada ou mandar true, clica. Se mandar false, não clica
	{
		AttemptCount := 0
		
		Loop
		{
			PixelSearch, posX, posY, x1, y1, x2, y2, color
			if (ErrorLevel = 0)
			{
				if (performAction)
				{
					Sleep, 200
					MouseMove, %posX%, %posY%
					Sleep, 500  ; Aguarda um pouco para garantir que o movimento foi registrado
					Click, %posX%, %posY%
					Sleep, 200
				}
				return true  ; Imagem encontrada
			}
			
			AttemptCount++
			if (AttemptCount >= MaxAttempts)
			{
				return false  ; Não encontrado após o número máximo de tentativas
			}
			
			Sleep, 1000  ; Aguarda antes de tentar novamente
		}
	}
	
	NumeroParaOrdinal(num)
	{
		ordinais := ["primeira", "segunda", "terceira", "quarta", "quinta", "sexta", "sétima", "oitava", "nona", "décima"]
		return ordinais[num]
	}