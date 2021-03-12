;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module ws2812_driver
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ws2812_gpio_config
	.globl _ws2812_send_8bits
	.globl _ws2812_send_pixel_24bits
	.globl _ws2812_send_latch
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/ws2812_driver.c: 4: void ws2812_gpio_config()
;	-----------------------------------------
;	 function ws2812_gpio_config
;	-----------------------------------------
_ws2812_gpio_config:
;	src/ws2812_driver.c: 6: PORT(WS2812_PORT, DDR) |= (1 << WS2812_PIN_POS); // WS2812_pin is output
	bset	20497, #2
;	src/ws2812_driver.c: 7: PORT(WS2812_PORT, CR1) |= (1 << WS2812_PIN_POS); // Push-pull mode  
	bset	20498, #2
;	src/ws2812_driver.c: 8: PORT(WS2812_PORT, CR2) |= (1 << WS2812_PIN_POS); // High speed (10MHz)
	bset	20499, #2
;	src/ws2812_driver.c: 9: PORT(WS2812_PORT, ODR) &= ~(1 << WS2812_PIN_POS); // Low (as ws2812 looks for logic high)
	bres	20495, #2
;	src/ws2812_driver.c: 10: }
	ret
;	src/ws2812_driver.c: 13: void ws2812_send_8bits(uint8_t d)
;	-----------------------------------------
;	 function ws2812_send_8bits
;	-----------------------------------------
_ws2812_send_8bits:
;	src/ws2812_driver.c: 33: uint8_t mask = 0x80;
	ld	a, #0x80
;	src/ws2812_driver.c: 34: uint8_t masked_val = d & mask;
	push	a
	ld	a, (0x04, sp)
	and	a, #0x80
	ld	xl, a
	pop	a
;	src/ws2812_driver.c: 35: while (mask) 
00104$:
	tnz	a
	jrne	00124$
	ret
00124$:
;	src/ws2812_driver.c: 51: mask >>= 1;
	srl	a
;	src/ws2812_driver.c: 37: if (masked_val) 
	exg	a, xl
	tnz	a
	exg	a, xl
	jreq	00102$
;	src/ws2812_driver.c: 47: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
	bset	0x500F, #2
;	src/ws2812_driver.c: 50: nop(); nop(); nop();
	nop
	nop
	nop
;	src/ws2812_driver.c: 51: mask >>= 1;
;	src/ws2812_driver.c: 52: masked_val = d & mask;
	push	a
	and	a, (0x04, sp)
	ld	xl, a
	pop	a
;	src/ws2812_driver.c: 56: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
	bres	0x500F, #2
	jra	00104$
00102$:
;	src/ws2812_driver.c: 71: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
	bset	0x500F, #2
;	src/ws2812_driver.c: 74: nop();// earlier 0 nops worked fine (390ns), addng one for testing
	nop
;	src/ws2812_driver.c: 75: mask >>= 1;
;	src/ws2812_driver.c: 76: masked_val = d & mask;
	push	a
	and	a, (0x04, sp)
	ld	xl, a
	pop	a
;	src/ws2812_driver.c: 79: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
	bres	0x500F, #2
	jra	00104$
;	src/ws2812_driver.c: 84: }
	ret
;	src/ws2812_driver.c: 87: void ws2812_send_pixel_24bits(uint8_t r, uint8_t g, uint8_t b)
;	-----------------------------------------
;	 function ws2812_send_pixel_24bits
;	-----------------------------------------
_ws2812_send_pixel_24bits:
;	src/ws2812_driver.c: 93: ws2812_send_8bits(g);
	ld	a, (0x04, sp)
	push	a
	call	_ws2812_send_8bits
	pop	a
;	src/ws2812_driver.c: 94: ws2812_send_8bits(r);
	ld	a, (0x03, sp)
	push	a
	call	_ws2812_send_8bits
	pop	a
;	src/ws2812_driver.c: 96: ws2812_send_8bits(b);
	ld	a, (0x05, sp)
	push	a
	call	_ws2812_send_8bits
	pop	a
;	src/ws2812_driver.c: 97: }
	ret
;	src/ws2812_driver.c: 101: void ws2812_send_latch()
;	-----------------------------------------
;	 function ws2812_send_latch
;	-----------------------------------------
_ws2812_send_latch:
;	src/ws2812_driver.c: 103: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS));
	bres	0x500F, #2
;	src/ws2812_driver.c: 106: for(uint16_t wait = 0; wait < 130; wait++);
	clrw	x
00103$:
	ldw	y, x
	cpw	y, #0x0082
	jrc	00118$
	ret
00118$:
	incw	x
	jra	00103$
;	src/ws2812_driver.c: 107: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
