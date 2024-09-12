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
comandos.pegarItem := "Space"
comandos.target := "z"

BOSS_ENCONTRADO := 1
BOSS_NAO_ENCONTRADO := 0
BOSS_MORTO := 2

; Ativa a janela do jogo
	IfWinExist, ahk_exe cabalmain.exe
	{  
		WinActivate, ahk_exe cabalmain.exe
		CoordMode, Pixel, Window
		CoordMode, Mouse, Window
		
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		MoverDeslizar(970, 125, 2)
		MoverDeslizar(970, 125, 1)
		ExitApp 
	}
	else
	{
		MsgBox, O cabal NÃO está ativo!
	}	
		
	MataBoss()
	{
		loop
		{
			resultado := ProcuraImgBoss(resultadoBoss)
			
			if (resultado == BOSS_ENCONTRADO) ; Encontrou e boss está vivo
			{
				AtivarBM3()
				BaterBM3()
				Sleep, 5000
				resultadoBoss := BOSS_ENCONTRADO
			}
			else if (resultado == BOSS_NAO_ENCONTRADO) ; Ainda não encontrou
			{
				SelecionarAlvo()
			}
			else if (resultado == BOSS_MORTO) ; Já encontrou, mas agora não encontrou (matou)
			{
				resultadoBoss := BOSS_NAO_ENCONTRADO
				voice.Speak("O boss foi eliminado")
				break
			}
		}
	}	

	ProcuraImgBoss(jaEncontrou)
	{
		ImageSearch, FoundX, FoundY, 753, 39, 790, 71, C:\Users\leona\Desktop\scripts\imagens\iconeboss.png
		if (ErrorLevel == 0)
		{
			return BOSS_ENCONTRADO
		}
		else if (ErrorLevel == 1)
		{
			if (jaEncontrou == BOSS_ENCONTRADO) ; Já encontrou antes, mas agora não
			{
				return BOSS_MORTO
			}
			return BOSS_NAO_ENCONTRADO
		}
	}
	
	MataMobSemIcone()
	{	
		resultado := ProcuraImgSemIcone(resultadoBoss) ; Variavel global
		if (resultado == 1) ; Encontrou e boss ta vivo
		{
			AtivarBM3()
			BaterBM3()
			Sleep, 5000
			resultadoBoss := 1
			MataMobSemIcone()
		}
		else if (resultado == 0) ; Ainda não encontrou
		{
			SelecionarAlvo()
			MataMobSemIcone()
		}
		else if (resultado == 2) ; Já encontrou, mas agora não encontrou (matou)
		{
			resultadoBoss := 0 ; Resetando valor da variavel global
			voice.Speak("O alvo foi eliminado")
			return
		}
	}
	
	ProcuraImgSemIcone(jaEncontrou)
	{
		ImageSearch, FoundX, FoundY, 753, 39, 790, 71, C:\Users\leona\Desktop\scripts\imagens\semiconemob.png
		if (ErrorLevel = 0)
		{
			return 1
		}
		else if (ErrorLevel = 1)
		{
			if (jaEncontrou == 1) ; Já encontrou antes, mas agora não
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
		x := comandos.bm3Invoca
		Send, %x%
		Sleep, 1200
	}
	
	BaterBM3()
	{
		x := comandos.bm3Ataca
		Send, %x%
		Sleep, 1400
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

	MoverDeslizar(x,y, tecla)
	{
		MouseMove, x, y
		Sleep, 500
		Send, %tecla%
		Sleep, 300
		return
	}
	
	MoverMouseClica(x,y)
	{
		MouseMove, x, y
		Sleep, 500
		Click, x, y
		Sleep, 500
		return
	}
	
	ArrastarTela(x1, y1, x2, y2)
	{
		MouseClickDrag, Right, x1, y1, x2, y2
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
		Sleep, 1000
		return
	}
	
	ClicaEntradaParteMapa()
	{
		x := 600
		y := 580
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1000
		return
	}
	
	ClicaEntrada1ss()
	{
		x := 981
		y := 374
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1000
		return
	}
	
	ClicaEntradaSelo()
	{	
		x := 1025
		y := 453
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1000
		return
	}
	
	ClicaEntrada2ss()
	{
		x := 981
		y := 374
		MouseMove, x, y
		Sleep, 300
		Click, x, y
		Sleep, 1000
		return
	}
	
	ProcuraBtnDesafio()
	{
		x1 := 777
		y1 := 740
		x2 := 861
		y2 := 784
		color := 0xe8e8e8
		MaxAttempts := 10
		
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
		color2 := 0xFF0000
		MaxAttempts := 10
		
		; Tenta encontrar a primeira cor no intervalo de tentativas
		if (BuscarPixel(x1, y1, x2, y2, color, MaxAttempts))
		{
			Sleep, 1000
			return  ; Imagem encontrada
		}
		
		; Se não encontrou a primeira cor, tenta a segunda cor
		; A segunda cor não executará nenhuma ação se encontrada
		if (BuscarPixel(x1, y1, x2, y2, color2, MaxAttempts, false)) ; mandou false, não vai clicar se achar
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