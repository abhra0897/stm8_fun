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
                                     11 	.globl _spi_read_8bits
                                     12 	.globl _spi_write_8bits
                                     13 	.globl _spi_write_24bits
                                     14 	.globl _flash_write_to_addr
                                     15 	.globl _flash_read_from_addr
                                     16 	.globl _flash_set_write_addr
                                     17 	.globl _flash_set_read_addr
                                     18 	.globl _flash_write_nbytes
                                     19 	.globl _flash_read_nbytes
                                     20 	.globl _flash_read_sreg
                                     21 	.globl _flash_write_sreg
                                     22 	.globl _flash_busy_wait
                                     23 	.globl _flash_erase_block
                                     24 	.globl _flash_write_enable
                                     25 	.globl _flash_erase_chip
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
                                     54 ;--------------------------------------------------------
                                     55 ; Home
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
                                     58 	.area HOME
                                     59 ;--------------------------------------------------------
                                     60 ; code
                                     61 ;--------------------------------------------------------
                                     62 	.area CODE
                                     63 ;	src/flash_driver.c: 13: void flash_write_to_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     64 ;	-----------------------------------------
                                     65 ;	 function flash_write_to_addr
                                     66 ;	-----------------------------------------
      0080D4                         67 _flash_write_to_addr:
                                     68 ;	src/flash_driver.c: 15: if (buff == NULL)
      0080D4 1E 07            [ 2]   69 	ldw	x, (0x07, sp)
      0080D6 26 01            [ 1]   70 	jrne	00102$
                                     71 ;	src/flash_driver.c: 16: return;
      0080D8 81               [ 4]   72 	ret
      0080D9                         73 00102$:
                                     74 ;	src/flash_driver.c: 17: flash_set_write_addr(addr);
      0080D9 1E 05            [ 2]   75 	ldw	x, (0x05, sp)
      0080DB 89               [ 2]   76 	pushw	x
      0080DC 1E 05            [ 2]   77 	ldw	x, (0x05, sp)
      0080DE 89               [ 2]   78 	pushw	x
      0080DF CD 81 0C         [ 4]   79 	call	_flash_set_write_addr
      0080E2 5B 04            [ 2]   80 	addw	sp, #4
                                     81 ;	src/flash_driver.c: 18: flash_write_nbytes(buff, nbytes);
      0080E4 1E 09            [ 2]   82 	ldw	x, (0x09, sp)
      0080E6 89               [ 2]   83 	pushw	x
      0080E7 1E 09            [ 2]   84 	ldw	x, (0x09, sp)
      0080E9 89               [ 2]   85 	pushw	x
      0080EA CD 81 30         [ 4]   86 	call	_flash_write_nbytes
      0080ED 5B 04            [ 2]   87 	addw	sp, #4
                                     88 ;	src/flash_driver.c: 19: }
      0080EF 81               [ 4]   89 	ret
                                     90 ;	src/flash_driver.c: 28: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
                                     91 ;	-----------------------------------------
                                     92 ;	 function flash_read_from_addr
                                     93 ;	-----------------------------------------
      0080F0                         94 _flash_read_from_addr:
                                     95 ;	src/flash_driver.c: 30: if (buff == NULL)
      0080F0 1E 07            [ 2]   96 	ldw	x, (0x07, sp)
      0080F2 26 01            [ 1]   97 	jrne	00102$
                                     98 ;	src/flash_driver.c: 31: return;
      0080F4 81               [ 4]   99 	ret
      0080F5                        100 00102$:
                                    101 ;	src/flash_driver.c: 32: flash_set_read_addr(addr);
      0080F5 1E 05            [ 2]  102 	ldw	x, (0x05, sp)
      0080F7 89               [ 2]  103 	pushw	x
      0080F8 1E 05            [ 2]  104 	ldw	x, (0x05, sp)
      0080FA 89               [ 2]  105 	pushw	x
      0080FB CD 81 1E         [ 4]  106 	call	_flash_set_read_addr
      0080FE 5B 04            [ 2]  107 	addw	sp, #4
                                    108 ;	src/flash_driver.c: 33: flash_read_nbytes(buff, nbytes);
      008100 1E 09            [ 2]  109 	ldw	x, (0x09, sp)
      008102 89               [ 2]  110 	pushw	x
      008103 1E 09            [ 2]  111 	ldw	x, (0x09, sp)
      008105 89               [ 2]  112 	pushw	x
      008106 CD 81 50         [ 4]  113 	call	_flash_read_nbytes
      008109 5B 04            [ 2]  114 	addw	sp, #4
                                    115 ;	src/flash_driver.c: 34: }
      00810B 81               [ 4]  116 	ret
                                    117 ;	src/flash_driver.c: 41: void flash_set_write_addr(uint32_t addr)
                                    118 ;	-----------------------------------------
                                    119 ;	 function flash_set_write_addr
                                    120 ;	-----------------------------------------
      00810C                        121 _flash_set_write_addr:
                                    122 ;	src/flash_driver.c: 43: spi_write_8bits(CMD_PAGE_WRITE);
      00810C 4B 02            [ 1]  123 	push	#0x02
      00810E CD 82 57         [ 4]  124 	call	_spi_write_8bits
      008111 84               [ 1]  125 	pop	a
                                    126 ;	src/flash_driver.c: 44: spi_write_24bits(addr);
      008112 1E 05            [ 2]  127 	ldw	x, (0x05, sp)
      008114 89               [ 2]  128 	pushw	x
      008115 1E 05            [ 2]  129 	ldw	x, (0x05, sp)
      008117 89               [ 2]  130 	pushw	x
      008118 CD 82 2B         [ 4]  131 	call	_spi_write_24bits
      00811B 5B 04            [ 2]  132 	addw	sp, #4
                                    133 ;	src/flash_driver.c: 45: }
      00811D 81               [ 4]  134 	ret
                                    135 ;	src/flash_driver.c: 52: void flash_set_read_addr(uint32_t addr)
                                    136 ;	-----------------------------------------
                                    137 ;	 function flash_set_read_addr
                                    138 ;	-----------------------------------------
      00811E                        139 _flash_set_read_addr:
                                    140 ;	src/flash_driver.c: 54: spi_write_8bits(CMD_READ_ARRAY);
      00811E 4B 03            [ 1]  141 	push	#0x03
      008120 CD 82 57         [ 4]  142 	call	_spi_write_8bits
      008123 84               [ 1]  143 	pop	a
                                    144 ;	src/flash_driver.c: 55: spi_write_24bits(addr);
      008124 1E 05            [ 2]  145 	ldw	x, (0x05, sp)
      008126 89               [ 2]  146 	pushw	x
      008127 1E 05            [ 2]  147 	ldw	x, (0x05, sp)
      008129 89               [ 2]  148 	pushw	x
      00812A CD 82 2B         [ 4]  149 	call	_spi_write_24bits
      00812D 5B 04            [ 2]  150 	addw	sp, #4
                                    151 ;	src/flash_driver.c: 56: }
      00812F 81               [ 4]  152 	ret
                                    153 ;	src/flash_driver.c: 67: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
                                    154 ;	-----------------------------------------
                                    155 ;	 function flash_write_nbytes
                                    156 ;	-----------------------------------------
      008130                        157 _flash_write_nbytes:
                                    158 ;	src/flash_driver.c: 69: if (buff == NULL)
      008130 1E 03            [ 2]  159 	ldw	x, (0x03, sp)
      008132 26 01            [ 1]  160 	jrne	00118$
                                    161 ;	src/flash_driver.c: 70: return;
      008134 81               [ 4]  162 	ret
                                    163 ;	src/flash_driver.c: 72: while (i < nbytes)
      008135                        164 00118$:
      008135 5F               [ 1]  165 	clrw	x
      008136                        166 00109$:
      008136 13 05            [ 2]  167 	cpw	x, (0x05, sp)
      008138 25 01            [ 1]  168 	jrc	00141$
      00813A 81               [ 4]  169 	ret
      00813B                        170 00141$:
                                    171 ;	src/flash_driver.c: 74: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
      00813B 90 93            [ 1]  172 	ldw	y, x
      00813D 72 F9 03         [ 2]  173 	addw	y, (0x03, sp)
      008140 90 F6            [ 1]  174 	ld	a, (y)
      008142 C7 52 04         [ 1]  175 	ld	0x5204, a
      008145                        176 00103$:
      008145 C6 52 03         [ 1]  177 	ld	a, 0x5203
      008148 A5 02            [ 1]  178 	bcp	a, #0x02
      00814A 27 F9            [ 1]  179 	jreq	00103$
                                    180 ;	src/flash_driver.c: 75: i++;
      00814C 5C               [ 1]  181 	incw	x
      00814D 20 E7            [ 2]  182 	jra	00109$
                                    183 ;	src/flash_driver.c: 77: }
      00814F 81               [ 4]  184 	ret
                                    185 ;	src/flash_driver.c: 88: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
                                    186 ;	-----------------------------------------
                                    187 ;	 function flash_read_nbytes
                                    188 ;	-----------------------------------------
      008150                        189 _flash_read_nbytes:
                                    190 ;	src/flash_driver.c: 90: if (buff == NULL)
      008150 1E 03            [ 2]  191 	ldw	x, (0x03, sp)
      008152 26 01            [ 1]  192 	jrne	00125$
                                    193 ;	src/flash_driver.c: 91: return;
      008154 81               [ 4]  194 	ret
                                    195 ;	src/flash_driver.c: 93: while (i < nbytes)
      008155                        196 00125$:
      008155 5F               [ 1]  197 	clrw	x
      008156                        198 00115$:
      008156 13 05            [ 2]  199 	cpw	x, (0x05, sp)
      008158 25 01            [ 1]  200 	jrc	00152$
      00815A 81               [ 4]  201 	ret
      00815B                        202 00152$:
                                    203 ;	src/flash_driver.c: 95: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
      00815B 35 FF 52 04      [ 1]  204 	mov	0x5204+0, #0xff
      00815F                        205 00103$:
      00815F C6 52 03         [ 1]  206 	ld	a, 0x5203
      008162 A5 02            [ 1]  207 	bcp	a, #0x02
      008164 27 F9            [ 1]  208 	jreq	00103$
      008166                        209 00109$:
      008166 C6 52 03         [ 1]  210 	ld	a, 0x5203
      008169 44               [ 1]  211 	srl	a
      00816A 24 FA            [ 1]  212 	jrnc	00109$
      00816C 90 93            [ 1]  213 	ldw	y, x
      00816E 72 F9 03         [ 2]  214 	addw	y, (0x03, sp)
      008171 C6 52 04         [ 1]  215 	ld	a, 0x5204
      008174 90 F7            [ 1]  216 	ld	(y), a
                                    217 ;	src/flash_driver.c: 96: i++;
      008176 5C               [ 1]  218 	incw	x
      008177 20 DD            [ 2]  219 	jra	00115$
                                    220 ;	src/flash_driver.c: 98: }
      008179 81               [ 4]  221 	ret
                                    222 ;	src/flash_driver.c: 106: uint8_t flash_read_sreg(uint8_t sreg_no)
                                    223 ;	-----------------------------------------
                                    224 ;	 function flash_read_sreg
                                    225 ;	-----------------------------------------
      00817A                        226 _flash_read_sreg:
                                    227 ;	src/flash_driver.c: 109: if (sreg_no == 1)
      00817A 7B 03            [ 1]  228 	ld	a, (0x03, sp)
      00817C 4A               [ 1]  229 	dec	a
      00817D 26 08            [ 1]  230 	jrne	00105$
                                    231 ;	src/flash_driver.c: 110: spi_write_8bits(CMD_READ_SREG_BYTE1);
      00817F 4B 05            [ 1]  232 	push	#0x05
      008181 CD 82 57         [ 4]  233 	call	_spi_write_8bits
      008184 84               [ 1]  234 	pop	a
      008185 20 10            [ 2]  235 	jra	00106$
      008187                        236 00105$:
                                    237 ;	src/flash_driver.c: 111: else if (sreg_no == 2)
      008187 7B 03            [ 1]  238 	ld	a, (0x03, sp)
      008189 A1 02            [ 1]  239 	cp	a, #0x02
      00818B 26 08            [ 1]  240 	jrne	00102$
                                    241 ;	src/flash_driver.c: 112: spi_write_8bits(CMD_READ_SREG_BYTE2);
      00818D 4B 35            [ 1]  242 	push	#0x35
      00818F CD 82 57         [ 4]  243 	call	_spi_write_8bits
      008192 84               [ 1]  244 	pop	a
      008193 20 02            [ 2]  245 	jra	00106$
      008195                        246 00102$:
                                    247 ;	src/flash_driver.c: 114: return 0;
      008195 4F               [ 1]  248 	clr	a
      008196 81               [ 4]  249 	ret
      008197                        250 00106$:
                                    251 ;	src/flash_driver.c: 116: sreg_val = spi_read_8bits();
                                    252 ;	src/flash_driver.c: 118: return sreg_val;
                                    253 ;	src/flash_driver.c: 119: }
      008197 CC 82 64         [ 2]  254 	jp	_spi_read_8bits
                                    255 ;	src/flash_driver.c: 127: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
                                    256 ;	-----------------------------------------
                                    257 ;	 function flash_write_sreg
                                    258 ;	-----------------------------------------
      00819A                        259 _flash_write_sreg:
                                    260 ;	src/flash_driver.c: 129: spi_write_8bits(CMD_WRITE_SREG);
      00819A 4B 01            [ 1]  261 	push	#0x01
      00819C CD 82 57         [ 4]  262 	call	_spi_write_8bits
      00819F 84               [ 1]  263 	pop	a
                                    264 ;	src/flash_driver.c: 130: spi_write_8bits(sreg_byte1);
      0081A0 7B 03            [ 1]  265 	ld	a, (0x03, sp)
      0081A2 88               [ 1]  266 	push	a
      0081A3 CD 82 57         [ 4]  267 	call	_spi_write_8bits
      0081A6 84               [ 1]  268 	pop	a
                                    269 ;	src/flash_driver.c: 131: spi_write_8bits(sreg_byte2);
      0081A7 7B 04            [ 1]  270 	ld	a, (0x04, sp)
      0081A9 88               [ 1]  271 	push	a
      0081AA CD 82 57         [ 4]  272 	call	_spi_write_8bits
      0081AD 84               [ 1]  273 	pop	a
                                    274 ;	src/flash_driver.c: 132: }
      0081AE 81               [ 4]  275 	ret
                                    276 ;	src/flash_driver.c: 138: void flash_busy_wait()
                                    277 ;	-----------------------------------------
                                    278 ;	 function flash_busy_wait
                                    279 ;	-----------------------------------------
      0081AF                        280 _flash_busy_wait:
                                    281 ;	src/flash_driver.c: 140: while (flash_read_sreg(1) & (1 << SREG_BYTE1_BSY));
      0081AF                        282 00101$:
      0081AF 4B 01            [ 1]  283 	push	#0x01
      0081B1 CD 81 7A         [ 4]  284 	call	_flash_read_sreg
      0081B4 5B 01            [ 2]  285 	addw	sp, #1
      0081B6 44               [ 1]  286 	srl	a
      0081B7 25 F6            [ 1]  287 	jrc	00101$
                                    288 ;	src/flash_driver.c: 141: }
      0081B9 81               [ 4]  289 	ret
                                    290 ;	src/flash_driver.c: 150: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
                                    291 ;	-----------------------------------------
                                    292 ;	 function flash_erase_block
                                    293 ;	-----------------------------------------
      0081BA                        294 _flash_erase_block:
                                    295 ;	src/flash_driver.c: 152: spi_write_8bits(cmd_block_erase);
      0081BA 7B 07            [ 1]  296 	ld	a, (0x07, sp)
      0081BC 88               [ 1]  297 	push	a
      0081BD CD 82 57         [ 4]  298 	call	_spi_write_8bits
      0081C0 84               [ 1]  299 	pop	a
                                    300 ;	src/flash_driver.c: 153: spi_write_24bits(addr);
      0081C1 1E 05            [ 2]  301 	ldw	x, (0x05, sp)
      0081C3 89               [ 2]  302 	pushw	x
      0081C4 1E 05            [ 2]  303 	ldw	x, (0x05, sp)
      0081C6 89               [ 2]  304 	pushw	x
      0081C7 CD 82 2B         [ 4]  305 	call	_spi_write_24bits
      0081CA 5B 04            [ 2]  306 	addw	sp, #4
                                    307 ;	src/flash_driver.c: 154: }
      0081CC 81               [ 4]  308 	ret
                                    309 ;	src/flash_driver.c: 160: void flash_write_enable()
                                    310 ;	-----------------------------------------
                                    311 ;	 function flash_write_enable
                                    312 ;	-----------------------------------------
      0081CD                        313 _flash_write_enable:
                                    314 ;	src/flash_driver.c: 162: spi_write_8bits(CMD_WRITE_ENABLE);
      0081CD 4B 06            [ 1]  315 	push	#0x06
      0081CF CD 82 57         [ 4]  316 	call	_spi_write_8bits
      0081D2 84               [ 1]  317 	pop	a
                                    318 ;	src/flash_driver.c: 163: }
      0081D3 81               [ 4]  319 	ret
                                    320 ;	src/flash_driver.c: 168: void flash_erase_chip()
                                    321 ;	-----------------------------------------
                                    322 ;	 function flash_erase_chip
                                    323 ;	-----------------------------------------
      0081D4                        324 _flash_erase_chip:
                                    325 ;	src/flash_driver.c: 170: spi_write_8bits(CMD_CHIP_ERASE);
      0081D4 4B 60            [ 1]  326 	push	#0x60
      0081D6 CD 82 57         [ 4]  327 	call	_spi_write_8bits
      0081D9 84               [ 1]  328 	pop	a
                                    329 ;	src/flash_driver.c: 171: }
      0081DA 81               [ 4]  330 	ret
                                    331 	.area CODE
                                    332 	.area CONST
                                    333 	.area INITIALIZER
                                    334 	.area CABS (ABS)
