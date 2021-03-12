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
      0086AD                         59 _spi_config:
                                     60 ;	src/spi.c: 9: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI are Output
      0086AD C6 50 0C         [ 1]   61 	ld	a, 0x500c
      0086B0 AA 60            [ 1]   62 	or	a, #0x60
      0086B2 C7 50 0C         [ 1]   63 	ld	0x500c, a
                                     64 ;	src/spi.c: 10: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO; //Clk and MOSI are push-pull and MISO is pullup
      0086B5 C6 50 0D         [ 1]   65 	ld	a, 0x500d
      0086B8 AA E0            [ 1]   66 	or	a, #0xe0
      0086BA C7 50 0D         [ 1]   67 	ld	0x500d, a
                                     68 ;	src/spi.c: 11: PORT(SPI_PORT, CR2) |= SPI_CLK | SPI_MOSI;  // Clk and MOSI are high speed (10MHz)
      0086BD C6 50 0E         [ 1]   69 	ld	a, 0x500e
      0086C0 AA 60            [ 1]   70 	or	a, #0x60
      0086C2 C7 50 0E         [ 1]   71 	ld	0x500e, a
                                     72 ;	src/spi.c: 14: PORT(SPI_PORT, DDR) |= SPI_CS; // Output
      0086C5 72 18 50 0C      [ 1]   73 	bset	20492, #4
                                     74 ;	src/spi.c: 15: PORT(SPI_PORT, CR1) |= SPI_CS; // Push-pull
      0086C9 72 18 50 0D      [ 1]   75 	bset	20493, #4
                                     76 ;	src/spi.c: 16: PORT(SPI_PORT, CR2) |= SPI_CS; // High speed
      0086CD 72 18 50 0E      [ 1]   77 	bset	20494, #4
                                     78 ;	src/spi.c: 17: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
      0086D1 72 18 50 0A      [ 1]   79 	bset	20490, #4
                                     80 ;	src/spi.c: 21: SPI_CR1 = 0;
      0086D5 35 00 52 00      [ 1]   81 	mov	0x5200+0, #0x00
                                     82 ;	src/spi.c: 22: SPI_CR2 = 0;
      0086D9 35 00 52 01      [ 1]   83 	mov	0x5201+0, #0x00
                                     84 ;	src/spi.c: 25: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
      0086DD 72 1F 52 00      [ 1]   85 	bres	20992, #7
                                     86 ;	src/spi.c: 27: SPI_CR1 |= SPI_CR1_BR(0b111);
      0086E1 C6 52 00         [ 1]   87 	ld	a, 0x5200
      0086E4 AA 38            [ 1]   88 	or	a, #0x38
      0086E6 C7 52 00         [ 1]   89 	ld	0x5200, a
                                     90 ;	src/spi.c: 31: SPI_CR1 &= ~SPI_CR1_CPOL;
      0086E9 72 13 52 00      [ 1]   91 	bres	20992, #1
                                     92 ;	src/spi.c: 33: SPI_CR1 &= ~SPI_CR1_CPHA;
      0086ED 72 11 52 00      [ 1]   93 	bres	20992, #0
                                     94 ;	src/spi.c: 35: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
      0086F1 72 12 52 01      [ 1]   95 	bset	20993, #1
                                     96 ;	src/spi.c: 36: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
      0086F5 72 10 52 01      [ 1]   97 	bset	20993, #0
                                     98 ;	src/spi.c: 37: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
      0086F9 72 14 52 00      [ 1]   99 	bset	20992, #2
                                    100 ;	src/spi.c: 38: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
      0086FD 72 1C 52 00      [ 1]  101 	bset	20992, #6
                                    102 ;	src/spi.c: 39: }
      008701 81               [ 4]  103 	ret
                                    104 ;	src/spi.c: 45: void spi_busy_wait()
                                    105 ;	-----------------------------------------
                                    106 ;	 function spi_busy_wait
                                    107 ;	-----------------------------------------
      008702                        108 _spi_busy_wait:
                                    109 ;	src/spi.c: 47: while (SPI_SR & SPI_SR_BSY);
      008702                        110 00101$:
      008702 C6 52 03         [ 1]  111 	ld	a, 0x5203
      008705 2B FB            [ 1]  112 	jrmi	00101$
                                    113 ;	src/spi.c: 48: }
      008707 81               [ 4]  114 	ret
                                    115 ;	src/spi.c: 54: void spi_write_24bits(uint32_t data)
                                    116 ;	-----------------------------------------
                                    117 ;	 function spi_write_24bits
                                    118 ;	-----------------------------------------
      008708                        119 _spi_write_24bits:
                                    120 ;	src/spi.c: 61: SPI_WRITE8(data >> 16);
      008708 1E 03            [ 2]  121 	ldw	x, (0x03, sp)
      00870A 9F               [ 1]  122 	ld	a, xl
      00870B C7 52 04         [ 1]  123 	ld	0x5204, a
      00870E                        124 00101$:
      00870E C6 52 03         [ 1]  125 	ld	a, 0x5203
      008711 A5 02            [ 1]  126 	bcp	a, #0x02
      008713 27 F9            [ 1]  127 	jreq	00101$
      008715 C6 52 04         [ 1]  128 	ld	a, 0x5204
                                    129 ;	src/spi.c: 62: SPI_WRITE8(data >> 8);
      008718 1E 05            [ 2]  130 	ldw	x, (0x05, sp)
      00871A 9E               [ 1]  131 	ld	a, xh
      00871B 5F               [ 1]  132 	clrw	x
      00871C C7 52 04         [ 1]  133 	ld	0x5204, a
      00871F                        134 00107$:
      00871F C6 52 03         [ 1]  135 	ld	a, 0x5203
      008722 A5 02            [ 1]  136 	bcp	a, #0x02
      008724 27 F9            [ 1]  137 	jreq	00107$
      008726 C6 52 04         [ 1]  138 	ld	a, 0x5204
                                    139 ;	src/spi.c: 63: SPI_WRITE8(data >> 0);
      008729 7B 06            [ 1]  140 	ld	a, (0x06, sp)
      00872B C7 52 04         [ 1]  141 	ld	0x5204, a
      00872E                        142 00113$:
      00872E C6 52 03         [ 1]  143 	ld	a, 0x5203
      008731 A5 02            [ 1]  144 	bcp	a, #0x02
      008733 27 F9            [ 1]  145 	jreq	00113$
      008735 C6 52 04         [ 1]  146 	ld	a, 0x5204
                                    147 ;	src/spi.c: 64: }
      008738 81               [ 4]  148 	ret
                                    149 ;	src/spi.c: 70: void spi_write_8bits(uint8_t data)
                                    150 ;	-----------------------------------------
                                    151 ;	 function spi_write_8bits
                                    152 ;	-----------------------------------------
      008739                        153 _spi_write_8bits:
                                    154 ;	src/spi.c: 72: SPI_WRITE8(data);
      008739 AE 52 04         [ 2]  155 	ldw	x, #0x5204
      00873C 7B 03            [ 1]  156 	ld	a, (0x03, sp)
      00873E F7               [ 1]  157 	ld	(x), a
      00873F                        158 00101$:
      00873F C6 52 03         [ 1]  159 	ld	a, 0x5203
      008742 A5 02            [ 1]  160 	bcp	a, #0x02
      008744 27 F9            [ 1]  161 	jreq	00101$
      008746 C6 52 04         [ 1]  162 	ld	a, 0x5204
                                    163 ;	src/spi.c: 73: }
      008749 81               [ 4]  164 	ret
                                    165 ;	src/spi.c: 79: uint8_t spi_read_8bits()
                                    166 ;	-----------------------------------------
                                    167 ;	 function spi_read_8bits
                                    168 ;	-----------------------------------------
      00874A                        169 _spi_read_8bits:
                                    170 ;	src/spi.c: 82: SPI_READ8(d);
      00874A 35 FF 52 04      [ 1]  171 	mov	0x5204+0, #0xff
      00874E                        172 00101$:
      00874E C6 52 03         [ 1]  173 	ld	a, 0x5203
      008751 A5 02            [ 1]  174 	bcp	a, #0x02
      008753 27 F9            [ 1]  175 	jreq	00101$
      008755 C6 52 04         [ 1]  176 	ld	a, 0x5204
      008758                        177 00107$:
      008758 C6 52 03         [ 1]  178 	ld	a, 0x5203
      00875B 44               [ 1]  179 	srl	a
      00875C 24 FA            [ 1]  180 	jrnc	00107$
      00875E C6 52 04         [ 1]  181 	ld	a, 0x5204
      008761 C6 52 04         [ 1]  182 	ld	a, 0x5204
                                    183 ;	src/spi.c: 83: return d;
                                    184 ;	src/spi.c: 84: }
      008764 81               [ 4]  185 	ret
                                    186 ;	src/spi.c: 90: void spi_cs_active()
                                    187 ;	-----------------------------------------
                                    188 ;	 function spi_cs_active
                                    189 ;	-----------------------------------------
      008765                        190 _spi_cs_active:
                                    191 ;	src/spi.c: 92: SPI_CS_ACTIVE();
      008765 72 19 50 0A      [ 1]  192 	bres	20490, #4
                                    193 ;	src/spi.c: 93: }
      008769 81               [ 4]  194 	ret
                                    195 ;	src/spi.c: 99: void spi_cs_idle()
                                    196 ;	-----------------------------------------
                                    197 ;	 function spi_cs_idle
                                    198 ;	-----------------------------------------
      00876A                        199 _spi_cs_idle:
                                    200 ;	src/spi.c: 101: SPI_CS_IDLE();
      00876A                        201 00101$:
      00876A C6 52 03         [ 1]  202 	ld	a, 0x5203
      00876D 2B FB            [ 1]  203 	jrmi	00101$
      00876F 72 18 50 0A      [ 1]  204 	bset	20490, #4
                                    205 ;	src/spi.c: 102: }
      008773 81               [ 4]  206 	ret
                                    207 	.area CODE
                                    208 	.area CONST
                                    209 	.area INITIALIZER
                                    210 	.area CABS (ABS)
