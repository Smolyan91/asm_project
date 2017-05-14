;Use microprocessor pic 16F1783
	processor	16F1783
	#include	p16F1783.inc
	radix		hex
;==================================
;Registers
result	equ	0x20	;source reg
count	equ	0x25
tmp		equ	0x30

;==================================
;Macro

m	macro	x,y
	movlw	x
	movwf	y
	endm
;++++++++++++++++++++++++++++++++++

		org		0x00
		goto	start
;=======================================
;Start

start:
	;Init tmp values
	m	0x77,0x20;
	m	0x77,0x21;
	m	0x77,0x22;
	m	0x77,0x23;
	m	0x77,0x24;

	call	d2b	;subprog converting numeric
	nop
loop:
	goto	loop

;========================================
;Subprogram convert 5-byte Bcd to binary format number
;
;Input:	FSR0+0 -msb float part
;		FSR0+1 -lsb float part
;		FSR0+2 -msb int part
;		FSR0+3 -int part
;		FSR0+4 -int part
;		FSR0+5 -msb int part
;Tcyc = 2344 cycle

d2b:
	movlw	result;
	movwf	FSR0L
	movlw	tmp
	movwf	FSR1L
	movlw	.16
	movwf	count
	flag	equ	0x27
d2b_convert:
	movf	INDF0,W
	addwf	INDF0,F
	movf	STATUS,W
	movwf	flag
	call	correct_dec	;bcd correction
	incf	FSR0L
	movf	flag,W
	movwf	STATUS
	movf	INDF0,W
	addwfc	INDF0,F
	movf	STATUS,W
	movwf	flag
	call	correct_dec
	movf	flag,W
	movwf	STATUS
	;Shirt result
	rlf	INDF1,F
	incf	FSR1L
	rlf	INDF1,F
	movlw	result
	movwf	FSR0L
	movlw	tmp
	movwf	FSR1L
	decfsz	count,F
	goto	d2b_convert
	;Trasport result
	movf	INDF1,W
	movwf	INDF0
	incf	FSR0L
	incf	FSR1L
	movf	INDF1,w
	movwf	INDF0
	;Return on start for converting integer part
	movlw	tmp
	movwf	FSR1L
	incf	FSR0L
	incf	FSR0L
	incf	FSR0L
	;Convert int part=>
	index_f	equ	0x26
	movf	FSR0L,W
	movwf	index_f
	movlw	0.24
	movwf	count
next_offset:
	movlw	tmp
	movwf	FESR1L
	movf	index_f,W
	movwf	FSR0L
	bcf		STATUS,0
	rrf		INDF0,F
	call	correct_int
	rrf		INDF0,F
	call	correct_int
	rrf		INDF0,F
	call	correct_int
	rrf		INDF1,F
	incf	FSR1L
	rrf		INDF1,F
	incf	FSR1L
	decfsz	count,F
	goto	next_offset
	;Transport result
	incf	FSR0L
	movf	INDF1,W
	movwf	INDF0
	decf	FSR1L
	incf	FSR0L
	movf	INDF1,W
	movwf	INDF0
	decf	FSR1L
	incf	FSR0L
	movf	INDF1,W
	movwf	INDF0
	return

correct_int:
	movf	STATUS,W
	movwf	flag
	clrw	
	btfsc	INDF0,3
	iorlw	0x03
	btfsc	INDF0,7
	iorlw	0x30
	subwf	INDF0,F
	decf	FSR0L
	movf	flag,W
	movwf	STATUS
	return

correct_dec:
	movlw	0x66
	addwf	INDF0,W
	movf	flag,W
	iorwf	STATUS,W
	movwf	flag
	clrw	
	btfsc	flag,0
	iorlw	0x60
	btfsc	flag,1
	iorlw	0x06
	addwf	INDF0,F
	return
;===================================================
	END

;++++++++++++++++++++++++++++++++++++++++++++++++++++

	
		
	
	
	
	
	