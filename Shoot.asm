.model small
.data
	; =========
title1 db 219,219,219,219,219,219,219,187,219,219,187,' ',' ',219,219,187,' ',219,219,219,219,219,219,187,' ',' ',219,219,219,219,219,219,187,' ',219,219,219,219,219,219,219,219,187,'$'
title2 db 219,219,201,205,205,205,205,188,219,219,186,' ',' ',219,219,186,219,219,201,205,205,205,219,219,187,219,219,201,205,205,205,219,219,187,200,205,205,219,219,201,205,205,188,'$'
title3 db 219,219,219,219,219,219,219,187,219,219,219,219,219,219,219,186,219,219,186,' ',' ',' ',219,219,186,219,219,186,' ',' ',' ',219,219,186,' ',' ',' ',219,219,186,' ',' ',' ','$'
title4 db 200,205,205,205,205,219,219,186,219,219,201,205,205,219,219,186,219,219,186,' ',' ',' ',219,219,186,219,219,186,' ',' ',' ',219,219,186,' ',' ',' ',219,219,186,' ',' ',' ','$'
title5 db 219,219,219,219,219,219,219,186,219,219,186,' ',' ',219,219,186,200,219,219,219,219,219,219,201,188,200,219,219,219,219,219,219,201,188,' ',' ',' ',219,219,186,' ',' ',' ','$'
title6 db 200,205,205,205,205,205,205,188,200,205,188,' ',' ',200,205,188,' ',200,205,205,205,205,205,188,' ',' ',200,205,205,205,205,205,188,' ',' ',' ',' ',200,205,188,' ',' ',' ','$'
border1 db "  .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-. ",'$'
border2 db " / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \  ",'$'
border3 db "`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-",'$'
borderA db ".     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     . ",'$'
borderB db " `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'  ",'$'
gameOverMsg1 db "  ___   __   _  _  ____     __   _  _  ____  ____    _  ",'$'
gameOverMsg2 db " / __) / _\ ( \/ )(  __)   /  \ / )( \(  __)(  _ \  / \ ",'$'
gameOverMsg3 db "( (_ \/    \/ \/ \ ) _)   (  O )\ \/ / ) _)  )   /  \_/ ",'$'
gameOverMsg4 db " \___/\_/\_/\_)(_/(____)   \__/  \__/ (____)(__\_)  (_) ",'$'
instructionB db "                                                     ",'$'
instruction1 db "   Shoot sideway-moving boxes to score points        ",'$'
instruction2 db "   Avoid downward-moving boxes or else lose a life   ",'$'
instruction3 db "   Try to beat highscore within 60 seconds           ",'$'
	; =========
	play db "  P L A Y   G A M E  ",'$'
	level db"      L E V E L      ",'$'
	exit db "       Q U I T       ",'$'
	namePrompt db "Please enter your name",'$'
	menuChoice db 1,0,0
	mc db 0
	; =========
	levelOne db "    L E V E L   1    ",'$'
	levelTwo db "    L E V E L   2    ",'$'
	levelThree db "    L E V E L   3    ",'$'
	levelChoice db 1,0,0
	lc db 0
	; =========
	enemy1 db 219,219,219,219,219,'$'
	enemy2 db 176,176,176,176,176,'$'
	enemyBlank db ' ',' ',' ',' ',' ','$'
	enemyColor db 01h,02h,03h,04h,05h,		; left to right
				  06h,07h,08h,09h,0ah,		; right to left
				  0bh,0ch,0dh,0eh,0fh		; up to down
	enemyRow db  1, 5, 9,13,17,
				 3, 7,11,15,18,
				 0, 0, 0, 0, 0
	enemyCol db 20,15,10, 5, 0,
				80,75,70,65,60,
				 0,15,30,45,60
	enemyDelay dw 13
	enemyBulletDone db 80 dup(1)
	enemyBulletRow db 80 dup(0)
	enemyBulletCol db 80 dup(81)
	; =========
	shipPart1 db ' ', ' ', 220, ' ', ' ','$'
	shipPart2 db 219, 220, 219, 220, 219,'$'
	shipPart3 db 223, 223, 223, 223, 223,'$'
	blank db ' ', ' ', ' ', ' ', ' ','$'
	shipRow db 20
	shipCol db 0
	bulletDone db 80 dup(1)
	bulletRow db 80 dup(0)
	bulletCol db 80 dup(81)
	nozzleIndex dw 2
	startTime dw ?
	timeCheck dw ?
	startTime2 dw ?
	timeCheck2 dw ?
	; =========
	inputRow db 13
	inputCol db 29
	blank2 db "                     ",'$'
	highscoreName db 21 dup(?)
	hsnCTR db 0
	highscore db 5 dup(?)
	playerName db 21 dup(?)
	pnCTR dw 0
	playerNameSTR db "Name:",'$'
	scoreSTR db "Score:       ",'$'
	livesSTR db "Lives:   ",'$'
	timeLeftSTR db "Time Left:   ",'$'
	score dw 0
	lives dw 3
	timeLeft dw 60
	startCountdown dw ?
	seed dw ?
	temp db ?
	randomNumber db 7
	seedRandomizer db 7
	; =========
.stack 100h
.code
    main proc

		mov ax, @data
		mov ds, ax
		
		call clear_screen
		xor dx, dx						; clear ax, cx, dx registers
		xor cx, cx
		xor ax, ax
		
		mov ah, 00h
		int 1ah
		mov startTime, dx
		mov ah, 00h
		int 1ah
		mov startTime2, dx
		
		call title_display
		call menu_highlight
		call hide_cursor
; *************************************************************************************
		titleMenu:
			call clear_screen
			call hide_cursor
			call title_display
			call menu_highlight
			
			mov ah, 01h
			int 21h
			
			cmp al, 'w'						; if 'w' or up arrow is pressed, go up
			je up
			cmp al, 72
			je up
			
			cmp al, 's'						; if 's' or down arrow is pressed, go down
			je down
			cmp al, 80
			je down
			
		cmp al, 0dh
		je check
		cmp al, ' '
		je check
			jmp titleMenu
		
		up:
			call clear_screen
			call go_up
		jmp titleMenu
		
		down:
			call clear_screen
			call go_down
		jmp titleMenu
		
		check:
			cmp menuChoice[0], 1
				je getPlayerName
			cmp menuChoice[1], 1
				je selectLevel
			cmp menuChoice[2], 1
				je done
; *************************************************************************************
		selectLevel:
			call clear_screen
			call hide_cursor
			call title_display
			call level_highlight
			
			mov ah, 01h
			int 21h
			
			cmp al, 'w'						; if 'w' or up arrow is pressed, go up
			je upup
			cmp al, 72
			je upup
			
			cmp al, 's'						; if 's' or down arrow is pressed, go down
			je downdown
			cmp al, 80
			je downdown
			
			cmp al, 0dh
			je confirmLevel
			cmp al, ' '
			je confirmLevel
				
				jmp selectLevel
			
		upup:
			call clear_screen
			call up_level
		jmp selectLevel
			
		downdown:
			call clear_screen
			call down_level
		jmp selectLevel
			
		confirmLevel:
			cmp levelChoice[0], 1
			je level1
			cmp levelChoice[1], 1
			je level2
			cmp levelChoice[2], 1
			je level3
			
			level1:
				mov enemyDelay, 13
			jmp titleMenu
			level2:
				mov enemyDelay, 8
			jmp titleMenu
			level3:
				mov enemyDelay, 5
			jmp titleMenu
		
		jmp titleMenu
; *************************************************************************************
		getPlayerName:
			call clear_screen
			call title_display
			call instructions_display
			call player_name
			call clear_screen
			
		mov ah, 00h
		int 1ah
		mov startCountdown, dx
		
		call player_display
		call print_timeleft
; *************************************************************************************
		start:
			call printShip
			;call player_display
			;call print_timeleft
			call print_countdown
			
			qwerty:
			call shooting
			call enemy_print
			mov ah, 01h 						; checks if a key is pressed
			int 16h
			jz continue 						; zero = no pressed

			mov ah, 00h 						; get the keystroke
			int 16h								; ascii code goes to al
												; scan code goes to ah
			
			xor bh, bh
			
			cmp al, 'a'							; if 'a' or left arrow is pressed, go left
			je left
			cmp ah, 4bh
			je left
			
			cmp al, 'd'							; if 'd' or right arrow is pressed, go right
			je right
			cmp ah, 4dh
			je right
			
			cmp al, ' '
			je shoot
			
		cmp al, 1bh							; if escape key is pressed, exit
		je gmeovr
		jmp start
		
		continue:
			;call player_display
			;call print_timeleft
			cmp timeLeft, 0
			jl gmeovr
			
			call print_countdown
			
			mov ah, 00h
			int 1ah
			sub dx, startCountdown
			cmp dx, 18
			jl abcd
				dec timeLeft
				
				mov ah, 00h
				int 1ah
				mov startCountdown, dx
			
			abcd:
			mov ah, 00h
			int 1ah
			sub dx, startTime
			mov timeCheck, dx
			cmp timeCheck, 1
			jl asdf
				mov si, 2
				loopy1:
					cmp bulletRow[si], 0
					jl skip1
						dec bulletRow[si]
						mov bulletDone[si], 0
						jmp skip2
					skip1:
						mov bulletDone[si], 1
					skip2:
					inc si
				cmp si, 77
				jle loopy1
				mov ah, 00h
				int 1ah
				mov startTime, dx
				
			asdf:
			
				mov si, 2
				
				loop2:
						xor bh, bh
						mov bh, bulletRow[si]
						xor bl, bl
						mov bl, bulletCol[si]
					cmp bh, enemyRow[0]
						je blue
					cmp bh, enemyRow[1]
						je green
					cmp bh, enemyRow[2]
						je cyan
					cmp bh, enemyRow[3]
						je red
					cmp bh, enemyRow[4]
						je magenta
					cmp bh, enemyRow[5]
						je brown
					cmp bh, enemyRow[6]
						je lightgray
					cmp bh, enemyRow[7]
						je darkgray
					cmp bh, enemyRow[8]
						je lightblue
					cmp bh, enemyRow[9]
						je lightgreen
					cmp bh, enemyRow[10]
						je lightcyan
					cmp bh, enemyRow[11]
						je lightred
					cmp bh, enemyRow[12]
						je lightmagenta
					cmp bh, enemyRow[13]
						je yellow
					cmp bh, enemyRow[14]
						je white
					
					jmp noHit
					
					blue:
						cmp bl, enemyCol[0]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[0]
								add cl, 2
						cmp bl, cl
							jg noHit
							
							mov al, 1 
							mov bl, 00h
							mov cx, 3
							mov dh, enemyRow[0]
							mov dl, enemyCol[0]
							dec dl
							mov bh, 0
							push ds
							pop es
							lea bp, offset enemyBlank
							mov ah, 13h 
							int 10h 
							
							mov enemyCol[0], 0
							
					jmp increaseScore
					
					green:
						cmp bl, enemyCol[1]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[1]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					cyan:
						cmp bl, enemyCol[2]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[2]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					red:
						cmp bl, enemyCol[3]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[3]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					magenta:
						cmp bl, enemyCol[4]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[4]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					brown:
						cmp bl, enemyCol[5]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[5]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightgray:
						cmp bl, enemyCol[6]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[6]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					darkgray:
						cmp bl, enemyCol[7]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[7]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightblue:
						cmp bl, enemyCol[8]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[8]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightgreen:
						cmp bl, enemyCol[9]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[9]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightcyan:
						cmp bl, enemyCol[10]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[10]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightred:
						cmp bl, enemyCol[11]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[11]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					lightmagenta:
						cmp bl, enemyCol[12]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[12]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					yellow:
						cmp bl, enemyCol[13]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[13]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					white:
						cmp bl, enemyCol[14]
							jl noHit
								xor cl, cl
								mov cl, enemyCol[14]
								add cl, 2
						cmp bl, cl
							jg noHit
						
					jmp increaseScore
					
					increaseScore:
						inc score
						mov bulletRow[si], 0
						dec bulletRow[si]
						mov bulletDone[si], 1
					noHit:
						
					inc si
				cmp si, 77
				jle loop2
			
			
			xyz:
			
			; mov ah, 00h
			; int 1ah
			; sub dx, startTime2
			; cmp dx, enemyDelay
			; jl qwerty
			; ; === left to right
				; mov si, 0
				; loopA:
					; cmp enemyCol[si], 79
					; jle cont1
						; mov enemyCol[si], 0
					; cont1:
						; inc enemyCol[si]
						; inc si
				; cmp si, 4
				; jle loopA
			; ; === right to left
				; mov si, 5
				; loopB:
					; cmp enemyCol[si], 0
					; jge cont2
						; mov enemyCol[si], 79
					; cont2:
						; dec enemyCol[si]
						; inc si
				; cmp si, 9
				; jle loopB
			; ; === up to down
				; mov si, 10
				; loopC:
					; cmp enemyRow[si], 24
					; jle cont3
						; mov enemyRow[si], 0
					; cont3:
						; inc enemyRow[si]
						; inc si
				; cmp si, 14
				; jle loopC
			; ; ===
			; mov ah, 00h
			; int 1ah
			; mov startTime2, dx
			; call printShip
			
		jmp qwerty
		
		left:
			call go_left
		jmp start
		
		right:
			call go_right
		jmp start
		
		shoot:
			xor bx, bx
			mov bx, nozzleIndex
			cmp bulletDone[bx], 0
			je start
				mov bulletCol[bx], bl
				mov bulletRow[bx], 18
				
				call shoot_sound

		jmp start
; *************************************************************************************
gmeovr:
	call game_over
	call delay
done:
	call clear_screen
    call quit

    main endp
	
; ################################################################################################################################################
	delay proc
		mov ah, 00
		int 1Ah
		mov seed, dx

		jmp_delay:
			
			mov ah, 00h
			int 1Ah
			sub dx, seed
			
		cmp dx, 54
		jl jmp_delay
		
			call clear_screen
			
			call hide_cursor
		ret
	delay endp
; ################################################################################################################################################
	printShip proc
		mov bh, shipRow
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		dec dl
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 1
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		dec dl
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 2
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		dec dl
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		; -----------------
		mov bh, shipRow
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		add dl, 5
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 1
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		add dl, 5
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 2
		mov al, 1 
		mov bl, 00h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		add dl, 5
		mov bh, 0
		push ds
		pop es
		lea bp, offset blank
		mov ah, 13h 
		int 10h 
		; ===============================================
		mov bh, shipRow
		mov al, 1 
		mov bl, 09h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		mov bh, 0
		push ds
		pop es
		lea bp, offset shipPart1
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 1
		mov al, 1 
		mov bl, 09h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		mov bh, 0
		push ds
		pop es
		lea bp, offset shipPart2
		mov ah, 13h 
		int 10h 
		
		
		mov bh, shipRow
		add bh, 2
		mov al, 1 
		mov bl, 09h
		mov cx, 5
		mov dh, bh
		mov dl, shipCol
		mov bh, 0
		push ds
		pop es
		lea bp, offset shipPart3
		mov ah, 13h 
		int 10h 
		
		call hide_cursor
		
		ret
	printShip endp
; ################################################################################################################################################
	shooting proc
		mov si, 1
		loopy:
			cmp si, 1
			jne qaz
			mov dh, bulletRow[si]						; dh = row
			inc dh
			mov dl, bulletCol[si]						; dl = col
			mov ah, 02h
			int 10h
			
			xor bh, bh
			mov bl, 00h							; color = black
			mov al, ' '	
			mov ah, 09h							; print character 
			mov cx, 01h							; print 1 character 
			int 10h		
			qaz:
			mov dh, bulletRow[si]						; dh = row
			inc dh
			mov dl, bulletCol[si]						; dl = col
			mov ah, 02h
			int 10h
			
			xor bh, bh
			mov bl, 00h							; color = black
			mov al, ' '	
			mov ah, 09h							; print character 
			mov cx, 01h							; print 1 character 
			int 10h		
			
			mov dh, bulletRow[si]						; dh = row
			mov dl, bulletCol[si]						; dl = col
			mov ah, 02h
			int 10h
			
			xor bh, bh
			mov bl, 0ch							; color = light blue
			mov al, 254	
			mov ah, 09h							; print character 
			mov cx, 01h							; print 1 character 
			int 10h		
			
			zaq:
			call hide_cursor
			inc si
		cmp si, 77
		jle loopy
		ret
	shooting endp
; ################################################################################################################################################
	enemy_print proc

		mov ah, 00h
		int 1ah
		sub dx, startTime2
		cmp dx, enemyDelay
		jl qwerty
		; === left to right
			mov si, 0
			mov bl, 1
			loop1:
				cmp enemyCol[si], 77
				jl cont1
					mov enemyCol[si], 0
					
					call randomize_row
					xor bh, bh
					mov bh, randomNumber
					mov enemyRow[si], bh
					
					call clear_screen
				cont1:
					add enemyCol[si], bl
					;inc bl
					inc si
			cmp si, 4
			jle loop1
		; === right to left
			mov si, 5
			mov bl, 1
			loop2:
				cmp enemyCol[si], 0
				jg cont2
					mov enemyCol[si], 79
					
					call randomize_row
					xor bh, bh
					mov bh, randomNumber
					mov enemyRow[si], bh
					
					call clear_screen
				cont2:
					sub enemyCol[si], bl
					;inc bl
					inc si
			cmp si, 9
			jle loop2
		; === up to down
			mov si, 10
			mov bl, 2
			loop3:
			cmp enemyRow[si], 20
				jl cont3
					mov enemyRow[si], 0
					call clear_screen
				cont3:
					add enemyRow[si], bl
					;inc bl
					inc si
			cmp si, 14
			jle loop3
		; ===
		mov ah, 00h
		int 1ah
		mov startTime2, dx
		call printShip
	; --------------------------------
	
					call clear_screen
					call printShip
		call player_display
		call print_timeleft
		
		mov si, 0
		loopA:
			mov al, 1
			mov bl, 00h				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			mov dl, enemyCol[si]				; column
			dec dl
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemyBlank			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			mov al, 1
			mov bl, enemyColor[si]				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			mov dl, enemyCol[si]				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemy1			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			inc si
		cmp si, 4
		jle loopA
		
		mov si, 5
		loopB:
			mov al, 1
			mov bl, 00h				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			mov dl, enemyCol[si]				; column
			inc dl
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemyBlank			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			mov al, 1
			mov bl, enemyColor[si]				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			mov dl, enemyCol[si]				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemy1			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			inc si
		cmp si, 9
		jle loopB
		
		mov si, 10
		loopC:
			mov al, 1
			mov bl, 00h				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			dec dh
			mov dl, enemyCol[si]				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemyBlank			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			mov al, 1
			mov bl, enemyColor[si]				; color
			mov cx, 3						; number of characters
			mov dh, enemyRow[si]				; row
			mov dl, enemyCol[si]				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset enemy1			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ===
			inc si
		cmp si, 14
		jle loopC
		
		qwerty:
		
		ret
	enemy_print endp
; ################################################################################################################################################
	
; ################################################################################################################################################
	
; ################################################################################################################################################
	
; ################################################################################################################################################
	
; ################################################################################################################################################
	randomize_row proc
		mov ah, 00h
		int 1ah
		mov al, dl
		xor ah, ah
		mov bl, 17
		div bl
		mov randomNumber, ah
		xor bh, bh
		mov bh, seedRandomizer
		add randomNumber, bh
		add seedRandomizer, 7
		
		cmp randomNumber, 17
		jle zaq
			sub randomNumber, 17
		zaq:
		cmp seedRandomizer, 17
		jle mlp
			sub seedRandomizer, 17
		mlp:
		
		ret
	randomize_row endp
; ################################################################################################################################################
	shoot_sound proc
		mov dx, 2000         ; Number of times to repeat whole routine.

		mov bx, 1            ; Frequency value.

		mov al, 10110110b   ; The Magic Number (use this binary number only)
		out 43h, al         ; Send it to the initializing port 43H Timer 2.

		next_frequency:     ; This is were we will jump back to 2000 times.

		mov ax, bx          ; Move our Frequency value into AX.

		out 42h, al         ; Send LSB to port 42H.
		mov al, ah          ; Move MSB into AL  
		out 42h, al         ; Send MSB to port 42H.

		in al, 61h          ; Get current value of port 61H.
		or al, 00000011b    ; OR AL to this value, forcing first two bits high.
		out 61h, al         ; Copy it to port 61H of the PPI Chip
							; to turn ON the speaker.

		mov cx, 200         ; Repeat loop 100 times
		delay_loop:              ; Here is where we loop back too.
		loop delay_loop     ; Jump repeatedly to DELAY_LOOP until CX = 0


		inc bx              ; Incrementing the value of BX lowers 
							; the frequency each time we repeat the
							; whole routine

		dec dx              ; Decrement repeat routine count

		cmp dx, 0           ; Is DX (repeat count) = to 0
		jnz next_frequency  ; If not jump to NEXT_FREQUENCY
							; and do whole routine again.

									; Else DX = 0 time to turn speaker OFF

		in al, 61h          ; Get current value of port 61H.
		and al, 11111100b   ; AND AL to this value, forcing first two bits low.
		out 61h, al         ; Copy it to port 61H of the PPI Chip
										; to turn OFF the speaker.
		ret
	shoot_sound endp
; ################################################################################################################################################
	print_timeleft proc
		ret
	print_timeleft endp
; ################################################################################################################################################
	print_countdown proc
		mov dh, 24
		mov dl, 35
		mov ah, 02h
		int 10h
		mov ax, lives
		call printAX
		
		mov dh, 24
		mov dl, 53
		mov ah, 02h
		int 10h
		mov ax, score
		call printAX
		
		mov dh, 24
		mov dl, 77
		mov ah, 02h
		int 10h
		mov ax, timeLeft
		call printAX
		ret
	print_countdown endp
; ################################################################################################################################################
	player_display proc
		mov al, 1
		mov bl, 00001111b				; color
		mov cx, pnCTR						; number of characters
		mov dh, 24				; row
		mov dl, 0				; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset playerName			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
		
		mov al, 1
		mov bl, 00001111b				; color
		mov cx, 9						; number of characters
		mov dh, 24				; row
		mov dl, 28				; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset livesSTR			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
		
		mov al, 1
		mov bl, 00001111b				; color
		mov cx, 13						; number of characters
		mov dh, 24				; row
		mov dl, 46				; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset scoreSTR			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
		
		mov al, 1
		mov bl, 00001111b				; color
		mov cx, 13						; number of characters
		mov dh, 24				; row
		mov dl, 66				; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset timeLeftSTR			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
		
		ret
	player_display endp
; ################################################################################################################################################
	player_name proc
		mov al, 1
		mov bl, 00001111b				; color
		mov cx, 21						; number of characters
		mov dh, inputRow				; row
		mov dl, inputCol				; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset blank2			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
			
		mov dh, inputRow					; row
		mov dl, inputCol					; column
		mov ah, 02h
		int 10h
		
		mov si, 0
		
		getName:
			mov ah, 01h
			int 21h
			
			;cmp si, 21
			;je max
			
			cmp al, ' '
			jge characterInput
			
			cmp al, 08h
			je backspace
			
			max:
			cmp al, 0dh
			je enterName
			
			jmp getName
			
			characterInput:
				inc inputCol
				 cmp si, 21
				 jge qwerty
				input:
				mov playerName[si], al
				inc si
				inc pnCTR
				jmp getName
				
				qwerty:
					dec inputCol
					mov dh, inputRow					; row
					mov dl, inputCol					; column
					mov ah, 02h
					int 10h
					xor bh, bh
					mov bl, 0fh							; color
					mov al, ' '				; character
					mov ah, 09h							; print character 
					mov cx, 01h							; print 1 character 
					int 10h								; BIOS interrupt 10h
			jmp getName
			
			backspace:
				cmp si, 0
				jle asdf
					dec inputCol
					dec si
				asdf:
				mov playerName[si], ' '
				mov dh, inputRow					; row
				mov dl, inputCol					; column
				mov ah, 02h
				int 10h
				xor bh, bh
				mov bl, 0fh							; color
				mov al, playerName[si]				; character
				mov ah, 09h							; print character 
				mov cx, 01h							; print 1 character 
				int 10h								; BIOS interrupt 10h
			jmp getName
		
		enterName:
			
			
		ret
	player_name endp
; ################################################################################################################################################
	title_display proc
		;mov bh, shipRow
		mov al, 1
		mov bl, 0ch						; color
		mov cx, 43						; number of characters
		mov dh, 5						; row
		mov dl, 18						; column
		mov bh, 0						; page
		push ds
		pop es
		lea bp, offset title1			; string
		mov ah, 13h 					; function 13
		int 10h 						; BIOS interrupt 10h
		;mov bh, shipRow
		mov al, 1 
		mov bl, 0eh
		mov cx, 43
		mov dh, 6
		mov dl, 18
		mov bh, 0
		push ds
		pop es
		lea bp, offset title2
		mov ah, 13h 
		int 10h 
		;mov bh, shipRow
		mov al, 1 
		mov bl, 0ah
		mov cx, 43
		mov dh, 7
		mov dl, 18
		mov bh, 0
		push ds
		pop es
		lea bp, offset title3
		mov ah, 13h 
		int 10h 
		;mov bh, shipRow
		mov al, 1 
		mov bl, 0bh
		mov cx, 43
		mov dh, 8
		mov dl, 18
		mov bh, 0
		push ds
		pop es
		lea bp, offset title4
		mov ah, 13h 
		int 10h 
		;mov bh, shipRow
		mov al, 1 
		mov bl, 09h
		mov cx, 43
		mov dh, 9
		mov dl, 18
		mov bh, 0
		push ds
		pop es
		lea bp, offset title5
		mov ah, 13h 
		int 10h 
		;mov bh, shipRow
		mov al, 1 
		mov bl, 0dh
		mov cx, 43
		mov dh, 10
		mov dl, 18
		mov bh, 0
		push ds
		pop es
		lea bp, offset title6
		mov ah, 13h 
		int 10h 
		; -----------------------
			mov al, 1
			mov bl, 00001001b				; color
			mov cx, 80						; number of characters
			mov dh, 2						; row
			mov dl, 0						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset borderA			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001001b				; color
			mov cx, 80						; number of characters
			mov dh, 3						; row
			mov dl, 0						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset borderB			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			; ------
			mov al, 1
			mov bl, 00001001b				; color
			mov cx, 80						; number of characters
			mov dh, 21						; row
			mov dl, 0						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset borderA			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001001b				; color
			mov cx, 80						; number of characters
			mov dh, 22						; row
			mov dl, 0						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset borderB			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov si, 1
			mov temp, 3
			brdr1:
				mov dh, 2
				mov dl, temp
				xor bh, bh
				mov ah, 02h
				int 10h

				xor bh, bh
				mov bl, 10001011b							; color = gray (default)
				mov al, 254
				mov ah, 09h							; print character 
				mov cx, 01h							; print 1 character 
				int 10h
				
				add temp, 8
				
				inc si
			cmp si, 11
			jl brdr1
			
			mov si, 1
			mov temp, 7
			brdr2:
				mov dh, 3
				mov dl, temp
				xor bh, bh
				mov ah, 02h
				int 10h

				xor bh, bh
				mov bl, 10001011b							; color = gray (default)
				mov al, 254
				mov ah, 09h							; print character 
				mov cx, 01h							; print 1 character 
				int 10h
				
				add temp, 8
				
				inc si
			cmp si, 10
			jl brdr2
			
			; ------
			
			mov si, 1
			mov temp, 3
			brdr3:
				mov dh, 21
				mov dl, temp
				xor bh, bh
				mov ah, 02h
				int 10h

				xor bh, bh
				mov bl, 10001011b							; color = gray (default)
				mov al, 254
				mov ah, 09h							; print character 
				mov cx, 01h							; print 1 character 
				int 10h
				
				add temp, 8
				
				inc si
			cmp si, 11
			jl brdr3
			
			mov si, 1
			mov temp, 7
			brdr4:
				mov dh, 22
				mov dl, temp
				xor bh, bh
				mov ah, 02h
				int 10h

				xor bh, bh
				mov bl, 10001011b							; color = gray (default)
				mov al, 254
				mov ah, 09h							; print character 
				mov cx, 01h							; print 1 character 
				int 10h
				
				add temp, 8
				
				inc si
			cmp si, 10
			jl brdr4
			
			; mov al, 1
			; mov bl, 00001001b				; color
			; mov cx, 80						; number of characters
			; mov dh, 23						; row
			; mov dl, 0						; column
			; mov bh, 0						; page
			; push ds
			; pop es
			; lea bp, offset border3			; string
			; mov ah, 13h 					; function 13
			; int 10h 						; BIOS interrupt 10h
		ret
	title_display endp
; ################################################################################################################################################
	instructions_display proc
			
			mov al, 1
			mov bl, 00111111b				; color
			mov cx, 53						; number of characters
			mov dh, 16				; row
			mov dl, 12				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset instruction1			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00111111b				; color
			mov cx, 53						; number of characters
			mov dh, 17				; row
			mov dl, 12				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset instruction2			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00111111b				; color
			mov cx, 53						; number of characters
			mov dh, 18				; row
			mov dl, 12				; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset instruction3			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
		ret
	instructions_display endp
; ################################################################################################################################################
	track_score proc
		mov dh, 2
		mov dl, 68
		xor bh, bh
		mov ah, 02h
		int 10h

		xor bh, bh
			mov bl, 07h							; color = gray (default)
			mov al, 254
			mov ah, 09h							; print character 
			mov cx, 01h							; print 1 character 
			int 10h
		
		mov ax, score
		call printAX
		ret
	track_score endp
; ################################################################################################################################################
	printAX proc
		; this basically prints the contents (numbers) of ax into the console
		xor cx, cx
		xor dx, dx
		xor bx, bx
		mov bx, 10
		loop1:  
			mov dx, 0000h    					; clears dx during jump
			div bx      						; divides ax by bx
			push dx     						; pushes dx(remainder) to stack
			inc cx      						; increments counter to track the number of digits
			cmp ax, 0     						; checks if there is still something in ax to divide
		jne loop1     							; jumps if ax is not zero
		
		loop2:  
			pop dx      						; pops from stack to dx
			add dx, 30h     					; converts to it's ascii equivalent
			mov ah, 02h     
			int 21h
		loop loop2    							; loops till cx equals zero
		xor ax, ax
		xor bx, bx
		ret
	printAX endp
; ################################################################################################################################################
	hide_cursor proc
		mov cx, 3200h					; cursor is invisible
		mov ah, 01h
		int 10h
		ret
	hide_cursor endp
; ################################################################################################################################################
	clear_screen proc
		mov al, 03h						; clear screen
		mov ah, 00h
		int 10h
		ret
	clear_screen endp
; ################################################################################################################################################
	level_highlight proc
		cmp levelChoice[0], 1
			je level1Highlight
		cmp levelChoice[1], 1
			je level2Highlight
		cmp levelChoice[2], 1
			je level3Highlight
		
		level1Highlight:
			mov al, 1
			mov bl, 00101111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelOne			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelTwo			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 16						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelThree			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		level2Highlight:
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelOne			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00101111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelTwo			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 16						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelThree			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		level3Highlight:
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelOne			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelTwo			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00101111b				; color
			mov cx, 21						; number of characters
			mov dh, 16					; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset levelThree			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		next:
		ret
	level_highlight endp
; ################################################################################################################################################
	up_level proc
		dec lc
		
		cmp lc, 0
		je level1Highlight
		cmp lc, 1
		je level2Highlight
		cmp lc, 2
		je level3Highlight
		cmp lc, 0
		jl level3Highlight
		
		level1Highlight:
			mov levelChoice[0], 1
			mov levelChoice[1], 0
			mov levelChoice[2], 0
		jmp next
		
		level2Highlight:
			mov levelChoice[0], 0
			mov levelChoice[1], 1
			mov levelChoice[2], 0
		jmp next
		
		level3Highlight:
			mov levelChoice[0], 0
			mov levelChoice[1], 0
			mov levelChoice[2], 1
			mov lc, 2
		jmp next
		
		next:
			call level_highlight
		ret
	up_level endp
; ################################################################################################################################################
	down_level proc
		inc lc
		
		cmp lc, 0
		je level1Highlight
		cmp lc, 2
		jg level1Highlight
		cmp lc, 1
		je level2Highlight
		cmp lc, 2
		je level3Highlight
		
		level1Highlight:
			mov levelChoice[0], 1
			mov levelChoice[1], 0
			mov levelChoice[2], 0
			mov lc, 0
		jmp next
		
		level2Highlight:
			mov levelChoice[0], 0
			mov levelChoice[1], 1
			mov levelChoice[2], 0
		jmp next
		
		level3Highlight:
			mov levelChoice[0], 0
			mov levelChoice[1], 0
			mov levelChoice[2], 1
		jmp next
		
		next:
			call level_highlight
		ret
	down_level endp
; ################################################################################################################################################
	menu_highlight proc
		cmp menuChoice[0], 1
			je playHighlight
		cmp menuChoice[1], 1
			je levelHighlight
		cmp menuChoice[2], 1
			je exitHighlight
		
		playHighlight:
			mov al, 1
			mov bl, 01001111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset play			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset level			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 16						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset exit			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		levelHighlight:
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset play			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00101111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset level			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 16						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset exit			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		exitHighlight:
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 12						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset play			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 00001111b				; color
			mov cx, 21						; number of characters
			mov dh, 14						; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset level			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
			
			mov al, 1
			mov bl, 01011111b				; color
			mov cx, 21						; number of characters
			mov dh, 16					; row
			mov dl, 29						; column
			mov bh, 0						; page
			push ds
			pop es
			lea bp, offset exit			; string
			mov ah, 13h 					; function 13
			int 10h 						; BIOS interrupt 10h
		jmp next
		
		next:
		ret
	menu_highlight endp
; ################################################################################################################################################
	go_up proc
		dec mc
		
		cmp mc, 0
		je playHighlight
		cmp mc, 1
		je levelHighlight
		cmp mc, 2
		je exitHighlight
		cmp mc, 0
		jl exitHighlight
		
		playHighlight:
			mov menuChoice[0], 1
			mov menuChoice[1], 0
			mov menuChoice[2], 0
		jmp next
		
		levelHighlight:
			mov menuChoice[0], 0
			mov menuChoice[1], 1
			mov menuChoice[2], 0
		jmp next
		
		exitHighlight:
			mov menuChoice[0], 0
			mov menuChoice[1], 0
			mov menuChoice[2], 1
			mov mc, 2
		jmp next
		
		next:
			call menu_highlight
		ret
	go_up endp
; ################################################################################################################################################
	go_down proc
		inc mc
		
		cmp mc, 0
		je playHighlight
		cmp mc, 2
		jg playHighlight
		cmp mc, 1
		je levelHighlight
		cmp mc, 2
		je exitHighlight
		
		playHighlight:
			mov menuChoice[0], 1
			mov menuChoice[1], 0
			mov menuChoice[2], 0
			mov mc, 0
		jmp next
		
		levelHighlight:
			mov menuChoice[0], 0
			mov menuChoice[1], 1
			mov menuChoice[2], 0
		jmp next
		
		exitHighlight:
			mov menuChoice[0], 0
			mov menuChoice[1], 0
			mov menuChoice[2], 1
		jmp next
		
		next:
			call menu_highlight
		ret
	go_down endp
; ################################################################################################################################################
	go_right proc
		inc shipCol							; increase column position of cursor
		inc nozzleIndex
		;inc ch
		
		cmp shipCol, 75						; if cursor goes through rightmost part of screen, go to leftmost part on the same line
		jle otherwise
		
		mov nozzleIndex, 77
		mov shipCol, 75
		
		otherwise:
		
		ret
	go_right endp
; ################################################################################################################################################
	go_left proc
		dec shipCol							; decrease column position of cursor
		dec nozzleIndex
		;dec ch
		
		cmp shipCol, 0						; if cursor goes through leftmost part of screen, go to rightmost part on the same line
		jge otherwise
		
		mov nozzleIndex, 2
		mov shipCol, 0
		
		otherwise:
		
		ret
	go_left endp
; ################################################################################################################################################
	game_over proc
		mov al, 1 
		mov bh, 0 
		mov bl, 10001100b  					; 8th bit -> blink, 7th to 5th bit -> background color, 4th bit -> intensity, 3rd to 1st bit -> foreground(text) color
		mov cx, 56
		mov dh, 9
		mov dl, 14
		push ds
		pop es
		lea bp, offset gameOverMsg1
		mov ah, 13h 
		int 10h
		
		mov al, 1 
		mov bh, 0 
		mov bl, 10001100b  					; 8th bit -> blink, 7th to 5th bit -> background color, 4th bit -> intensity, 3rd to 1st bit -> foreground(text) color
		mov cx, 56
		mov dh, 10
		mov dl, 14
		push ds
		pop es
		lea bp, offset gameOverMsg2
		mov ah, 13h 
		int 10h
		
		mov al, 1 
		mov bh, 0 
		mov bl, 10001100b  					; 8th bit -> blink, 7th to 5th bit -> background color, 4th bit -> intensity, 3rd to 1st bit -> foreground(text) color
		mov cx, 56
		mov dh, 11
		mov dl, 14
		push ds
		pop es
		lea bp, offset gameOverMsg3
		mov ah, 13h 
		int 10h
		
		mov al, 1 
		mov bh, 0 
		mov bl, 10001100b  					; 8th bit -> blink, 7th to 5th bit -> background color, 4th bit -> intensity, 3rd to 1st bit -> foreground(text) color
		mov cx, 56
		mov dh, 12
		mov dl, 14
		push ds
		pop es
		lea bp, offset gameOverMsg4
		mov ah, 13h 
		int 10h
	
		; mov dh, 3
		; mov dl, 5
		; xor bh, bh
		; mov ah, 02h
		; int 10h

		; lea dx, scoreString
		; mov ah, 09h
		; int 21h
		
		; mov ax, score
		; call printAX
		ret
	game_over endp
; ################################################################################################################################################
	quit proc
		mov ax, 4c00h
		int 21h 
		ret
	quit endp
; ################################################################################################################################################
	
    end main
    
