                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module ws2812_driver
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _ws2812_gpio_config
                                     12 	.globl _ws2812_send_8bits
                                     13 	.globl _ws2812_send_pixel_24bits
                                     14 	.globl _ws2812_send_latch
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	src/ws2812_driver.c: 4: void ws2812_gpio_config()
                                     53 ;	-----------------------------------------
                                     54 ;	 function ws2812_gpio_config
                                     55 ;	-----------------------------------------
      008832                         56 _ws2812_gpio_config:
                                     57 ;	src/ws2812_driver.c: 6: PORT(WS2812_PORT, DDR) |= (1 << WS2812_PIN_POS); // WS2812_pin is output
      008832 72 14 50 11      [ 1]   58 	bset	20497, #2
                                     59 ;	src/ws2812_driver.c: 7: PORT(WS2812_PORT, CR1) |= (1 << WS2812_PIN_POS); // Push-pull mode  
      008836 72 14 50 12      [ 1]   60 	bset	20498, #2
                                     61 ;	src/ws2812_driver.c: 8: PORT(WS2812_PORT, CR2) |= (1 << WS2812_PIN_POS); // High speed (10MHz)
      00883A 72 14 50 13      [ 1]   62 	bset	20499, #2
                                     63 ;	src/ws2812_driver.c: 9: PORT(WS2812_PORT, ODR) &= ~(1 << WS2812_PIN_POS); // Low (as ws2812 looks for logic high)
      00883E 72 15 50 0F      [ 1]   64 	bres	20495, #2
                                     65 ;	src/ws2812_driver.c: 10: }
      008842 81               [ 4]   66 	ret
                                     67 ;	src/ws2812_driver.c: 13: void ws2812_send_8bits(uint8_t d)
                                     68 ;	-----------------------------------------
                                     69 ;	 function ws2812_send_8bits
                                     70 ;	-----------------------------------------
      008843                         71 _ws2812_send_8bits:
                                     72 ;	src/ws2812_driver.c: 33: uint8_t mask = 0x80;
      008843 A6 80            [ 1]   73 	ld	a, #0x80
                                     74 ;	src/ws2812_driver.c: 34: uint8_t masked_val = d & mask;
      008845 88               [ 1]   75 	push	a
      008846 7B 04            [ 1]   76 	ld	a, (0x04, sp)
      008848 A4 80            [ 1]   77 	and	a, #0x80
      00884A 97               [ 1]   78 	ld	xl, a
      00884B 84               [ 1]   79 	pop	a
                                     80 ;	src/ws2812_driver.c: 35: while (mask) 
      00884C                         81 00104$:
      00884C 4D               [ 1]   82 	tnz	a
      00884D 26 01            [ 1]   83 	jrne	00124$
      00884F 81               [ 4]   84 	ret
      008850                         85 00124$:
                                     86 ;	src/ws2812_driver.c: 51: mask >>= 1;
      008850 44               [ 1]   87 	srl	a
                                     88 ;	src/ws2812_driver.c: 37: if (masked_val) 
      008851 41               [ 1]   89 	exg	a, xl
      008852 4D               [ 1]   90 	tnz	a
      008853 41               [ 1]   91 	exg	a, xl
      008854 27 12            [ 1]   92 	jreq	00102$
                                     93 ;	src/ws2812_driver.c: 47: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
      008856 72 14 50 0F      [ 1]   94 	bset	0x500F, #2
                                     95 ;	src/ws2812_driver.c: 50: nop(); nop(); nop();
      00885A 9D               [ 1]   96 	nop
      00885B 9D               [ 1]   97 	nop
      00885C 9D               [ 1]   98 	nop
                                     99 ;	src/ws2812_driver.c: 51: mask >>= 1;
                                    100 ;	src/ws2812_driver.c: 52: masked_val = d & mask;
      00885D 88               [ 1]  101 	push	a
      00885E 14 04            [ 1]  102 	and	a, (0x04, sp)
      008860 97               [ 1]  103 	ld	xl, a
      008861 84               [ 1]  104 	pop	a
                                    105 ;	src/ws2812_driver.c: 56: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
      008862 72 15 50 0F      [ 1]  106 	bres	0x500F, #2
      008866 20 E4            [ 2]  107 	jra	00104$
      008868                        108 00102$:
                                    109 ;	src/ws2812_driver.c: 71: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
      008868 72 14 50 0F      [ 1]  110 	bset	0x500F, #2
                                    111 ;	src/ws2812_driver.c: 74: nop();// earlier 0 nops worked fine (390ns), addng one for testing
      00886C 9D               [ 1]  112 	nop
                                    113 ;	src/ws2812_driver.c: 75: mask >>= 1;
                                    114 ;	src/ws2812_driver.c: 76: masked_val = d & mask;
      00886D 88               [ 1]  115 	push	a
      00886E 14 04            [ 1]  116 	and	a, (0x04, sp)
      008870 97               [ 1]  117 	ld	xl, a
      008871 84               [ 1]  118 	pop	a
                                    119 ;	src/ws2812_driver.c: 79: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
      008872 72 15 50 0F      [ 1]  120 	bres	0x500F, #2
      008876 20 D4            [ 2]  121 	jra	00104$
                                    122 ;	src/ws2812_driver.c: 84: }
      008878 81               [ 4]  123 	ret
                                    124 ;	src/ws2812_driver.c: 87: void ws2812_send_pixel_24bits(uint8_t r, uint8_t g, uint8_t b)
                                    125 ;	-----------------------------------------
                                    126 ;	 function ws2812_send_pixel_24bits
                                    127 ;	-----------------------------------------
      008879                        128 _ws2812_send_pixel_24bits:
                                    129 ;	src/ws2812_driver.c: 93: ws2812_send_8bits(g);
      008879 7B 04            [ 1]  130 	ld	a, (0x04, sp)
      00887B 88               [ 1]  131 	push	a
      00887C CD 88 43         [ 4]  132 	call	_ws2812_send_8bits
      00887F 84               [ 1]  133 	pop	a
                                    134 ;	src/ws2812_driver.c: 94: ws2812_send_8bits(r);
      008880 7B 03            [ 1]  135 	ld	a, (0x03, sp)
      008882 88               [ 1]  136 	push	a
      008883 CD 88 43         [ 4]  137 	call	_ws2812_send_8bits
      008886 84               [ 1]  138 	pop	a
                                    139 ;	src/ws2812_driver.c: 96: ws2812_send_8bits(b);
      008887 7B 05            [ 1]  140 	ld	a, (0x05, sp)
      008889 88               [ 1]  141 	push	a
      00888A CD 88 43         [ 4]  142 	call	_ws2812_send_8bits
      00888D 84               [ 1]  143 	pop	a
                                    144 ;	src/ws2812_driver.c: 97: }
      00888E 81               [ 4]  145 	ret
                                    146 ;	src/ws2812_driver.c: 101: void ws2812_send_latch()
                                    147 ;	-----------------------------------------
                                    148 ;	 function ws2812_send_latch
                                    149 ;	-----------------------------------------
      00888F                        150 _ws2812_send_latch:
                                    151 ;	src/ws2812_driver.c: 103: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS));
      00888F 72 15 50 0F      [ 1]  152 	bres	0x500F, #2
                                    153 ;	src/ws2812_driver.c: 106: for(uint16_t wait = 0; wait < 130; wait++);
      008893 5F               [ 1]  154 	clrw	x
      008894                        155 00103$:
      008894 90 93            [ 1]  156 	ldw	y, x
      008896 90 A3 00 82      [ 2]  157 	cpw	y, #0x0082
      00889A 25 01            [ 1]  158 	jrc	00118$
      00889C 81               [ 4]  159 	ret
      00889D                        160 00118$:
      00889D 5C               [ 1]  161 	incw	x
      00889E 20 F4            [ 2]  162 	jra	00103$
                                    163 ;	src/ws2812_driver.c: 107: }
      0088A0 81               [ 4]  164 	ret
                                    165 	.area CODE
                                    166 	.area CONST
                                    167 	.area INITIALIZER
                                    168 	.area CABS (ABS)
