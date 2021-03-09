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
                                     13 	.globl _ws2812_send_reset
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	src/ws2812_driver.c: 4: void ws2812_gpio_config()
                                     52 ;	-----------------------------------------
                                     53 ;	 function ws2812_gpio_config
                                     54 ;	-----------------------------------------
      0085B8                         55 _ws2812_gpio_config:
                                     56 ;	src/ws2812_driver.c: 6: PORT(WS2812_PORT, DDR) |= (1 << WS2812_PIN_POS); // WS2812_pin is output
      0085B8 72 14 50 11      [ 1]   57 	bset	20497, #2
                                     58 ;	src/ws2812_driver.c: 7: PORT(WS2812_PORT, CR1) |= (1 << WS2812_PIN_POS); // Push-pull mode  
      0085BC 72 14 50 12      [ 1]   59 	bset	20498, #2
                                     60 ;	src/ws2812_driver.c: 9: PORT(WS2812_PORT, ODR) |= (1 << WS2812_PIN_POS); // Low (as ws2812 looks for logic high)
      0085C0 72 14 50 0F      [ 1]   61 	bset	20495, #2
                                     62 ;	src/ws2812_driver.c: 10: }
      0085C4 81               [ 4]   63 	ret
                                     64 ;	src/ws2812_driver.c: 13: void ws2812_send_8bits(uint8_t d)
                                     65 ;	-----------------------------------------
                                     66 ;	 function ws2812_send_8bits
                                     67 ;	-----------------------------------------
      0085C5                         68 _ws2812_send_8bits:
                                     69 ;	src/ws2812_driver.c: 35: uint8_t mask = 0x80;
      0085C5 A6 80            [ 1]   70 	ld	a, #0x80
                                     71 ;	src/ws2812_driver.c: 36: uint8_t masked_val = d & mask;
      0085C7 88               [ 1]   72 	push	a
      0085C8 7B 04            [ 1]   73 	ld	a, (0x04, sp)
      0085CA A4 80            [ 1]   74 	and	a, #0x80
      0085CC 97               [ 1]   75 	ld	xl, a
      0085CD 84               [ 1]   76 	pop	a
                                     77 ;	src/ws2812_driver.c: 37: while (mask) 
      0085CE                         78 00104$:
      0085CE 4D               [ 1]   79 	tnz	a
      0085CF 26 01            [ 1]   80 	jrne	00124$
      0085D1 81               [ 4]   81 	ret
      0085D2                         82 00124$:
                                     83 ;	src/ws2812_driver.c: 53: mask >>= 1;
      0085D2 44               [ 1]   84 	srl	a
                                     85 ;	src/ws2812_driver.c: 39: if (masked_val) 
      0085D3 41               [ 1]   86 	exg	a, xl
      0085D4 4D               [ 1]   87 	tnz	a
      0085D5 41               [ 1]   88 	exg	a, xl
      0085D6 27 13            [ 1]   89 	jreq	00102$
                                     90 ;	src/ws2812_driver.c: 49: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
      0085D8 72 14 50 0F      [ 1]   91 	bset	0x500F, #2
                                     92 ;	src/ws2812_driver.c: 52: nop(); nop(); nop(); nop();
      0085DC 9D               [ 1]   93 	nop
      0085DD 9D               [ 1]   94 	nop
      0085DE 9D               [ 1]   95 	nop
      0085DF 9D               [ 1]   96 	nop
                                     97 ;	src/ws2812_driver.c: 53: mask >>= 1;
                                     98 ;	src/ws2812_driver.c: 54: masked_val = d & mask;
      0085E0 88               [ 1]   99 	push	a
      0085E1 14 04            [ 1]  100 	and	a, (0x04, sp)
      0085E3 97               [ 1]  101 	ld	xl, a
      0085E4 84               [ 1]  102 	pop	a
                                    103 ;	src/ws2812_driver.c: 58: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
      0085E5 72 15 50 0F      [ 1]  104 	bres	0x500F, #2
      0085E9 20 E3            [ 2]  105 	jra	00104$
      0085EB                        106 00102$:
                                    107 ;	src/ws2812_driver.c: 73: __asm__("bset " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bset 0x5007, #5")
      0085EB 72 14 50 0F      [ 1]  108 	bset	0x500F, #2
                                    109 ;	src/ws2812_driver.c: 77: mask >>= 1;
                                    110 ;	src/ws2812_driver.c: 78: masked_val = d & mask;
      0085EF 88               [ 1]  111 	push	a
      0085F0 14 04            [ 1]  112 	and	a, (0x04, sp)
      0085F2 97               [ 1]  113 	ld	xl, a
      0085F3 84               [ 1]  114 	pop	a
                                    115 ;	src/ws2812_driver.c: 81: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS)); // __asm__("bres 0x5007, #5")
      0085F4 72 15 50 0F      [ 1]  116 	bres	0x500F, #2
      0085F8 20 D4            [ 2]  117 	jra	00104$
                                    118 ;	src/ws2812_driver.c: 86: }
      0085FA 81               [ 4]  119 	ret
                                    120 ;	src/ws2812_driver.c: 89: void ws2812_send_reset()
                                    121 ;	-----------------------------------------
                                    122 ;	 function ws2812_send_reset
                                    123 ;	-----------------------------------------
      0085FB                        124 _ws2812_send_reset:
                                    125 ;	src/ws2812_driver.c: 91: __asm__("bres " XSTR(WS2812_ODR_ADDR) ", #" XSTR(WS2812_PIN_POS));
      0085FB 72 15 50 0F      [ 1]  126 	bres	0x500F, #2
                                    127 ;	src/ws2812_driver.c: 94: for(uint16_t wait = 0; wait < 130; wait++);
      0085FF 5F               [ 1]  128 	clrw	x
      008600                        129 00103$:
      008600 90 93            [ 1]  130 	ldw	y, x
      008602 90 A3 00 82      [ 2]  131 	cpw	y, #0x0082
      008606 25 01            [ 1]  132 	jrc	00118$
      008608 81               [ 4]  133 	ret
      008609                        134 00118$:
      008609 5C               [ 1]  135 	incw	x
      00860A 20 F4            [ 2]  136 	jra	00103$
                                    137 ;	src/ws2812_driver.c: 95: }
      00860C 81               [ 4]  138 	ret
                                    139 	.area CODE
                                    140 	.area CONST
                                    141 	.area INITIALIZER
                                    142 	.area CABS (ABS)
