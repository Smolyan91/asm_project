    processor	16F1787
    #include	p16F1787.inc
    radix	hex
    
    
    cont    macro   x, y
	    movlw   x
	    movwf   y
	    endm
	
S_L	equ 0x20
S_LH	equ 0x21
S_HH	equ 0x22
S_TMP	equ 0x23
F_L	equ 0x24
F_LH	equ 0x25
F_HH	equ 0x26


	    org	0x00
	    goto    start
	    
	    
start:
    cont    0xAD, S_L
    cont    0xDD, S_LH
    cont    0xAB, S_HH
    cont    0x36, F_L
    cont    0x56, F_LH
    cont    0xFF, F_HH
