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
      0084F1                         59 _spi_config:
                                     60 ;	src/spi.c: 9: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI are Output
      0084F1 C6 50 0C         [ 1]   61 	ld	a, 0x500c
      0084F4 AA 60            [ 1]   62 	or	a, #0x60
      0084F6 C7 50 0C         [ 1]   63 	ld	0x500c, a
                                     64 ;	src/spi.c: 10: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO; //Clk and MOSI are push-pull and MISO is pullup
      0084F9 C6 50 0D         [ 1]   65 	ld	a, 0x500d
      0084FC AA E0            [ 1]   66 	or	a, #0xe0
      0084FE C7 50 0D         [ 1]   67 	ld	0x500d, a
                                     68 ;	src/spi.c: 11: PORT(SPI_PORT, CR2) |= SPI_CLK | SPI_MOSI;  // Clk and MOSI are high speed (10MHz)
      008501 C6 50 0E         [ 1]   69 	ld	a, 0x500e
      008504 AA 60            [ 1]   70 	or	a, #0x60
      008506 C7 50 0E         [ 1]   71 	ld	0x500e, a
                                     72 ;	src/spi.c: 14: PORT(SPI_PORT, DDR) |= SPI_CS; // Output
      008509 72 18 50 0C      [ 1]   73 	bset	20492, #4
                                     74 ;	src/spi.c: 15: PORT(SPI_PORT, CR1) |= SPI_CS; // Push-pull
      00850D 72 18 50 0D      [ 1]   75 	bset	20493, #4
                                     76 ;	src/spi.c: 16: PORT(SPI_PORT, CR2) |= SPI_CS; // High speed
      008511 72 18 50 0E      [ 1]   77 	bset	20494, #4
                                     78 ;	src/spi.c: 17: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
      008515 72 18 50 0A      [ 1]   79 	bset	20490, #4
                                     80 ;	src/spi.c: 21: SPI_CR1 = 0;
      008519 35 00 52 00      [ 1]   81 	mov	0x5200+0, #0x00
                                     82 ;	src/spi.c: 22: SPI_CR2 = 0;
      00851D 35 00 52 01      [ 1]   83 	mov	0x5201+0, #0x00
                                     84 ;	src/spi.c: 25: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
      008521 72 1F 52 00      [ 1]   85 	bres	20992, #7
                                     86 ;	src/spi.c: 27: SPI_CR1 |= SPI_CR1_BR(0b111);
      008525 C6 52 00         [ 1]   87 	ld	a, 0x5200
      008528 AA 38            [ 1]   88 	or	a, #0x38
      00852A C7 52 00         [ 1]   89 	ld	0x5200, a
                                     90 ;	src/spi.c: 31: SPI_CR1 &= ~SPI_CR1_CPOL;
      00852D 72 13 52 00      [ 1]   91 	bres	20992, #1
                                     92 ;	src/spi.c: 33: SPI_CR1 &= ~SPI_CR1_CPHA;
      008531 72 11 52 00      [ 1]   93 	bres	20992, #0
                                     94 ;	src/spi.c: 35: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
      008535 72 12 52 01      [ 1]   95 	bset	20993, #1
                                     96 ;	src/spi.c: 36: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
      008539 72 10 52 01      [ 1]   97 	bset	20993, #0
                                     98 ;	src/spi.c: 37: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
      00853D 72 14 52 00      [ 1]   99 	bset	20992, #2
                                    100 ;	src/spi.c: 38: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
      008541 72 1C 52 00      [ 1]  101 	bset	20992, #6
                                    102 ;	src/spi.c: 39: }
      008545 81               [ 4]  103 	ret
                                    104 ;	src/spi.c: 45: void spi_busy_wait()
                                    105 ;	-----------------------------------------
                                    106 ;	 function spi_busy_wait
                                    107 ;	-----------------------------------------
      008546                        108 _spi_busy_wait:
                                    109 ;	src/spi.c: 47: while (SPI_SR & SPI_SR_BSY);
      008546                        110 00101$:
      008546 C6 52 03         [ 1]  111 	ld	a, 0x5203
      008549 2B FB            [ 1]  112 	jrmi	00101$
                                    113 ;	src/spi.c: 48: }
      00854B 81               [ 4]  114 	ret
                                    115 ;	src/spi.c: 54: void spi_write_24bits(uint32_t data)
                                    116 ;	-----------------------------------------
                                    117 ;	 function spi_write_24bits
                                    118 ;	-----------------------------------------
      00854C                        119 _spi_write_24bits:
                                    120 ;	src/spi.c: 61: SPI_WRITE8(data >> 16);
      00854C 1E 03            [ 2]  121 	ldw	x, (0x03, sp)
      00854E 9F               [ 1]  122 	ld	a, xl
      00854F C7 52 04         [ 1]  123 	ld	0x5204, a
      008552                        124 00101$:
      008552 C6 52 03         [ 1]  125 	ld	a, 0x5203
      008555 A5 02            [ 1]  126 	bcp	a, #0x02
      008557 27 F9            [ 1]  127 	jreq	00101$
      008559 C6 52 04         [ 1]  128 	ld	a, 0x5204
                                    129 ;	src/spi.c: 62: SPI_WRITE8(data >> 8);
      00855C 1E 05            [ 2]  130 	ldw	x, (0x05, sp)
      00855E 9E               [ 1]  131 	ld	a, xh
      00855F 5F               [ 1]  132 	clrw	x
      008560 C7 52 04         [ 1]  133 	ld	0x5204, a
      008563                        134 00107$:
      008563 C6 52 03         [ 1]  135 	ld	a, 0x5203
      008566 A5 02            [ 1]  136 	bcp	a, #0x02
      008568 27 F9            [ 1]  137 	jreq	00107$
      00856A C6 52 04         [ 1]  138 	ld	a, 0x5204
                                    139 ;	src/spi.c: 63: SPI_WRITE8(data >> 0);
      00856D 7B 06            [ 1]  140 	ld	a, (0x06, sp)
      00856F C7 52 04         [ 1]  141 	ld	0x5204, a
      008572                        142 00113$:
      008572 C6 52 03         [ 1]  143 	ld	a, 0x5203
      008575 A5 02            [ 1]  144 	bcp	a, #0x02
      008577 27 F9            [ 1]  145 	jreq	00113$
      008579 C6 52 04         [ 1]  146 	ld	a, 0x5204
                                    147 ;	src/spi.c: 64: }
      00857C 81               [ 4]  148 	ret
                                    149 ;	src/spi.c: 70: void spi_write_8bits(uint8_t data)
                                    150 ;	-----------------------------------------
                                    151 ;	 function spi_write_8bits
                                    152 ;	-----------------------------------------
      00857D                        153 _spi_write_8bits:
                                    154 ;	src/spi.c: 72: SPI_WRITE8(data);
      00857D AE 52 04         [ 2]  155 	ldw	x, #0x5204
      008580 7B 03            [ 1]  156 	ld	a, (0x03, sp)
      008582 F7               [ 1]  157 	ld	(x), a
      008583                        158 00101$:
      008583 C6 52 03         [ 1]  159 	ld	a, 0x5203
      008586 A5 02            [ 1]  160 	bcp	a, #0x02
      008588 27 F9            [ 1]  161 	jreq	00101$
      00858A C6 52 04         [ 1]  162 	ld	a, 0x5204
                                    163 ;	src/spi.c: 73: }
      00858D 81               [ 4]  164 	ret
                                    165 ;	src/spi.c: 79: uint8_t spi_read_8bits()
                                    166 ;	-----------------------------------------
                                    167 ;	 function spi_read_8bits
                                    168 ;	-----------------------------------------
      00858E                        169 _spi_read_8bits:
                                    170 ;	src/spi.c: 82: SPI_READ8(d);
      00858E 35 FF 52 04      [ 1]  171 	mov	0x5204+0, #0xff
      008592                        172 00101$:
      008592 C6 52 03         [ 1]  173 	ld	a, 0x5203
      008595 A5 02            [ 1]  174 	bcp	a, #0x02
      008597 27 F9            [ 1]  175 	jreq	00101$
      008599 C6 52 04         [ 1]  176 	ld	a, 0x5204
      00859C                        177 00107$:
      00859C C6 52 03         [ 1]  178 	ld	a, 0x5203
      00859F 44               [ 1]  179 	srl	a
      0085A0 24 FA            [ 1]  180 	jrnc	00107$
      0085A2 C6 52 04         [ 1]  181 	ld	a, 0x5204
      0085A5 C6 52 04         [ 1]  182 	ld	a, 0x5204
                                    183 ;	src/spi.c: 83: return d;
                                    184 ;	src/spi.c: 84: }
      0085A8 81               [ 4]  185 	ret
                                    186 ;	src/spi.c: 90: void spi_cs_active()
                                    187 ;	-----------------------------------------
                                    188 ;	 function spi_cs_active
                                    189 ;	-----------------------------------------
      0085A9                        190 _spi_cs_active:
                                    191 ;	src/spi.c: 92: SPI_CS_ACTIVE();
      0085A9 72 19 50 0A      [ 1]  192 	bres	20490, #4
                                    193 ;	src/spi.c: 93: }
      0085AD 81               [ 4]  194 	ret
                                    195 ;	src/spi.c: 99: void spi_cs_idle()
                                    196 ;	-----------------------------------------
                                    197 ;	 function spi_cs_idle
                                    198 ;	-----------------------------------------
      0085AE                        199 _spi_cs_idle:
                                    200 ;	src/spi.c: 101: SPI_CS_IDLE();
      0085AE                        201 00101$:
      0085AE C6 52 03         [ 1]  202 	ld	a, 0x5203
      0085B1 2B FB            [ 1]  203 	jrmi	00101$
      0085B3 72 18 50 0A      [ 1]  204 	bset	20490, #4
                                    205 ;	src/spi.c: 102: }
      0085B7 81               [ 4]  206 	ret
                                    207 	.area CODE
                                    208 	.area CONST
                                    209 	.area INITIALIZER
                                    210 	.area CABS (ABS)
