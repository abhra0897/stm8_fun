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
      0083A7                         69 _flash_write_to_addr:
                                     70 ;	src/flash_driver.c: 15: if (buff == NULL)
      0083A7 1E 07            [ 2]   71 	ldw	x, (0x07, sp)
      0083A9 26 01            [ 1]   72 	jrne	00102$
                                     73 ;	src/flash_driver.c: 16: return;
      0083AB 81               [ 4]   74 	ret
      0083AC                         75 00102$:
                                     76 ;	src/flash_driver.c: 17: spi_cs_active();
      0083AC CD 85 A9         [ 4]   77 	call	_spi_cs_active
                                     78 ;	src/flash_driver.c: 18: flash_set_write_addr(addr);
      0083AF 1E 05            [ 2]   79 	ldw	x, (0x05, sp)
      0083B1 89               [ 2]   80 	pushw	x
      0083B2 1E 05            [ 2]   81 	ldw	x, (0x05, sp)
      0083B4 89               [ 2]   82 	pushw	x
      0083B5 CD 83 E9         [ 4]   83 	call	_flash_set_write_addr
      0083B8 5B 04            [ 2]   84 	addw	sp, #4
                                     85 ;	src/flash_driver.c: 19: flash_write_nbytes(buff, nbytes);
      0083BA 1E 09            [ 2]   86 	ldw	x, (0x09, sp)
      0083BC 89               [ 2]   87 	pushw	x
      0083BD 1E 09            [ 2]   88 	ldw	x, (0x09, sp)
      0083BF 89               [ 2]   89 	pushw	x
      0083C0 CD 84 0D         [ 4]   90 	call	_flash_write_nbytes
      0083C3 5B 04            [ 2]   91 	addw	sp, #4
                                     92 ;	src/flash_driver.c: 20: spi_cs_idle();
                                     93 ;	src/flash_driver.c: 21: }
      0083C5 CC 85 AE         [ 2]   94 	jp	_spi_cs_idle
                                     95 ;	src/flash_driver.c: 30: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     96 ;	-----------------------------------------
                                     97 ;	 function flash_read_from_addr
                                     98 ;	-----------------------------------------
      0083C8                         99 _flash_read_from_addr:
                                    100 ;	src/flash_driver.c: 32: if (buff == NULL)
      0083C8 1E 07            [ 2]  101 	ldw	x, (0x07, sp)
      0083CA 26 01            [ 1]  102 	jrne	00102$
                                    103 ;	src/flash_driver.c: 33: return;
      0083CC 81               [ 4]  104 	ret
      0083CD                        105 00102$:
                                    106 ;	src/flash_driver.c: 34: spi_cs_active();
      0083CD CD 85 A9         [ 4]  107 	call	_spi_cs_active
                                    108 ;	src/flash_driver.c: 35: flash_set_read_addr(addr);
      0083D0 1E 05            [ 2]  109 	ldw	x, (0x05, sp)
      0083D2 89               [ 2]  110 	pushw	x
      0083D3 1E 05            [ 2]  111 	ldw	x, (0x05, sp)
      0083D5 89               [ 2]  112 	pushw	x
      0083D6 CD 83 FB         [ 4]  113 	call	_flash_set_read_addr
      0083D9 5B 04            [ 2]  114 	addw	sp, #4
                                    115 ;	src/flash_driver.c: 36: flash_read_nbytes(buff, nbytes);
      0083DB 1E 09            [ 2]  116 	ldw	x, (0x09, sp)
      0083DD 89               [ 2]  117 	pushw	x
      0083DE 1E 09            [ 2]  118 	ldw	x, (0x09, sp)
      0083E0 89               [ 2]  119 	pushw	x
      0083E1 CD 84 30         [ 4]  120 	call	_flash_read_nbytes
      0083E4 5B 04            [ 2]  121 	addw	sp, #4
                                    122 ;	src/flash_driver.c: 37: spi_cs_idle();
                                    123 ;	src/flash_driver.c: 38: }
      0083E6 CC 85 AE         [ 2]  124 	jp	_spi_cs_idle
                                    125 ;	src/flash_driver.c: 45: void flash_set_write_addr(uint32_t addr)
                                    126 ;	-----------------------------------------
                                    127 ;	 function flash_set_write_addr
                                    128 ;	-----------------------------------------
      0083E9                        129 _flash_set_write_addr:
                                    130 ;	src/flash_driver.c: 47: spi_write_8bits(CMD_PAGE_WRITE);
      0083E9 4B 02            [ 1]  131 	push	#0x02
      0083EB CD 85 7D         [ 4]  132 	call	_spi_write_8bits
      0083EE 84               [ 1]  133 	pop	a
                                    134 ;	src/flash_driver.c: 48: spi_write_24bits(addr);
      0083EF 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      0083F1 89               [ 2]  136 	pushw	x
      0083F2 1E 05            [ 2]  137 	ldw	x, (0x05, sp)
      0083F4 89               [ 2]  138 	pushw	x
      0083F5 CD 85 4C         [ 4]  139 	call	_spi_write_24bits
      0083F8 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	src/flash_driver.c: 49: }
      0083FA 81               [ 4]  142 	ret
                                    143 ;	src/flash_driver.c: 56: void flash_set_read_addr(uint32_t addr)
                                    144 ;	-----------------------------------------
                                    145 ;	 function flash_set_read_addr
                                    146 ;	-----------------------------------------
      0083FB                        147 _flash_set_read_addr:
                                    148 ;	src/flash_driver.c: 58: spi_write_8bits(CMD_READ_ARRAY);
      0083FB 4B 03            [ 1]  149 	push	#0x03
      0083FD CD 85 7D         [ 4]  150 	call	_spi_write_8bits
      008400 84               [ 1]  151 	pop	a
                                    152 ;	src/flash_driver.c: 59: spi_write_24bits(addr);
      008401 1E 05            [ 2]  153 	ldw	x, (0x05, sp)
      008403 89               [ 2]  154 	pushw	x
      008404 1E 05            [ 2]  155 	ldw	x, (0x05, sp)
      008406 89               [ 2]  156 	pushw	x
      008407 CD 85 4C         [ 4]  157 	call	_spi_write_24bits
      00840A 5B 04            [ 2]  158 	addw	sp, #4
                                    159 ;	src/flash_driver.c: 60: }
      00840C 81               [ 4]  160 	ret
                                    161 ;	src/flash_driver.c: 71: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
                                    162 ;	-----------------------------------------
                                    163 ;	 function flash_write_nbytes
                                    164 ;	-----------------------------------------
      00840D                        165 _flash_write_nbytes:
                                    166 ;	src/flash_driver.c: 73: if (buff == NULL)
      00840D 1E 03            [ 2]  167 	ldw	x, (0x03, sp)
      00840F 26 01            [ 1]  168 	jrne	00118$
                                    169 ;	src/flash_driver.c: 74: return;
      008411 81               [ 4]  170 	ret
                                    171 ;	src/flash_driver.c: 76: while (i < nbytes)
      008412                        172 00118$:
      008412 5F               [ 1]  173 	clrw	x
      008413                        174 00109$:
      008413 13 05            [ 2]  175 	cpw	x, (0x05, sp)
      008415 25 01            [ 1]  176 	jrc	00141$
      008417 81               [ 4]  177 	ret
      008418                        178 00141$:
                                    179 ;	src/flash_driver.c: 78: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
      008418 90 93            [ 1]  180 	ldw	y, x
      00841A 72 F9 03         [ 2]  181 	addw	y, (0x03, sp)
      00841D 90 F6            [ 1]  182 	ld	a, (y)
      00841F C7 52 04         [ 1]  183 	ld	0x5204, a
      008422                        184 00103$:
      008422 C6 52 03         [ 1]  185 	ld	a, 0x5203
      008425 A5 02            [ 1]  186 	bcp	a, #0x02
      008427 27 F9            [ 1]  187 	jreq	00103$
      008429 C6 52 04         [ 1]  188 	ld	a, 0x5204
                                    189 ;	src/flash_driver.c: 79: i++;
      00842C 5C               [ 1]  190 	incw	x
      00842D 20 E4            [ 2]  191 	jra	00109$
                                    192 ;	src/flash_driver.c: 81: }
      00842F 81               [ 4]  193 	ret
                                    194 ;	src/flash_driver.c: 92: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
                                    195 ;	-----------------------------------------
                                    196 ;	 function flash_read_nbytes
                                    197 ;	-----------------------------------------
      008430                        198 _flash_read_nbytes:
                                    199 ;	src/flash_driver.c: 94: if (buff == NULL)
      008430 1E 03            [ 2]  200 	ldw	x, (0x03, sp)
      008432 26 01            [ 1]  201 	jrne	00126$
                                    202 ;	src/flash_driver.c: 95: return;
      008434 81               [ 4]  203 	ret
                                    204 ;	src/flash_driver.c: 97: while (i < nbytes)
      008435                        205 00126$:
      008435 5F               [ 1]  206 	clrw	x
      008436                        207 00115$:
      008436 13 05            [ 2]  208 	cpw	x, (0x05, sp)
      008438 25 01            [ 1]  209 	jrc	00157$
      00843A 81               [ 4]  210 	ret
      00843B                        211 00157$:
                                    212 ;	src/flash_driver.c: 99: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
      00843B 35 FF 52 04      [ 1]  213 	mov	0x5204+0, #0xff
      00843F                        214 00103$:
      00843F C6 52 03         [ 1]  215 	ld	a, 0x5203
      008442 A5 02            [ 1]  216 	bcp	a, #0x02
      008444 27 F9            [ 1]  217 	jreq	00103$
      008446 C6 52 04         [ 1]  218 	ld	a, 0x5204
      008449                        219 00109$:
      008449 C6 52 03         [ 1]  220 	ld	a, 0x5203
      00844C 44               [ 1]  221 	srl	a
      00844D 24 FA            [ 1]  222 	jrnc	00109$
      00844F 90 93            [ 1]  223 	ldw	y, x
      008451 72 F9 03         [ 2]  224 	addw	y, (0x03, sp)
      008454 C6 52 04         [ 1]  225 	ld	a, 0x5204
      008457 90 F7            [ 1]  226 	ld	(y), a
      008459 C6 52 04         [ 1]  227 	ld	a, 0x5204
      00845C 90 F7            [ 1]  228 	ld	(y), a
                                    229 ;	src/flash_driver.c: 100: i++;
      00845E 5C               [ 1]  230 	incw	x
      00845F 20 D5            [ 2]  231 	jra	00115$
                                    232 ;	src/flash_driver.c: 102: }
      008461 81               [ 4]  233 	ret
                                    234 ;	src/flash_driver.c: 110: uint8_t flash_read_sreg(uint8_t sreg_no)
                                    235 ;	-----------------------------------------
                                    236 ;	 function flash_read_sreg
                                    237 ;	-----------------------------------------
      008462                        238 _flash_read_sreg:
      008462 88               [ 1]  239 	push	a
                                    240 ;	src/flash_driver.c: 112: uint8_t sreg_val = 0; 
      008463 0F 01            [ 1]  241 	clr	(0x01, sp)
                                    242 ;	src/flash_driver.c: 114: if (sreg_no == 1 || sreg_no == 2)
      008465 7B 04            [ 1]  243 	ld	a, (0x04, sp)
      008467 4A               [ 1]  244 	dec	a
      008468 26 03            [ 1]  245 	jrne	00120$
      00846A A6 01            [ 1]  246 	ld	a, #0x01
      00846C 21                     247 	.byte 0x21
      00846D                        248 00120$:
      00846D 4F               [ 1]  249 	clr	a
      00846E                        250 00121$:
      00846E 4D               [ 1]  251 	tnz	a
      00846F 26 08            [ 1]  252 	jrne	00104$
      008471 88               [ 1]  253 	push	a
      008472 7B 05            [ 1]  254 	ld	a, (0x05, sp)
      008474 A1 02            [ 1]  255 	cp	a, #0x02
      008476 84               [ 1]  256 	pop	a
      008477 26 1E            [ 1]  257 	jrne	00105$
      008479                        258 00104$:
                                    259 ;	src/flash_driver.c: 116: spi_cs_active();
      008479 88               [ 1]  260 	push	a
      00847A CD 85 A9         [ 4]  261 	call	_spi_cs_active
      00847D 84               [ 1]  262 	pop	a
                                    263 ;	src/flash_driver.c: 117: if (sreg_no == 1)
      00847E 4D               [ 1]  264 	tnz	a
      00847F 27 08            [ 1]  265 	jreq	00102$
                                    266 ;	src/flash_driver.c: 118: spi_write_8bits(CMD_READ_SREG_BYTE1);
      008481 4B 05            [ 1]  267 	push	#0x05
      008483 CD 85 7D         [ 4]  268 	call	_spi_write_8bits
      008486 84               [ 1]  269 	pop	a
      008487 20 06            [ 2]  270 	jra	00103$
      008489                        271 00102$:
                                    272 ;	src/flash_driver.c: 120: spi_write_8bits(CMD_READ_SREG_BYTE2);
      008489 4B 35            [ 1]  273 	push	#0x35
      00848B CD 85 7D         [ 4]  274 	call	_spi_write_8bits
      00848E 84               [ 1]  275 	pop	a
      00848F                        276 00103$:
                                    277 ;	src/flash_driver.c: 122: sreg_val = spi_read_8bits();
      00848F CD 85 8E         [ 4]  278 	call	_spi_read_8bits
      008492 6B 01            [ 1]  279 	ld	(0x01, sp), a
                                    280 ;	src/flash_driver.c: 123: spi_cs_idle();
      008494 CD 85 AE         [ 4]  281 	call	_spi_cs_idle
      008497                        282 00105$:
                                    283 ;	src/flash_driver.c: 126: return sreg_val;
      008497 7B 01            [ 1]  284 	ld	a, (0x01, sp)
                                    285 ;	src/flash_driver.c: 127: }
      008499 5B 01            [ 2]  286 	addw	sp, #1
      00849B 81               [ 4]  287 	ret
                                    288 ;	src/flash_driver.c: 135: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
                                    289 ;	-----------------------------------------
                                    290 ;	 function flash_write_sreg
                                    291 ;	-----------------------------------------
      00849C                        292 _flash_write_sreg:
                                    293 ;	src/flash_driver.c: 137: spi_cs_active();
      00849C CD 85 A9         [ 4]  294 	call	_spi_cs_active
                                    295 ;	src/flash_driver.c: 138: spi_write_8bits(CMD_WRITE_SREG);
      00849F 4B 01            [ 1]  296 	push	#0x01
      0084A1 CD 85 7D         [ 4]  297 	call	_spi_write_8bits
      0084A4 84               [ 1]  298 	pop	a
                                    299 ;	src/flash_driver.c: 139: spi_write_8bits(sreg_byte1);
      0084A5 7B 03            [ 1]  300 	ld	a, (0x03, sp)
      0084A7 88               [ 1]  301 	push	a
      0084A8 CD 85 7D         [ 4]  302 	call	_spi_write_8bits
      0084AB 84               [ 1]  303 	pop	a
                                    304 ;	src/flash_driver.c: 140: spi_write_8bits(sreg_byte2);
      0084AC 7B 04            [ 1]  305 	ld	a, (0x04, sp)
      0084AE 88               [ 1]  306 	push	a
      0084AF CD 85 7D         [ 4]  307 	call	_spi_write_8bits
      0084B2 84               [ 1]  308 	pop	a
                                    309 ;	src/flash_driver.c: 141: spi_cs_idle();
                                    310 ;	src/flash_driver.c: 142: }
      0084B3 CC 85 AE         [ 2]  311 	jp	_spi_cs_idle
                                    312 ;	src/flash_driver.c: 148: void flash_busy_wait()
                                    313 ;	-----------------------------------------
                                    314 ;	 function flash_busy_wait
                                    315 ;	-----------------------------------------
      0084B6                        316 _flash_busy_wait:
                                    317 ;	src/flash_driver.c: 153: do
      0084B6                        318 00101$:
                                    319 ;	src/flash_driver.c: 155: sreg_val = flash_read_sreg(1);
      0084B6 4B 01            [ 1]  320 	push	#0x01
      0084B8 CD 84 62         [ 4]  321 	call	_flash_read_sreg
      0084BB 5B 01            [ 2]  322 	addw	sp, #1
                                    323 ;	src/flash_driver.c: 156: } while (sreg_val & (1 << SREG_BYTE1_BSY));
      0084BD 44               [ 1]  324 	srl	a
      0084BE 25 F6            [ 1]  325 	jrc	00101$
                                    326 ;	src/flash_driver.c: 158: }
      0084C0 81               [ 4]  327 	ret
                                    328 ;	src/flash_driver.c: 167: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
                                    329 ;	-----------------------------------------
                                    330 ;	 function flash_erase_block
                                    331 ;	-----------------------------------------
      0084C1                        332 _flash_erase_block:
                                    333 ;	src/flash_driver.c: 169: spi_cs_active();
      0084C1 CD 85 A9         [ 4]  334 	call	_spi_cs_active
                                    335 ;	src/flash_driver.c: 170: spi_write_8bits(cmd_block_erase);
      0084C4 7B 07            [ 1]  336 	ld	a, (0x07, sp)
      0084C6 88               [ 1]  337 	push	a
      0084C7 CD 85 7D         [ 4]  338 	call	_spi_write_8bits
      0084CA 84               [ 1]  339 	pop	a
                                    340 ;	src/flash_driver.c: 171: spi_write_24bits(addr);
      0084CB 1E 05            [ 2]  341 	ldw	x, (0x05, sp)
      0084CD 89               [ 2]  342 	pushw	x
      0084CE 1E 05            [ 2]  343 	ldw	x, (0x05, sp)
      0084D0 89               [ 2]  344 	pushw	x
      0084D1 CD 85 4C         [ 4]  345 	call	_spi_write_24bits
      0084D4 5B 04            [ 2]  346 	addw	sp, #4
                                    347 ;	src/flash_driver.c: 172: spi_cs_idle();
                                    348 ;	src/flash_driver.c: 173: }
      0084D6 CC 85 AE         [ 2]  349 	jp	_spi_cs_idle
                                    350 ;	src/flash_driver.c: 179: void flash_write_enable()
                                    351 ;	-----------------------------------------
                                    352 ;	 function flash_write_enable
                                    353 ;	-----------------------------------------
      0084D9                        354 _flash_write_enable:
                                    355 ;	src/flash_driver.c: 181: spi_cs_active();
      0084D9 CD 85 A9         [ 4]  356 	call	_spi_cs_active
                                    357 ;	src/flash_driver.c: 182: spi_write_8bits(CMD_WRITE_ENABLE);
      0084DC 4B 06            [ 1]  358 	push	#0x06
      0084DE CD 85 7D         [ 4]  359 	call	_spi_write_8bits
      0084E1 84               [ 1]  360 	pop	a
                                    361 ;	src/flash_driver.c: 183: spi_cs_idle();
                                    362 ;	src/flash_driver.c: 184: }
      0084E2 CC 85 AE         [ 2]  363 	jp	_spi_cs_idle
                                    364 ;	src/flash_driver.c: 189: void flash_erase_chip()
                                    365 ;	-----------------------------------------
                                    366 ;	 function flash_erase_chip
                                    367 ;	-----------------------------------------
      0084E5                        368 _flash_erase_chip:
                                    369 ;	src/flash_driver.c: 191: spi_cs_active();
      0084E5 CD 85 A9         [ 4]  370 	call	_spi_cs_active
                                    371 ;	src/flash_driver.c: 192: spi_write_8bits(CMD_CHIP_ERASE);
      0084E8 4B 60            [ 1]  372 	push	#0x60
      0084EA CD 85 7D         [ 4]  373 	call	_spi_write_8bits
      0084ED 84               [ 1]  374 	pop	a
                                    375 ;	src/flash_driver.c: 193: spi_cs_idle();
                                    376 ;	src/flash_driver.c: 194: }
      0084EE CC 85 AE         [ 2]  377 	jp	_spi_cs_idle
                                    378 	.area CODE
                                    379 	.area CONST
                                    380 	.area INITIALIZER
                                    381 	.area CABS (ABS)
