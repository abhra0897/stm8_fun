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
	.globl _ws2812_send_reset
	.globl _ws2812_send_8bits
	.globl _ws2812_gpio_config
	.globl _flash_read_from_addr
	.globl _spi_config
	.globl _strlen
	.globl _uart_init
	.globl _uart_write
	.globl _uart_write_8bits
	.globl _int_to_hex_str
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
;	src/main.c: 16: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #203
;	src/main.c: 19: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	src/main.c: 20: uart_init();
	call	_uart_init
;	src/main.c: 22: uint8_t buff[100] = {0};
	clr	(0x01, sp)
	ldw	x, sp
	clr	(2, x)
	ldw	x, sp
	clr	(3, x)
	ldw	x, sp
	clr	(4, x)
	ldw	x, sp
	clr	(5, x)
	ldw	x, sp
	clr	(6, x)
	ldw	x, sp
	clr	(7, x)
	ldw	x, sp
	clr	(8, x)
	ldw	x, sp
	clr	(9, x)
	ldw	x, sp
	clr	(10, x)
	ldw	x, sp
	clr	(11, x)
	ldw	x, sp
	clr	(12, x)
	ldw	x, sp
	clr	(13, x)
	ldw	x, sp
	clr	(14, x)
	ldw	x, sp
	clr	(15, x)
	ldw	x, sp
	clr	(16, x)
	ldw	x, sp
	clr	(17, x)
	ldw	x, sp
	clr	(18, x)
	ldw	x, sp
	clr	(19, x)
	ldw	x, sp
	clr	(20, x)
	ldw	x, sp
	clr	(21, x)
	ldw	x, sp
	clr	(22, x)
	ldw	x, sp
	clr	(23, x)
	ldw	x, sp
	clr	(24, x)
	ldw	x, sp
	clr	(25, x)
	ldw	x, sp
	clr	(26, x)
	ldw	x, sp
	clr	(27, x)
	ldw	x, sp
	clr	(28, x)
	ldw	x, sp
	clr	(29, x)
	ldw	x, sp
	clr	(30, x)
	ldw	x, sp
	clr	(31, x)
	ldw	x, sp
	clr	(32, x)
	ldw	x, sp
	clr	(33, x)
	ldw	x, sp
	clr	(34, x)
	ldw	x, sp
	clr	(35, x)
	ldw	x, sp
	clr	(36, x)
	ldw	x, sp
	clr	(37, x)
	ldw	x, sp
	clr	(38, x)
	ldw	x, sp
	clr	(39, x)
	ldw	x, sp
	clr	(40, x)
	ldw	x, sp
	clr	(41, x)
	ldw	x, sp
	clr	(42, x)
	ldw	x, sp
	clr	(43, x)
	ldw	x, sp
	clr	(44, x)
	ldw	x, sp
	clr	(45, x)
	ldw	x, sp
	clr	(46, x)
	ldw	x, sp
	clr	(47, x)
	ldw	x, sp
	clr	(48, x)
	ldw	x, sp
	clr	(49, x)
	ldw	x, sp
	clr	(50, x)
	ldw	x, sp
	clr	(51, x)
	ldw	x, sp
	clr	(52, x)
	ldw	x, sp
	clr	(53, x)
	ldw	x, sp
	clr	(54, x)
	ldw	x, sp
	clr	(55, x)
	ldw	x, sp
	clr	(56, x)
	ldw	x, sp
	clr	(57, x)
	ldw	x, sp
	clr	(58, x)
	ldw	x, sp
	clr	(59, x)
	ldw	x, sp
	clr	(60, x)
	ldw	x, sp
	clr	(61, x)
	ldw	x, sp
	clr	(62, x)
	ldw	x, sp
	clr	(63, x)
	ldw	x, sp
	clr	(64, x)
	ldw	x, sp
	clr	(65, x)
	ldw	x, sp
	clr	(66, x)
	ldw	x, sp
	clr	(67, x)
	ldw	x, sp
	clr	(68, x)
	ldw	x, sp
	clr	(69, x)
	ldw	x, sp
	clr	(70, x)
	ldw	x, sp
	clr	(71, x)
	ldw	x, sp
	clr	(72, x)
	ldw	x, sp
	clr	(73, x)
	ldw	x, sp
	clr	(74, x)
	ldw	x, sp
	clr	(75, x)
	ldw	x, sp
	clr	(76, x)
	ldw	x, sp
	clr	(77, x)
	ldw	x, sp
	clr	(78, x)
	ldw	x, sp
	clr	(79, x)
	ldw	x, sp
	clr	(80, x)
	ldw	x, sp
	clr	(81, x)
	ldw	x, sp
	clr	(82, x)
	ldw	x, sp
	clr	(83, x)
	ldw	x, sp
	clr	(84, x)
	ldw	x, sp
	clr	(85, x)
	ldw	x, sp
	clr	(86, x)
	ldw	x, sp
	clr	(87, x)
	ldw	x, sp
	clr	(88, x)
	ldw	x, sp
	clr	(89, x)
	ldw	x, sp
	clr	(90, x)
	ldw	x, sp
	clr	(91, x)
	ldw	x, sp
	clr	(92, x)
	ldw	x, sp
	clr	(93, x)
	ldw	x, sp
	clr	(94, x)
	ldw	x, sp
	clr	(95, x)
	ldw	x, sp
	clr	(96, x)
	ldw	x, sp
	clr	(97, x)
	ldw	x, sp
	clr	(98, x)
	ldw	x, sp
	clr	(99, x)
	ldw	x, sp
	clr	(100, x)
;	src/main.c: 23: uint8_t buff2[100] = {0};
	clr	(0x65, sp)
	ldw	x, sp
	clr	(102, x)
	ldw	x, sp
	clr	(103, x)
	ldw	x, sp
	clr	(104, x)
	ldw	x, sp
	clr	(105, x)
	ldw	x, sp
	clr	(106, x)
	ldw	x, sp
	clr	(107, x)
	ldw	x, sp
	clr	(108, x)
	ldw	x, sp
	clr	(109, x)
	ldw	x, sp
	clr	(110, x)
	ldw	x, sp
	clr	(111, x)
	ldw	x, sp
	clr	(112, x)
	ldw	x, sp
	clr	(113, x)
	ldw	x, sp
	clr	(114, x)
	ldw	x, sp
	clr	(115, x)
	ldw	x, sp
	clr	(116, x)
	ldw	x, sp
	clr	(117, x)
	ldw	x, sp
	clr	(118, x)
	ldw	x, sp
	clr	(119, x)
	ldw	x, sp
	clr	(120, x)
	ldw	x, sp
	clr	(121, x)
	ldw	x, sp
	clr	(122, x)
	ldw	x, sp
	clr	(123, x)
	ldw	x, sp
	clr	(124, x)
	ldw	x, sp
	clr	(125, x)
	ldw	x, sp
	clr	(126, x)
	ldw	x, sp
	clr	(127, x)
	ldw	x, sp
	clr	(128, x)
	ldw	x, sp
	clr	(129, x)
	ldw	x, sp
	clr	(130, x)
	ldw	x, sp
	clr	(131, x)
	ldw	x, sp
	clr	(132, x)
	ldw	x, sp
	clr	(133, x)
	ldw	x, sp
	clr	(134, x)
	ldw	x, sp
	clr	(135, x)
	ldw	x, sp
	clr	(136, x)
	ldw	x, sp
	clr	(137, x)
	ldw	x, sp
	clr	(138, x)
	ldw	x, sp
	clr	(139, x)
	ldw	x, sp
	clr	(140, x)
	ldw	x, sp
	clr	(141, x)
	ldw	x, sp
	clr	(142, x)
	ldw	x, sp
	clr	(143, x)
	ldw	x, sp
	clr	(144, x)
	ldw	x, sp
	clr	(145, x)
	ldw	x, sp
	clr	(146, x)
	ldw	x, sp
	clr	(147, x)
	ldw	x, sp
	clr	(148, x)
	ldw	x, sp
	clr	(149, x)
	ldw	x, sp
	clr	(150, x)
	ldw	x, sp
	clr	(151, x)
	ldw	x, sp
	clr	(152, x)
	ldw	x, sp
	clr	(153, x)
	ldw	x, sp
	clr	(154, x)
	ldw	x, sp
	clr	(155, x)
	ldw	x, sp
	clr	(156, x)
	ldw	x, sp
	clr	(157, x)
	ldw	x, sp
	clr	(158, x)
	ldw	x, sp
	clr	(159, x)
	ldw	x, sp
	clr	(160, x)
	ldw	x, sp
	clr	(161, x)
	ldw	x, sp
	clr	(162, x)
	ldw	x, sp
	clr	(163, x)
	ldw	x, sp
	clr	(164, x)
	ldw	x, sp
	clr	(165, x)
	ldw	x, sp
	clr	(166, x)
	ldw	x, sp
	clr	(167, x)
	ldw	x, sp
	clr	(168, x)
	ldw	x, sp
	clr	(169, x)
	ldw	x, sp
	clr	(170, x)
	ldw	x, sp
	clr	(171, x)
	ldw	x, sp
	clr	(172, x)
	ldw	x, sp
	clr	(173, x)
	ldw	x, sp
	clr	(174, x)
	ldw	x, sp
	clr	(175, x)
	ldw	x, sp
	clr	(176, x)
	ldw	x, sp
	clr	(177, x)
	ldw	x, sp
	clr	(178, x)
	ldw	x, sp
	clr	(179, x)
	ldw	x, sp
	clr	(180, x)
	ldw	x, sp
	clr	(181, x)
	ldw	x, sp
	clr	(182, x)
	ldw	x, sp
	clr	(183, x)
	ldw	x, sp
	clr	(184, x)
	ldw	x, sp
	clr	(185, x)
	ldw	x, sp
	clr	(186, x)
	ldw	x, sp
	clr	(187, x)
	ldw	x, sp
	clr	(188, x)
	ldw	x, sp
	clr	(189, x)
	ldw	x, sp
	clr	(190, x)
	ldw	x, sp
	clr	(191, x)
	ldw	x, sp
	clr	(192, x)
	ldw	x, sp
	clr	(193, x)
	ldw	x, sp
	clr	(194, x)
	ldw	x, sp
	clr	(195, x)
	ldw	x, sp
	clr	(196, x)
	ldw	x, sp
	clr	(197, x)
	ldw	x, sp
	clr	(198, x)
	ldw	x, sp
	clr	(199, x)
	ldw	x, sp
	clr	(200, x)
;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
	clr	a
00111$:
	cp	a, #0x64
	jrnc	00101$
;	src/main.c: 26: buff[i] = i/* +7+'0' */;
	ldw	x, sp
	incw	x
	pushw	x
	clrw	x
	ld	xl, a
	addw	x, (1, sp)
	addw	sp, #2
	ld	(x), a
;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
	inc	a
	jra	00111$
00101$:
;	src/main.c: 29: ws2812_gpio_config();
	call	_ws2812_gpio_config
;	src/main.c: 30: spi_config();
	call	_spi_config
;	src/main.c: 41: uart_write_8bits(0x99); //indicates start
	push	#0x99
	call	_uart_write_8bits
	pop	a
;	src/main.c: 43: flash_read_from_addr(0x012345, buff2, 100);
	push	#0x64
	push	#0x00
	ldw	x, sp
	addw	x, #103
	pushw	x
	push	#0x45
	push	#0x23
	push	#0x01
	push	#0x00
	call	_flash_read_from_addr
	addw	sp, #8
;	src/main.c: 46: char hex_string[2] = {0};
	clr	(0xc9, sp)
	ldw	x, sp
	clr	(202, x)
;	src/main.c: 51: for(uint8_t ii = 0; ii < 100; ii++)
00127$:
	clr	(0xcb, sp)
00117$:
	ld	a, (0xcb, sp)
	cp	a, #0x64
	jrnc	00127$
;	src/main.c: 54: uart_write_8bits(buff2[ii]);
	clrw	x
	ld	a, (0xcb, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #103
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	pushw	x
	push	a
	call	_uart_write_8bits
	pop	a
	popw	x
;	src/main.c: 55: ws2812_send_8bits(buff2[ii]);
	ld	a, (x)
	pushw	x
	push	a
	call	_ws2812_send_8bits
	pop	a
	popw	x
;	src/main.c: 56: ws2812_send_8bits(buff2[ii]);
	ld	a, (x)
	pushw	x
	push	a
	call	_ws2812_send_8bits
	pop	a
	popw	x
;	src/main.c: 57: ws2812_send_8bits(buff2[ii]);
	ld	a, (x)
	push	a
	call	_ws2812_send_8bits
	pop	a
;	src/main.c: 59: ws2812_send_reset();
	call	_ws2812_send_reset
;	src/main.c: 61: for (uint32_t jj = 0; jj < 32000; jj++);
	clrw	y
	clrw	x
00114$:
	cpw	y, #0x7d00
	ld	a, xl
	sbc	a, #0x00
	ld	a, xh
	sbc	a, #0x00
	jrnc	00118$
	incw	y
	jrne	00114$
	incw	x
	jra	00114$
00118$:
;	src/main.c: 51: for(uint8_t ii = 0; ii < 100; ii++)
	inc	(0xcb, sp)
	jra	00117$
;	src/main.c: 67: while(1);
;	src/main.c: 68: }
	addw	sp, #203
	ret
;	src/main.c: 71: void uart_init()
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	src/main.c: 74: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	21045, #3
;	src/main.c: 76: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	src/main.c: 78: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
	mov	0x5233+0, #0x01
	mov	0x5232+0, #0x34
;	src/main.c: 79: }
	ret
;	src/main.c: 82: uint16_t uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	src/main.c: 84: for(i = 0; i < strlen(str); i++) {
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
;	src/main.c: 85: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 86: UART1_DR = str[i];
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	ld	0x5231, a
;	src/main.c: 84: for(i = 0; i < strlen(str); i++) {
	inc	(0x03, sp)
	jra	00106$
00104$:
;	src/main.c: 88: return(i); // Bytes sent
	ld	a, (0x03, sp)
	clrw	x
	ld	xl, a
;	src/main.c: 89: }
	addw	sp, #3
	ret
;	src/main.c: 91: void uart_write_8bits(uint8_t d)
;	-----------------------------------------
;	 function uart_write_8bits
;	-----------------------------------------
_uart_write_8bits:
;	src/main.c: 93: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 94: UART1_DR = d;
	ldw	x, #0x5231
	ld	a, (0x03, sp)
	ld	(x), a
;	src/main.c: 95: }
	ret
;	src/main.c: 98: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
;	-----------------------------------------
;	 function int_to_hex_str
;	-----------------------------------------
_int_to_hex_str:
	sub	sp, #3
;	src/main.c: 101: while(hex_str_len)
	ld	a, (0x0c, sp)
	ld	(0x03, sp), a
00101$:
	tnz	(0x03, sp)
	jreq	00104$
;	src/main.c: 103: uint8_t masked_dec = (dec & mask);
	ld	a, (0x09, sp)
	and	a, #0x0f
;	src/main.c: 104: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
	clrw	x
	exg	a, xl
	ld	a, (0x03, sp)
	exg	a, xl
	decw	x
	addw	x, (0x0a, sp)
	ldw	(0x01, sp), x
	ld	xl, a
	cp	a, #0x0a
	jrnc	00106$
	ld	a, xl
	add	a, #0x30
	jra	00107$
00106$:
	ld	a, xl
	add	a, #0x37
00107$:
	ldw	x, (0x01, sp)
	ld	(x), a
;	src/main.c: 106: dec >>= 4;
	ldw	x, (0x08, sp)
	ldw	y, (0x06, sp)
	srlw	y
	rrcw	x
	srlw	y
	rrcw	x
	srlw	y
	rrcw	x
	srlw	y
	rrcw	x
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	src/main.c: 107: hex_str_len--;
	dec	(0x03, sp)
	jra	00101$
00104$:
;	src/main.c: 109: }
	addw	sp, #3
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
