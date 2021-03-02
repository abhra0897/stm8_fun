;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _strlen
	.globl _spi_init
	.globl _uart_init
	.globl _gpio_init
	.globl _uart_write
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/main.c: 14: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #8
;	src/main.c: 17: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	src/main.c: 18: uart_init();
	call	_uart_init
;	src/main.c: 20: while(1)
00103$:
;	src/main.c: 22: uart_write("Hello World!\r\n");
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 23: for(uint64_t i = 0; i < 10000; i++);
	clrw	x
	ldw	(0x07, sp), x
	ldw	(0x05, sp), x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
00106$:
	ldw	x, (0x07, sp)
	cpw	x, #0x2710
	ld	a, (0x06, sp)
	sbc	a, #0x00
	ld	a, (0x05, sp)
	sbc	a, #0x00
	ld	a, (0x04, sp)
	sbc	a, #0x00
	ld	a, (0x03, sp)
	sbc	a, #0x00
	ld	a, (0x02, sp)
	sbc	a, #0x00
	ld	a, (0x01, sp)
	sbc	a, #0x00
	jrnc	00103$
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x07, sp), x
	jrne	00106$
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jrne	00106$
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jrne	00106$
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
	jra	00106$
;	src/main.c: 26: }
	addw	sp, #8
	ret
;	src/main.c: 28: void spi_init()
;	-----------------------------------------
;	 function spi_init
;	-----------------------------------------
_spi_init:
;	src/main.c: 31: }
	ret
;	src/main.c: 33: void uart_init()
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	src/main.c: 36: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	21045, #3
;	src/main.c: 38: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	src/main.c: 40: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see page 365 and 336 of ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	src/main.c: 41: }
	ret
;	src/main.c: 43: void gpio_init()
;	-----------------------------------------
;	 function gpio_init
;	-----------------------------------------
_gpio_init:
;	src/main.c: 46: }
	ret
;	src/main.c: 48: uint16_t uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	src/main.c: 50: for(i = 0; i < strlen(str); i++) {
	clr	(0x03, sp)
00106$:
	ldw	x, (0x06, sp)
	pushw	x
	call	_strlen
	addw	sp, #2
	ldw	(0x01, sp), x
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	cpw	x, (0x01, sp)
	jrnc	00104$
;	src/main.c: 51: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 52: UART1_DR = str[i];
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	ld	0x5231, a
;	src/main.c: 50: for(i = 0; i < strlen(str); i++) {
	inc	(0x03, sp)
	jra	00106$
00104$:
;	src/main.c: 54: return(i); // Bytes sent
	ld	a, (0x03, sp)
	clrw	x
	ld	xl, a
;	src/main.c: 55: }
	addw	sp, #3
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "Hello World!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
