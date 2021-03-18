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
      008621                         69 _flash_write_to_addr:
                                     70 ;	src/flash_driver.c: 15: if (buff == NULL)
      008621 1E 07            [ 2]   71 	ldw	x, (0x07, sp)
      008623 26 01            [ 1]   72 	jrne	00102$
                                     73 ;	src/flash_driver.c: 16: return;
      008625 81               [ 4]   74 	ret
      008626                         75 00102$:
                                     76 ;	src/flash_driver.c: 17: spi_cs_active();
      008626 CD 88 23         [ 4]   77 	call	_spi_cs_active
                                     78 ;	src/flash_driver.c: 18: flash_set_write_addr(addr);
      008629 1E 05            [ 2]   79 	ldw	x, (0x05, sp)
      00862B 89               [ 2]   80 	pushw	x
      00862C 1E 05            [ 2]   81 	ldw	x, (0x05, sp)
      00862E 89               [ 2]   82 	pushw	x
      00862F CD 86 63         [ 4]   83 	call	_flash_set_write_addr
      008632 5B 04            [ 2]   84 	addw	sp, #4
                                     85 ;	src/flash_driver.c: 19: flash_write_nbytes(buff, nbytes);
      008634 1E 09            [ 2]   86 	ldw	x, (0x09, sp)
      008636 89               [ 2]   87 	pushw	x
      008637 1E 09            [ 2]   88 	ldw	x, (0x09, sp)
      008639 89               [ 2]   89 	pushw	x
      00863A CD 86 87         [ 4]   90 	call	_flash_write_nbytes
      00863D 5B 04            [ 2]   91 	addw	sp, #4
                                     92 ;	src/flash_driver.c: 20: spi_cs_idle();
                                     93 ;	src/flash_driver.c: 21: }
      00863F CC 88 28         [ 2]   94 	jp	_spi_cs_idle
                                     95 ;	src/flash_driver.c: 30: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     96 ;	-----------------------------------------
                                     97 ;	 function flash_read_from_addr
                                     98 ;	-----------------------------------------
      008642                         99 _flash_read_from_addr:
                                    100 ;	src/flash_driver.c: 32: if (buff == NULL)
      008642 1E 07            [ 2]  101 	ldw	x, (0x07, sp)
      008644 26 01            [ 1]  102 	jrne	00102$
                                    103 ;	src/flash_driver.c: 33: return;
      008646 81               [ 4]  104 	ret
      008647                        105 00102$:
                                    106 ;	src/flash_driver.c: 34: spi_cs_active();
      008647 CD 88 23         [ 4]  107 	call	_spi_cs_active
                                    108 ;	src/flash_driver.c: 35: flash_set_read_addr(addr);
      00864A 1E 05            [ 2]  109 	ldw	x, (0x05, sp)
      00864C 89               [ 2]  110 	pushw	x
      00864D 1E 05            [ 2]  111 	ldw	x, (0x05, sp)
      00864F 89               [ 2]  112 	pushw	x
      008650 CD 86 75         [ 4]  113 	call	_flash_set_read_addr
      008653 5B 04            [ 2]  114 	addw	sp, #4
                                    115 ;	src/flash_driver.c: 36: flash_read_nbytes(buff, nbytes);
      008655 1E 09            [ 2]  116 	ldw	x, (0x09, sp)
      008657 89               [ 2]  117 	pushw	x
      008658 1E 09            [ 2]  118 	ldw	x, (0x09, sp)
      00865A 89               [ 2]  119 	pushw	x
      00865B CD 86 AA         [ 4]  120 	call	_flash_read_nbytes
      00865E 5B 04            [ 2]  121 	addw	sp, #4
                                    122 ;	src/flash_driver.c: 37: spi_cs_idle();
                                    123 ;	src/flash_driver.c: 38: }
      008660 CC 88 28         [ 2]  124 	jp	_spi_cs_idle
                                    125 ;	src/flash_driver.c: 45: void flash_set_write_addr(uint32_t addr)
                                    126 ;	-----------------------------------------
                                    127 ;	 function flash_set_write_addr
                                    128 ;	-----------------------------------------
      008663                        129 _flash_set_write_addr:
                                    130 ;	src/flash_driver.c: 47: spi_write_8bits(CMD_PAGE_WRITE);
      008663 4B 02            [ 1]  131 	push	#0x02
      008665 CD 87 F7         [ 4]  132 	call	_spi_write_8bits
      008668 84               [ 1]  133 	pop	a
                                    134 ;	src/flash_driver.c: 48: spi_write_24bits(addr);
      008669 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      00866B 89               [ 2]  136 	pushw	x
      00866C 1E 05            [ 2]  137 	ldw	x, (0x05, sp)
      00866E 89               [ 2]  138 	pushw	x
      00866F CD 87 C6         [ 4]  139 	call	_spi_write_24bits
      008672 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	src/flash_driver.c: 49: }
      008674 81               [ 4]  142 	ret
                                    143 ;	src/flash_driver.c: 56: void flash_set_read_addr(uint32_t addr)
                                    144 ;	-----------------------------------------
                                    145 ;	 function flash_set_read_addr
                                    146 ;	-----------------------------------------
      008675                        147 _flash_set_read_addr:
                                    148 ;	src/flash_driver.c: 58: spi_write_8bits(CMD_READ_ARRAY);
      008675 4B 03            [ 1]  149 	push	#0x03
      008677 CD 87 F7         [ 4]  150 	call	_spi_write_8bits
      00867A 84               [ 1]  151 	pop	a
                                    152 ;	src/flash_driver.c: 59: spi_write_24bits(addr);
      00867B 1E 05            [ 2]  153 	ldw	x, (0x05, sp)
      00867D 89               [ 2]  154 	pushw	x
      00867E 1E 05            [ 2]  155 	ldw	x, (0x05, sp)
      008680 89               [ 2]  156 	pushw	x
      008681 CD 87 C6         [ 4]  157 	call	_spi_write_24bits
      008684 5B 04            [ 2]  158 	addw	sp, #4
                                    159 ;	src/flash_driver.c: 60: }
      008686 81               [ 4]  160 	ret
                                    161 ;	src/flash_driver.c: 71: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
                                    162 ;	-----------------------------------------
                                    163 ;	 function flash_write_nbytes
                                    164 ;	-----------------------------------------
      008687                        165 _flash_write_nbytes:
                                    166 ;	src/flash_driver.c: 73: if (buff == NULL)
      008687 1E 03            [ 2]  167 	ldw	x, (0x03, sp)
      008689 26 01            [ 1]  168 	jrne	00118$
                                    169 ;	src/flash_driver.c: 74: return;
      00868B 81               [ 4]  170 	ret
                                    171 ;	src/flash_driver.c: 76: while (i < nbytes)
      00868C                        172 00118$:
      00868C 5F               [ 1]  173 	clrw	x
      00868D                        174 00109$:
      00868D 13 05            [ 2]  175 	cpw	x, (0x05, sp)
      00868F 25 01            [ 1]  176 	jrc	00141$
      008691 81               [ 4]  177 	ret
      008692                        178 00141$:
                                    179 ;	src/flash_driver.c: 78: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
      008692 90 93            [ 1]  180 	ldw	y, x
      008694 72 F9 03         [ 2]  181 	addw	y, (0x03, sp)
      008697 90 F6            [ 1]  182 	ld	a, (y)
      008699 C7 52 04         [ 1]  183 	ld	0x5204, a
      00869C                        184 00103$:
      00869C C6 52 03         [ 1]  185 	ld	a, 0x5203
      00869F A5 02            [ 1]  186 	bcp	a, #0x02
      0086A1 27 F9            [ 1]  187 	jreq	00103$
      0086A3 C6 52 04         [ 1]  188 	ld	a, 0x5204
                                    189 ;	src/flash_driver.c: 79: i++;
      0086A6 5C               [ 1]  190 	incw	x
      0086A7 20 E4            [ 2]  191 	jra	00109$
                                    192 ;	src/flash_driver.c: 81: }
      0086A9 81               [ 4]  193 	ret
                                    194 ;	src/flash_driver.c: 92: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
                                    195 ;	-----------------------------------------
                                    196 ;	 function flash_read_nbytes
                                    197 ;	-----------------------------------------
      0086AA                        198 _flash_read_nbytes:
                                    199 ;	src/flash_driver.c: 94: if (buff == NULL)
      0086AA 1E 03            [ 2]  200 	ldw	x, (0x03, sp)
      0086AC 26 01            [ 1]  201 	jrne	00126$
                                    202 ;	src/flash_driver.c: 95: return;
      0086AE 81               [ 4]  203 	ret
                                    204 ;	src/flash_driver.c: 97: while (i < nbytes)
      0086AF                        205 00126$:
      0086AF 5F               [ 1]  206 	clrw	x
      0086B0                        207 00115$:
      0086B0 13 05            [ 2]  208 	cpw	x, (0x05, sp)
      0086B2 25 01            [ 1]  209 	jrc	00157$
      0086B4 81               [ 4]  210 	ret
      0086B5                        211 00157$:
                                    212 ;	src/flash_driver.c: 99: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
      0086B5 35 FF 52 04      [ 1]  213 	mov	0x5204+0, #0xff
      0086B9                        214 00103$:
      0086B9 C6 52 03         [ 1]  215 	ld	a, 0x5203
      0086BC A5 02            [ 1]  216 	bcp	a, #0x02
      0086BE 27 F9            [ 1]  217 	jreq	00103$
      0086C0 C6 52 04         [ 1]  218 	ld	a, 0x5204
      0086C3                        219 00109$:
      0086C3 C6 52 03         [ 1]  220 	ld	a, 0x5203
      0086C6 44               [ 1]  221 	srl	a
      0086C7 24 FA            [ 1]  222 	jrnc	00109$
      0086C9 90 93            [ 1]  223 	ldw	y, x
      0086CB 72 F9 03         [ 2]  224 	addw	y, (0x03, sp)
      0086CE C6 52 04         [ 1]  225 	ld	a, 0x5204
      0086D1 90 F7            [ 1]  226 	ld	(y), a
      0086D3 C6 52 04         [ 1]  227 	ld	a, 0x5204
      0086D6 90 F7            [ 1]  228 	ld	(y), a
                                    229 ;	src/flash_driver.c: 100: i++;
      0086D8 5C               [ 1]  230 	incw	x
      0086D9 20 D5            [ 2]  231 	jra	00115$
                                    232 ;	src/flash_driver.c: 102: }
      0086DB 81               [ 4]  233 	ret
                                    234 ;	src/flash_driver.c: 110: uint8_t flash_read_sreg(uint8_t sreg_no)
                                    235 ;	-----------------------------------------
                                    236 ;	 function flash_read_sreg
                                    237 ;	-----------------------------------------
      0086DC                        238 _flash_read_sreg:
      0086DC 88               [ 1]  239 	push	a
                                    240 ;	src/flash_driver.c: 112: uint8_t sreg_val = 0; 
      0086DD 0F 01            [ 1]  241 	clr	(0x01, sp)
                                    242 ;	src/flash_driver.c: 114: if (sreg_no == 1 || sreg_no == 2)
      0086DF 7B 04            [ 1]  243 	ld	a, (0x04, sp)
      0086E1 4A               [ 1]  244 	dec	a
      0086E2 26 03            [ 1]  245 	jrne	00120$
      0086E4 A6 01            [ 1]  246 	ld	a, #0x01
      0086E6 21                     247 	.byte 0x21
      0086E7                        248 00120$:
      0086E7 4F               [ 1]  249 	clr	a
      0086E8                        250 00121$:
      0086E8 4D               [ 1]  251 	tnz	a
      0086E9 26 08            [ 1]  252 	jrne	00104$
      0086EB 88               [ 1]  253 	push	a
      0086EC 7B 05            [ 1]  254 	ld	a, (0x05, sp)
      0086EE A1 02            [ 1]  255 	cp	a, #0x02
      0086F0 84               [ 1]  256 	pop	a
      0086F1 26 1E            [ 1]  257 	jrne	00105$
      0086F3                        258 00104$:
                                    259 ;	src/flash_driver.c: 116: spi_cs_active();
      0086F3 88               [ 1]  260 	push	a
      0086F4 CD 88 23         [ 4]  261 	call	_spi_cs_active
      0086F7 84               [ 1]  262 	pop	a
                                    263 ;	src/flash_driver.c: 117: if (sreg_no == 1)
      0086F8 4D               [ 1]  264 	tnz	a
      0086F9 27 08            [ 1]  265 	jreq	00102$
                                    266 ;	src/flash_driver.c: 118: spi_write_8bits(CMD_READ_SREG_BYTE1);
      0086FB 4B 05            [ 1]  267 	push	#0x05
      0086FD CD 87 F7         [ 4]  268 	call	_spi_write_8bits
      008700 84               [ 1]  269 	pop	a
      008701 20 06            [ 2]  270 	jra	00103$
      008703                        271 00102$:
                                    272 ;	src/flash_driver.c: 120: spi_write_8bits(CMD_READ_SREG_BYTE2);
      008703 4B 35            [ 1]  273 	push	#0x35
      008705 CD 87 F7         [ 4]  274 	call	_spi_write_8bits
      008708 84               [ 1]  275 	pop	a
      008709                        276 00103$:
                                    277 ;	src/flash_driver.c: 122: sreg_val = spi_read_8bits();
      008709 CD 88 08         [ 4]  278 	call	_spi_read_8bits
      00870C 6B 01            [ 1]  279 	ld	(0x01, sp), a
                                    280 ;	src/flash_driver.c: 123: spi_cs_idle();
      00870E CD 88 28         [ 4]  281 	call	_spi_cs_idle
      008711                        282 00105$:
                                    283 ;	src/flash_driver.c: 126: return sreg_val;
      008711 7B 01            [ 1]  284 	ld	a, (0x01, sp)
                                    285 ;	src/flash_driver.c: 127: }
      008713 5B 01            [ 2]  286 	addw	sp, #1
      008715 81               [ 4]  287 	ret
                                    288 ;	src/flash_driver.c: 135: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
                                    289 ;	-----------------------------------------
                                    290 ;	 function flash_write_sreg
                                    291 ;	-----------------------------------------
      008716                        292 _flash_write_sreg:
                                    293 ;	src/flash_driver.c: 137: spi_cs_active();
      008716 CD 88 23         [ 4]  294 	call	_spi_cs_active
                                    295 ;	src/flash_driver.c: 138: spi_write_8bits(CMD_WRITE_SREG);
      008719 4B 01            [ 1]  296 	push	#0x01
      00871B CD 87 F7         [ 4]  297 	call	_spi_write_8bits
      00871E 84               [ 1]  298 	pop	a
                                    299 ;	src/flash_driver.c: 139: spi_write_8bits(sreg_byte1);
      00871F 7B 03            [ 1]  300 	ld	a, (0x03, sp)
      008721 88               [ 1]  301 	push	a
      008722 CD 87 F7         [ 4]  302 	call	_spi_write_8bits
      008725 84               [ 1]  303 	pop	a
                                    304 ;	src/flash_driver.c: 140: spi_write_8bits(sreg_byte2);
      008726 7B 04            [ 1]  305 	ld	a, (0x04, sp)
      008728 88               [ 1]  306 	push	a
      008729 CD 87 F7         [ 4]  307 	call	_spi_write_8bits
      00872C 84               [ 1]  308 	pop	a
                                    309 ;	src/flash_driver.c: 141: spi_cs_idle();
                                    310 ;	src/flash_driver.c: 142: }
      00872D CC 88 28         [ 2]  311 	jp	_spi_cs_idle
                                    312 ;	src/flash_driver.c: 148: void flash_busy_wait()
                                    313 ;	-----------------------------------------
                                    314 ;	 function flash_busy_wait
                                    315 ;	-----------------------------------------
      008730                        316 _flash_busy_wait:
                                    317 ;	src/flash_driver.c: 153: do
      008730                        318 00101$:
                                    319 ;	src/flash_driver.c: 155: sreg_val = flash_read_sreg(1);
      008730 4B 01            [ 1]  320 	push	#0x01
      008732 CD 86 DC         [ 4]  321 	call	_flash_read_sreg
      008735 5B 01            [ 2]  322 	addw	sp, #1
                                    323 ;	src/flash_driver.c: 156: } while (sreg_val & (1 << SREG_BYTE1_BSY));
      008737 44               [ 1]  324 	srl	a
      008738 25 F6            [ 1]  325 	jrc	00101$
                                    326 ;	src/flash_driver.c: 158: }
      00873A 81               [ 4]  327 	ret
                                    328 ;	src/flash_driver.c: 167: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
                                    329 ;	-----------------------------------------
                                    330 ;	 function flash_erase_block
                                    331 ;	-----------------------------------------
      00873B                        332 _flash_erase_block:
                                    333 ;	src/flash_driver.c: 169: spi_cs_active();
      00873B CD 88 23         [ 4]  334 	call	_spi_cs_active
                                    335 ;	src/flash_driver.c: 170: spi_write_8bits(cmd_block_erase);
      00873E 7B 07            [ 1]  336 	ld	a, (0x07, sp)
      008740 88               [ 1]  337 	push	a
      008741 CD 87 F7         [ 4]  338 	call	_spi_write_8bits
      008744 84               [ 1]  339 	pop	a
                                    340 ;	src/flash_driver.c: 171: spi_write_24bits(addr);
      008745 1E 05            [ 2]  341 	ldw	x, (0x05, sp)
      008747 89               [ 2]  342 	pushw	x
      008748 1E 05            [ 2]  343 	ldw	x, (0x05, sp)
      00874A 89               [ 2]  344 	pushw	x
      00874B CD 87 C6         [ 4]  345 	call	_spi_write_24bits
      00874E 5B 04            [ 2]  346 	addw	sp, #4
                                    347 ;	src/flash_driver.c: 172: spi_cs_idle();
                                    348 ;	src/flash_driver.c: 173: }
      008750 CC 88 28         [ 2]  349 	jp	_spi_cs_idle
                                    350 ;	src/flash_driver.c: 179: void flash_write_enable()
                                    351 ;	-----------------------------------------
                                    352 ;	 function flash_write_enable
                                    353 ;	-----------------------------------------
      008753                        354 _flash_write_enable:
                                    355 ;	src/flash_driver.c: 181: spi_cs_active();
      008753 CD 88 23         [ 4]  356 	call	_spi_cs_active
                                    357 ;	src/flash_driver.c: 182: spi_write_8bits(CMD_WRITE_ENABLE);
      008756 4B 06            [ 1]  358 	push	#0x06
      008758 CD 87 F7         [ 4]  359 	call	_spi_write_8bits
      00875B 84               [ 1]  360 	pop	a
                                    361 ;	src/flash_driver.c: 183: spi_cs_idle();
                                    362 ;	src/flash_driver.c: 184: }
      00875C CC 88 28         [ 2]  363 	jp	_spi_cs_idle
                                    364 ;	src/flash_driver.c: 189: void flash_erase_chip()
                                    365 ;	-----------------------------------------
                                    366 ;	 function flash_erase_chip
                                    367 ;	-----------------------------------------
      00875F                        368 _flash_erase_chip:
                                    369 ;	src/flash_driver.c: 191: spi_cs_active();
      00875F CD 88 23         [ 4]  370 	call	_spi_cs_active
                                    371 ;	src/flash_driver.c: 192: spi_write_8bits(CMD_CHIP_ERASE);
      008762 4B 60            [ 1]  372 	push	#0x60
      008764 CD 87 F7         [ 4]  373 	call	_spi_write_8bits
      008767 84               [ 1]  374 	pop	a
                                    375 ;	src/flash_driver.c: 193: spi_cs_idle();
                                    376 ;	src/flash_driver.c: 194: }
      008768 CC 88 28         [ 2]  377 	jp	_spi_cs_idle
                                    378 	.area CODE
                                    379 	.area CONST
                                    380 	.area INITIALIZER
                                    381 	.area CABS (ABS)
