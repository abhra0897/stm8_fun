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
                                     11 	.globl _spi_config
                                     12 	.globl _spi_busy_wait
                                     13 	.globl _spi_write_24bits
                                     14 	.globl _spi_write_8bits
                                     15 	.globl _spi_read_8bits
                                     16 	.globl _spi_cs_active
                                     17 	.globl _spi_cs_idle
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	src/spi.c: 6: void spi_config()
                                     56 ;	-----------------------------------------
                                     57 ;	 function spi_config
                                     58 ;	-----------------------------------------
      008551                         59 _spi_config:
                                     60 ;	src/spi.c: 9: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
      008551 C6 50 0C         [ 1]   61 	ld	a, 0x500c
      008554 AA 60            [ 1]   62 	or	a, #0x60
      008556 C7 50 0C         [ 1]   63 	ld	0x500c, a
                                     64 ;	src/spi.c: 10: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;
      008559 C6 50 0D         [ 1]   65 	ld	a, 0x500d
      00855C AA E0            [ 1]   66 	or	a, #0xe0
      00855E C7 50 0D         [ 1]   67 	ld	0x500d, a
                                     68 ;	src/spi.c: 13: PORT(SPI_PORT, DDR) |= SPI_CS;
      008561 72 18 50 0C      [ 1]   69 	bset	20492, #4
                                     70 ;	src/spi.c: 14: PORT(SPI_PORT, CR1) |= SPI_CS;
      008565 72 18 50 0D      [ 1]   71 	bset	20493, #4
                                     72 ;	src/spi.c: 15: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
      008569 72 18 50 0A      [ 1]   73 	bset	20490, #4
                                     74 ;	src/spi.c: 19: SPI_CR1 = 0;
      00856D 35 00 52 00      [ 1]   75 	mov	0x5200+0, #0x00
                                     76 ;	src/spi.c: 20: SPI_CR2 = 0;
      008571 35 00 52 01      [ 1]   77 	mov	0x5201+0, #0x00
                                     78 ;	src/spi.c: 23: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
      008575 72 1F 52 00      [ 1]   79 	bres	20992, #7
                                     80 ;	src/spi.c: 25: SPI_CR1 |= SPI_CR1_BR(0b111);
      008579 C6 52 00         [ 1]   81 	ld	a, 0x5200
      00857C AA 38            [ 1]   82 	or	a, #0x38
      00857E C7 52 00         [ 1]   83 	ld	0x5200, a
                                     84 ;	src/spi.c: 29: SPI_CR1 &= ~SPI_CR1_CPOL;
      008581 72 13 52 00      [ 1]   85 	bres	20992, #1
                                     86 ;	src/spi.c: 31: SPI_CR1 &= ~SPI_CR1_CPHA;
      008585 72 11 52 00      [ 1]   87 	bres	20992, #0
                                     88 ;	src/spi.c: 33: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
      008589 72 12 52 01      [ 1]   89 	bset	20993, #1
                                     90 ;	src/spi.c: 34: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
      00858D 72 10 52 01      [ 1]   91 	bset	20993, #0
                                     92 ;	src/spi.c: 35: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
      008591 72 14 52 00      [ 1]   93 	bset	20992, #2
                                     94 ;	src/spi.c: 36: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
      008595 72 1C 52 00      [ 1]   95 	bset	20992, #6
                                     96 ;	src/spi.c: 37: }
      008599 81               [ 4]   97 	ret
                                     98 ;	src/spi.c: 43: void spi_busy_wait()
                                     99 ;	-----------------------------------------
                                    100 ;	 function spi_busy_wait
                                    101 ;	-----------------------------------------
      00859A                        102 _spi_busy_wait:
                                    103 ;	src/spi.c: 45: while (SPI_SR & SPI_SR_BSY);
      00859A                        104 00101$:
      00859A C6 52 03         [ 1]  105 	ld	a, 0x5203
      00859D 2B FB            [ 1]  106 	jrmi	00101$
                                    107 ;	src/spi.c: 46: }
      00859F 81               [ 4]  108 	ret
                                    109 ;	src/spi.c: 52: void spi_write_24bits(uint32_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function spi_write_24bits
                                    112 ;	-----------------------------------------
      0085A0                        113 _spi_write_24bits:
      0085A0 88               [ 1]  114 	push	a
                                    115 ;	src/spi.c: 54: for (int8_t i = 2; i >= 0; i--)
      0085A1 A6 02            [ 1]  116 	ld	a, #0x02
      0085A3 6B 01            [ 1]  117 	ld	(0x01, sp), a
      0085A5                        118 00109$:
      0085A5 0D 01            [ 1]  119 	tnz	(0x01, sp)
      0085A7 2B 21            [ 1]  120 	jrmi	00111$
                                    121 ;	src/spi.c: 56: SPI_WRITE8(0xFF & (data >> (i << 4)));   // Explanation: i<<4 = i*8 = 16, 8, 0 for i = 2, 1, 0 respectively. So, we're shifting data and then sending
      0085A9 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      0085AB 4E               [ 1]  123 	swap	a
      0085AC A4 F0            [ 1]  124 	and	a, #0xf0
      0085AE 1E 06            [ 2]  125 	ldw	x, (0x06, sp)
      0085B0 16 04            [ 2]  126 	ldw	y, (0x04, sp)
      0085B2 4D               [ 1]  127 	tnz	a
      0085B3 27 06            [ 1]  128 	jreq	00136$
      0085B5                        129 00135$:
      0085B5 90 54            [ 2]  130 	srlw	y
      0085B7 56               [ 2]  131 	rrcw	x
      0085B8 4A               [ 1]  132 	dec	a
      0085B9 26 FA            [ 1]  133 	jrne	00135$
      0085BB                        134 00136$:
      0085BB 9F               [ 1]  135 	ld	a, xl
      0085BC C7 52 04         [ 1]  136 	ld	0x5204, a
      0085BF                        137 00101$:
      0085BF C6 52 03         [ 1]  138 	ld	a, 0x5203
      0085C2 A5 02            [ 1]  139 	bcp	a, #0x02
      0085C4 27 F9            [ 1]  140 	jreq	00101$
                                    141 ;	src/spi.c: 54: for (int8_t i = 2; i >= 0; i--)
      0085C6 0A 01            [ 1]  142 	dec	(0x01, sp)
      0085C8 20 DB            [ 2]  143 	jra	00109$
      0085CA                        144 00111$:
                                    145 ;	src/spi.c: 58: }
      0085CA 84               [ 1]  146 	pop	a
      0085CB 81               [ 4]  147 	ret
                                    148 ;	src/spi.c: 64: void spi_write_8bits(uint8_t data)
                                    149 ;	-----------------------------------------
                                    150 ;	 function spi_write_8bits
                                    151 ;	-----------------------------------------
      0085CC                        152 _spi_write_8bits:
                                    153 ;	src/spi.c: 66: SPI_WRITE8(0xFF & data);
      0085CC 7B 03            [ 1]  154 	ld	a, (0x03, sp)
      0085CE C7 52 04         [ 1]  155 	ld	0x5204, a
      0085D1                        156 00101$:
      0085D1 C6 52 03         [ 1]  157 	ld	a, 0x5203
      0085D4 A5 02            [ 1]  158 	bcp	a, #0x02
      0085D6 27 F9            [ 1]  159 	jreq	00101$
                                    160 ;	src/spi.c: 67: }
      0085D8 81               [ 4]  161 	ret
                                    162 ;	src/spi.c: 73: uint8_t spi_read_8bits()
                                    163 ;	-----------------------------------------
                                    164 ;	 function spi_read_8bits
                                    165 ;	-----------------------------------------
      0085D9                        166 _spi_read_8bits:
                                    167 ;	src/spi.c: 76: SPI_READ8(d);
      0085D9 35 1A 52 04      [ 1]  168 	mov	0x5204+0, #0x1a
      0085DD                        169 00101$:
      0085DD C6 52 03         [ 1]  170 	ld	a, 0x5203
      0085E0 A5 02            [ 1]  171 	bcp	a, #0x02
      0085E2 27 F9            [ 1]  172 	jreq	00101$
      0085E4                        173 00107$:
      0085E4 C6 52 03         [ 1]  174 	ld	a, 0x5203
      0085E7 44               [ 1]  175 	srl	a
      0085E8 24 FA            [ 1]  176 	jrnc	00107$
      0085EA C6 52 04         [ 1]  177 	ld	a, 0x5204
                                    178 ;	src/spi.c: 77: return d;
                                    179 ;	src/spi.c: 78: }
      0085ED 81               [ 4]  180 	ret
                                    181 ;	src/spi.c: 84: void spi_cs_active()
                                    182 ;	-----------------------------------------
                                    183 ;	 function spi_cs_active
                                    184 ;	-----------------------------------------
      0085EE                        185 _spi_cs_active:
                                    186 ;	src/spi.c: 86: SPI_CS_ACTIVE();
      0085EE 72 19 50 0A      [ 1]  187 	bres	20490, #4
                                    188 ;	src/spi.c: 87: }
      0085F2 81               [ 4]  189 	ret
                                    190 ;	src/spi.c: 93: void spi_cs_idle()
                                    191 ;	-----------------------------------------
                                    192 ;	 function spi_cs_idle
                                    193 ;	-----------------------------------------
      0085F3                        194 _spi_cs_idle:
                                    195 ;	src/spi.c: 95: SPI_CS_IDLE();
      0085F3                        196 00101$:
      0085F3 C6 52 03         [ 1]  197 	ld	a, 0x5203
      0085F6 2B FB            [ 1]  198 	jrmi	00101$
      0085F8 72 18 50 0A      [ 1]  199 	bset	20490, #4
                                    200 ;	src/spi.c: 96: }
      0085FC 81               [ 4]  201 	ret
                                    202 	.area CODE
                                    203 	.area CONST
                                    204 	.area INITIALIZER
                                    205 	.area CABS (ABS)
