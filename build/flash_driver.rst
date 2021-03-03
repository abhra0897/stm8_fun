                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module flash_driver
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _spi_cs_idle
                                     12 	.globl _spi_cs_active
                                     13 	.globl _spi_read_8bits
                                     14 	.globl _spi_write_8bits
                                     15 	.globl _spi_write_24bits
                                     16 	.globl _flash_write_to_addr
                                     17 	.globl _flash_read_from_addr
                                     18 	.globl _flash_set_write_addr
                                     19 	.globl _flash_set_read_addr
                                     20 	.globl _flash_write_nbytes
                                     21 	.globl _flash_read_nbytes
                                     22 	.globl _flash_read_sreg
                                     23 	.globl _flash_write_sreg
                                     24 	.globl _flash_busy_wait
                                     25 	.globl _flash_erase_block
                                     26 	.globl _flash_write_enable
                                     27 	.globl _flash_erase_chip
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area INITIALIZED
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 
                                     41 ; default segment ordering for linker
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area CONST
                                     46 	.area INITIALIZER
                                     47 	.area CODE
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; global & static initialisations
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area GSINIT
                                     56 ;--------------------------------------------------------
                                     57 ; Home
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
                                     60 	.area HOME
                                     61 ;--------------------------------------------------------
                                     62 ; code
                                     63 ;--------------------------------------------------------
                                     64 	.area CODE
                                     65 ;	src/flash_driver.c: 13: void flash_write_to_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     66 ;	-----------------------------------------
                                     67 ;	 function flash_write_to_addr
                                     68 ;	-----------------------------------------
      008412                         69 _flash_write_to_addr:
                                     70 ;	src/flash_driver.c: 15: if (buff == NULL)
      008412 1E 07            [ 2]   71 	ldw	x, (0x07, sp)
      008414 26 01            [ 1]   72 	jrne	00102$
                                     73 ;	src/flash_driver.c: 16: return;
      008416 81               [ 4]   74 	ret
      008417                         75 00102$:
                                     76 ;	src/flash_driver.c: 17: spi_cs_active();
      008417 CD 85 EE         [ 4]   77 	call	_spi_cs_active
                                     78 ;	src/flash_driver.c: 18: flash_set_write_addr(addr);
      00841A 1E 05            [ 2]   79 	ldw	x, (0x05, sp)
      00841C 89               [ 2]   80 	pushw	x
      00841D 1E 05            [ 2]   81 	ldw	x, (0x05, sp)
      00841F 89               [ 2]   82 	pushw	x
      008420 CD 84 54         [ 4]   83 	call	_flash_set_write_addr
      008423 5B 04            [ 2]   84 	addw	sp, #4
                                     85 ;	src/flash_driver.c: 19: flash_write_nbytes(buff, nbytes);
      008425 1E 09            [ 2]   86 	ldw	x, (0x09, sp)
      008427 89               [ 2]   87 	pushw	x
      008428 1E 09            [ 2]   88 	ldw	x, (0x09, sp)
      00842A 89               [ 2]   89 	pushw	x
      00842B CD 84 78         [ 4]   90 	call	_flash_write_nbytes
      00842E 5B 04            [ 2]   91 	addw	sp, #4
                                     92 ;	src/flash_driver.c: 20: spi_cs_idle();
                                     93 ;	src/flash_driver.c: 21: }
      008430 CC 85 F3         [ 2]   94 	jp	_spi_cs_idle
                                     95 ;	src/flash_driver.c: 30: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     96 ;	-----------------------------------------
                                     97 ;	 function flash_read_from_addr
                                     98 ;	-----------------------------------------
      008433                         99 _flash_read_from_addr:
                                    100 ;	src/flash_driver.c: 32: if (buff == NULL)
      008433 1E 07            [ 2]  101 	ldw	x, (0x07, sp)
      008435 26 01            [ 1]  102 	jrne	00102$
                                    103 ;	src/flash_driver.c: 33: return;
      008437 81               [ 4]  104 	ret
      008438                        105 00102$:
                                    106 ;	src/flash_driver.c: 34: spi_cs_active();
      008438 CD 85 EE         [ 4]  107 	call	_spi_cs_active
                                    108 ;	src/flash_driver.c: 35: flash_set_read_addr(addr);
      00843B 1E 05            [ 2]  109 	ldw	x, (0x05, sp)
      00843D 89               [ 2]  110 	pushw	x
      00843E 1E 05            [ 2]  111 	ldw	x, (0x05, sp)
      008440 89               [ 2]  112 	pushw	x
      008441 CD 84 66         [ 4]  113 	call	_flash_set_read_addr
      008444 5B 04            [ 2]  114 	addw	sp, #4
                                    115 ;	src/flash_driver.c: 36: flash_read_nbytes(buff, nbytes);
      008446 1E 09            [ 2]  116 	ldw	x, (0x09, sp)
      008448 89               [ 2]  117 	pushw	x
      008449 1E 09            [ 2]  118 	ldw	x, (0x09, sp)
      00844B 89               [ 2]  119 	pushw	x
      00844C CD 84 98         [ 4]  120 	call	_flash_read_nbytes
      00844F 5B 04            [ 2]  121 	addw	sp, #4
                                    122 ;	src/flash_driver.c: 37: spi_cs_idle();
                                    123 ;	src/flash_driver.c: 38: }
      008451 CC 85 F3         [ 2]  124 	jp	_spi_cs_idle
                                    125 ;	src/flash_driver.c: 45: void flash_set_write_addr(uint32_t addr)
                                    126 ;	-----------------------------------------
                                    127 ;	 function flash_set_write_addr
                                    128 ;	-----------------------------------------
      008454                        129 _flash_set_write_addr:
                                    130 ;	src/flash_driver.c: 47: spi_write_8bits(CMD_PAGE_WRITE);
      008454 4B 02            [ 1]  131 	push	#0x02
      008456 CD 85 CC         [ 4]  132 	call	_spi_write_8bits
      008459 84               [ 1]  133 	pop	a
                                    134 ;	src/flash_driver.c: 48: spi_write_24bits(addr);
      00845A 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      00845C 89               [ 2]  136 	pushw	x
      00845D 1E 05            [ 2]  137 	ldw	x, (0x05, sp)
      00845F 89               [ 2]  138 	pushw	x
      008460 CD 85 A0         [ 4]  139 	call	_spi_write_24bits
      008463 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	src/flash_driver.c: 49: }
      008465 81               [ 4]  142 	ret
                                    143 ;	src/flash_driver.c: 56: void flash_set_read_addr(uint32_t addr)
                                    144 ;	-----------------------------------------
                                    145 ;	 function flash_set_read_addr
                                    146 ;	-----------------------------------------
      008466                        147 _flash_set_read_addr:
                                    148 ;	src/flash_driver.c: 58: spi_write_8bits(CMD_READ_ARRAY);
      008466 4B 03            [ 1]  149 	push	#0x03
      008468 CD 85 CC         [ 4]  150 	call	_spi_write_8bits
      00846B 84               [ 1]  151 	pop	a
                                    152 ;	src/flash_driver.c: 59: spi_write_24bits(addr);
      00846C 1E 05            [ 2]  153 	ldw	x, (0x05, sp)
      00846E 89               [ 2]  154 	pushw	x
      00846F 1E 05            [ 2]  155 	ldw	x, (0x05, sp)
      008471 89               [ 2]  156 	pushw	x
      008472 CD 85 A0         [ 4]  157 	call	_spi_write_24bits
      008475 5B 04            [ 2]  158 	addw	sp, #4
                                    159 ;	src/flash_driver.c: 60: }
      008477 81               [ 4]  160 	ret
                                    161 ;	src/flash_driver.c: 71: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
                                    162 ;	-----------------------------------------
                                    163 ;	 function flash_write_nbytes
                                    164 ;	-----------------------------------------
      008478                        165 _flash_write_nbytes:
                                    166 ;	src/flash_driver.c: 73: if (buff == NULL)
      008478 1E 03            [ 2]  167 	ldw	x, (0x03, sp)
      00847A 26 01            [ 1]  168 	jrne	00118$
                                    169 ;	src/flash_driver.c: 74: return;
      00847C 81               [ 4]  170 	ret
                                    171 ;	src/flash_driver.c: 76: while (i < nbytes)
      00847D                        172 00118$:
      00847D 5F               [ 1]  173 	clrw	x
      00847E                        174 00109$:
      00847E 13 05            [ 2]  175 	cpw	x, (0x05, sp)
      008480 25 01            [ 1]  176 	jrc	00141$
      008482 81               [ 4]  177 	ret
      008483                        178 00141$:
                                    179 ;	src/flash_driver.c: 78: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
      008483 90 93            [ 1]  180 	ldw	y, x
      008485 72 F9 03         [ 2]  181 	addw	y, (0x03, sp)
      008488 90 F6            [ 1]  182 	ld	a, (y)
      00848A C7 52 04         [ 1]  183 	ld	0x5204, a
      00848D                        184 00103$:
      00848D C6 52 03         [ 1]  185 	ld	a, 0x5203
      008490 A5 02            [ 1]  186 	bcp	a, #0x02
      008492 27 F9            [ 1]  187 	jreq	00103$
                                    188 ;	src/flash_driver.c: 79: i++;
      008494 5C               [ 1]  189 	incw	x
      008495 20 E7            [ 2]  190 	jra	00109$
                                    191 ;	src/flash_driver.c: 81: }
      008497 81               [ 4]  192 	ret
                                    193 ;	src/flash_driver.c: 92: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
                                    194 ;	-----------------------------------------
                                    195 ;	 function flash_read_nbytes
                                    196 ;	-----------------------------------------
      008498                        197 _flash_read_nbytes:
                                    198 ;	src/flash_driver.c: 94: if (buff == NULL)
      008498 1E 03            [ 2]  199 	ldw	x, (0x03, sp)
      00849A 26 01            [ 1]  200 	jrne	00125$
                                    201 ;	src/flash_driver.c: 95: return;
      00849C 81               [ 4]  202 	ret
                                    203 ;	src/flash_driver.c: 97: while (i < nbytes)
      00849D                        204 00125$:
      00849D 5F               [ 1]  205 	clrw	x
      00849E                        206 00115$:
      00849E 13 05            [ 2]  207 	cpw	x, (0x05, sp)
      0084A0 25 01            [ 1]  208 	jrc	00152$
      0084A2 81               [ 4]  209 	ret
      0084A3                        210 00152$:
                                    211 ;	src/flash_driver.c: 99: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
      0084A3 35 1A 52 04      [ 1]  212 	mov	0x5204+0, #0x1a
      0084A7                        213 00103$:
      0084A7 C6 52 03         [ 1]  214 	ld	a, 0x5203
      0084AA A5 02            [ 1]  215 	bcp	a, #0x02
      0084AC 27 F9            [ 1]  216 	jreq	00103$
      0084AE                        217 00109$:
      0084AE C6 52 03         [ 1]  218 	ld	a, 0x5203
      0084B1 44               [ 1]  219 	srl	a
      0084B2 24 FA            [ 1]  220 	jrnc	00109$
      0084B4 90 93            [ 1]  221 	ldw	y, x
      0084B6 72 F9 03         [ 2]  222 	addw	y, (0x03, sp)
      0084B9 C6 52 04         [ 1]  223 	ld	a, 0x5204
      0084BC 90 F7            [ 1]  224 	ld	(y), a
                                    225 ;	src/flash_driver.c: 100: i++;
      0084BE 5C               [ 1]  226 	incw	x
      0084BF 20 DD            [ 2]  227 	jra	00115$
                                    228 ;	src/flash_driver.c: 102: }
      0084C1 81               [ 4]  229 	ret
                                    230 ;	src/flash_driver.c: 110: uint8_t flash_read_sreg(uint8_t sreg_no)
                                    231 ;	-----------------------------------------
                                    232 ;	 function flash_read_sreg
                                    233 ;	-----------------------------------------
      0084C2                        234 _flash_read_sreg:
      0084C2 88               [ 1]  235 	push	a
                                    236 ;	src/flash_driver.c: 112: uint8_t sreg_val = 0; 
      0084C3 0F 01            [ 1]  237 	clr	(0x01, sp)
                                    238 ;	src/flash_driver.c: 114: if (sreg_no == 1 || sreg_no == 2)
      0084C5 7B 04            [ 1]  239 	ld	a, (0x04, sp)
      0084C7 4A               [ 1]  240 	dec	a
      0084C8 26 03            [ 1]  241 	jrne	00120$
      0084CA A6 01            [ 1]  242 	ld	a, #0x01
      0084CC 21                     243 	.byte 0x21
      0084CD                        244 00120$:
      0084CD 4F               [ 1]  245 	clr	a
      0084CE                        246 00121$:
      0084CE 4D               [ 1]  247 	tnz	a
      0084CF 26 08            [ 1]  248 	jrne	00104$
      0084D1 88               [ 1]  249 	push	a
      0084D2 7B 05            [ 1]  250 	ld	a, (0x05, sp)
      0084D4 A1 02            [ 1]  251 	cp	a, #0x02
      0084D6 84               [ 1]  252 	pop	a
      0084D7 26 1E            [ 1]  253 	jrne	00105$
      0084D9                        254 00104$:
                                    255 ;	src/flash_driver.c: 116: spi_cs_active();
      0084D9 88               [ 1]  256 	push	a
      0084DA CD 85 EE         [ 4]  257 	call	_spi_cs_active
      0084DD 84               [ 1]  258 	pop	a
                                    259 ;	src/flash_driver.c: 117: if (sreg_no == 1)
      0084DE 4D               [ 1]  260 	tnz	a
      0084DF 27 08            [ 1]  261 	jreq	00102$
                                    262 ;	src/flash_driver.c: 118: spi_write_8bits(CMD_READ_SREG_BYTE1);
      0084E1 4B 05            [ 1]  263 	push	#0x05
      0084E3 CD 85 CC         [ 4]  264 	call	_spi_write_8bits
      0084E6 84               [ 1]  265 	pop	a
      0084E7 20 06            [ 2]  266 	jra	00103$
      0084E9                        267 00102$:
                                    268 ;	src/flash_driver.c: 120: spi_write_8bits(CMD_READ_SREG_BYTE2);
      0084E9 4B 35            [ 1]  269 	push	#0x35
      0084EB CD 85 CC         [ 4]  270 	call	_spi_write_8bits
      0084EE 84               [ 1]  271 	pop	a
      0084EF                        272 00103$:
                                    273 ;	src/flash_driver.c: 122: sreg_val = spi_read_8bits();
      0084EF CD 85 D9         [ 4]  274 	call	_spi_read_8bits
      0084F2 6B 01            [ 1]  275 	ld	(0x01, sp), a
                                    276 ;	src/flash_driver.c: 123: spi_cs_idle();
      0084F4 CD 85 F3         [ 4]  277 	call	_spi_cs_idle
      0084F7                        278 00105$:
                                    279 ;	src/flash_driver.c: 126: return sreg_val;
      0084F7 7B 01            [ 1]  280 	ld	a, (0x01, sp)
                                    281 ;	src/flash_driver.c: 127: }
      0084F9 5B 01            [ 2]  282 	addw	sp, #1
      0084FB 81               [ 4]  283 	ret
                                    284 ;	src/flash_driver.c: 135: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
                                    285 ;	-----------------------------------------
                                    286 ;	 function flash_write_sreg
                                    287 ;	-----------------------------------------
      0084FC                        288 _flash_write_sreg:
                                    289 ;	src/flash_driver.c: 137: spi_cs_active();
      0084FC CD 85 EE         [ 4]  290 	call	_spi_cs_active
                                    291 ;	src/flash_driver.c: 138: spi_write_8bits(CMD_WRITE_SREG);
      0084FF 4B 01            [ 1]  292 	push	#0x01
      008501 CD 85 CC         [ 4]  293 	call	_spi_write_8bits
      008504 84               [ 1]  294 	pop	a
                                    295 ;	src/flash_driver.c: 139: spi_write_8bits(sreg_byte1);
      008505 7B 03            [ 1]  296 	ld	a, (0x03, sp)
      008507 88               [ 1]  297 	push	a
      008508 CD 85 CC         [ 4]  298 	call	_spi_write_8bits
      00850B 84               [ 1]  299 	pop	a
                                    300 ;	src/flash_driver.c: 140: spi_write_8bits(sreg_byte2);
      00850C 7B 04            [ 1]  301 	ld	a, (0x04, sp)
      00850E 88               [ 1]  302 	push	a
      00850F CD 85 CC         [ 4]  303 	call	_spi_write_8bits
      008512 84               [ 1]  304 	pop	a
                                    305 ;	src/flash_driver.c: 141: spi_cs_idle();
                                    306 ;	src/flash_driver.c: 142: }
      008513 CC 85 F3         [ 2]  307 	jp	_spi_cs_idle
                                    308 ;	src/flash_driver.c: 148: void flash_busy_wait()
                                    309 ;	-----------------------------------------
                                    310 ;	 function flash_busy_wait
                                    311 ;	-----------------------------------------
      008516                        312 _flash_busy_wait:
                                    313 ;	src/flash_driver.c: 150: while (flash_read_sreg(1) & (1 << SREG_BYTE1_BSY));
      008516                        314 00101$:
      008516 4B 01            [ 1]  315 	push	#0x01
      008518 CD 84 C2         [ 4]  316 	call	_flash_read_sreg
      00851B 5B 01            [ 2]  317 	addw	sp, #1
      00851D 44               [ 1]  318 	srl	a
      00851E 25 F6            [ 1]  319 	jrc	00101$
                                    320 ;	src/flash_driver.c: 151: }
      008520 81               [ 4]  321 	ret
                                    322 ;	src/flash_driver.c: 160: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
                                    323 ;	-----------------------------------------
                                    324 ;	 function flash_erase_block
                                    325 ;	-----------------------------------------
      008521                        326 _flash_erase_block:
                                    327 ;	src/flash_driver.c: 162: spi_cs_active();
      008521 CD 85 EE         [ 4]  328 	call	_spi_cs_active
                                    329 ;	src/flash_driver.c: 163: spi_write_8bits(cmd_block_erase);
      008524 7B 07            [ 1]  330 	ld	a, (0x07, sp)
      008526 88               [ 1]  331 	push	a
      008527 CD 85 CC         [ 4]  332 	call	_spi_write_8bits
      00852A 84               [ 1]  333 	pop	a
                                    334 ;	src/flash_driver.c: 164: spi_write_24bits(addr);
      00852B 1E 05            [ 2]  335 	ldw	x, (0x05, sp)
      00852D 89               [ 2]  336 	pushw	x
      00852E 1E 05            [ 2]  337 	ldw	x, (0x05, sp)
      008530 89               [ 2]  338 	pushw	x
      008531 CD 85 A0         [ 4]  339 	call	_spi_write_24bits
      008534 5B 04            [ 2]  340 	addw	sp, #4
                                    341 ;	src/flash_driver.c: 165: spi_cs_idle();
                                    342 ;	src/flash_driver.c: 166: }
      008536 CC 85 F3         [ 2]  343 	jp	_spi_cs_idle
                                    344 ;	src/flash_driver.c: 172: void flash_write_enable()
                                    345 ;	-----------------------------------------
                                    346 ;	 function flash_write_enable
                                    347 ;	-----------------------------------------
      008539                        348 _flash_write_enable:
                                    349 ;	src/flash_driver.c: 174: spi_cs_active();
      008539 CD 85 EE         [ 4]  350 	call	_spi_cs_active
                                    351 ;	src/flash_driver.c: 175: spi_write_8bits(CMD_WRITE_ENABLE);
      00853C 4B 06            [ 1]  352 	push	#0x06
      00853E CD 85 CC         [ 4]  353 	call	_spi_write_8bits
      008541 84               [ 1]  354 	pop	a
                                    355 ;	src/flash_driver.c: 176: spi_cs_idle();
                                    356 ;	src/flash_driver.c: 177: }
      008542 CC 85 F3         [ 2]  357 	jp	_spi_cs_idle
                                    358 ;	src/flash_driver.c: 182: void flash_erase_chip()
                                    359 ;	-----------------------------------------
                                    360 ;	 function flash_erase_chip
                                    361 ;	-----------------------------------------
      008545                        362 _flash_erase_chip:
                                    363 ;	src/flash_driver.c: 184: spi_cs_active();
      008545 CD 85 EE         [ 4]  364 	call	_spi_cs_active
                                    365 ;	src/flash_driver.c: 185: spi_write_8bits(CMD_CHIP_ERASE);
      008548 4B 60            [ 1]  366 	push	#0x60
      00854A CD 85 CC         [ 4]  367 	call	_spi_write_8bits
      00854D 84               [ 1]  368 	pop	a
                                    369 ;	src/flash_driver.c: 186: spi_cs_idle();
                                    370 ;	src/flash_driver.c: 187: }
      00854E CC 85 F3         [ 2]  371 	jp	_spi_cs_idle
                                    372 	.area CODE
                                    373 	.area CONST
                                    374 	.area INITIALIZER
                                    375 	.area CABS (ABS)
