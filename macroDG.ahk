global voice := ComObjCreate("SAPI.SpVoice")
global limiteRepeticao := 5
global comandos := {}
comandos.deslizar := "1"
comandos.recuar := "2"
comandos.atkArea1 := "3"
comandos.atkArea2 := "4"
comandos.atkArea3 := "5"
comandos.bmAtaca := "6"
comandos.bm3Invoca := "7"
comandos.bm2Invoca := "8"
comandos.aura := "9"
comandos.buff := "-"
comandos.hp := "="
comandos.target := "Space"
comandos.pegarItem := "z"

; Defina o diretório base usando o diretório do script
baseDir := A_ScriptDir . "\imagens"

global img := {}
img.iconeBoss := baseDir . "\iconebosspc.png"
img.iconeMob := baseDir . "\iconemob.png"
img.semIconeMob := baseDir . "\semiconemob.png"
img.iconeQuestDG := baseDir . "\iconequestdg.png"

BOSS_ENCONTRADO := 1
BOSS_NAO_ENCONTRADO := 0
BOSS_MORTO := 2

global resultadoBoss

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
			
			if(dgSelecionada = 1) ; ARENA DO CAOS
			{
				ClicaEntradaArena() 
				ClicaListaDG(1)
				ProcuraBtnEntrar()			
				ProcuraBtnDesafio()
				RolaScrollBack()

			}
			
			if(dgSelecionada = 2) ; PARTE DO MAPA
			{
				ClicaEntradaParteMapa()
				ClicaListaDG(2)				
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
				RolaScrollBack()
			}
			
			if(dgSelecionada = 3) ; 1SS
			{
				ClicaEntrada1ss()
				ClicaListaDG(1)				
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
				RolaScrollBack()
			}
			
			if(dgSelecionada = 4) ; SELO
			{
				ClicaEntradaSelo()
				ClicaListaDG(1)
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
				RolaScrollBack()
				Sleep, 300
				DGSelo()				
				
			}
			
			if(dgSelecionada = 5) ; 2SS
			{
				ClicaEntrada2ss()
				ClicaListaDG(2)
				ProcuraBtnEntrar()
				ProcuraBtnDesafio()
				RolaScrollBack()
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
	
	DGSelo()
	{
		MoverDeslizar(415, 318, 1)
		MoverMouseClica(709, 477)
		MoverMouseClica(265, 751)
		ArrastarTela(1060, 314, 552, 330)
		MoverDeslizar(783, 80, 1)
		MoverDeslizar(795, 120, 2)
		MoverDeslizar(556, 220, 1)
		MoverDeslizar(774, 152, 2)
		MoverDeslizar(896, 137, 1)
		MoverDeslizar(1089, 163, 2)
		MoverDeslizar(1310, 285, 1)
		ArrastarTela(1338, 483, 1622, 480)
		MoverDeslizar(1431, 247, 2)
		MoverDeslizar(1519, 298, 1)
		ArrastarTela(1497, 334, 1669, 360)
		MoverDeslizar(1306, 138, 2)
		MoverDeslizar(1313, 129, 1)
		MoverDeslizar(1537, 240, 2)
		MoverDeslizar(1517, 210, 1)
		MoverDeslizar(1325, 142, 2)
		
		VerificaStatusAlvo( img.iconeBoss, 1)	
		MoverDeslizar(1068, 268, 1)
		
		MoverMouseClica(969, 402)
		
		ProcuraObstaculo(img.iconeQuestDG, 20, 733, 59, 768)
		
		MoverMouseClica(263, 749)
		MoverMouseClica(245, 756)
		MoverMouseClica(212, 756)
		MoverMouseClica(171, 753)
		MoverMouseClica(148, 750)
		MoverMouseClica(133, 754)
		MoverMouseClica(147, 753)
		MoverMouseClica(176, 747)
		MoverMouseClica(204, 741)
		MoverMouseClica(177, 742)
		MoverMouseClica(177, 740)
		MoverMouseClica(161, 752)
		MoverDeslizar(610, 188, 1)
		MoverDeslizar(333, 348, 2)
		MoverDeslizar(260, 412, 1)
		MoverDeslizar(266, 558, 2)
		MoverDeslizar(272, 942, 1)
		MoverDeslizar(592, 1087, 2)
		MoverDeslizar(775, 1087, 1)
		MoverDeslizar(951, 934, 1)
		MoverDeslizar(271, 795, 2)
		MoverDeslizar(394, 477, 1)
		MoverDeslizar(896, 197, 2)
		MoverDeslizar(1119, 87, 1)
		MoverDeslizar(1275, 119, 2)
		MoverDeslizar(1269, 132, 1)
		MoverDeslizar(1514, 227, 2)
		MoverDeslizar(1411, 200, 1)
		MoverDeslizar(552, 195, 2)
		MoverDeslizar(569, 161, 1)
		MoverDeslizar(559, 187, 2)
		MoverDeslizar(544, 237, 1)
		MoverDeslizar(491, 631, 2)
		MoverDeslizar(800, 888, 1)
		MoverDeslizar(1352, 1029, 2)
		MoverDeslizar(1360, 1032, 1)
		MoverDeslizar(1007, 1058, 2)
		MoverDeslizar(557, 969, 1)
		MoverDeslizar(382, 471, 2)
		MoverDeslizar(441, 231, 1)
		MoverDeslizar(569, 237, 2)
		MoverDeslizar(749, 168, 1)
		MoverDeslizar(932, 416, 2)
		
		VerificaStatusAlvo( img.semIconeMob, 1)
		VerificaStatusAlvo( img.semIconeMob, 1)
		
		MoverDeslizar(777, 192, 1)
		MoverDeslizar(804, 201, 2)
		
		VerificaStatusAlvo( img.semIconeMob, 1)
		
		MoverMouseClica(888, 271)
		MoverMouseClica(92, 762)
		MoverDeslizar(812, 122, 1)
		
		VerificaStatusAlvo( img.iconeBoss, 1)
		
	}
	
	Atacar(tipoAtaque)
	{
		if(tipoAtaque == 1)
		{
			voice.Speak("Bater com dano em area")
			DanoArea()		
		}
		else if (tipoAtaque == 3)
		{
			voice.Speak("Bater com BM3")
			AtivarBM3()
			BaterBM()
		}
		else if (tipoAtaque == 2)
		{
			voice.Speak("Bater com BM2")
			AtivarBM2()
			BaterBM()
		}
	}
	
	VerificaStatusAlvo(imagemAlvo, tipoAtaque)
	{
		AttemptCount := 0
		loop
		{
			resultado := ProcuraAlvo(imagemAlvo, resultadoBoss)
			
			if (resultado == 1)  ; Encontrou e alvo está vivo
			{
				resultadoBoss := 1
				if(AttemptCount < 1)
				{
					AttemptCount++
					voice.Speak("Alvo encontrado")
				}
				Atacar(tipoAtaque)
			}
			else if (resultado == 0)  ; Ainda não encontrou
			{
				voice.Speak("Procurando alvo")
				SelecionarAlvo()
			}
			else if (resultado == 2)  ; Já encontrou, mas agora não encontrou (matou)
			{
				resultadoBoss := 0  ; Resetando valor da variável global
				voice.Speak("O alvo foi eliminado")
				break
			}
		}
	}

	ProcuraAlvo(imagemAlvo, jaEncontrou)
	{
		ImageSearch, FoundX, FoundY, 761, 40, 793, 74, % imagemAlvo
		if (ErrorLevel = 0)
		{
			return 1
		}
		else if (ErrorLevel = 1)
		{
			if (jaEncontrou == 1)  ; Já encontrou antes, mas agora não
			{
				return 2
			}
			return 0
		}
	}
	
	ProcuraObstaculo(imgObstaculo, x1, y1, x2, y2)
	{
		AttemptCount := 0
		loop
		{
			ImageSearch, FoundX, FoundY, x1, y1, x2, y2, % imgObstaculo
			if (ErrorLevel = 0)
			{
				voice.Speak("Obstaculo encontrado")
				break
			}
			
			AttemptCount++
			if (AttemptCount >= 3)
			{
				voice.Speak("Obstaculo não encontrado") ; Não encontrado após o número máximo de tentativas
				ExitApp  
			}
			
			Sleep, 500  ; Aguarda antes de tentar novamente
		}
	}
	
	PegarBau()
	{
		x := comandos.pegarItem	
		Loop, 10
		{
			Send, { %x% }
			Sleep, 300
		}
	}
	
	SelecionarAlvo()
	{
		x := comandos.target
		Send, { %x% }
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
		Sleep, 3100
		Send, %y%
		Sleep, 2300
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
	
	AtivarBM2()
	{
		x := comandos.bm2Invoca
		Send, %x%
		Sleep, 1000
	}
	
	AtivarBM3()
	{
		x := comandos.bm3Invoca
		Send, %x%
		Sleep, 1000
	}
	
	BaterBM()
	{
		x := comandos.bmAtaca
		Send, %x%
		Sleep, 500
	}
	
	RolaScrollBack()
	{
		ScrollDown(10)
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

	MoverDeslizar(x,y, tecla)
	{
		MouseMove, x, y
		Sleep, 300
		Send, %tecla%
		Sleep, 500
		return
	}
	
	MoverMouseClica(x,y)
	{
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 300
		return
	}
	
	ArrastarTela(x1, y1, x2, y2)
	{
		MouseClickDrag, Right, x1, y1, x2, y2
		Sleep, 300
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
		x := 995
		y := 400
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
		x1 := 1085
		y1 := 870
		x2 := 1105
		y2 := 890
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
					MouseMove, %posX%, %posY%
					Sleep, 300  ; Aguarda um pouco para garantir que o movimento foi registrado
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
			
			Sleep, 500  ; Aguarda antes de tentar novamente
		}
	}
	
	NumeroParaOrdinal(num)
	{
		ordinais := ["primeira", "segunda", "terceira", "quarta", "quinta", "sexta", "sétima", "oitava", "nona", "décima"]
		return ordinais[num]
	}
	