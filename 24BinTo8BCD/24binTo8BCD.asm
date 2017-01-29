;The programm convert 24-bit binary numeric
;to BCD formatt (8 digits)
;START0 - lsb
;START2 - msb
;
;DIGIT1 - msb
;	...
;DIGIT8 - lsb
;This programm used pic16f84 MK
;*******************************************************

;*****		Head	************************************
	processor 16f84
	include p16f84.inc
	radix dec			;defoult formatt number
;*******************************************************


;=========================================================
;***********	Initialization		**********************

;Ram equates
START0	equ	0x0C		;lsb
START1	equ	0x0D
START2	equ	0x0E		;msb
DIGIT1	equ	0x11		;lsd
DIGIT2	equ	0x12
DIGIT3	equ	0x13
DIGIT4	equ	0x14
DIGIT5	equ	0x15
DIGIT6	equ	0x16
DIGIT7	equ	0x17
DIGIT8	equ	0x18		;msd
COUNT1	equ	0x19		;head
COUNT2	equ	0x1A		;num

;===========================================================


;===========================================================
;*************		Programm listing		****************

			org		0
			GOTO	START	

START:
		MOVLW	0xAA
		MOVWF	START2
		MOVLW	0xBB
		MOVWF	START1
		MOVLW	0xCC
		MOVWF	START0
BINDEC:  
		CALL	CLR_DIG
       	MOVLW	.24
       	MOVWF	COUNT1
BITLOOP:		
		RLF		START0, F
		RLF		START1, F
		RLF		START2, F
		MOVLW	DIGIT1
		MOVWF	FSR
		MOVLW	8
		MOVWF	COUNT2
		MOVLW	6
ADJLP:
		RLF		INDF, F
		ADDWF	INDF, F
		BTFSS	INDF, 4
		SUBWF	INDF, F
		BSF		STATUS, 0
		BTFSS	INDF, 4
		BCF		STATUS, 0
		BCF		INDF, 4
		INCF	FSR, F
		DECFSZ	COUNT2, F
		GOTO	ADJLP
		DECFSZ	COUNT1, F
		GOTO	BITLOOP
		RETURN
CLR_DIG: 
	 	CLRF DIGIT1
       	CLRF DIGIT2
       	CLRF DIGIT3
       	CLRF DIGIT4
       	CLRF DIGIT5
       	CLRF DIGIT6
       	CLRF DIGIT7
       	CLRF DIGIT8
       	RETURN

	END