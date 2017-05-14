;Program adds two 24-bit numbers
;This prograv uses the old command systems (35 instruction)
;Program with direct addressing
;pic 16F84

;*************************************************************
;Summ saved in firstHH(msb), firstHL, firstll(lsb) and add reg firstC

;*************************************************************

	processor 16f84
	include p16f84.inc

;Memory init
firstHH		equ	0x0C		;lsb
firstHL		equ	0x0D
firstLL		equ	0x0E		;msb
firstC		equ 0x0F
secondHH	equ	0x11		;lsd
secondHL	equ	0x12
secondLL	equ	0x13

	org	0		
		clrf	firstHH
		clrf	firstHL
		clrf	firstLL
		clrf	firstC
		MOVLW	0x8F
		MOVWF	firstHH
		MOVLW	0xDD
		MOVWF	firstHL
		MOVLW	0x6F
		MOVWF	firstLL
		MOVLW	0xC1
		MOVWF	secondHH
		MOVLW	0x4E
		MOVWF	secondHL
		MOVLW	0x69
		MOVWF	secondLL

		MOVF	secondLL, W
		ADDWF	firstLL, F
		BTFSS	STATUS, 0
		GOTO	loop
		INCFSZ	firstHL, F
		GOTO	loop
		INCFSZ	firstHH, F
loop
		MOVF	secondHL, W
		ADDWF	firstHL, F
		BTFSC	STATUS, 0
		INCF	firstHH
		MOVF	secondHH, W
		ADDWF	firstHH, F
		BTFSC	STATUS, 0
		incf	firstC
	end