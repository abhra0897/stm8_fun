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
      0084E6                         59 _spi_config:
                                     60 ;	src/spi.c: 9: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
      0084E6 C6 50 0C         [ 1]   61 	ld	a, 0x500c
      0084E9 AA 60            [ 1]   62 	or	a, #0x60
      0084EB C7 50 0C         [ 1]   63 	ld	0x500c, a
                                     64 ;	src/spi.c: 10: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;
      0084EE C6 50 0D         [ 1]   65 	ld	a, 0x500d
      0084F1 AA E0            [ 1]   66 	or	a, #0xe0
      0084F3 C7 50 0D         [ 1]   67 	ld	0x500d, a
                                     68 ;	src/spi.c: 13: PORT(SPI_PORT, DDR) |= SPI_CS;
      0084F6 72 18 50 0C      [ 1]   69 	bset	20492, #4
                                     70 ;	src/spi.c: 14: PORT(SPI_PORT, CR1) |= SPI_CS;
      0084FA 72 18 50 0D      [ 1]   71 	bset	20493, #4
                                     72 ;	src/spi.c: 15: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
      0084FE 72 18 50 0A      [ 1]   73 	bset	20490, #4
                                     74 ;	src/spi.c: 19: SPI_CR1 = 0;
      008502 35 00 52 00      [ 1]   75 	mov	0x5200+0, #0x00
                                     76 ;	src/spi.c: 20: SPI_CR2 = 0;
      008506 35 00 52 01      [ 1]   77 	mov	0x5201+0, #0x00
                                     78 ;	src/spi.c: 23: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
      00850A 72 1F 52 00      [ 1]   79 	bres	20992, #7
                                     80 ;	src/spi.c: 25: SPI_CR1 |= SPI_CR1_BR(0b111);
      00850E C6 52 00         [ 1]   81 	ld	a, 0x5200
      008511 AA 38            [ 1]   82 	or	a, #0x38
      008513 C7 52 00         [ 1]   83 	ld	0x5200, a
                                     84 ;	src/spi.c: 29: SPI_CR1 &= ~SPI_CR1_CPOL;
      008516 72 13 52 00      [ 1]   85 	bres	20992, #1
                                     86 ;	src/spi.c: 31: SPI_CR1 &= ~SPI_CR1_CPHA;
      00851A 72 11 52 00      [ 1]   87 	bres	20992, #0
                                     88 ;	src/spi.c: 33: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
      00851E 72 12 52 01      [ 1]   89 	bset	20993, #1
                                     90 ;	src/spi.c: 34: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
      008522 72 10 52 01      [ 1]   91 	bset	20993, #0
                                     92 ;	src/spi.c: 35: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
      008526 72 14 52 00      [ 1]   93 	bset	20992, #2
                                     94 ;	src/spi.c: 36: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
      00852A 72 1C 52 00      [ 1]   95 	bset	20992, #6
                                     96 ;	src/spi.c: 37: }
      00852E 81               [ 4]   97 	ret
                                     98 ;	src/spi.c: 43: void spi_busy_wait()
                                     99 ;	-----------------------------------------
                                    100 ;	 function spi_busy_wait
                                    101 ;	-----------------------------------------
      00852F                        102 _spi_busy_wait:
                                    103 ;	src/spi.c: 45: while (SPI_SR & SPI_SR_BSY);
      00852F                        104 00101$:
      00852F C6 52 03         [ 1]  105 	ld	a, 0x5203
      008532 2B FB            [ 1]  106 	jrmi	00101$
                                    107 ;	src/spi.c: 46: }
      008534 81               [ 4]  108 	ret
                                    109 ;	src/spi.c: 52: void spi_write_24bits(uint32_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function spi_write_24bits
                                    112 ;	-----------------------------------------
      008535                        113 _spi_write_24bits:
                                    114 ;	src/spi.c: 59: SPI_WRITE8(data >> 16);
      008535 1E 03            [ 2]  115 	ldw	x, (0x03, sp)
      008537 9F               [ 1]  116 	ld	a, xl
      008538 C7 52 04         [ 1]  117 	ld	0x5204, a
      00853B                        118 00101$:
      00853B C6 52 03         [ 1]  119 	ld	a, 0x5203
      00853E A5 02            [ 1]  120 	bcp	a, #0x02
      008540 27 F9            [ 1]  121 	jreq	00101$
      008542 C6 52 04         [ 1]  122 	ld	a, 0x5204
                                    123 ;	src/spi.c: 60: SPI_WRITE8(data >> 8);
      008545 1E 05            [ 2]  124 	ldw	x, (0x05, sp)
      008547 9E               [ 1]  125 	ld	a, xh
      008548 5F               [ 1]  126 	clrw	x
      008549 C7 52 04         [ 1]  127 	ld	0x5204, a
      00854C                        128 00107$:
      00854C C6 52 03         [ 1]  129 	ld	a, 0x5203
      00854F A5 02            [ 1]  130 	bcp	a, #0x02
      008551 27 F9            [ 1]  131 	jreq	00107$
      008553 C6 52 04         [ 1]  132 	ld	a, 0x5204
                                    133 ;	src/spi.c: 61: SPI_WRITE8(data >> 0);
      008556 7B 06            [ 1]  134 	ld	a, (0x06, sp)
      008558 C7 52 04         [ 1]  135 	ld	0x5204, a
      00855B                        136 00113$:
      00855B C6 52 03         [ 1]  137 	ld	a, 0x5203
      00855E A5 02            [ 1]  138 	bcp	a, #0x02
      008560 27 F9            [ 1]  139 	jreq	00113$
      008562 C6 52 04         [ 1]  140 	ld	a, 0x5204
                                    141 ;	src/spi.c: 62: }
      008565 81               [ 4]  142 	ret
                                    143 ;	src/spi.c: 68: void spi_write_8bits(uint8_t data)
                                    144 ;	-----------------------------------------
                                    145 ;	 function spi_write_8bits
                                    146 ;	-----------------------------------------
      008566                        147 _spi_write_8bits:
                                    148 ;	src/spi.c: 70: SPI_WRITE8(data);
      008566 AE 52 04         [ 2]  149 	ldw	x, #0x5204
      008569 7B 03            [ 1]  150 	ld	a, (0x03, sp)
      00856B F7               [ 1]  151 	ld	(x), a
      00856C                        152 00101$:
      00856C C6 52 03         [ 1]  153 	ld	a, 0x5203
      00856F A5 02            [ 1]  154 	bcp	a, #0x02
      008571 27 F9            [ 1]  155 	jreq	00101$
      008573 C6 52 04         [ 1]  156 	ld	a, 0x5204
                                    157 ;	src/spi.c: 71: }
      008576 81               [ 4]  158 	ret
                                    159 ;	src/spi.c: 77: uint8_t spi_read_8bits()
                                    160 ;	-----------------------------------------
                                    161 ;	 function spi_read_8bits
                                    162 ;	-----------------------------------------
      008577                        163 _spi_read_8bits:
                                    164 ;	src/spi.c: 80: SPI_READ8(d);
      008577 35 FF 52 04      [ 1]  165 	mov	0x5204+0, #0xff
      00857B                        166 00101$:
      00857B C6 52 03         [ 1]  167 	ld	a, 0x5203
      00857E A5 02            [ 1]  168 	bcp	a, #0x02
      008580 27 F9            [ 1]  169 	jreq	00101$
      008582 C6 52 04         [ 1]  170 	ld	a, 0x5204
      008585                        171 00107$:
      008585 C6 52 03         [ 1]  172 	ld	a, 0x5203
      008588 44               [ 1]  173 	srl	a
      008589 24 FA            [ 1]  174 	jrnc	00107$
      00858B C6 52 04         [ 1]  175 	ld	a, 0x5204
      00858E C6 52 04         [ 1]  176 	ld	a, 0x5204
                                    177 ;	src/spi.c: 81: return d;
                                    178 ;	src/spi.c: 82: }
      008591 81               [ 4]  179 	ret
                                    180 ;	src/spi.c: 88: void spi_cs_active()
                                    181 ;	-----------------------------------------
                                    182 ;	 function spi_cs_active
                                    183 ;	-----------------------------------------
      008592                        184 _spi_cs_active:
                                    185 ;	src/spi.c: 90: SPI_CS_ACTIVE();
      008592 72 19 50 0A      [ 1]  186 	bres	20490, #4
                                    187 ;	src/spi.c: 91: }
      008596 81               [ 4]  188 	ret
                                    189 ;	src/spi.c: 97: void spi_cs_idle()
                                    190 ;	-----------------------------------------
                                    191 ;	 function spi_cs_idle
                                    192 ;	-----------------------------------------
      008597                        193 _spi_cs_idle:
                                    194 ;	src/spi.c: 99: SPI_CS_IDLE();
      008597                        195 00101$:
      008597 C6 52 03         [ 1]  196 	ld	a, 0x5203
      00859A 2B FB            [ 1]  197 	jrmi	00101$
      00859C 72 18 50 0A      [ 1]  198 	bset	20490, #4
                                    199 ;	src/spi.c: 100: }
      0085A0 81               [ 4]  200 	ret
                                    201 	.area CODE
                                    202 	.area CONST
                                    203 	.area INITIALIZER
                                    204 	.area CABS (ABS)
