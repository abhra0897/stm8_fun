                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _strlen
                                     13 	.globl _spi_init
                                     14 	.globl _uart_init
                                     15 	.globl _gpio_init
                                     16 	.globl _uart_write
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram 
                                     27 ;--------------------------------------------------------
                                     28 	.area	SSEG
      FFFFFF                         29 __start__stack:
      FFFFFF                         30 	.ds	1
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; interrupt vector 
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
      008000                         49 __interrupt_vect:
      008000 82 00 80 07             50 	int s_GSINIT ; reset
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
      008007                         58 __sdcc_gs_init_startup:
      008007                         59 __sdcc_init_data:
                                     60 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   61 	ldw x, #l_DATA
      00800A 27 07            [ 1]   62 	jreq	00002$
      00800C                         63 00001$:
      00800C 72 4F 00 00      [ 1]   64 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   65 	decw x
      008011 26 F9            [ 1]   66 	jrne	00001$
      008013                         67 00002$:
      008013 AE 00 00         [ 2]   68 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   69 	jreq	00004$
      008018                         70 00003$:
      008018 D6 80 32         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   72 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   73 	decw	x
      00801F 26 F7            [ 1]   74 	jrne	00003$
      008021                         75 00004$:
                                     76 ; stm8_genXINIT() end
                                     77 	.area GSFINAL
      008021 CC 80 04         [ 2]   78 	jp	__sdcc_program_startup
                                     79 ;--------------------------------------------------------
                                     80 ; Home
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area HOME
      008004                         84 __sdcc_program_startup:
      008004 CC 80 33         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	src/main.c: 14: void main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008033                         95 _main:
      008033 52 08            [ 2]   96 	sub	sp, #8
                                     97 ;	src/main.c: 17: CLK_CKDIVR = 0;
      008035 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	src/main.c: 18: uart_init();
      008039 CD 80 8D         [ 4]  100 	call	_uart_init
                                    101 ;	src/main.c: 20: while(1)
      00803C                        102 00103$:
                                    103 ;	src/main.c: 22: uart_write("Hello World!\r\n");
      00803C 4B 24            [ 1]  104 	push	#<(___str_0 + 0)
      00803E 4B 80            [ 1]  105 	push	#((___str_0 + 0) >> 8)
      008040 CD 80 A3         [ 4]  106 	call	_uart_write
      008043 5B 02            [ 2]  107 	addw	sp, #2
                                    108 ;	src/main.c: 23: for(uint64_t i = 0; i < 10000; i++);
      008045 5F               [ 1]  109 	clrw	x
      008046 1F 07            [ 2]  110 	ldw	(0x07, sp), x
      008048 1F 05            [ 2]  111 	ldw	(0x05, sp), x
      00804A 1F 03            [ 2]  112 	ldw	(0x03, sp), x
      00804C 1F 01            [ 2]  113 	ldw	(0x01, sp), x
      00804E                        114 00106$:
      00804E 1E 07            [ 2]  115 	ldw	x, (0x07, sp)
      008050 A3 27 10         [ 2]  116 	cpw	x, #0x2710
      008053 7B 06            [ 1]  117 	ld	a, (0x06, sp)
      008055 A2 00            [ 1]  118 	sbc	a, #0x00
      008057 7B 05            [ 1]  119 	ld	a, (0x05, sp)
      008059 A2 00            [ 1]  120 	sbc	a, #0x00
      00805B 7B 04            [ 1]  121 	ld	a, (0x04, sp)
      00805D A2 00            [ 1]  122 	sbc	a, #0x00
      00805F 7B 03            [ 1]  123 	ld	a, (0x03, sp)
      008061 A2 00            [ 1]  124 	sbc	a, #0x00
      008063 7B 02            [ 1]  125 	ld	a, (0x02, sp)
      008065 A2 00            [ 1]  126 	sbc	a, #0x00
      008067 7B 01            [ 1]  127 	ld	a, (0x01, sp)
      008069 A2 00            [ 1]  128 	sbc	a, #0x00
      00806B 24 CF            [ 1]  129 	jrnc	00103$
      00806D 1E 07            [ 2]  130 	ldw	x, (0x07, sp)
      00806F 5C               [ 1]  131 	incw	x
      008070 1F 07            [ 2]  132 	ldw	(0x07, sp), x
      008072 26 DA            [ 1]  133 	jrne	00106$
      008074 1E 05            [ 2]  134 	ldw	x, (0x05, sp)
      008076 5C               [ 1]  135 	incw	x
      008077 1F 05            [ 2]  136 	ldw	(0x05, sp), x
      008079 26 D3            [ 1]  137 	jrne	00106$
      00807B 1E 03            [ 2]  138 	ldw	x, (0x03, sp)
      00807D 5C               [ 1]  139 	incw	x
      00807E 1F 03            [ 2]  140 	ldw	(0x03, sp), x
      008080 26 CC            [ 1]  141 	jrne	00106$
      008082 1E 01            [ 2]  142 	ldw	x, (0x01, sp)
      008084 5C               [ 1]  143 	incw	x
      008085 1F 01            [ 2]  144 	ldw	(0x01, sp), x
      008087 20 C5            [ 2]  145 	jra	00106$
                                    146 ;	src/main.c: 26: }
      008089 5B 08            [ 2]  147 	addw	sp, #8
      00808B 81               [ 4]  148 	ret
                                    149 ;	src/main.c: 28: void spi_init()
                                    150 ;	-----------------------------------------
                                    151 ;	 function spi_init
                                    152 ;	-----------------------------------------
      00808C                        153 _spi_init:
                                    154 ;	src/main.c: 31: }
      00808C 81               [ 4]  155 	ret
                                    156 ;	src/main.c: 33: void uart_init()
                                    157 ;	-----------------------------------------
                                    158 ;	 function uart_init
                                    159 ;	-----------------------------------------
      00808D                        160 _uart_init:
                                    161 ;	src/main.c: 36: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00808D 72 16 52 35      [ 1]  162 	bset	21045, #3
                                    163 ;	src/main.c: 38: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008091 C6 52 36         [ 1]  164 	ld	a, 0x5236
      008094 A4 CF            [ 1]  165 	and	a, #0xcf
      008096 C7 52 36         [ 1]  166 	ld	0x5236, a
                                    167 ;	src/main.c: 40: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see page 365 and 336 of ref manual)
      008099 35 03 52 33      [ 1]  168 	mov	0x5233+0, #0x03
      00809D 35 68 52 32      [ 1]  169 	mov	0x5232+0, #0x68
                                    170 ;	src/main.c: 41: }
      0080A1 81               [ 4]  171 	ret
                                    172 ;	src/main.c: 43: void gpio_init()
                                    173 ;	-----------------------------------------
                                    174 ;	 function gpio_init
                                    175 ;	-----------------------------------------
      0080A2                        176 _gpio_init:
                                    177 ;	src/main.c: 46: }
      0080A2 81               [ 4]  178 	ret
                                    179 ;	src/main.c: 48: uint16_t uart_write(const char *str) {
                                    180 ;	-----------------------------------------
                                    181 ;	 function uart_write
                                    182 ;	-----------------------------------------
      0080A3                        183 _uart_write:
      0080A3 52 03            [ 2]  184 	sub	sp, #3
                                    185 ;	src/main.c: 50: for(i = 0; i < strlen(str); i++) {
      0080A5 0F 03            [ 1]  186 	clr	(0x03, sp)
      0080A7                        187 00106$:
      0080A7 1E 06            [ 2]  188 	ldw	x, (0x06, sp)
      0080A9 89               [ 2]  189 	pushw	x
      0080AA CD 82 79         [ 4]  190 	call	_strlen
      0080AD 5B 02            [ 2]  191 	addw	sp, #2
      0080AF 1F 01            [ 2]  192 	ldw	(0x01, sp), x
      0080B1 5F               [ 1]  193 	clrw	x
      0080B2 7B 03            [ 1]  194 	ld	a, (0x03, sp)
      0080B4 97               [ 1]  195 	ld	xl, a
      0080B5 13 01            [ 2]  196 	cpw	x, (0x01, sp)
      0080B7 24 14            [ 1]  197 	jrnc	00104$
                                    198 ;	src/main.c: 51: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0080B9                        199 00101$:
      0080B9 C6 52 30         [ 1]  200 	ld	a, 0x5230
      0080BC 2A FB            [ 1]  201 	jrpl	00101$
                                    202 ;	src/main.c: 52: UART1_DR = str[i];
      0080BE 5F               [ 1]  203 	clrw	x
      0080BF 7B 03            [ 1]  204 	ld	a, (0x03, sp)
      0080C1 97               [ 1]  205 	ld	xl, a
      0080C2 72 FB 06         [ 2]  206 	addw	x, (0x06, sp)
      0080C5 F6               [ 1]  207 	ld	a, (x)
      0080C6 C7 52 31         [ 1]  208 	ld	0x5231, a
                                    209 ;	src/main.c: 50: for(i = 0; i < strlen(str); i++) {
      0080C9 0C 03            [ 1]  210 	inc	(0x03, sp)
      0080CB 20 DA            [ 2]  211 	jra	00106$
      0080CD                        212 00104$:
                                    213 ;	src/main.c: 54: return(i); // Bytes sent
      0080CD 7B 03            [ 1]  214 	ld	a, (0x03, sp)
      0080CF 5F               [ 1]  215 	clrw	x
      0080D0 97               [ 1]  216 	ld	xl, a
                                    217 ;	src/main.c: 55: }
      0080D1 5B 03            [ 2]  218 	addw	sp, #3
      0080D3 81               [ 4]  219 	ret
                                    220 	.area CODE
                                    221 	.area CONST
                                    222 	.area CONST
      008024                        223 ___str_0:
      008024 48 65 6C 6C 6F 20 57   224 	.ascii "Hello World!"
             6F 72 6C 64 21
      008030 0D                     225 	.db 0x0d
      008031 0A                     226 	.db 0x0a
      008032 00                     227 	.db 0x00
                                    228 	.area CODE
                                    229 	.area INITIALIZER
                                    230 	.area CABS (ABS)
