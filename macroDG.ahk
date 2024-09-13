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
comandos.pegarItem := "Space"
comandos.target := "z"

; Defina o diretório base usando o diretório do script
baseDir := A_ScriptDir . "\imagens"

global imagem := {}
imagem.iconeBoss := baseDir . "\iconeboss.png"
imagem.icone := baseDir . "\iconemob.png"
imagem.semIconeMob := baseDir . "\semiconemob.png"

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
		MoverDeslizar(453, 372, 1)
		MoverMouseClica(793, 468)
		MoverMouseClica(211, 737)
		ArrastarTela(1089, 302, 531, 311)
		MoverDeslizar(988, 144, 1)
		MoverDeslizar(834, 149, 2)
		MoverDeslizar(741, 191, 1)
		MoverDeslizar(1053, 167, 2)
		MoverDeslizar(1061, 165, 1)
		MoverDeslizar(1319, 233, 2)
		MoverDeslizar(1457, 384, 1)
		ArrastarTela(1243, 404, 1661, 436)
		MoverDeslizar(1360, 112, 2)
		MoverDeslizar(1495, 154, 1)
		MoverDeslizar(1629, 172, 2)
		MoverDeslizar(1756, 222, 1)
		MoverDeslizar(1811, 429, 2)
		MoverDeslizar(1749, 332, 1)
				
		VerificaStatusAlvo( imagem.iconeBoss, 1)	
		
		MoverDeslizar(1264, 245, 1)
		MoverMouseClica(1094, 432)
		MoverMouseClica(129, 754)
		MoverMouseClica(118, 756)
		MoverMouseClica(154, 752)
		MoverMouseClica(172, 749)
		MoverMouseClica(181, 725)
		MoverMouseClica(202, 730)
		MoverMouseClica(221, 731)
		MoverMouseClica(231, 744)
		MoverMouseClica(206, 746)
		MoverMouseClica(212, 740)
		MoverMouseClica(211, 741)
		MoverMouseClica(208, 714)
		MoverDeslizar(808, 158, 1)
		MoverDeslizar(662, 168, 2)
		MoverDeslizar(664, 168, 1)
		MoverDeslizar(355, 488, 2)
		MoverDeslizar(235, 746, 1)
		MoverDeslizar(198, 867, 2)
		MoverDeslizar(172, 914, 1)
		MoverDeslizar(457, 428, 2)
		MoverDeslizar(743, 210, 1)
		MoverDeslizar(1527, 253, 2)
		MoverDeslizar(1543, 230, 1)
		MoverDeslizar(1555, 232, 2)
		MoverDeslizar(1555, 232, 1)
		MoverDeslizar(1554, 479, 2)
		MoverDeslizar(1430, 332, 1)
		MoverDeslizar(646, 199, 2)
		MoverDeslizar(769, 121, 1)
		MoverDeslizar(767, 155, 2)
		MoverDeslizar(680, 218, 1)
		MoverDeslizar(597, 820, 2)
		MoverDeslizar(966, 913, 1)
		MoverDeslizar(977, 925, 2)
		MoverDeslizar(923, 913, 1)
		MoverDeslizar(795, 916, 2)
		MoverDeslizar(581, 809, 1)
		MoverDeslizar(690, 265, 2)
		MoverDeslizar(711, 193, 1)
		MoverDeslizar(816, 207, 2)
		MoverDeslizar(1025, 231, 1)
		
		VerificaStatusAlvo( imagem.iconeBoss, 3)
		VerificaStatusAlvo( imagem.iconeBoss, 3)
		
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
		loop
		{
			resultado := ProcuraAlvo(imagemAlvo, resultadoBoss)
			if (resultado == 1)  ; Encontrou e alvo está vivo
			{
				resultadoBoss := 1
				voice.Speak("Alvo encontrado")
				Atacar(tipoAtaque)
			}
			else if (resultado == 0)  ; Ainda não encontrou
			{
				voice.Speak("Alvo não encontrado")
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
		ImageSearch, FoundX, FoundY, 764, 48, 796, 78, % imagemAlvo
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
	