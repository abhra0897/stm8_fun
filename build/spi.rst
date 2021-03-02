                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module spi
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _flash_spi_config
                                     12 	.globl _flash_gpio_config
                                     13 	.globl _spi_busy_wait
                                     14 	.globl _spi_write_24bits
                                     15 	.globl _spi_write_8bits
                                     16 	.globl _spi_read_8bits
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	src/spi.c: 6: void flash_spi_config()
                                     55 ;	-----------------------------------------
                                     56 ;	 function flash_spi_config
                                     57 ;	-----------------------------------------
      0081DB                         58 _flash_spi_config:
                                     59 ;	src/spi.c: 9: SPI_CR1 = 0;
      0081DB 35 00 52 00      [ 1]   60 	mov	0x5200+0, #0x00
                                     61 ;	src/spi.c: 10: SPI_CR2 = 0;
      0081DF 35 00 52 01      [ 1]   62 	mov	0x5201+0, #0x00
                                     63 ;	src/spi.c: 13: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
      0081E3 72 1F 52 00      [ 1]   64 	bres	20992, #7
                                     65 ;	src/spi.c: 15: SPI_CR1 |= SPI_CR1_BR(0b111);
      0081E7 C6 52 00         [ 1]   66 	ld	a, 0x5200
      0081EA AA 38            [ 1]   67 	or	a, #0x38
      0081EC C7 52 00         [ 1]   68 	ld	0x5200, a
                                     69 ;	src/spi.c: 19: SPI_CR1 &= ~SPI_CR1_CPOL;
      0081EF 72 13 52 00      [ 1]   70 	bres	20992, #1
                                     71 ;	src/spi.c: 21: SPI_CR1 &= ~SPI_CR1_CPHA;
      0081F3 72 11 52 00      [ 1]   72 	bres	20992, #0
                                     73 ;	src/spi.c: 23: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
      0081F7 72 12 52 01      [ 1]   74 	bset	20993, #1
                                     75 ;	src/spi.c: 24: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
      0081FB 72 10 52 01      [ 1]   76 	bset	20993, #0
                                     77 ;	src/spi.c: 25: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
      0081FF 72 14 52 00      [ 1]   78 	bset	20992, #2
                                     79 ;	src/spi.c: 26: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
      008203 72 1C 52 00      [ 1]   80 	bset	20992, #6
                                     81 ;	src/spi.c: 27: }
      008207 81               [ 4]   82 	ret
                                     83 ;	src/spi.c: 33: void flash_gpio_config()
                                     84 ;	-----------------------------------------
                                     85 ;	 function flash_gpio_config
                                     86 ;	-----------------------------------------
      008208                         87 _flash_gpio_config:
                                     88 ;	src/spi.c: 36: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
      008208 C6 50 0C         [ 1]   89 	ld	a, 0x500c
      00820B AA 60            [ 1]   90 	or	a, #0x60
      00820D C7 50 0C         [ 1]   91 	ld	0x500c, a
                                     92 ;	src/spi.c: 37: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;
      008210 C6 50 0D         [ 1]   93 	ld	a, 0x500d
      008213 AA E0            [ 1]   94 	or	a, #0xe0
      008215 C7 50 0D         [ 1]   95 	ld	0x500d, a
                                     96 ;	src/spi.c: 40: PORT(SPI_PORT, DDR) |= SPI_CS;
      008218 72 18 50 0C      [ 1]   97 	bset	20492, #4
                                     98 ;	src/spi.c: 41: PORT(SPI_PORT, CR1) |= SPI_CS;
      00821C 72 18 50 0D      [ 1]   99 	bset	20493, #4
                                    100 ;	src/spi.c: 42: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
      008220 72 18 50 0A      [ 1]  101 	bset	20490, #4
                                    102 ;	src/spi.c: 43: }
      008224 81               [ 4]  103 	ret
                                    104 ;	src/spi.c: 49: void spi_busy_wait()
                                    105 ;	-----------------------------------------
                                    106 ;	 function spi_busy_wait
                                    107 ;	-----------------------------------------
      008225                        108 _spi_busy_wait:
                                    109 ;	src/spi.c: 51: while (SPI_SR & SPI_SR_BSY);
      008225                        110 00101$:
      008225 C6 52 03         [ 1]  111 	ld	a, 0x5203
      008228 2B FB            [ 1]  112 	jrmi	00101$
                                    113 ;	src/spi.c: 52: }
      00822A 81               [ 4]  114 	ret
                                    115 ;	src/spi.c: 58: void spi_write_24bits(uint32_t data)
                                    116 ;	-----------------------------------------
                                    117 ;	 function spi_write_24bits
                                    118 ;	-----------------------------------------
      00822B                        119 _spi_write_24bits:
      00822B 88               [ 1]  120 	push	a
                                    121 ;	src/spi.c: 60: for (int8_t i = 2; i >= 0; i--)
      00822C A6 02            [ 1]  122 	ld	a, #0x02
      00822E 6B 01            [ 1]  123 	ld	(0x01, sp), a
      008230                        124 00109$:
      008230 0D 01            [ 1]  125 	tnz	(0x01, sp)
      008232 2B 21            [ 1]  126 	jrmi	00111$
                                    127 ;	src/spi.c: 62: SPI_WRITE8(0xFF & (data >> (i << 4)));   // Explanation: i<<4 = i*8 = 16, 8, 0 for i = 2, 1, 0 respectively. So, we're shifting data and then sending
      008234 7B 01            [ 1]  128 	ld	a, (0x01, sp)
      008236 4E               [ 1]  129 	swap	a
      008237 A4 F0            [ 1]  130 	and	a, #0xf0
      008239 1E 06            [ 2]  131 	ldw	x, (0x06, sp)
      00823B 16 04            [ 2]  132 	ldw	y, (0x04, sp)
      00823D 4D               [ 1]  133 	tnz	a
      00823E 27 06            [ 1]  134 	jreq	00136$
      008240                        135 00135$:
      008240 90 54            [ 2]  136 	srlw	y
      008242 56               [ 2]  137 	rrcw	x
      008243 4A               [ 1]  138 	dec	a
      008244 26 FA            [ 1]  139 	jrne	00135$
      008246                        140 00136$:
      008246 9F               [ 1]  141 	ld	a, xl
      008247 C7 52 04         [ 1]  142 	ld	0x5204, a
      00824A                        143 00101$:
      00824A C6 52 03         [ 1]  144 	ld	a, 0x5203
      00824D A5 02            [ 1]  145 	bcp	a, #0x02
      00824F 27 F9            [ 1]  146 	jreq	00101$
                                    147 ;	src/spi.c: 60: for (int8_t i = 2; i >= 0; i--)
      008251 0A 01            [ 1]  148 	dec	(0x01, sp)
      008253 20 DB            [ 2]  149 	jra	00109$
      008255                        150 00111$:
                                    151 ;	src/spi.c: 64: }
      008255 84               [ 1]  152 	pop	a
      008256 81               [ 4]  153 	ret
                                    154 ;	src/spi.c: 70: void spi_write_8bits(uint8_t data)
                                    155 ;	-----------------------------------------
                                    156 ;	 function spi_write_8bits
                                    157 ;	-----------------------------------------
      008257                        158 _spi_write_8bits:
                                    159 ;	src/spi.c: 72: SPI_WRITE8(0xFF & data);
      008257 7B 03            [ 1]  160 	ld	a, (0x03, sp)
      008259 C7 52 04         [ 1]  161 	ld	0x5204, a
      00825C                        162 00101$:
      00825C C6 52 03         [ 1]  163 	ld	a, 0x5203
      00825F A5 02            [ 1]  164 	bcp	a, #0x02
      008261 27 F9            [ 1]  165 	jreq	00101$
                                    166 ;	src/spi.c: 73: }
      008263 81               [ 4]  167 	ret
                                    168 ;	src/spi.c: 79: uint8_t spi_read_8bits()
                                    169 ;	-----------------------------------------
                                    170 ;	 function spi_read_8bits
                                    171 ;	-----------------------------------------
      008264                        172 _spi_read_8bits:
                                    173 ;	src/spi.c: 82: SPI_READ8(d);
      008264 35 FF 52 04      [ 1]  174 	mov	0x5204+0, #0xff
      008268                        175 00101$:
      008268 C6 52 03         [ 1]  176 	ld	a, 0x5203
      00826B A5 02            [ 1]  177 	bcp	a, #0x02
      00826D 27 F9            [ 1]  178 	jreq	00101$
      00826F                        179 00107$:
      00826F C6 52 03         [ 1]  180 	ld	a, 0x5203
      008272 44               [ 1]  181 	srl	a
      008273 24 FA            [ 1]  182 	jrnc	00107$
      008275 C6 52 04         [ 1]  183 	ld	a, 0x5204
                                    184 ;	src/spi.c: 83: return d;
                                    185 ;	src/spi.c: 84: }
      008278 81               [ 4]  186 	ret
                                    187 	.area CODE
                                    188 	.area CONST
                                    189 	.area INITIALIZER
                                    190 	.area CABS (ABS)
