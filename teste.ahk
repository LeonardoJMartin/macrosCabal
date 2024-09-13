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
imagem.iconeMob := baseDir . "\iconemob.png"
imagem.semIconeMob := baseDir . "\iconemobsemicone.png"


; Ativa a janela do jogo
	IfWinExist, ahk_exe cabalmain.exe
	{  
		WinActivate, ahk_exe cabalmain.exe
		CoordMode, Pixel, Window
		CoordMode, Mouse, Window
		MataMobSemIcone(3)
		MataMobSemIcone(3)
		ExitApp 
	}
	else
	{
		MsgBox, O cabal NÃO está ativo!
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
	
	MataBoss(tipoAtaque)
	{	
		loop
		{
			resultado := ProcuraBossIcone(resultadoBoss) ; Variavel global
			if (resultado == 1) ; Encontrou e boss ta vivo
			{
				resultadoBoss := 1
				voice.Speak("Boss encontrado")
				Atacar(tipoAtaque)
			}
			else if (resultado == 0) ; Ainda não encontrou
			{
				voice.Speak("Boss não encontrado")
				SelecionarAlvo()
			}
			else if (resultado == 2) ; Já encontrou, mas agora não encontrou (matou)
			{
				resultadoBoss := 0 ; Resetando valor da variavel global
				voice.Speak("O alvo foi eliminado")
				break
			}
		}
	}
	
	ProcuraBossIcone(jaEncontrou)
	{
		ImageSearch, FoundX, FoundY, 764, 48, 796, 78, % imagem.iconeBoss
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
	
	MataMobSemIcone(tipoAtaque)
	{	
		loop
		{
			resultado := ProcuraMobSemIcone(resultadoBoss) ; Variavel global
			if (resultado == 1) ; Encontrou e boss ta vivo
			{
				resultadoBoss := 1
				voice.Speak("Boss encontrado")
				Atacar(tipoAtaque)
			}
			else if (resultado == 0) ; Ainda não encontrou
			{
				voice.Speak("Boss não encontrado")
				SelecionarAlvo()
			}
			else if (resultado == 2) ; Já encontrou, mas agora não encontrou (matou)
			{
				resultadoBoss := 0 ; Resetando valor da variavel global
				voice.Speak("O alvo foi eliminado")
				break
			}
		}
	}
	
	ProcuraMobSemIcone(jaEncontrou)
	{
		ImageSearch, FoundX, FoundY, 764, 48, 796, 78, % imagem.semIconeMob
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
			Send, { %x% }
			Sleep, 300
		}
	}
	
	SelecionarAlvo()
	{
		x := comandos.target
		SendInput, { %x% }
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
		Sleep, 2400
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
		Sleep, 300
		Send, %tecla%
		Sleep, 300
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
	