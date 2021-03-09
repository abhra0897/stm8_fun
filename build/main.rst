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
                                     12 	.globl _ws2812_send_reset
                                     13 	.globl _ws2812_send_8bits
                                     14 	.globl _ws2812_gpio_config
                                     15 	.globl _flash_read_from_addr
                                     16 	.globl _spi_config
                                     17 	.globl _strlen
                                     18 	.globl _uart_init
                                     19 	.globl _uart_write
                                     20 	.globl _uart_write_8bits
                                     21 	.globl _int_to_hex_str
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DATA
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area INITIALIZED
                                     30 ;--------------------------------------------------------
                                     31 ; Stack segment in internal ram 
                                     32 ;--------------------------------------------------------
                                     33 	.area	SSEG
      FFFFFF                         34 __start__stack:
      FFFFFF                         35 	.ds	1
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; absolute external ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DABS (ABS)
                                     41 
                                     42 ; default segment ordering for linker
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area CONST
                                     47 	.area INITIALIZER
                                     48 	.area CODE
                                     49 
                                     50 ;--------------------------------------------------------
                                     51 ; interrupt vector 
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
      008000                         54 __interrupt_vect:
      008000 82 00 80 07             55 	int s_GSINIT ; reset
                                     56 ;--------------------------------------------------------
                                     57 ; global & static initialisations
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
                                     60 	.area GSINIT
                                     61 	.area GSFINAL
                                     62 	.area GSINIT
      008007                         63 __sdcc_gs_init_startup:
      008007                         64 __sdcc_init_data:
                                     65 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   66 	ldw x, #l_DATA
      00800A 27 07            [ 1]   67 	jreq	00002$
      00800C                         68 00001$:
      00800C 72 4F 00 00      [ 1]   69 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   70 	decw x
      008011 26 F9            [ 1]   71 	jrne	00001$
      008013                         72 00002$:
      008013 AE 00 00         [ 2]   73 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   74 	jreq	00004$
      008018                         75 00003$:
      008018 D6 80 23         [ 1]   76 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   77 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   78 	decw	x
      00801F 26 F7            [ 1]   79 	jrne	00003$
      008021                         80 00004$:
                                     81 ; stm8_genXINIT() end
                                     82 	.area GSFINAL
      008021 CC 80 04         [ 2]   83 	jp	__sdcc_program_startup
                                     84 ;--------------------------------------------------------
                                     85 ; Home
                                     86 ;--------------------------------------------------------
                                     87 	.area HOME
                                     88 	.area HOME
      008004                         89 __sdcc_program_startup:
      008004 CC 80 24         [ 2]   90 	jp	_main
                                     91 ;	return from main will return to caller
                                     92 ;--------------------------------------------------------
                                     93 ; code
                                     94 ;--------------------------------------------------------
                                     95 	.area CODE
                                     96 ;	src/main.c: 16: void main(void)
                                     97 ;	-----------------------------------------
                                     98 ;	 function main
                                     99 ;	-----------------------------------------
      008024                        100 _main:
      008024 52 CB            [ 2]  101 	sub	sp, #203
                                    102 ;	src/main.c: 19: CLK_CKDIVR = 0;
      008026 35 00 50 C6      [ 1]  103 	mov	0x50c6+0, #0x00
                                    104 ;	src/main.c: 20: uart_init();
      00802A CD 83 11         [ 4]  105 	call	_uart_init
                                    106 ;	src/main.c: 22: uint8_t buff[100] = {0};
      00802D 0F 01            [ 1]  107 	clr	(0x01, sp)
      00802F 96               [ 1]  108 	ldw	x, sp
      008030 6F 02            [ 1]  109 	clr	(2, x)
      008032 96               [ 1]  110 	ldw	x, sp
      008033 6F 03            [ 1]  111 	clr	(3, x)
      008035 96               [ 1]  112 	ldw	x, sp
      008036 6F 04            [ 1]  113 	clr	(4, x)
      008038 96               [ 1]  114 	ldw	x, sp
      008039 6F 05            [ 1]  115 	clr	(5, x)
      00803B 96               [ 1]  116 	ldw	x, sp
      00803C 6F 06            [ 1]  117 	clr	(6, x)
      00803E 96               [ 1]  118 	ldw	x, sp
      00803F 6F 07            [ 1]  119 	clr	(7, x)
      008041 96               [ 1]  120 	ldw	x, sp
      008042 6F 08            [ 1]  121 	clr	(8, x)
      008044 96               [ 1]  122 	ldw	x, sp
      008045 6F 09            [ 1]  123 	clr	(9, x)
      008047 96               [ 1]  124 	ldw	x, sp
      008048 6F 0A            [ 1]  125 	clr	(10, x)
      00804A 96               [ 1]  126 	ldw	x, sp
      00804B 6F 0B            [ 1]  127 	clr	(11, x)
      00804D 96               [ 1]  128 	ldw	x, sp
      00804E 6F 0C            [ 1]  129 	clr	(12, x)
      008050 96               [ 1]  130 	ldw	x, sp
      008051 6F 0D            [ 1]  131 	clr	(13, x)
      008053 96               [ 1]  132 	ldw	x, sp
      008054 6F 0E            [ 1]  133 	clr	(14, x)
      008056 96               [ 1]  134 	ldw	x, sp
      008057 6F 0F            [ 1]  135 	clr	(15, x)
      008059 96               [ 1]  136 	ldw	x, sp
      00805A 6F 10            [ 1]  137 	clr	(16, x)
      00805C 96               [ 1]  138 	ldw	x, sp
      00805D 6F 11            [ 1]  139 	clr	(17, x)
      00805F 96               [ 1]  140 	ldw	x, sp
      008060 6F 12            [ 1]  141 	clr	(18, x)
      008062 96               [ 1]  142 	ldw	x, sp
      008063 6F 13            [ 1]  143 	clr	(19, x)
      008065 96               [ 1]  144 	ldw	x, sp
      008066 6F 14            [ 1]  145 	clr	(20, x)
      008068 96               [ 1]  146 	ldw	x, sp
      008069 6F 15            [ 1]  147 	clr	(21, x)
      00806B 96               [ 1]  148 	ldw	x, sp
      00806C 6F 16            [ 1]  149 	clr	(22, x)
      00806E 96               [ 1]  150 	ldw	x, sp
      00806F 6F 17            [ 1]  151 	clr	(23, x)
      008071 96               [ 1]  152 	ldw	x, sp
      008072 6F 18            [ 1]  153 	clr	(24, x)
      008074 96               [ 1]  154 	ldw	x, sp
      008075 6F 19            [ 1]  155 	clr	(25, x)
      008077 96               [ 1]  156 	ldw	x, sp
      008078 6F 1A            [ 1]  157 	clr	(26, x)
      00807A 96               [ 1]  158 	ldw	x, sp
      00807B 6F 1B            [ 1]  159 	clr	(27, x)
      00807D 96               [ 1]  160 	ldw	x, sp
      00807E 6F 1C            [ 1]  161 	clr	(28, x)
      008080 96               [ 1]  162 	ldw	x, sp
      008081 6F 1D            [ 1]  163 	clr	(29, x)
      008083 96               [ 1]  164 	ldw	x, sp
      008084 6F 1E            [ 1]  165 	clr	(30, x)
      008086 96               [ 1]  166 	ldw	x, sp
      008087 6F 1F            [ 1]  167 	clr	(31, x)
      008089 96               [ 1]  168 	ldw	x, sp
      00808A 6F 20            [ 1]  169 	clr	(32, x)
      00808C 96               [ 1]  170 	ldw	x, sp
      00808D 6F 21            [ 1]  171 	clr	(33, x)
      00808F 96               [ 1]  172 	ldw	x, sp
      008090 6F 22            [ 1]  173 	clr	(34, x)
      008092 96               [ 1]  174 	ldw	x, sp
      008093 6F 23            [ 1]  175 	clr	(35, x)
      008095 96               [ 1]  176 	ldw	x, sp
      008096 6F 24            [ 1]  177 	clr	(36, x)
      008098 96               [ 1]  178 	ldw	x, sp
      008099 6F 25            [ 1]  179 	clr	(37, x)
      00809B 96               [ 1]  180 	ldw	x, sp
      00809C 6F 26            [ 1]  181 	clr	(38, x)
      00809E 96               [ 1]  182 	ldw	x, sp
      00809F 6F 27            [ 1]  183 	clr	(39, x)
      0080A1 96               [ 1]  184 	ldw	x, sp
      0080A2 6F 28            [ 1]  185 	clr	(40, x)
      0080A4 96               [ 1]  186 	ldw	x, sp
      0080A5 6F 29            [ 1]  187 	clr	(41, x)
      0080A7 96               [ 1]  188 	ldw	x, sp
      0080A8 6F 2A            [ 1]  189 	clr	(42, x)
      0080AA 96               [ 1]  190 	ldw	x, sp
      0080AB 6F 2B            [ 1]  191 	clr	(43, x)
      0080AD 96               [ 1]  192 	ldw	x, sp
      0080AE 6F 2C            [ 1]  193 	clr	(44, x)
      0080B0 96               [ 1]  194 	ldw	x, sp
      0080B1 6F 2D            [ 1]  195 	clr	(45, x)
      0080B3 96               [ 1]  196 	ldw	x, sp
      0080B4 6F 2E            [ 1]  197 	clr	(46, x)
      0080B6 96               [ 1]  198 	ldw	x, sp
      0080B7 6F 2F            [ 1]  199 	clr	(47, x)
      0080B9 96               [ 1]  200 	ldw	x, sp
      0080BA 6F 30            [ 1]  201 	clr	(48, x)
      0080BC 96               [ 1]  202 	ldw	x, sp
      0080BD 6F 31            [ 1]  203 	clr	(49, x)
      0080BF 96               [ 1]  204 	ldw	x, sp
      0080C0 6F 32            [ 1]  205 	clr	(50, x)
      0080C2 96               [ 1]  206 	ldw	x, sp
      0080C3 6F 33            [ 1]  207 	clr	(51, x)
      0080C5 96               [ 1]  208 	ldw	x, sp
      0080C6 6F 34            [ 1]  209 	clr	(52, x)
      0080C8 96               [ 1]  210 	ldw	x, sp
      0080C9 6F 35            [ 1]  211 	clr	(53, x)
      0080CB 96               [ 1]  212 	ldw	x, sp
      0080CC 6F 36            [ 1]  213 	clr	(54, x)
      0080CE 96               [ 1]  214 	ldw	x, sp
      0080CF 6F 37            [ 1]  215 	clr	(55, x)
      0080D1 96               [ 1]  216 	ldw	x, sp
      0080D2 6F 38            [ 1]  217 	clr	(56, x)
      0080D4 96               [ 1]  218 	ldw	x, sp
      0080D5 6F 39            [ 1]  219 	clr	(57, x)
      0080D7 96               [ 1]  220 	ldw	x, sp
      0080D8 6F 3A            [ 1]  221 	clr	(58, x)
      0080DA 96               [ 1]  222 	ldw	x, sp
      0080DB 6F 3B            [ 1]  223 	clr	(59, x)
      0080DD 96               [ 1]  224 	ldw	x, sp
      0080DE 6F 3C            [ 1]  225 	clr	(60, x)
      0080E0 96               [ 1]  226 	ldw	x, sp
      0080E1 6F 3D            [ 1]  227 	clr	(61, x)
      0080E3 96               [ 1]  228 	ldw	x, sp
      0080E4 6F 3E            [ 1]  229 	clr	(62, x)
      0080E6 96               [ 1]  230 	ldw	x, sp
      0080E7 6F 3F            [ 1]  231 	clr	(63, x)
      0080E9 96               [ 1]  232 	ldw	x, sp
      0080EA 6F 40            [ 1]  233 	clr	(64, x)
      0080EC 96               [ 1]  234 	ldw	x, sp
      0080ED 6F 41            [ 1]  235 	clr	(65, x)
      0080EF 96               [ 1]  236 	ldw	x, sp
      0080F0 6F 42            [ 1]  237 	clr	(66, x)
      0080F2 96               [ 1]  238 	ldw	x, sp
      0080F3 6F 43            [ 1]  239 	clr	(67, x)
      0080F5 96               [ 1]  240 	ldw	x, sp
      0080F6 6F 44            [ 1]  241 	clr	(68, x)
      0080F8 96               [ 1]  242 	ldw	x, sp
      0080F9 6F 45            [ 1]  243 	clr	(69, x)
      0080FB 96               [ 1]  244 	ldw	x, sp
      0080FC 6F 46            [ 1]  245 	clr	(70, x)
      0080FE 96               [ 1]  246 	ldw	x, sp
      0080FF 6F 47            [ 1]  247 	clr	(71, x)
      008101 96               [ 1]  248 	ldw	x, sp
      008102 6F 48            [ 1]  249 	clr	(72, x)
      008104 96               [ 1]  250 	ldw	x, sp
      008105 6F 49            [ 1]  251 	clr	(73, x)
      008107 96               [ 1]  252 	ldw	x, sp
      008108 6F 4A            [ 1]  253 	clr	(74, x)
      00810A 96               [ 1]  254 	ldw	x, sp
      00810B 6F 4B            [ 1]  255 	clr	(75, x)
      00810D 96               [ 1]  256 	ldw	x, sp
      00810E 6F 4C            [ 1]  257 	clr	(76, x)
      008110 96               [ 1]  258 	ldw	x, sp
      008111 6F 4D            [ 1]  259 	clr	(77, x)
      008113 96               [ 1]  260 	ldw	x, sp
      008114 6F 4E            [ 1]  261 	clr	(78, x)
      008116 96               [ 1]  262 	ldw	x, sp
      008117 6F 4F            [ 1]  263 	clr	(79, x)
      008119 96               [ 1]  264 	ldw	x, sp
      00811A 6F 50            [ 1]  265 	clr	(80, x)
      00811C 96               [ 1]  266 	ldw	x, sp
      00811D 6F 51            [ 1]  267 	clr	(81, x)
      00811F 96               [ 1]  268 	ldw	x, sp
      008120 6F 52            [ 1]  269 	clr	(82, x)
      008122 96               [ 1]  270 	ldw	x, sp
      008123 6F 53            [ 1]  271 	clr	(83, x)
      008125 96               [ 1]  272 	ldw	x, sp
      008126 6F 54            [ 1]  273 	clr	(84, x)
      008128 96               [ 1]  274 	ldw	x, sp
      008129 6F 55            [ 1]  275 	clr	(85, x)
      00812B 96               [ 1]  276 	ldw	x, sp
      00812C 6F 56            [ 1]  277 	clr	(86, x)
      00812E 96               [ 1]  278 	ldw	x, sp
      00812F 6F 57            [ 1]  279 	clr	(87, x)
      008131 96               [ 1]  280 	ldw	x, sp
      008132 6F 58            [ 1]  281 	clr	(88, x)
      008134 96               [ 1]  282 	ldw	x, sp
      008135 6F 59            [ 1]  283 	clr	(89, x)
      008137 96               [ 1]  284 	ldw	x, sp
      008138 6F 5A            [ 1]  285 	clr	(90, x)
      00813A 96               [ 1]  286 	ldw	x, sp
      00813B 6F 5B            [ 1]  287 	clr	(91, x)
      00813D 96               [ 1]  288 	ldw	x, sp
      00813E 6F 5C            [ 1]  289 	clr	(92, x)
      008140 96               [ 1]  290 	ldw	x, sp
      008141 6F 5D            [ 1]  291 	clr	(93, x)
      008143 96               [ 1]  292 	ldw	x, sp
      008144 6F 5E            [ 1]  293 	clr	(94, x)
      008146 96               [ 1]  294 	ldw	x, sp
      008147 6F 5F            [ 1]  295 	clr	(95, x)
      008149 96               [ 1]  296 	ldw	x, sp
      00814A 6F 60            [ 1]  297 	clr	(96, x)
      00814C 96               [ 1]  298 	ldw	x, sp
      00814D 6F 61            [ 1]  299 	clr	(97, x)
      00814F 96               [ 1]  300 	ldw	x, sp
      008150 6F 62            [ 1]  301 	clr	(98, x)
      008152 96               [ 1]  302 	ldw	x, sp
      008153 6F 63            [ 1]  303 	clr	(99, x)
      008155 96               [ 1]  304 	ldw	x, sp
      008156 6F 64            [ 1]  305 	clr	(100, x)
                                    306 ;	src/main.c: 23: uint8_t buff2[100] = {0};
      008158 0F 65            [ 1]  307 	clr	(0x65, sp)
      00815A 96               [ 1]  308 	ldw	x, sp
      00815B 6F 66            [ 1]  309 	clr	(102, x)
      00815D 96               [ 1]  310 	ldw	x, sp
      00815E 6F 67            [ 1]  311 	clr	(103, x)
      008160 96               [ 1]  312 	ldw	x, sp
      008161 6F 68            [ 1]  313 	clr	(104, x)
      008163 96               [ 1]  314 	ldw	x, sp
      008164 6F 69            [ 1]  315 	clr	(105, x)
      008166 96               [ 1]  316 	ldw	x, sp
      008167 6F 6A            [ 1]  317 	clr	(106, x)
      008169 96               [ 1]  318 	ldw	x, sp
      00816A 6F 6B            [ 1]  319 	clr	(107, x)
      00816C 96               [ 1]  320 	ldw	x, sp
      00816D 6F 6C            [ 1]  321 	clr	(108, x)
      00816F 96               [ 1]  322 	ldw	x, sp
      008170 6F 6D            [ 1]  323 	clr	(109, x)
      008172 96               [ 1]  324 	ldw	x, sp
      008173 6F 6E            [ 1]  325 	clr	(110, x)
      008175 96               [ 1]  326 	ldw	x, sp
      008176 6F 6F            [ 1]  327 	clr	(111, x)
      008178 96               [ 1]  328 	ldw	x, sp
      008179 6F 70            [ 1]  329 	clr	(112, x)
      00817B 96               [ 1]  330 	ldw	x, sp
      00817C 6F 71            [ 1]  331 	clr	(113, x)
      00817E 96               [ 1]  332 	ldw	x, sp
      00817F 6F 72            [ 1]  333 	clr	(114, x)
      008181 96               [ 1]  334 	ldw	x, sp
      008182 6F 73            [ 1]  335 	clr	(115, x)
      008184 96               [ 1]  336 	ldw	x, sp
      008185 6F 74            [ 1]  337 	clr	(116, x)
      008187 96               [ 1]  338 	ldw	x, sp
      008188 6F 75            [ 1]  339 	clr	(117, x)
      00818A 96               [ 1]  340 	ldw	x, sp
      00818B 6F 76            [ 1]  341 	clr	(118, x)
      00818D 96               [ 1]  342 	ldw	x, sp
      00818E 6F 77            [ 1]  343 	clr	(119, x)
      008190 96               [ 1]  344 	ldw	x, sp
      008191 6F 78            [ 1]  345 	clr	(120, x)
      008193 96               [ 1]  346 	ldw	x, sp
      008194 6F 79            [ 1]  347 	clr	(121, x)
      008196 96               [ 1]  348 	ldw	x, sp
      008197 6F 7A            [ 1]  349 	clr	(122, x)
      008199 96               [ 1]  350 	ldw	x, sp
      00819A 6F 7B            [ 1]  351 	clr	(123, x)
      00819C 96               [ 1]  352 	ldw	x, sp
      00819D 6F 7C            [ 1]  353 	clr	(124, x)
      00819F 96               [ 1]  354 	ldw	x, sp
      0081A0 6F 7D            [ 1]  355 	clr	(125, x)
      0081A2 96               [ 1]  356 	ldw	x, sp
      0081A3 6F 7E            [ 1]  357 	clr	(126, x)
      0081A5 96               [ 1]  358 	ldw	x, sp
      0081A6 6F 7F            [ 1]  359 	clr	(127, x)
      0081A8 96               [ 1]  360 	ldw	x, sp
      0081A9 6F 80            [ 1]  361 	clr	(128, x)
      0081AB 96               [ 1]  362 	ldw	x, sp
      0081AC 6F 81            [ 1]  363 	clr	(129, x)
      0081AE 96               [ 1]  364 	ldw	x, sp
      0081AF 6F 82            [ 1]  365 	clr	(130, x)
      0081B1 96               [ 1]  366 	ldw	x, sp
      0081B2 6F 83            [ 1]  367 	clr	(131, x)
      0081B4 96               [ 1]  368 	ldw	x, sp
      0081B5 6F 84            [ 1]  369 	clr	(132, x)
      0081B7 96               [ 1]  370 	ldw	x, sp
      0081B8 6F 85            [ 1]  371 	clr	(133, x)
      0081BA 96               [ 1]  372 	ldw	x, sp
      0081BB 6F 86            [ 1]  373 	clr	(134, x)
      0081BD 96               [ 1]  374 	ldw	x, sp
      0081BE 6F 87            [ 1]  375 	clr	(135, x)
      0081C0 96               [ 1]  376 	ldw	x, sp
      0081C1 6F 88            [ 1]  377 	clr	(136, x)
      0081C3 96               [ 1]  378 	ldw	x, sp
      0081C4 6F 89            [ 1]  379 	clr	(137, x)
      0081C6 96               [ 1]  380 	ldw	x, sp
      0081C7 6F 8A            [ 1]  381 	clr	(138, x)
      0081C9 96               [ 1]  382 	ldw	x, sp
      0081CA 6F 8B            [ 1]  383 	clr	(139, x)
      0081CC 96               [ 1]  384 	ldw	x, sp
      0081CD 6F 8C            [ 1]  385 	clr	(140, x)
      0081CF 96               [ 1]  386 	ldw	x, sp
      0081D0 6F 8D            [ 1]  387 	clr	(141, x)
      0081D2 96               [ 1]  388 	ldw	x, sp
      0081D3 6F 8E            [ 1]  389 	clr	(142, x)
      0081D5 96               [ 1]  390 	ldw	x, sp
      0081D6 6F 8F            [ 1]  391 	clr	(143, x)
      0081D8 96               [ 1]  392 	ldw	x, sp
      0081D9 6F 90            [ 1]  393 	clr	(144, x)
      0081DB 96               [ 1]  394 	ldw	x, sp
      0081DC 6F 91            [ 1]  395 	clr	(145, x)
      0081DE 96               [ 1]  396 	ldw	x, sp
      0081DF 6F 92            [ 1]  397 	clr	(146, x)
      0081E1 96               [ 1]  398 	ldw	x, sp
      0081E2 6F 93            [ 1]  399 	clr	(147, x)
      0081E4 96               [ 1]  400 	ldw	x, sp
      0081E5 6F 94            [ 1]  401 	clr	(148, x)
      0081E7 96               [ 1]  402 	ldw	x, sp
      0081E8 6F 95            [ 1]  403 	clr	(149, x)
      0081EA 96               [ 1]  404 	ldw	x, sp
      0081EB 6F 96            [ 1]  405 	clr	(150, x)
      0081ED 96               [ 1]  406 	ldw	x, sp
      0081EE 6F 97            [ 1]  407 	clr	(151, x)
      0081F0 96               [ 1]  408 	ldw	x, sp
      0081F1 6F 98            [ 1]  409 	clr	(152, x)
      0081F3 96               [ 1]  410 	ldw	x, sp
      0081F4 6F 99            [ 1]  411 	clr	(153, x)
      0081F6 96               [ 1]  412 	ldw	x, sp
      0081F7 6F 9A            [ 1]  413 	clr	(154, x)
      0081F9 96               [ 1]  414 	ldw	x, sp
      0081FA 6F 9B            [ 1]  415 	clr	(155, x)
      0081FC 96               [ 1]  416 	ldw	x, sp
      0081FD 6F 9C            [ 1]  417 	clr	(156, x)
      0081FF 96               [ 1]  418 	ldw	x, sp
      008200 6F 9D            [ 1]  419 	clr	(157, x)
      008202 96               [ 1]  420 	ldw	x, sp
      008203 6F 9E            [ 1]  421 	clr	(158, x)
      008205 96               [ 1]  422 	ldw	x, sp
      008206 6F 9F            [ 1]  423 	clr	(159, x)
      008208 96               [ 1]  424 	ldw	x, sp
      008209 6F A0            [ 1]  425 	clr	(160, x)
      00820B 96               [ 1]  426 	ldw	x, sp
      00820C 6F A1            [ 1]  427 	clr	(161, x)
      00820E 96               [ 1]  428 	ldw	x, sp
      00820F 6F A2            [ 1]  429 	clr	(162, x)
      008211 96               [ 1]  430 	ldw	x, sp
      008212 6F A3            [ 1]  431 	clr	(163, x)
      008214 96               [ 1]  432 	ldw	x, sp
      008215 6F A4            [ 1]  433 	clr	(164, x)
      008217 96               [ 1]  434 	ldw	x, sp
      008218 6F A5            [ 1]  435 	clr	(165, x)
      00821A 96               [ 1]  436 	ldw	x, sp
      00821B 6F A6            [ 1]  437 	clr	(166, x)
      00821D 96               [ 1]  438 	ldw	x, sp
      00821E 6F A7            [ 1]  439 	clr	(167, x)
      008220 96               [ 1]  440 	ldw	x, sp
      008221 6F A8            [ 1]  441 	clr	(168, x)
      008223 96               [ 1]  442 	ldw	x, sp
      008224 6F A9            [ 1]  443 	clr	(169, x)
      008226 96               [ 1]  444 	ldw	x, sp
      008227 6F AA            [ 1]  445 	clr	(170, x)
      008229 96               [ 1]  446 	ldw	x, sp
      00822A 6F AB            [ 1]  447 	clr	(171, x)
      00822C 96               [ 1]  448 	ldw	x, sp
      00822D 6F AC            [ 1]  449 	clr	(172, x)
      00822F 96               [ 1]  450 	ldw	x, sp
      008230 6F AD            [ 1]  451 	clr	(173, x)
      008232 96               [ 1]  452 	ldw	x, sp
      008233 6F AE            [ 1]  453 	clr	(174, x)
      008235 96               [ 1]  454 	ldw	x, sp
      008236 6F AF            [ 1]  455 	clr	(175, x)
      008238 96               [ 1]  456 	ldw	x, sp
      008239 6F B0            [ 1]  457 	clr	(176, x)
      00823B 96               [ 1]  458 	ldw	x, sp
      00823C 6F B1            [ 1]  459 	clr	(177, x)
      00823E 96               [ 1]  460 	ldw	x, sp
      00823F 6F B2            [ 1]  461 	clr	(178, x)
      008241 96               [ 1]  462 	ldw	x, sp
      008242 6F B3            [ 1]  463 	clr	(179, x)
      008244 96               [ 1]  464 	ldw	x, sp
      008245 6F B4            [ 1]  465 	clr	(180, x)
      008247 96               [ 1]  466 	ldw	x, sp
      008248 6F B5            [ 1]  467 	clr	(181, x)
      00824A 96               [ 1]  468 	ldw	x, sp
      00824B 6F B6            [ 1]  469 	clr	(182, x)
      00824D 96               [ 1]  470 	ldw	x, sp
      00824E 6F B7            [ 1]  471 	clr	(183, x)
      008250 96               [ 1]  472 	ldw	x, sp
      008251 6F B8            [ 1]  473 	clr	(184, x)
      008253 96               [ 1]  474 	ldw	x, sp
      008254 6F B9            [ 1]  475 	clr	(185, x)
      008256 96               [ 1]  476 	ldw	x, sp
      008257 6F BA            [ 1]  477 	clr	(186, x)
      008259 96               [ 1]  478 	ldw	x, sp
      00825A 6F BB            [ 1]  479 	clr	(187, x)
      00825C 96               [ 1]  480 	ldw	x, sp
      00825D 6F BC            [ 1]  481 	clr	(188, x)
      00825F 96               [ 1]  482 	ldw	x, sp
      008260 6F BD            [ 1]  483 	clr	(189, x)
      008262 96               [ 1]  484 	ldw	x, sp
      008263 6F BE            [ 1]  485 	clr	(190, x)
      008265 96               [ 1]  486 	ldw	x, sp
      008266 6F BF            [ 1]  487 	clr	(191, x)
      008268 96               [ 1]  488 	ldw	x, sp
      008269 6F C0            [ 1]  489 	clr	(192, x)
      00826B 96               [ 1]  490 	ldw	x, sp
      00826C 6F C1            [ 1]  491 	clr	(193, x)
      00826E 96               [ 1]  492 	ldw	x, sp
      00826F 6F C2            [ 1]  493 	clr	(194, x)
      008271 96               [ 1]  494 	ldw	x, sp
      008272 6F C3            [ 1]  495 	clr	(195, x)
      008274 96               [ 1]  496 	ldw	x, sp
      008275 6F C4            [ 1]  497 	clr	(196, x)
      008277 96               [ 1]  498 	ldw	x, sp
      008278 6F C5            [ 1]  499 	clr	(197, x)
      00827A 96               [ 1]  500 	ldw	x, sp
      00827B 6F C6            [ 1]  501 	clr	(198, x)
      00827D 96               [ 1]  502 	ldw	x, sp
      00827E 6F C7            [ 1]  503 	clr	(199, x)
      008280 96               [ 1]  504 	ldw	x, sp
      008281 6F C8            [ 1]  505 	clr	(200, x)
                                    506 ;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
      008283 4F               [ 1]  507 	clr	a
      008284                        508 00111$:
      008284 A1 64            [ 1]  509 	cp	a, #0x64
      008286 24 0E            [ 1]  510 	jrnc	00101$
                                    511 ;	src/main.c: 26: buff[i] = i/* +7+'0' */;
      008288 96               [ 1]  512 	ldw	x, sp
      008289 5C               [ 1]  513 	incw	x
      00828A 89               [ 2]  514 	pushw	x
      00828B 5F               [ 1]  515 	clrw	x
      00828C 97               [ 1]  516 	ld	xl, a
      00828D 72 FB 01         [ 2]  517 	addw	x, (1, sp)
      008290 5B 02            [ 2]  518 	addw	sp, #2
      008292 F7               [ 1]  519 	ld	(x), a
                                    520 ;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
      008293 4C               [ 1]  521 	inc	a
      008294 20 EE            [ 2]  522 	jra	00111$
      008296                        523 00101$:
                                    524 ;	src/main.c: 29: ws2812_gpio_config();
      008296 CD 85 B8         [ 4]  525 	call	_ws2812_gpio_config
                                    526 ;	src/main.c: 30: spi_config();
      008299 CD 84 F1         [ 4]  527 	call	_spi_config
                                    528 ;	src/main.c: 41: uart_write_8bits(0x99); //indicates start
      00829C 4B 99            [ 1]  529 	push	#0x99
      00829E CD 83 57         [ 4]  530 	call	_uart_write_8bits
      0082A1 84               [ 1]  531 	pop	a
                                    532 ;	src/main.c: 43: flash_read_from_addr(0x012345, buff2, 100);
      0082A2 4B 64            [ 1]  533 	push	#0x64
      0082A4 4B 00            [ 1]  534 	push	#0x00
      0082A6 96               [ 1]  535 	ldw	x, sp
      0082A7 1C 00 67         [ 2]  536 	addw	x, #103
      0082AA 89               [ 2]  537 	pushw	x
      0082AB 4B 45            [ 1]  538 	push	#0x45
      0082AD 4B 23            [ 1]  539 	push	#0x23
      0082AF 4B 01            [ 1]  540 	push	#0x01
      0082B1 4B 00            [ 1]  541 	push	#0x00
      0082B3 CD 83 C8         [ 4]  542 	call	_flash_read_from_addr
      0082B6 5B 08            [ 2]  543 	addw	sp, #8
                                    544 ;	src/main.c: 46: char hex_string[2] = {0};
      0082B8 0F C9            [ 1]  545 	clr	(0xc9, sp)
      0082BA 96               [ 1]  546 	ldw	x, sp
      0082BB 6F CA            [ 1]  547 	clr	(202, x)
                                    548 ;	src/main.c: 51: for(uint8_t ii = 0; ii < 100; ii++)
      0082BD                        549 00127$:
      0082BD 0F CB            [ 1]  550 	clr	(0xcb, sp)
      0082BF                        551 00117$:
      0082BF 7B CB            [ 1]  552 	ld	a, (0xcb, sp)
      0082C1 A1 64            [ 1]  553 	cp	a, #0x64
      0082C3 24 F8            [ 1]  554 	jrnc	00127$
                                    555 ;	src/main.c: 54: uart_write_8bits(buff2[ii]);
      0082C5 5F               [ 1]  556 	clrw	x
      0082C6 7B CB            [ 1]  557 	ld	a, (0xcb, sp)
      0082C8 97               [ 1]  558 	ld	xl, a
      0082C9 89               [ 2]  559 	pushw	x
      0082CA 96               [ 1]  560 	ldw	x, sp
      0082CB 1C 00 67         [ 2]  561 	addw	x, #103
      0082CE 72 FB 01         [ 2]  562 	addw	x, (1, sp)
      0082D1 5B 02            [ 2]  563 	addw	sp, #2
      0082D3 F6               [ 1]  564 	ld	a, (x)
      0082D4 89               [ 2]  565 	pushw	x
      0082D5 88               [ 1]  566 	push	a
      0082D6 CD 83 57         [ 4]  567 	call	_uart_write_8bits
      0082D9 84               [ 1]  568 	pop	a
      0082DA 85               [ 2]  569 	popw	x
                                    570 ;	src/main.c: 55: ws2812_send_8bits(buff2[ii]);
      0082DB F6               [ 1]  571 	ld	a, (x)
      0082DC 89               [ 2]  572 	pushw	x
      0082DD 88               [ 1]  573 	push	a
      0082DE CD 85 C5         [ 4]  574 	call	_ws2812_send_8bits
      0082E1 84               [ 1]  575 	pop	a
      0082E2 85               [ 2]  576 	popw	x
                                    577 ;	src/main.c: 56: ws2812_send_8bits(buff2[ii]);
      0082E3 F6               [ 1]  578 	ld	a, (x)
      0082E4 89               [ 2]  579 	pushw	x
      0082E5 88               [ 1]  580 	push	a
      0082E6 CD 85 C5         [ 4]  581 	call	_ws2812_send_8bits
      0082E9 84               [ 1]  582 	pop	a
      0082EA 85               [ 2]  583 	popw	x
                                    584 ;	src/main.c: 57: ws2812_send_8bits(buff2[ii]);
      0082EB F6               [ 1]  585 	ld	a, (x)
      0082EC 88               [ 1]  586 	push	a
      0082ED CD 85 C5         [ 4]  587 	call	_ws2812_send_8bits
      0082F0 84               [ 1]  588 	pop	a
                                    589 ;	src/main.c: 59: ws2812_send_reset();
      0082F1 CD 85 FB         [ 4]  590 	call	_ws2812_send_reset
                                    591 ;	src/main.c: 61: for (uint32_t jj = 0; jj < 32000; jj++);
      0082F4 90 5F            [ 1]  592 	clrw	y
      0082F6 5F               [ 1]  593 	clrw	x
      0082F7                        594 00114$:
      0082F7 90 A3 7D 00      [ 2]  595 	cpw	y, #0x7d00
      0082FB 9F               [ 1]  596 	ld	a, xl
      0082FC A2 00            [ 1]  597 	sbc	a, #0x00
      0082FE 9E               [ 1]  598 	ld	a, xh
      0082FF A2 00            [ 1]  599 	sbc	a, #0x00
      008301 24 07            [ 1]  600 	jrnc	00118$
      008303 90 5C            [ 1]  601 	incw	y
      008305 26 F0            [ 1]  602 	jrne	00114$
      008307 5C               [ 1]  603 	incw	x
      008308 20 ED            [ 2]  604 	jra	00114$
      00830A                        605 00118$:
                                    606 ;	src/main.c: 51: for(uint8_t ii = 0; ii < 100; ii++)
      00830A 0C CB            [ 1]  607 	inc	(0xcb, sp)
      00830C 20 B1            [ 2]  608 	jra	00117$
                                    609 ;	src/main.c: 67: while(1);
                                    610 ;	src/main.c: 68: }
      00830E 5B CB            [ 2]  611 	addw	sp, #203
      008310 81               [ 4]  612 	ret
                                    613 ;	src/main.c: 71: void uart_init()
                                    614 ;	-----------------------------------------
                                    615 ;	 function uart_init
                                    616 ;	-----------------------------------------
      008311                        617 _uart_init:
                                    618 ;	src/main.c: 74: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008311 72 16 52 35      [ 1]  619 	bset	21045, #3
                                    620 ;	src/main.c: 76: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008315 C6 52 36         [ 1]  621 	ld	a, 0x5236
      008318 A4 CF            [ 1]  622 	and	a, #0xcf
      00831A C7 52 36         [ 1]  623 	ld	0x5236, a
                                    624 ;	src/main.c: 78: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
      00831D 35 01 52 33      [ 1]  625 	mov	0x5233+0, #0x01
      008321 35 34 52 32      [ 1]  626 	mov	0x5232+0, #0x34
                                    627 ;	src/main.c: 79: }
      008325 81               [ 4]  628 	ret
                                    629 ;	src/main.c: 82: uint16_t uart_write(const char *str) {
                                    630 ;	-----------------------------------------
                                    631 ;	 function uart_write
                                    632 ;	-----------------------------------------
      008326                        633 _uart_write:
      008326 52 03            [ 2]  634 	sub	sp, #3
                                    635 ;	src/main.c: 84: for(i = 0; i < strlen(str); i++) {
      008328 0F 03            [ 1]  636 	clr	(0x03, sp)
      00832A                        637 00106$:
      00832A 1E 06            [ 2]  638 	ldw	x, (0x06, sp)
      00832C 89               [ 2]  639 	pushw	x
      00832D CD 86 0D         [ 4]  640 	call	_strlen
      008330 5B 02            [ 2]  641 	addw	sp, #2
      008332 1F 01            [ 2]  642 	ldw	(0x01, sp), x
      008334 5F               [ 1]  643 	clrw	x
      008335 7B 03            [ 1]  644 	ld	a, (0x03, sp)
      008337 97               [ 1]  645 	ld	xl, a
      008338 13 01            [ 2]  646 	cpw	x, (0x01, sp)
      00833A 24 14            [ 1]  647 	jrnc	00104$
                                    648 ;	src/main.c: 85: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      00833C                        649 00101$:
      00833C C6 52 30         [ 1]  650 	ld	a, 0x5230
      00833F 2A FB            [ 1]  651 	jrpl	00101$
                                    652 ;	src/main.c: 86: UART1_DR = str[i];
      008341 5F               [ 1]  653 	clrw	x
      008342 7B 03            [ 1]  654 	ld	a, (0x03, sp)
      008344 97               [ 1]  655 	ld	xl, a
      008345 72 FB 06         [ 2]  656 	addw	x, (0x06, sp)
      008348 F6               [ 1]  657 	ld	a, (x)
      008349 C7 52 31         [ 1]  658 	ld	0x5231, a
                                    659 ;	src/main.c: 84: for(i = 0; i < strlen(str); i++) {
      00834C 0C 03            [ 1]  660 	inc	(0x03, sp)
      00834E 20 DA            [ 2]  661 	jra	00106$
      008350                        662 00104$:
                                    663 ;	src/main.c: 88: return(i); // Bytes sent
      008350 7B 03            [ 1]  664 	ld	a, (0x03, sp)
      008352 5F               [ 1]  665 	clrw	x
      008353 97               [ 1]  666 	ld	xl, a
                                    667 ;	src/main.c: 89: }
      008354 5B 03            [ 2]  668 	addw	sp, #3
      008356 81               [ 4]  669 	ret
                                    670 ;	src/main.c: 91: void uart_write_8bits(uint8_t d)
                                    671 ;	-----------------------------------------
                                    672 ;	 function uart_write_8bits
                                    673 ;	-----------------------------------------
      008357                        674 _uart_write_8bits:
                                    675 ;	src/main.c: 93: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008357                        676 00101$:
      008357 C6 52 30         [ 1]  677 	ld	a, 0x5230
      00835A 2A FB            [ 1]  678 	jrpl	00101$
                                    679 ;	src/main.c: 94: UART1_DR = d;
      00835C AE 52 31         [ 2]  680 	ldw	x, #0x5231
      00835F 7B 03            [ 1]  681 	ld	a, (0x03, sp)
      008361 F7               [ 1]  682 	ld	(x), a
                                    683 ;	src/main.c: 95: }
      008362 81               [ 4]  684 	ret
                                    685 ;	src/main.c: 98: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
                                    686 ;	-----------------------------------------
                                    687 ;	 function int_to_hex_str
                                    688 ;	-----------------------------------------
      008363                        689 _int_to_hex_str:
      008363 52 03            [ 2]  690 	sub	sp, #3
                                    691 ;	src/main.c: 101: while(hex_str_len)
      008365 7B 0C            [ 1]  692 	ld	a, (0x0c, sp)
      008367 6B 03            [ 1]  693 	ld	(0x03, sp), a
      008369                        694 00101$:
      008369 0D 03            [ 1]  695 	tnz	(0x03, sp)
      00836B 27 37            [ 1]  696 	jreq	00104$
                                    697 ;	src/main.c: 103: uint8_t masked_dec = (dec & mask);
      00836D 7B 09            [ 1]  698 	ld	a, (0x09, sp)
      00836F A4 0F            [ 1]  699 	and	a, #0x0f
                                    700 ;	src/main.c: 104: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
      008371 5F               [ 1]  701 	clrw	x
      008372 41               [ 1]  702 	exg	a, xl
      008373 7B 03            [ 1]  703 	ld	a, (0x03, sp)
      008375 41               [ 1]  704 	exg	a, xl
      008376 5A               [ 2]  705 	decw	x
      008377 72 FB 0A         [ 2]  706 	addw	x, (0x0a, sp)
      00837A 1F 01            [ 2]  707 	ldw	(0x01, sp), x
      00837C 97               [ 1]  708 	ld	xl, a
      00837D A1 0A            [ 1]  709 	cp	a, #0x0a
      00837F 24 05            [ 1]  710 	jrnc	00106$
      008381 9F               [ 1]  711 	ld	a, xl
      008382 AB 30            [ 1]  712 	add	a, #0x30
      008384 20 03            [ 2]  713 	jra	00107$
      008386                        714 00106$:
      008386 9F               [ 1]  715 	ld	a, xl
      008387 AB 37            [ 1]  716 	add	a, #0x37
      008389                        717 00107$:
      008389 1E 01            [ 2]  718 	ldw	x, (0x01, sp)
      00838B F7               [ 1]  719 	ld	(x), a
                                    720 ;	src/main.c: 106: dec >>= 4;
      00838C 1E 08            [ 2]  721 	ldw	x, (0x08, sp)
      00838E 16 06            [ 2]  722 	ldw	y, (0x06, sp)
      008390 90 54            [ 2]  723 	srlw	y
      008392 56               [ 2]  724 	rrcw	x
      008393 90 54            [ 2]  725 	srlw	y
      008395 56               [ 2]  726 	rrcw	x
      008396 90 54            [ 2]  727 	srlw	y
      008398 56               [ 2]  728 	rrcw	x
      008399 90 54            [ 2]  729 	srlw	y
      00839B 56               [ 2]  730 	rrcw	x
      00839C 1F 08            [ 2]  731 	ldw	(0x08, sp), x
      00839E 17 06            [ 2]  732 	ldw	(0x06, sp), y
                                    733 ;	src/main.c: 107: hex_str_len--;
      0083A0 0A 03            [ 1]  734 	dec	(0x03, sp)
      0083A2 20 C5            [ 2]  735 	jra	00101$
      0083A4                        736 00104$:
                                    737 ;	src/main.c: 109: }
      0083A4 5B 03            [ 2]  738 	addw	sp, #3
      0083A6 81               [ 4]  739 	ret
                                    740 	.area CODE
                                    741 	.area CONST
                                    742 	.area INITIALIZER
                                    743 	.area CABS (ABS)
