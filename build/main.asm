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
	.globl _ws2812_send_pixel_24bits
	.globl _ws2812_send_latch
	.globl _ws2812_gpio_config
	.globl _flash_read_from_addr
	.globl _spi_config
	.globl _strlen
	.globl _get_next_color
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
;	src/main.c: 47: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #238
;	src/main.c: 50: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	src/main.c: 51: uart_init();
	call	_uart_init
;	src/main.c: 53: uint8_t buff[100] = {0};
	clr	(0x03, sp)
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
	ldw	x, sp
	clr	(101, x)
	ldw	x, sp
	clr	(102, x)
;	src/main.c: 54: uint8_t buff2[100] = {0};
	clr	(0x67, sp)
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
	ldw	x, sp
	clr	(201, x)
	ldw	x, sp
	clr	(202, x)
;	src/main.c: 55: for (uint8_t i = 0; i < 100; i++)
	clr	a
00112$:
	cp	a, #0x64
	jrnc	00101$
;	src/main.c: 57: buff[i] = i/* +7+'0' */;
	ldw	x, sp
	addw	x, #3
	pushw	x
	clrw	x
	ld	xl, a
	addw	x, (1, sp)
	addw	sp, #2
	ld	(x), a
;	src/main.c: 55: for (uint8_t i = 0; i < 100; i++)
	inc	a
	jra	00112$
00101$:
;	src/main.c: 60: ws2812_gpio_config();
	call	_ws2812_gpio_config
;	src/main.c: 61: spi_config();
	call	_spi_config
;	src/main.c: 72: uart_write_8bits(0x99); //indicates start
	push	#0x99
	call	_uart_write_8bits
	pop	a
;	src/main.c: 74: flash_read_from_addr(0x012345, buff2, 100);
	push	#0x64
	push	#0x00
	ldw	x, sp
	addw	x, #105
	pushw	x
	push	#0x45
	push	#0x23
	push	#0x01
	push	#0x00
	call	_flash_read_from_addr
	addw	sp, #8
;	src/main.c: 77: char hex_string[2] = {0};
	clr	(0xcb, sp)
	ldw	x, sp
	addw	x, #204
	clr	(x)
;	src/main.c: 80: uint8_t red = 255, green = 0, blue = 0;
	ld	a, #0xff
	ld	(0xcd, sp), a
	clr	(0xce, sp)
	clr	(0xcf, sp)
;	src/main.c: 81: uint8_t r_temp = red, g_temp = green, b_temp = blue;
	ld	a, #0xff
	ld	(0xd0, sp), a
	clr	(0xd1, sp)
	clr	(0xd2, sp)
;	src/main.c: 89: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
00128$:
	clr	(0xee, sp)
00115$:
	ld	a, (0xee, sp)
	cp	a, #0x08
	jrnc	00102$
;	src/main.c: 91: get_next_color(&r_temp, &g_temp, &b_temp, 100);
	push	#0x64
	ldw	x, sp
	addw	x, #211
	pushw	x
	ldw	x, sp
	addw	x, #212
	pushw	x
	ldw	x, sp
	addw	x, #213
	pushw	x
	call	_get_next_color
	addw	sp, #7
;	src/main.c: 92: color_buff[led_cnt][0] = CIE_CORRECTION[r_temp];
	ld	a, (0xee, sp)
	ld	xl, a
	ld	a, #0x03
	mul	x, a
	ldw	(0xec, sp), x
	ldw	y, sp
	addw	y, #211
	addw	y, (0xec, sp)
	clrw	x
	ld	a, (0xd0, sp)
	ld	xl, a
	addw	x, #(_CIE_CORRECTION + 0)
	ld	a, (x)
	ld	(y), a
;	src/main.c: 93: color_buff[led_cnt][1] = CIE_CORRECTION[g_temp];
	ldw	y, sp
	addw	y, #211
	addw	y, (0xec, sp)
	ldw	x, y
	incw	x
	ldw	(0xec, sp), x
	clrw	x
	ld	a, (0xd1, sp)
	ld	xl, a
	addw	x, #(_CIE_CORRECTION + 0)
	ld	a, (x)
	ldw	x, (0xec, sp)
	ld	(x), a
;	src/main.c: 94: color_buff[led_cnt][2] = CIE_CORRECTION[b_temp];
	addw	y, #0x0002
	clrw	x
	ld	a, (0xd2, sp)
	ld	xl, a
	addw	x, #(_CIE_CORRECTION + 0)
	ld	a, (x)
	ld	(y), a
;	src/main.c: 89: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
	inc	(0xee, sp)
	jra	00115$
00102$:
;	src/main.c: 101: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
	clr	(0xee, sp)
00118$:
	ld	a, (0xee, sp)
	cp	a, #0x08
	jrnc	00103$
;	src/main.c: 104: ws2812_send_pixel_24bits(color_buff[led_cnt][0], color_buff[led_cnt][1], color_buff[led_cnt][2]);
	ld	a, (0xee, sp)
	ld	xl, a
	ld	a, #0x03
	mul	x, a
	ldw	(0x01, sp), x
	ldw	x, sp
	addw	x, #211
	addw	x, (0x01, sp)
	ldw	(0xeb, sp), x
	ld	a, (0x2, x)
	ld	(0xed, sp), a
	ldw	x, (0xeb, sp)
	ld	a, (0x1, x)
	ld	xl, a
	ldw	y, (0xeb, sp)
	ld	a, (y)
	ld	xh, a
	ld	a, (0xed, sp)
	push	a
	ld	a, xl
	push	a
	ld	a, xh
	push	a
	call	_ws2812_send_pixel_24bits
	addw	sp, #3
;	src/main.c: 101: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
	inc	(0xee, sp)
	jra	00118$
00103$:
;	src/main.c: 108: ws2812_send_latch();
	call	_ws2812_send_latch
;	src/main.c: 109: get_next_color(&red, &green, &blue, 10);
	push	#0x0a
	ldw	x, sp
	addw	x, #208
	pushw	x
	ldw	x, sp
	addw	x, #209
	pushw	x
	ldw	x, sp
	addw	x, #210
	pushw	x
	call	_get_next_color
	addw	sp, #7
;	src/main.c: 110: r_temp = red, g_temp = green, b_temp = blue;
	ld	a, (0xcd, sp)
	ld	(0xd0, sp), a
	ld	a, (0xce, sp)
	ld	(0xd1, sp), a
	ld	a, (0xcf, sp)
	ld	(0xd2, sp), a
;	src/main.c: 112: for (uint32_t jj = 0; jj < 10000; jj++);
	clrw	y
	clrw	x
00121$:
	cpw	y, #0x2710
	ld	a, xl
	sbc	a, #0x00
	ld	a, xh
	sbc	a, #0x00
	jrc	00176$
	jp	00128$
00176$:
	incw	y
	jrne	00121$
	incw	x
	jra	00121$
;	src/main.c: 118: while(1);
;	src/main.c: 119: }
	addw	sp, #238
	ret
;	src/main.c: 121: void get_next_color(uint8_t *r, uint8_t *g, uint8_t *b, uint8_t step)
;	-----------------------------------------
;	 function get_next_color
;	-----------------------------------------
_get_next_color:
	sub	sp, #18
;	src/main.c: 123: while (step--)
	ldw	y, (0x19, sp)
	ldw	(0x01, sp), y
	ldw	(0x03, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x07, sp), y
	ld	a, (0x1b, sp)
	ld	(0x12, sp), a
00130$:
	ld	a, (0x12, sp)
	dec	(0x12, sp)
	tnz	a
	jrne	00236$
	jp	00133$
00236$:
;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
	ldw	y, (0x15, sp)
	ldw	(0x09, sp), y
	ldw	x, y
	ld	a, (x)
	ld	(0x0b, sp), a
	ldw	y, (0x17, sp)
;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
	ldw	(0x0c, sp), y
	ldw	x, y
	ld	a, (x)
	ld	(0x0e, sp), a
;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
	ld	a, (0x0b, sp)
	inc	a
	jrne	00238$
	ld	a, #0x01
	ld	(0x0f, sp), a
	.byte 0xc5
00238$:
	clr	(0x0f, sp)
00239$:
;	src/main.c: 126: (*g) += 1;
	ld	a, (0x0e, sp)
	ld	(0x10, sp), a
;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
	tnz	(0x0f, sp)
	jreq	00126$
	ldw	x, (0x01, sp)
	ld	a, (x)
	jrne	00126$
	ld	a, (0x0e, sp)
	cp	a, #0xff
	jrnc	00126$
;	src/main.c: 126: (*g) += 1;
	ld	a, (0x10, sp)
	inc	a
	ldw	x, (0x0c, sp)
	ld	(x), a
	jra	00130$
00126$:
;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
	ld	a, (0x0e, sp)
	inc	a
	jrne	00244$
	ld	a, #0x01
	ld	(0x11, sp), a
	.byte 0xc5
00244$:
	clr	(0x11, sp)
00245$:
;	src/main.c: 128: (*r) -= 1;
	ld	a, (0x0b, sp)
	ld	yl, a
;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
	tnz	(0x11, sp)
	jreq	00121$
	ldw	x, (0x03, sp)
	ld	a, (x)
	jrne	00121$
	tnz	(0x0b, sp)
	jreq	00121$
;	src/main.c: 128: (*r) -= 1;
	ld	a, yl
	dec	a
	ldw	x, (0x09, sp)
	ld	(x), a
	jra	00130$
00121$:
;	src/main.c: 129: else if (*r == 0 && *g == 255 && *b < 255)
	tnz	(0x0b, sp)
	jrne	00116$
	tnz	(0x11, sp)
	jreq	00116$
	ldw	x, (0x01, sp)
	ld	a, (x)
	cp	a, #0xff
	jrnc	00116$
;	src/main.c: 130: (*b) += 1;
	inc	a
	ldw	x, (0x01, sp)
	ld	(x), a
	jra	00130$
00116$:
;	src/main.c: 131: else if (*r == 0 && *b == 255 && *g > 0)
	tnz	(0x0b, sp)
	jrne	00111$
	ldw	x, (0x05, sp)
	ld	a, (x)
	inc	a
	jrne	00111$
	tnz	(0x0e, sp)
	jreq	00111$
;	src/main.c: 132: (*g) -= 1;
	ld	a, (0x10, sp)
	dec	a
	ldw	x, (0x0c, sp)
	ld	(x), a
	jp	00130$
00111$:
;	src/main.c: 133: else if (*g == 0 && *b == 255 && *r < 255)
	tnz	(0x0e, sp)
	jrne	00106$
	ldw	x, (0x07, sp)
	ld	a, (x)
	inc	a
	jrne	00106$
	ld	a, (0x0b, sp)
	cp	a, #0xff
	jrnc	00106$
;	src/main.c: 134: (*r) += 1;
	ld	a, yl
	inc	a
	ldw	x, (0x09, sp)
	ld	(x), a
	jp	00130$
00106$:
;	src/main.c: 135: else if (*r == 255 && *g == 0 && *b > 0)
	tnz	(0x0f, sp)
	jrne	00262$
	jp	00130$
00262$:
	tnz	(0x0e, sp)
	jreq	00263$
	jp	00130$
00263$:
	ldw	x, (0x01, sp)
	ld	a, (x)
	jrne	00264$
	jp	00130$
00264$:
;	src/main.c: 136: (*b) -= 1;
	dec	a
	ldw	x, (0x01, sp)
	ld	(x), a
	jp	00130$
00133$:
;	src/main.c: 138: }
	addw	sp, #18
	ret
;	src/main.c: 140: void uart_init()
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	src/main.c: 143: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	21045, #3
;	src/main.c: 145: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	src/main.c: 147: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
	mov	0x5233+0, #0x01
	mov	0x5232+0, #0x34
;	src/main.c: 148: }
	ret
;	src/main.c: 151: uint16_t uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	src/main.c: 153: for(i = 0; i < strlen(str); i++) {
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
;	src/main.c: 154: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 155: UART1_DR = str[i];
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	ld	0x5231, a
;	src/main.c: 153: for(i = 0; i < strlen(str); i++) {
	inc	(0x03, sp)
	jra	00106$
00104$:
;	src/main.c: 157: return(i); // Bytes sent
	ld	a, (0x03, sp)
	clrw	x
	ld	xl, a
;	src/main.c: 158: }
	addw	sp, #3
	ret
;	src/main.c: 160: void uart_write_8bits(uint8_t d)
;	-----------------------------------------
;	 function uart_write_8bits
;	-----------------------------------------
_uart_write_8bits:
;	src/main.c: 162: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	src/main.c: 163: UART1_DR = d;
	ldw	x, #0x5231
	ld	a, (0x03, sp)
	ld	(x), a
;	src/main.c: 164: }
	ret
;	src/main.c: 167: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
;	-----------------------------------------
;	 function int_to_hex_str
;	-----------------------------------------
_int_to_hex_str:
	sub	sp, #3
;	src/main.c: 170: while(hex_str_len)
	ld	a, (0x0c, sp)
	ld	(0x03, sp), a
00101$:
	tnz	(0x03, sp)
	jreq	00104$
;	src/main.c: 172: uint8_t masked_dec = (dec & mask);
	ld	a, (0x09, sp)
	and	a, #0x0f
;	src/main.c: 173: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
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
;	src/main.c: 175: dec >>= 4;
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
;	src/main.c: 176: hex_str_len--;
	dec	(0x03, sp)
	jra	00101$
00104$:
;	src/main.c: 178: }
	addw	sp, #3
	ret
	.area CODE
	.area CONST
_CIE_CORRECTION:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x76	; 118	'v'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x86	; 134
	.db #0x88	; 136
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x8d	; 141
	.db #0x8f	; 143
	.db #0x91	; 145
	.db #0x92	; 146
	.db #0x94	; 148
	.db #0x96	; 150
	.db #0x98	; 152
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x9d	; 157
	.db #0x9f	; 159
	.db #0xa1	; 161
	.db #0xa3	; 163
	.db #0xa5	; 165
	.db #0xa7	; 167
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0xad	; 173
	.db #0xaf	; 175
	.db #0xb1	; 177
	.db #0xb3	; 179
	.db #0xb5	; 181
	.db #0xb7	; 183
	.db #0xb9	; 185
	.db #0xbb	; 187
	.db #0xbd	; 189
	.db #0xbf	; 191
	.db #0xc1	; 193
	.db #0xc4	; 196
	.db #0xc6	; 198
	.db #0xc8	; 200
	.db #0xca	; 202
	.db #0xcc	; 204
	.db #0xcf	; 207
	.db #0xd1	; 209
	.db #0xd3	; 211
	.db #0xd6	; 214
	.db #0xd8	; 216
	.db #0xda	; 218
	.db #0xdc	; 220
	.db #0xdf	; 223
	.db #0xe1	; 225
	.db #0xe4	; 228
	.db #0xe6	; 230
	.db #0xe8	; 232
	.db #0xeb	; 235
	.db #0xed	; 237
	.db #0xf0	; 240
	.db #0xf2	; 242
	.db #0xf5	; 245
	.db #0xf7	; 247
	.db #0xfa	; 250
	.db #0xfc	; 252
	.db #0xff	; 255
	.area INITIALIZER
	.area CABS (ABS)
