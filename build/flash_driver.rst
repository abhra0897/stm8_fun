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
      008563                         69 _flash_write_to_addr:
                                     70 ;	src/flash_driver.c: 15: if (buff == NULL)
      008563 1E 07            [ 2]   71 	ldw	x, (0x07, sp)
      008565 26 01            [ 1]   72 	jrne	00102$
                                     73 ;	src/flash_driver.c: 16: return;
      008567 81               [ 4]   74 	ret
      008568                         75 00102$:
                                     76 ;	src/flash_driver.c: 17: spi_cs_active();
      008568 CD 87 65         [ 4]   77 	call	_spi_cs_active
                                     78 ;	src/flash_driver.c: 18: flash_set_write_addr(addr);
      00856B 1E 05            [ 2]   79 	ldw	x, (0x05, sp)
      00856D 89               [ 2]   80 	pushw	x
      00856E 1E 05            [ 2]   81 	ldw	x, (0x05, sp)
      008570 89               [ 2]   82 	pushw	x
      008571 CD 85 A5         [ 4]   83 	call	_flash_set_write_addr
      008574 5B 04            [ 2]   84 	addw	sp, #4
                                     85 ;	src/flash_driver.c: 19: flash_write_nbytes(buff, nbytes);
      008576 1E 09            [ 2]   86 	ldw	x, (0x09, sp)
      008578 89               [ 2]   87 	pushw	x
      008579 1E 09            [ 2]   88 	ldw	x, (0x09, sp)
      00857B 89               [ 2]   89 	pushw	x
      00857C CD 85 C9         [ 4]   90 	call	_flash_write_nbytes
      00857F 5B 04            [ 2]   91 	addw	sp, #4
                                     92 ;	src/flash_driver.c: 20: spi_cs_idle();
                                     93 ;	src/flash_driver.c: 21: }
      008581 CC 87 6A         [ 2]   94 	jp	_spi_cs_idle
                                     95 ;	src/flash_driver.c: 30: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     96 ;	-----------------------------------------
                                     97 ;	 function flash_read_from_addr
                                     98 ;	-----------------------------------------
      008584                         99 _flash_read_from_addr:
                                    100 ;	src/flash_driver.c: 32: if (buff == NULL)
      008584 1E 07            [ 2]  101 	ldw	x, (0x07, sp)
      008586 26 01            [ 1]  102 	jrne	00102$
                                    103 ;	src/flash_driver.c: 33: return;
      008588 81               [ 4]  104 	ret
      008589                        105 00102$:
                                    106 ;	src/flash_driver.c: 34: spi_cs_active();
      008589 CD 87 65         [ 4]  107 	call	_spi_cs_active
                                    108 ;	src/flash_driver.c: 35: flash_set_read_addr(addr);
      00858C 1E 05            [ 2]  109 	ldw	x, (0x05, sp)
      00858E 89               [ 2]  110 	pushw	x
      00858F 1E 05            [ 2]  111 	ldw	x, (0x05, sp)
      008591 89               [ 2]  112 	pushw	x
      008592 CD 85 B7         [ 4]  113 	call	_flash_set_read_addr
      008595 5B 04            [ 2]  114 	addw	sp, #4
                                    115 ;	src/flash_driver.c: 36: flash_read_nbytes(buff, nbytes);
      008597 1E 09            [ 2]  116 	ldw	x, (0x09, sp)
      008599 89               [ 2]  117 	pushw	x
      00859A 1E 09            [ 2]  118 	ldw	x, (0x09, sp)
      00859C 89               [ 2]  119 	pushw	x
      00859D CD 85 EC         [ 4]  120 	call	_flash_read_nbytes
      0085A0 5B 04            [ 2]  121 	addw	sp, #4
                                    122 ;	src/flash_driver.c: 37: spi_cs_idle();
                                    123 ;	src/flash_driver.c: 38: }
      0085A2 CC 87 6A         [ 2]  124 	jp	_spi_cs_idle
                                    125 ;	src/flash_driver.c: 45: void flash_set_write_addr(uint32_t addr)
                                    126 ;	-----------------------------------------
                                    127 ;	 function flash_set_write_addr
                                    128 ;	-----------------------------------------
      0085A5                        129 _flash_set_write_addr:
                                    130 ;	src/flash_driver.c: 47: spi_write_8bits(CMD_PAGE_WRITE);
      0085A5 4B 02            [ 1]  131 	push	#0x02
      0085A7 CD 87 39         [ 4]  132 	call	_spi_write_8bits
      0085AA 84               [ 1]  133 	pop	a
                                    134 ;	src/flash_driver.c: 48: spi_write_24bits(addr);
      0085AB 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      0085AD 89               [ 2]  136 	pushw	x
      0085AE 1E 05            [ 2]  137 	ldw	x, (0x05, sp)
      0085B0 89               [ 2]  138 	pushw	x
      0085B1 CD 87 08         [ 4]  139 	call	_spi_write_24bits
      0085B4 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	src/flash_driver.c: 49: }
      0085B6 81               [ 4]  142 	ret
                                    143 ;	src/flash_driver.c: 56: void flash_set_read_addr(uint32_t addr)
                                    144 ;	-----------------------------------------
                                    145 ;	 function flash_set_read_addr
                                    146 ;	-----------------------------------------
      0085B7                        147 _flash_set_read_addr:
                                    148 ;	src/flash_driver.c: 58: spi_write_8bits(CMD_READ_ARRAY);
      0085B7 4B 03            [ 1]  149 	push	#0x03
      0085B9 CD 87 39         [ 4]  150 	call	_spi_write_8bits
      0085BC 84               [ 1]  151 	pop	a
                                    152 ;	src/flash_driver.c: 59: spi_write_24bits(addr);
      0085BD 1E 05            [ 2]  153 	ldw	x, (0x05, sp)
      0085BF 89               [ 2]  154 	pushw	x
      0085C0 1E 05            [ 2]  155 	ldw	x, (0x05, sp)
      0085C2 89               [ 2]  156 	pushw	x
      0085C3 CD 87 08         [ 4]  157 	call	_spi_write_24bits
      0085C6 5B 04            [ 2]  158 	addw	sp, #4
                                    159 ;	src/flash_driver.c: 60: }
      0085C8 81               [ 4]  160 	ret
                                    161 ;	src/flash_driver.c: 71: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
                                    162 ;	-----------------------------------------
                                    163 ;	 function flash_write_nbytes
                                    164 ;	-----------------------------------------
      0085C9                        165 _flash_write_nbytes:
                                    166 ;	src/flash_driver.c: 73: if (buff == NULL)
      0085C9 1E 03            [ 2]  167 	ldw	x, (0x03, sp)
      0085CB 26 01            [ 1]  168 	jrne	00118$
                                    169 ;	src/flash_driver.c: 74: return;
      0085CD 81               [ 4]  170 	ret
                                    171 ;	src/flash_driver.c: 76: while (i < nbytes)
      0085CE                        172 00118$:
      0085CE 5F               [ 1]  173 	clrw	x
      0085CF                        174 00109$:
      0085CF 13 05            [ 2]  175 	cpw	x, (0x05, sp)
      0085D1 25 01            [ 1]  176 	jrc	00141$
      0085D3 81               [ 4]  177 	ret
      0085D4                        178 00141$:
                                    179 ;	src/flash_driver.c: 78: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
      0085D4 90 93            [ 1]  180 	ldw	y, x
      0085D6 72 F9 03         [ 2]  181 	addw	y, (0x03, sp)
      0085D9 90 F6            [ 1]  182 	ld	a, (y)
      0085DB C7 52 04         [ 1]  183 	ld	0x5204, a
      0085DE                        184 00103$:
      0085DE C6 52 03         [ 1]  185 	ld	a, 0x5203
      0085E1 A5 02            [ 1]  186 	bcp	a, #0x02
      0085E3 27 F9            [ 1]  187 	jreq	00103$
      0085E5 C6 52 04         [ 1]  188 	ld	a, 0x5204
                                    189 ;	src/flash_driver.c: 79: i++;
      0085E8 5C               [ 1]  190 	incw	x
      0085E9 20 E4            [ 2]  191 	jra	00109$
                                    192 ;	src/flash_driver.c: 81: }
      0085EB 81               [ 4]  193 	ret
                                    194 ;	src/flash_driver.c: 92: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
                                    195 ;	-----------------------------------------
                                    196 ;	 function flash_read_nbytes
                                    197 ;	-----------------------------------------
      0085EC                        198 _flash_read_nbytes:
                                    199 ;	src/flash_driver.c: 94: if (buff == NULL)
      0085EC 1E 03            [ 2]  200 	ldw	x, (0x03, sp)
      0085EE 26 01            [ 1]  201 	jrne	00126$
                                    202 ;	src/flash_driver.c: 95: return;
      0085F0 81               [ 4]  203 	ret
                                    204 ;	src/flash_driver.c: 97: while (i < nbytes)
      0085F1                        205 00126$:
      0085F1 5F               [ 1]  206 	clrw	x
      0085F2                        207 00115$:
      0085F2 13 05            [ 2]  208 	cpw	x, (0x05, sp)
      0085F4 25 01            [ 1]  209 	jrc	00157$
      0085F6 81               [ 4]  210 	ret
      0085F7                        211 00157$:
                                    212 ;	src/flash_driver.c: 99: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
      0085F7 35 FF 52 04      [ 1]  213 	mov	0x5204+0, #0xff
      0085FB                        214 00103$:
      0085FB C6 52 03         [ 1]  215 	ld	a, 0x5203
      0085FE A5 02            [ 1]  216 	bcp	a, #0x02
      008600 27 F9            [ 1]  217 	jreq	00103$
      008602 C6 52 04         [ 1]  218 	ld	a, 0x5204
      008605                        219 00109$:
      008605 C6 52 03         [ 1]  220 	ld	a, 0x5203
      008608 44               [ 1]  221 	srl	a
      008609 24 FA            [ 1]  222 	jrnc	00109$
      00860B 90 93            [ 1]  223 	ldw	y, x
      00860D 72 F9 03         [ 2]  224 	addw	y, (0x03, sp)
      008610 C6 52 04         [ 1]  225 	ld	a, 0x5204
      008613 90 F7            [ 1]  226 	ld	(y), a
      008615 C6 52 04         [ 1]  227 	ld	a, 0x5204
      008618 90 F7            [ 1]  228 	ld	(y), a
                                    229 ;	src/flash_driver.c: 100: i++;
      00861A 5C               [ 1]  230 	incw	x
      00861B 20 D5            [ 2]  231 	jra	00115$
                                    232 ;	src/flash_driver.c: 102: }
      00861D 81               [ 4]  233 	ret
                                    234 ;	src/flash_driver.c: 110: uint8_t flash_read_sreg(uint8_t sreg_no)
                                    235 ;	-----------------------------------------
                                    236 ;	 function flash_read_sreg
                                    237 ;	-----------------------------------------
      00861E                        238 _flash_read_sreg:
      00861E 88               [ 1]  239 	push	a
                                    240 ;	src/flash_driver.c: 112: uint8_t sreg_val = 0; 
      00861F 0F 01            [ 1]  241 	clr	(0x01, sp)
                                    242 ;	src/flash_driver.c: 114: if (sreg_no == 1 || sreg_no == 2)
      008621 7B 04            [ 1]  243 	ld	a, (0x04, sp)
      008623 4A               [ 1]  244 	dec	a
      008624 26 03            [ 1]  245 	jrne	00120$
      008626 A6 01            [ 1]  246 	ld	a, #0x01
      008628 21                     247 	.byte 0x21
      008629                        248 00120$:
      008629 4F               [ 1]  249 	clr	a
      00862A                        250 00121$:
      00862A 4D               [ 1]  251 	tnz	a
      00862B 26 08            [ 1]  252 	jrne	00104$
      00862D 88               [ 1]  253 	push	a
      00862E 7B 05            [ 1]  254 	ld	a, (0x05, sp)
      008630 A1 02            [ 1]  255 	cp	a, #0x02
      008632 84               [ 1]  256 	pop	a
      008633 26 1E            [ 1]  257 	jrne	00105$
      008635                        258 00104$:
                                    259 ;	src/flash_driver.c: 116: spi_cs_active();
      008635 88               [ 1]  260 	push	a
      008636 CD 87 65         [ 4]  261 	call	_spi_cs_active
      008639 84               [ 1]  262 	pop	a
                                    263 ;	src/flash_driver.c: 117: if (sreg_no == 1)
      00863A 4D               [ 1]  264 	tnz	a
      00863B 27 08            [ 1]  265 	jreq	00102$
                                    266 ;	src/flash_driver.c: 118: spi_write_8bits(CMD_READ_SREG_BYTE1);
      00863D 4B 05            [ 1]  267 	push	#0x05
      00863F CD 87 39         [ 4]  268 	call	_spi_write_8bits
      008642 84               [ 1]  269 	pop	a
      008643 20 06            [ 2]  270 	jra	00103$
      008645                        271 00102$:
                                    272 ;	src/flash_driver.c: 120: spi_write_8bits(CMD_READ_SREG_BYTE2);
      008645 4B 35            [ 1]  273 	push	#0x35
      008647 CD 87 39         [ 4]  274 	call	_spi_write_8bits
      00864A 84               [ 1]  275 	pop	a
      00864B                        276 00103$:
                                    277 ;	src/flash_driver.c: 122: sreg_val = spi_read_8bits();
      00864B CD 87 4A         [ 4]  278 	call	_spi_read_8bits
      00864E 6B 01            [ 1]  279 	ld	(0x01, sp), a
                                    280 ;	src/flash_driver.c: 123: spi_cs_idle();
      008650 CD 87 6A         [ 4]  281 	call	_spi_cs_idle
      008653                        282 00105$:
                                    283 ;	src/flash_driver.c: 126: return sreg_val;
      008653 7B 01            [ 1]  284 	ld	a, (0x01, sp)
                                    285 ;	src/flash_driver.c: 127: }
      008655 5B 01            [ 2]  286 	addw	sp, #1
      008657 81               [ 4]  287 	ret
                                    288 ;	src/flash_driver.c: 135: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
                                    289 ;	-----------------------------------------
                                    290 ;	 function flash_write_sreg
                                    291 ;	-----------------------------------------
      008658                        292 _flash_write_sreg:
                                    293 ;	src/flash_driver.c: 137: spi_cs_active();
      008658 CD 87 65         [ 4]  294 	call	_spi_cs_active
                                    295 ;	src/flash_driver.c: 138: spi_write_8bits(CMD_WRITE_SREG);
      00865B 4B 01            [ 1]  296 	push	#0x01
      00865D CD 87 39         [ 4]  297 	call	_spi_write_8bits
      008660 84               [ 1]  298 	pop	a
                                    299 ;	src/flash_driver.c: 139: spi_write_8bits(sreg_byte1);
      008661 7B 03            [ 1]  300 	ld	a, (0x03, sp)
      008663 88               [ 1]  301 	push	a
      008664 CD 87 39         [ 4]  302 	call	_spi_write_8bits
      008667 84               [ 1]  303 	pop	a
                                    304 ;	src/flash_driver.c: 140: spi_write_8bits(sreg_byte2);
      008668 7B 04            [ 1]  305 	ld	a, (0x04, sp)
      00866A 88               [ 1]  306 	push	a
      00866B CD 87 39         [ 4]  307 	call	_spi_write_8bits
      00866E 84               [ 1]  308 	pop	a
                                    309 ;	src/flash_driver.c: 141: spi_cs_idle();
                                    310 ;	src/flash_driver.c: 142: }
      00866F CC 87 6A         [ 2]  311 	jp	_spi_cs_idle
                                    312 ;	src/flash_driver.c: 148: void flash_busy_wait()
                                    313 ;	-----------------------------------------
                                    314 ;	 function flash_busy_wait
                                    315 ;	-----------------------------------------
      008672                        316 _flash_busy_wait:
                                    317 ;	src/flash_driver.c: 153: do
      008672                        318 00101$:
                                    319 ;	src/flash_driver.c: 155: sreg_val = flash_read_sreg(1);
      008672 4B 01            [ 1]  320 	push	#0x01
      008674 CD 86 1E         [ 4]  321 	call	_flash_read_sreg
      008677 5B 01            [ 2]  322 	addw	sp, #1
                                    323 ;	src/flash_driver.c: 156: } while (sreg_val & (1 << SREG_BYTE1_BSY));
      008679 44               [ 1]  324 	srl	a
      00867A 25 F6            [ 1]  325 	jrc	00101$
                                    326 ;	src/flash_driver.c: 158: }
      00867C 81               [ 4]  327 	ret
                                    328 ;	src/flash_driver.c: 167: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
                                    329 ;	-----------------------------------------
                                    330 ;	 function flash_erase_block
                                    331 ;	-----------------------------------------
      00867D                        332 _flash_erase_block:
                                    333 ;	src/flash_driver.c: 169: spi_cs_active();
      00867D CD 87 65         [ 4]  334 	call	_spi_cs_active
                                    335 ;	src/flash_driver.c: 170: spi_write_8bits(cmd_block_erase);
      008680 7B 07            [ 1]  336 	ld	a, (0x07, sp)
      008682 88               [ 1]  337 	push	a
      008683 CD 87 39         [ 4]  338 	call	_spi_write_8bits
      008686 84               [ 1]  339 	pop	a
                                    340 ;	src/flash_driver.c: 171: spi_write_24bits(addr);
      008687 1E 05            [ 2]  341 	ldw	x, (0x05, sp)
      008689 89               [ 2]  342 	pushw	x
      00868A 1E 05            [ 2]  343 	ldw	x, (0x05, sp)
      00868C 89               [ 2]  344 	pushw	x
      00868D CD 87 08         [ 4]  345 	call	_spi_write_24bits
      008690 5B 04            [ 2]  346 	addw	sp, #4
                                    347 ;	src/flash_driver.c: 172: spi_cs_idle();
                                    348 ;	src/flash_driver.c: 173: }
      008692 CC 87 6A         [ 2]  349 	jp	_spi_cs_idle
                                    350 ;	src/flash_driver.c: 179: void flash_write_enable()
                                    351 ;	-----------------------------------------
                                    352 ;	 function flash_write_enable
                                    353 ;	-----------------------------------------
      008695                        354 _flash_write_enable:
                                    355 ;	src/flash_driver.c: 181: spi_cs_active();
      008695 CD 87 65         [ 4]  356 	call	_spi_cs_active
                                    357 ;	src/flash_driver.c: 182: spi_write_8bits(CMD_WRITE_ENABLE);
      008698 4B 06            [ 1]  358 	push	#0x06
      00869A CD 87 39         [ 4]  359 	call	_spi_write_8bits
      00869D 84               [ 1]  360 	pop	a
                                    361 ;	src/flash_driver.c: 183: spi_cs_idle();
                                    362 ;	src/flash_driver.c: 184: }
      00869E CC 87 6A         [ 2]  363 	jp	_spi_cs_idle
                                    364 ;	src/flash_driver.c: 189: void flash_erase_chip()
                                    365 ;	-----------------------------------------
                                    366 ;	 function flash_erase_chip
                                    367 ;	-----------------------------------------
      0086A1                        368 _flash_erase_chip:
                                    369 ;	src/flash_driver.c: 191: spi_cs_active();
      0086A1 CD 87 65         [ 4]  370 	call	_spi_cs_active
                                    371 ;	src/flash_driver.c: 192: spi_write_8bits(CMD_CHIP_ERASE);
      0086A4 4B 60            [ 1]  372 	push	#0x60
      0086A6 CD 87 39         [ 4]  373 	call	_spi_write_8bits
      0086A9 84               [ 1]  374 	pop	a
                                    375 ;	src/flash_driver.c: 193: spi_cs_idle();
                                    376 ;	src/flash_driver.c: 194: }
      0086AA CC 87 6A         [ 2]  377 	jp	_spi_cs_idle
                                    378 	.area CODE
                                    379 	.area CONST
                                    380 	.area INITIALIZER
                                    381 	.area CABS (ABS)
