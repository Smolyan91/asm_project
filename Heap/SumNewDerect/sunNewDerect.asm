;Program adds two 24-bit numbers
;This prograv uses the new command systems (49 instruction)
;Program with direct addressing
;pic 18f4520

;*************************************************************
;Summ saved in firstHH(msb), firstHL, firstll(lsb) and add reg firstC

;*************************************************************

	processor 18f4520
	include p18f4520.inc

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
		MOVF	secondHL, W
		ADDWFC	firstHL,F
		MOVF	secondHH, W
		ADDWFC	firstHH, F
		BTFSC	STATUS, 0
		incf	firstC
	end