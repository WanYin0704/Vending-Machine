

TITLE Project 1 	(main.asm)
TITLE Library Test #1: Integer I/O (InputLoop.asm)  

INCLUDE Irvine32.inc

.data
    lineStars byte 70 dup('*'), 0
    lineWelcome byte " Hello, This is Abuden Vending Machine ",0
    lineStars1 byte 70 dup('*'), 0
    linePricing byte "  1. TEA = 60 cents ", 0
    linePricing2 byte "  2. CHOCO = 70 cents  ",0
    linePricing3 byte "  3. COFFEE = 100 cents ",0
    linePricing4 byte "  4. MOCHA = 120 cents ",0
    line1 byte "PLEASE INPUT MONEY: Only 10, 20 & 50 cents accepted", 0
    line2 byte "10 cents: ", 0
    line3 byte "20 cents: ", 0
    line4 byte "50 cents: ", 0
    line5 byte "YOUR MONEY: ", 0
    line6 byte "PLEASE CHOOSE ITEM: ", 0
    line7 byte "PLEASE CHOOSE QUANTITY: ", 0
    line8 byte "YOUR BILL IS: ", 0
    line9 byte "YOUR CHANGE IS: ", 0
    line10 byte "HERE IS YOUR ORDER, ENJOY!", 0
    line11 byte "SORRY BUT YOUR MONEY IS INSUFFICIENT BY : ", 0
    line12 byte "INCORRECT ANSWER, PLEASE CHOOSE BETWEEN NUMBERS 1-4", 0
    line13 byte "WOULD YOU LIKE TO ORDER AGAIN?", 0
    line14 byte "[Yes = YES, TAKE MY MONEY, No = NAH I'M FULL FAM]", 0
    line15 byte "DO COME AGAIN! THANK YOU FOR USING OUR VENDING MACHINE!", 0
    lineErr byte "ERROR IDENTIFIED!"

    ARR_MONEY dword 0, 0, 0             ;array for money entered
    ARR_ORDER dword 0, 0, 0, 0          ;array for cost of order
    change dword 0                      ;stores the difference between ARR_MONEY-ARR_ORDER
    answer dword ?                      ;stores the answer for line13 
    totalMoney dword 0                  ;stores the total amount of money entered
    totalOrder dword 0	                ;stores the total cost of the order

.code
main PROC
	mov  eax,black + (yellow * 16)      ;set text color to black text on yellow background:
	call SetTextColor                   ;set the text colour
	call Clrscr		                    ;clear the screen
	call Randomize		                ;reset random number sequence

ORDERBARU:                              ;if user chooses "YES" at the final prompt "WOULD YOU LIKE TO ORDER AGAIN?", program returns here 
    mov EAX, 0                          ;set the value of EAX as 0
    mov EBX, 0	                        ;set the value of EBX as 0
    mov EDX, 0	                        ;set the value of EDX as 0
    mov change, 0                       ;set the value of change as 0
    mov totalOrder, 0	                ;set the value of totalOrder as 0
    mov totalMoney, 0                   ;set the value of totalMoney as 0
    call clrscr                         ;clears the terminal of any text
			             
    mov EDX, offset lineStars           ;set the address of lineStars as value of EDX
    call writestring                    ;null terminated string
    call crlf                           ;end line sequence for console
    mov EDX, offset lineWelcome         ;set the address of lineWelcome as value of EDX
    call writestring		            ;display " Hello, This is Abuden Vending Machine "
    call crlf                           ;create newline
    mov EDX, offset lineStars1          ;set the address of lineStars1 as value of EDX
    call writestring                    ;display 70 dup('*')
    call crlf			                ;create newline
    mov EDX, offset linePricing         ;set the address of linePricing as value of EDX
    call writestring	 	            ;display "  1. TEA = 60 cents "
    call crlf			                ;create newline
    mov EDX, offset linePricing2        ;set the address of linePricing2 as value of EDX
    call writestring		            ;display "  2. CHOCO = 70 cents "
    call crlf			                ;create newline
    mov EDX, offset linePricing3        ;set the address of linePricing3 as value of EDX
    call writestring		            ;display "  3. COFFEE = 100 cents "
    call crlf			                ;create newline
    mov EDX, offset linePricing4        ;set the address of linePricing4 as value of EDX
    call writestring		            ;display ? 4. MOCHA = 120 cents ?
    call crlf			                ;create newline
    mov EDX, offset lineStars           ;set the address of lineStars as value of EDX
    call writestring		            ;display 70 dup('*')
    call crlf			                ;create newline
    ;menu design ends 

    mov EDX, offset line1               ;set the address of line1 as value of EDX
    call MsgBox                         ;popup window called
    call writestring                    ;write Line1 in terminal
    call crlf                           ;create newline 
    mov EDX, offset line2	            ;set the address of line2 as value of EDX
    call writestring                    ;write Line 2 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    mov EDX, 10		                    ;set the value of EDX as 10
    mul EDX                             ;mul EAX by EDX (10), stored in EAX
    mov [ARR_MONEY], EAX                ;set value of ARR_MONEY item 1 pointer as the value in EAX
    call crlf			                ;create newline
    mov EDX, offset line3	            ;set the address of line3 as value of EDX
    call writestring                    ;write Line 3 in terminal
    call readdec                        ;read user input in decimal, terminate by Enter 
    mov EDX, 20		                    ;set the value of EDX as 20
    mul EDX		                        ;mul EAX by EDX (20), stored in EAX
    mov [ARR_MONEY+4], EAX              ;set value of ARR_MONEY item 2 pointer as the value in EAX
    call crlf			                ;create newline
    mov EDX, offset line4               ;set the address of line4 as value of EDX
    call writestring                    ;write Line 4 in terminal
    call readdec                        ;read user input in decimal, terminate by Enter 
    mov EDX, 50                         ;set the value of EDX as 50
    mul EDX                             ;mul EAX by EDX (20), stored in EAX
    mov [ARR_MONEY+8], EAX              ;set value of ARR_MONEY item 3 pointer as the value in EAX

    call crlf			                ;create newline
    mov EAX, 0                          ;set the value of EAX as 0
    mov ECX, 4                          ;set loop counter (ECX) to 4
    mov EBX, offset ARR_MONEY           ;move EBX to the address of  ARR_MONEY
L1:
    add EAX, [EBX]		                ;add EAX by value pointed by EBX , stored in EAX
    add EBX, 4                          ;add value of 4 to EBX
    loop L1                             ;loop back to L1 for 4 times
    mov totalMoney, EAX                 ;set value of totalMoney as value stored in EAX
    
    call crlf                           ;create newline
    mov EDX, offset line5               ;set the address of line5 as value of EDX
    call writestring		            ;write Line5 in terminal
    call writedec		                ;display decimal value store in EAX

AGAIN:
    mov EAX, 0                          ;set the value of EAX as 0
    mov EBX, offset ARR_ORDER           ;set offset address ARR_ORDER and move into EBX
    call crlf                           ;create newline
    mov EDX, offset line6               ;set offset address line6 and move into EDX
    call writestring                    ;write Line6 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    cmp EAX, 1                          ;compare EAX value with 1
    je TEA                              ;jump to TEA if EAX == 1
    cmp EAX, 2                          ;compare EAX value with 2
    je CHOCO                            ;jump to CHOCO if EAX == 2
    cmp EAX, 3                          ;compare EAX value with 3
    je COFFEE                           ;jump to COFFEE if EAX == 3
    cmp EAX, 4                          ;compare EAX value with 4
    je MOCHA                            ;jump to MOCHA if EAX == 4
    jmp ERR                             ;jump to ERR if equal to none

TEA:
    mov EDX, offset line7               ;set offset address line7 and move into EDX
    call writestring                    ;write Line7 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    mov EDX, 60                         ;set Tea price to 60 cents
    mul EDX                             ;multiply by the tea quantity
    mov [EBX], EAX
    jmp SKIP                            ;jump to SKIP

CHOCO:
    mov EDX, offset line7               ;set offset address line7 and move into EDX
    call writestring                    ;write Line7 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    mov EDX, 70                         ;set Choco price to 70 cents
    mul EDX                             ;multiply by the tea quantity
    mov [EBX+4], EAX
    jmp SKIP		                    ;jump to SKIP

COFFEE:
    mov EDX, offset line7               ;set offset address line7 and move into EDX
    call writestring                    ;write Line7 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    mov EDX, 100                        ;set Coffee price to 100 cents
    mul EDX                             ;multiply by the coffee quantity
    mov [EBX+8], EAX
    jmp SKIP                            ;jump to SKIP

MOCHA:
    mov EDX, offset line7               ;set offset address line7 and move into EDX
    call writestring                    ;write Line7 in terminal
    call readdec                        ;input a decimal value, stored in EAX
    mov EDX, 120                        ;set Mocha price to 120 cents
    mul EDX                             ;multiply by the mocha quantity
    mov [EBX+12], EAX
    jmp SKIP                            ;jump to SKIP

ERR:
    mov EDX, offset line12              ;set offset address line12 and move into EDX
    mov EBX, offset lineErr             ;set offset address lineErr and move into EBX
    call MsgBox                         ;pop up window called
    jmp AGAIN                           ;jump to AGAIN

SKIP:
    call crlf                           ;create newline
    mov EDX, offset line8               ;set offset address line8 and move into EDX
    call writestring                    ;write Line8 in terminal
    mov EAX, 0                          ;set the value of EAX as 0
    mov ECX, 4                          ;set loop counter (ECX) to 4
L2:
    add EAX, [EBX]		                ;add EAX by value pointed by EBX , stored in EAX
    add EBX, 4		                    ;add value of 4 to EBX
    loop L2			                    ;loop back to L2 for 4 times
    mov totalOrder, EAX	                ;set value of totalMoney value in EAX

    call writedec		                ;display decimal value store in EAX
    mov EBX, totalMoney	                ;set the value of EBX as the value in totalMoney
    cmp EBX, totalOrder	                ;compare the value of EBX to that of totalOrder
    je XDECHANGE		                ;if comparison is equal, jump to XDECHANGE
    jg ADECHANGE		                ;if in comparison, EBX>totalOrder , jump to ADECHANGE
    jl XCUKUPDOHH		                ;if in comparison, EBX<totalOrder , jump to XCUKUPDOHH

XDECHANGE:                              ;go here if the amount of money entered is exactly as required             
    call crlf			                ;create newline
    mov EDX, offset line10	            ;set offset address line10 and move into EBX
    call writestring		            ;write line10 in terminal
    jmp SKIPLAGI		                ;jump to SKIPLAGI
ADECHANGE:                              ;go here if the amount of money entered is more than required
    sub totalMoney, EAX                 ;subtract totalMoney by EAX
    mov EAX, totalMoney                 ;move EAX to totalMoney
    mov change, EAX                     ;move change to EAX
    call crlf                           ;create newline
    mov EDX, offset line9               ;set offset address line9 and move into EDX
    call writestring                    ;write line9 in terminal
    call writedec		                ;display decimal value store in EAX
    call crlf			                ;create newline
    mov EDX, offset line10              ;set offset address line10 and move into EDX
    call writestring		            ;write line10 in terminal
    mov EAX, change                     ;move EAX to change
    jmp SKIPLAGI                        ;jump to SKIPLAGI
XCUKUPDOHH:                             ;go here if the amount of money entered is less than required
    sub EAX, totalMoney                 ;subtract EAX by totalMoney 
    mov change, EAX                     ;move EAX to change
    call crlf                           ;create newline
    mov EDX, offset line11              ;move  "SORRY BUT YOUR MONEY IS INSUFFICIENT BY : " to EDX
    call writestring                    ;write line11 in terminal
    mov EAX, change                     ;move change back to EAX
    call writedec                       ;write the change in decimal to console window 
    jmp SKIPLAGI                        ;jump to SKIPLAGI
SKIPLAGI:
    call crlf                           ;create newline
    call crlf			                ;create newline
    mov EDX, 0                          ;sets EDX to 0
    mov EDX, offset line13              ;move "WOULD YOU LIKE TO ORDER AGAIN?" to EDX
    mov EBX, 0                          ;sets EBX to 0
    mov EAX, 2000                       ;sets EAX to 2000 for delay call
    call Delay                          ;delays the next line of code by EAX miliseconds (i.e 2 seconds)
    mov EAX, 0                          ;sets EAX to 0
    call writestring                    ;write line13 in terminal
    call crlf                           ;create newline
    mov EDX, offset line14              ;set offset address line14 and move into EDX
    call writestring                    ;write line14 in terminal
    mov EDX, offset line13              ;set offset address line13 and move into EDX
    call MsgBoxAsk                      ;asks user to choose YES/NO and result will be stored in EAX (YES, EAX=6/NO, EAX=7)
    call crlf                           ;create new line

    mov answer, EAX                     ;set the value of answer as the value in EAX
    cmp answer, 6                       ;compare EAX value with 6
    je ORDERBARU                        ;go to ORDERBARU if user clicks YES (EAX==6), restarts program
    cmp answer, 7                       ;compare EAX value with 7
    je ENDING                           ;go to ENDING if user clicks NO (EAX==7), ends the program

ENDING:
    call crlf			                ;create newline
    mov EDX, offset line15              ;set offset address line15 and move into EDX
    call writestring                    ;write line15 in terminal
    call crlf                           ;create newline
    call crlf			                ;create newline
    call WaitMsg		                ;displays a graphical popup message box with Yes and No buttons.
    Exit			                    ;ends all process
main ENDP		                        ;end program

END main		                        ;end main



