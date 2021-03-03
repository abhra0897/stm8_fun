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
	.globl _flash_write_enable
	.globl _flash_erase_block
	.globl _flash_busy_wait
	.globl _flash_read_from_addr
	.globl _flash_write_to_addr
	.globl _spi_config
	.globl _strlen
	.globl _uart_init
	.globl _gpio_init
	.globl _uart_write
	.globl _uart_write_8bits
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
;	src/main.c: 15: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #201
;	src/main.c: 18: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	src/main.c: 19: uart_init();
	call	_uart_init
;	src/main.c: 21: uint8_t buff[100] = {0};
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
;	src/main.c: 22: uint8_t buff2[100] = {0};
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
;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
	clr	a
00104$:
	cp	a, #0x64
	jrnc	00101$
;	src/main.c: 25: buff[i] = i;
	ldw	x, sp
	incw	x
	pushw	x
	clrw	x
	ld	xl, a
	addw	x, (1, sp)
	addw	sp, #2
	ld	(x), a
;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
	inc	a
	jra	00104$
00101$:
;	src/main.c: 28: uart_write("Configuring SPI...\n");
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 29: spi_config();
	call	_spi_config
;	src/main.c: 31: uart_write("Prepare to write...\n");
	push	#<(___str_1 + 0)
	push	#((___str_1 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 32: flash_write_enable();
	call	_flash_write_enable
;	src/main.c: 33: flash_erase_block(0, CMD_4K_BLOCK_ERASE);
	push	#0x20
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	call	_flash_erase_block
	addw	sp, #5
;	src/main.c: 34: flash_busy_wait();
	call	_flash_busy_wait
;	src/main.c: 42: flash_write_enable();
	call	_flash_write_enable
;	src/main.c: 43: uart_write("Writing...\n");
	push	#<(___str_2 + 0)
	push	#((___str_2 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 44: flash_write_to_addr(0, buff, 100);
	push	#0x64
	push	#0x00
	ldw	x, sp
	addw	x, #3
	pushw	x
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	call	_flash_write_to_addr
	addw	sp, #8
;	src/main.c: 45: flash_busy_wait();
	call	_flash_busy_wait
;	src/main.c: 46: uart_write("Write complete...\n");
	push	#<(___str_3 + 0)
	push	#((___str_3 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 48: uart_write("Reading...\n");
	push	#<(___str_4 + 0)
	push	#((___str_4 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 49: flash_read_from_addr(0, buff2, 100);
	push	#0x64
	push	#0x00
	ldw	x, sp
	addw	x, #103
	pushw	x
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	call	_flash_read_from_addr
	addw	sp, #8
;	src/main.c: 50: uart_write("Read complete...\n");
	push	#<(___str_5 + 0)
	push	#((___str_5 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 52: uart_write("Comparing...\n");
	push	#<(___str_6 + 0)
	push	#((___str_6 + 0) >> 8)
	call	_uart_write
	addw	sp, #2
;	src/main.c: 54: for(uint8_t ii = 0; ii < 100; ii++)
	clr	(0xc9, sp)
00107$:
	ld	a, (0xc9, sp)
	cp	a, #0x64
	jrnc	00102$
;	src/main.c: 56: uart_write_8bits(buff2[ii]);
	clrw	x
	ld	a, (0xc9, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #103
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	push	a
	call	_uart_write_8bits
	pop	a
;	src/main.c: 54: for(uint8_t ii = 0; ii < 100; ii++)
	inc	(0xc9, sp)
	jra	00107$
00102$:
;	src/main.c: 63: uart_write("Error count: ");
	push	#<(___str_7 + 0)
	push	#((___str_7 + 0) >> 8)
	call	_uart_write
;	src/main.c: 66: }
	addw	sp, #203
	ret
;	src/main.c: 69: void uart_init()
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	src/main.c: 72: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	21045, #3
;	src/main.c: 74: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	src/main.c: 76: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
	mov	0x5233+0, #0x01
	mov	0x5232+0, #0x34
;	src/main.c: 77: }
	ret
;	src/main.c: 79: void gpio_init()
;	-----------------------------------------
;	 function gpio_init
;	-----------------------------------------
_gpio_init:
;	src/main.c: 82: }
	ret
;	src/main.c: 84: uint16_t uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	src/main.c: 86: for(i = 0; i < strlen(str); i++) {
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
;	src/main.c: 87: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 88: UART1_DR = str[i];
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	ld	0x5231, a
;	src/main.c: 86: for(i = 0; i < strlen(str); i++) {
	inc	(0x03, sp)
	jra	00106$
00104$:
;	src/main.c: 90: return(i); // Bytes sent
	ld	a, (0x03, sp)
	clrw	x
	ld	xl, a
;	src/main.c: 91: }
	addw	sp, #3
	ret
;	src/main.c: 93: void uart_write_8bits(uint8_t d)
;	-----------------------------------------
;	 function uart_write_8bits
;	-----------------------------------------
_uart_write_8bits:
;	src/main.c: 95: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 96: UART1_DR = d;
	ldw	x, #0x5231
	ld	a, (0x03, sp)
	ld	(x), a
;	src/main.c: 97: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "Configuring SPI..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "Prepare to write..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "Writing..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "Write complete..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "Reading..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "Read complete..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "Comparing..."
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "Error count: "
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
