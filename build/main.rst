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
                                     12 	.globl _ws2812_send_pixel_24bits
                                     13 	.globl _ws2812_send_latch
                                     14 	.globl _ws2812_gpio_config
                                     15 	.globl _flash_read_from_addr
                                     16 	.globl _spi_config
                                     17 	.globl _strlen
                                     18 	.globl _get_next_color
                                     19 	.globl _uart_init
                                     20 	.globl _uart_write
                                     21 	.globl _uart_write_8bits
                                     22 	.globl _int_to_hex_str
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
                                     31 ;--------------------------------------------------------
                                     32 ; Stack segment in internal ram 
                                     33 ;--------------------------------------------------------
                                     34 	.area	SSEG
      FFFFFF                         35 __start__stack:
      FFFFFF                         36 	.ds	1
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 
                                     43 ; default segment ordering for linker
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area CONST
                                     48 	.area INITIALIZER
                                     49 	.area CODE
                                     50 
                                     51 ;--------------------------------------------------------
                                     52 ; interrupt vector 
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
      008000                         55 __interrupt_vect:
      008000 82 00 80 07             56 	int s_GSINIT ; reset
                                     57 ;--------------------------------------------------------
                                     58 ; global & static initialisations
                                     59 ;--------------------------------------------------------
                                     60 	.area HOME
                                     61 	.area GSINIT
                                     62 	.area GSFINAL
                                     63 	.area GSINIT
      008007                         64 __sdcc_gs_init_startup:
      008007                         65 __sdcc_init_data:
                                     66 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   67 	ldw x, #l_DATA
      00800A 27 07            [ 1]   68 	jreq	00002$
      00800C                         69 00001$:
      00800C 72 4F 00 00      [ 1]   70 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   71 	decw x
      008011 26 F9            [ 1]   72 	jrne	00001$
      008013                         73 00002$:
      008013 AE 00 00         [ 2]   74 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   75 	jreq	00004$
      008018                         76 00003$:
      008018 D6 80 23         [ 1]   77 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   78 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   79 	decw	x
      00801F 26 F7            [ 1]   80 	jrne	00003$
      008021                         81 00004$:
                                     82 ; stm8_genXINIT() end
                                     83 	.area GSFINAL
      008021 CC 80 04         [ 2]   84 	jp	__sdcc_program_startup
                                     85 ;--------------------------------------------------------
                                     86 ; Home
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
                                     89 	.area HOME
      008004                         90 __sdcc_program_startup:
      008004 CC 80 24         [ 2]   91 	jp	_main
                                     92 ;	return from main will return to caller
                                     93 ;--------------------------------------------------------
                                     94 ; code
                                     95 ;--------------------------------------------------------
                                     96 	.area CODE
                                     97 ;	src/main.c: 16: void main(void)
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
      008024                        101 _main:
      008024 90 96            [ 1]  102 	ldw	y, sp
      008026 72 A2 00 96      [ 2]  103 	subw	y, #150
      00802A 52 FF            [ 2]  104 	sub	sp, #255
      00802C 52 8A            [ 2]  105 	sub	sp, #138
                                    106 ;	src/main.c: 19: CLK_CKDIVR = 0;
      00802E 35 00 50 C6      [ 1]  107 	mov	0x50c6+0, #0x00
                                    108 ;	src/main.c: 20: uart_init();
      008032 90 89            [ 2]  109 	pushw	y
      008034 CD 84 CD         [ 4]  110 	call	_uart_init
      008037 90 85            [ 2]  111 	popw	y
                                    112 ;	src/main.c: 22: uint8_t buff[100] = {0};
      008039 0F 01            [ 1]  113 	clr	(0x01, sp)
      00803B 96               [ 1]  114 	ldw	x, sp
      00803C 6F 02            [ 1]  115 	clr	(2, x)
      00803E 96               [ 1]  116 	ldw	x, sp
      00803F 6F 03            [ 1]  117 	clr	(3, x)
      008041 96               [ 1]  118 	ldw	x, sp
      008042 6F 04            [ 1]  119 	clr	(4, x)
      008044 96               [ 1]  120 	ldw	x, sp
      008045 6F 05            [ 1]  121 	clr	(5, x)
      008047 96               [ 1]  122 	ldw	x, sp
      008048 6F 06            [ 1]  123 	clr	(6, x)
      00804A 96               [ 1]  124 	ldw	x, sp
      00804B 6F 07            [ 1]  125 	clr	(7, x)
      00804D 96               [ 1]  126 	ldw	x, sp
      00804E 6F 08            [ 1]  127 	clr	(8, x)
      008050 96               [ 1]  128 	ldw	x, sp
      008051 6F 09            [ 1]  129 	clr	(9, x)
      008053 96               [ 1]  130 	ldw	x, sp
      008054 6F 0A            [ 1]  131 	clr	(10, x)
      008056 96               [ 1]  132 	ldw	x, sp
      008057 6F 0B            [ 1]  133 	clr	(11, x)
      008059 96               [ 1]  134 	ldw	x, sp
      00805A 6F 0C            [ 1]  135 	clr	(12, x)
      00805C 96               [ 1]  136 	ldw	x, sp
      00805D 6F 0D            [ 1]  137 	clr	(13, x)
      00805F 96               [ 1]  138 	ldw	x, sp
      008060 6F 0E            [ 1]  139 	clr	(14, x)
      008062 96               [ 1]  140 	ldw	x, sp
      008063 6F 0F            [ 1]  141 	clr	(15, x)
      008065 96               [ 1]  142 	ldw	x, sp
      008066 6F 10            [ 1]  143 	clr	(16, x)
      008068 96               [ 1]  144 	ldw	x, sp
      008069 6F 11            [ 1]  145 	clr	(17, x)
      00806B 96               [ 1]  146 	ldw	x, sp
      00806C 6F 12            [ 1]  147 	clr	(18, x)
      00806E 96               [ 1]  148 	ldw	x, sp
      00806F 6F 13            [ 1]  149 	clr	(19, x)
      008071 96               [ 1]  150 	ldw	x, sp
      008072 6F 14            [ 1]  151 	clr	(20, x)
      008074 96               [ 1]  152 	ldw	x, sp
      008075 6F 15            [ 1]  153 	clr	(21, x)
      008077 96               [ 1]  154 	ldw	x, sp
      008078 6F 16            [ 1]  155 	clr	(22, x)
      00807A 96               [ 1]  156 	ldw	x, sp
      00807B 6F 17            [ 1]  157 	clr	(23, x)
      00807D 96               [ 1]  158 	ldw	x, sp
      00807E 6F 18            [ 1]  159 	clr	(24, x)
      008080 96               [ 1]  160 	ldw	x, sp
      008081 6F 19            [ 1]  161 	clr	(25, x)
      008083 96               [ 1]  162 	ldw	x, sp
      008084 6F 1A            [ 1]  163 	clr	(26, x)
      008086 96               [ 1]  164 	ldw	x, sp
      008087 6F 1B            [ 1]  165 	clr	(27, x)
      008089 96               [ 1]  166 	ldw	x, sp
      00808A 6F 1C            [ 1]  167 	clr	(28, x)
      00808C 96               [ 1]  168 	ldw	x, sp
      00808D 6F 1D            [ 1]  169 	clr	(29, x)
      00808F 96               [ 1]  170 	ldw	x, sp
      008090 6F 1E            [ 1]  171 	clr	(30, x)
      008092 96               [ 1]  172 	ldw	x, sp
      008093 6F 1F            [ 1]  173 	clr	(31, x)
      008095 96               [ 1]  174 	ldw	x, sp
      008096 6F 20            [ 1]  175 	clr	(32, x)
      008098 96               [ 1]  176 	ldw	x, sp
      008099 6F 21            [ 1]  177 	clr	(33, x)
      00809B 96               [ 1]  178 	ldw	x, sp
      00809C 6F 22            [ 1]  179 	clr	(34, x)
      00809E 96               [ 1]  180 	ldw	x, sp
      00809F 6F 23            [ 1]  181 	clr	(35, x)
      0080A1 96               [ 1]  182 	ldw	x, sp
      0080A2 6F 24            [ 1]  183 	clr	(36, x)
      0080A4 96               [ 1]  184 	ldw	x, sp
      0080A5 6F 25            [ 1]  185 	clr	(37, x)
      0080A7 96               [ 1]  186 	ldw	x, sp
      0080A8 6F 26            [ 1]  187 	clr	(38, x)
      0080AA 96               [ 1]  188 	ldw	x, sp
      0080AB 6F 27            [ 1]  189 	clr	(39, x)
      0080AD 96               [ 1]  190 	ldw	x, sp
      0080AE 6F 28            [ 1]  191 	clr	(40, x)
      0080B0 96               [ 1]  192 	ldw	x, sp
      0080B1 6F 29            [ 1]  193 	clr	(41, x)
      0080B3 96               [ 1]  194 	ldw	x, sp
      0080B4 6F 2A            [ 1]  195 	clr	(42, x)
      0080B6 96               [ 1]  196 	ldw	x, sp
      0080B7 6F 2B            [ 1]  197 	clr	(43, x)
      0080B9 96               [ 1]  198 	ldw	x, sp
      0080BA 6F 2C            [ 1]  199 	clr	(44, x)
      0080BC 96               [ 1]  200 	ldw	x, sp
      0080BD 6F 2D            [ 1]  201 	clr	(45, x)
      0080BF 96               [ 1]  202 	ldw	x, sp
      0080C0 6F 2E            [ 1]  203 	clr	(46, x)
      0080C2 96               [ 1]  204 	ldw	x, sp
      0080C3 6F 2F            [ 1]  205 	clr	(47, x)
      0080C5 96               [ 1]  206 	ldw	x, sp
      0080C6 6F 30            [ 1]  207 	clr	(48, x)
      0080C8 96               [ 1]  208 	ldw	x, sp
      0080C9 6F 31            [ 1]  209 	clr	(49, x)
      0080CB 96               [ 1]  210 	ldw	x, sp
      0080CC 6F 32            [ 1]  211 	clr	(50, x)
      0080CE 96               [ 1]  212 	ldw	x, sp
      0080CF 6F 33            [ 1]  213 	clr	(51, x)
      0080D1 96               [ 1]  214 	ldw	x, sp
      0080D2 6F 34            [ 1]  215 	clr	(52, x)
      0080D4 96               [ 1]  216 	ldw	x, sp
      0080D5 6F 35            [ 1]  217 	clr	(53, x)
      0080D7 96               [ 1]  218 	ldw	x, sp
      0080D8 6F 36            [ 1]  219 	clr	(54, x)
      0080DA 96               [ 1]  220 	ldw	x, sp
      0080DB 6F 37            [ 1]  221 	clr	(55, x)
      0080DD 96               [ 1]  222 	ldw	x, sp
      0080DE 6F 38            [ 1]  223 	clr	(56, x)
      0080E0 96               [ 1]  224 	ldw	x, sp
      0080E1 6F 39            [ 1]  225 	clr	(57, x)
      0080E3 96               [ 1]  226 	ldw	x, sp
      0080E4 6F 3A            [ 1]  227 	clr	(58, x)
      0080E6 96               [ 1]  228 	ldw	x, sp
      0080E7 6F 3B            [ 1]  229 	clr	(59, x)
      0080E9 96               [ 1]  230 	ldw	x, sp
      0080EA 6F 3C            [ 1]  231 	clr	(60, x)
      0080EC 96               [ 1]  232 	ldw	x, sp
      0080ED 6F 3D            [ 1]  233 	clr	(61, x)
      0080EF 96               [ 1]  234 	ldw	x, sp
      0080F0 6F 3E            [ 1]  235 	clr	(62, x)
      0080F2 96               [ 1]  236 	ldw	x, sp
      0080F3 6F 3F            [ 1]  237 	clr	(63, x)
      0080F5 96               [ 1]  238 	ldw	x, sp
      0080F6 6F 40            [ 1]  239 	clr	(64, x)
      0080F8 96               [ 1]  240 	ldw	x, sp
      0080F9 6F 41            [ 1]  241 	clr	(65, x)
      0080FB 96               [ 1]  242 	ldw	x, sp
      0080FC 6F 42            [ 1]  243 	clr	(66, x)
      0080FE 96               [ 1]  244 	ldw	x, sp
      0080FF 6F 43            [ 1]  245 	clr	(67, x)
      008101 96               [ 1]  246 	ldw	x, sp
      008102 6F 44            [ 1]  247 	clr	(68, x)
      008104 96               [ 1]  248 	ldw	x, sp
      008105 6F 45            [ 1]  249 	clr	(69, x)
      008107 96               [ 1]  250 	ldw	x, sp
      008108 6F 46            [ 1]  251 	clr	(70, x)
      00810A 96               [ 1]  252 	ldw	x, sp
      00810B 6F 47            [ 1]  253 	clr	(71, x)
      00810D 96               [ 1]  254 	ldw	x, sp
      00810E 6F 48            [ 1]  255 	clr	(72, x)
      008110 96               [ 1]  256 	ldw	x, sp
      008111 6F 49            [ 1]  257 	clr	(73, x)
      008113 96               [ 1]  258 	ldw	x, sp
      008114 6F 4A            [ 1]  259 	clr	(74, x)
      008116 96               [ 1]  260 	ldw	x, sp
      008117 6F 4B            [ 1]  261 	clr	(75, x)
      008119 96               [ 1]  262 	ldw	x, sp
      00811A 6F 4C            [ 1]  263 	clr	(76, x)
      00811C 96               [ 1]  264 	ldw	x, sp
      00811D 6F 4D            [ 1]  265 	clr	(77, x)
      00811F 96               [ 1]  266 	ldw	x, sp
      008120 6F 4E            [ 1]  267 	clr	(78, x)
      008122 96               [ 1]  268 	ldw	x, sp
      008123 6F 4F            [ 1]  269 	clr	(79, x)
      008125 96               [ 1]  270 	ldw	x, sp
      008126 6F 50            [ 1]  271 	clr	(80, x)
      008128 96               [ 1]  272 	ldw	x, sp
      008129 6F 51            [ 1]  273 	clr	(81, x)
      00812B 96               [ 1]  274 	ldw	x, sp
      00812C 6F 52            [ 1]  275 	clr	(82, x)
      00812E 96               [ 1]  276 	ldw	x, sp
      00812F 6F 53            [ 1]  277 	clr	(83, x)
      008131 96               [ 1]  278 	ldw	x, sp
      008132 6F 54            [ 1]  279 	clr	(84, x)
      008134 96               [ 1]  280 	ldw	x, sp
      008135 6F 55            [ 1]  281 	clr	(85, x)
      008137 96               [ 1]  282 	ldw	x, sp
      008138 6F 56            [ 1]  283 	clr	(86, x)
      00813A 96               [ 1]  284 	ldw	x, sp
      00813B 6F 57            [ 1]  285 	clr	(87, x)
      00813D 96               [ 1]  286 	ldw	x, sp
      00813E 6F 58            [ 1]  287 	clr	(88, x)
      008140 96               [ 1]  288 	ldw	x, sp
      008141 6F 59            [ 1]  289 	clr	(89, x)
      008143 96               [ 1]  290 	ldw	x, sp
      008144 6F 5A            [ 1]  291 	clr	(90, x)
      008146 96               [ 1]  292 	ldw	x, sp
      008147 6F 5B            [ 1]  293 	clr	(91, x)
      008149 96               [ 1]  294 	ldw	x, sp
      00814A 6F 5C            [ 1]  295 	clr	(92, x)
      00814C 96               [ 1]  296 	ldw	x, sp
      00814D 6F 5D            [ 1]  297 	clr	(93, x)
      00814F 96               [ 1]  298 	ldw	x, sp
      008150 6F 5E            [ 1]  299 	clr	(94, x)
      008152 96               [ 1]  300 	ldw	x, sp
      008153 6F 5F            [ 1]  301 	clr	(95, x)
      008155 96               [ 1]  302 	ldw	x, sp
      008156 6F 60            [ 1]  303 	clr	(96, x)
      008158 96               [ 1]  304 	ldw	x, sp
      008159 6F 61            [ 1]  305 	clr	(97, x)
      00815B 96               [ 1]  306 	ldw	x, sp
      00815C 6F 62            [ 1]  307 	clr	(98, x)
      00815E 96               [ 1]  308 	ldw	x, sp
      00815F 6F 63            [ 1]  309 	clr	(99, x)
      008161 96               [ 1]  310 	ldw	x, sp
      008162 6F 64            [ 1]  311 	clr	(100, x)
                                    312 ;	src/main.c: 23: uint8_t buff2[100] = {0};
      008164 0F 65            [ 1]  313 	clr	(0x65, sp)
      008166 96               [ 1]  314 	ldw	x, sp
      008167 6F 66            [ 1]  315 	clr	(102, x)
      008169 96               [ 1]  316 	ldw	x, sp
      00816A 6F 67            [ 1]  317 	clr	(103, x)
      00816C 96               [ 1]  318 	ldw	x, sp
      00816D 6F 68            [ 1]  319 	clr	(104, x)
      00816F 96               [ 1]  320 	ldw	x, sp
      008170 6F 69            [ 1]  321 	clr	(105, x)
      008172 96               [ 1]  322 	ldw	x, sp
      008173 6F 6A            [ 1]  323 	clr	(106, x)
      008175 96               [ 1]  324 	ldw	x, sp
      008176 6F 6B            [ 1]  325 	clr	(107, x)
      008178 96               [ 1]  326 	ldw	x, sp
      008179 6F 6C            [ 1]  327 	clr	(108, x)
      00817B 96               [ 1]  328 	ldw	x, sp
      00817C 6F 6D            [ 1]  329 	clr	(109, x)
      00817E 96               [ 1]  330 	ldw	x, sp
      00817F 6F 6E            [ 1]  331 	clr	(110, x)
      008181 96               [ 1]  332 	ldw	x, sp
      008182 6F 6F            [ 1]  333 	clr	(111, x)
      008184 96               [ 1]  334 	ldw	x, sp
      008185 6F 70            [ 1]  335 	clr	(112, x)
      008187 96               [ 1]  336 	ldw	x, sp
      008188 6F 71            [ 1]  337 	clr	(113, x)
      00818A 96               [ 1]  338 	ldw	x, sp
      00818B 6F 72            [ 1]  339 	clr	(114, x)
      00818D 96               [ 1]  340 	ldw	x, sp
      00818E 6F 73            [ 1]  341 	clr	(115, x)
      008190 96               [ 1]  342 	ldw	x, sp
      008191 6F 74            [ 1]  343 	clr	(116, x)
      008193 96               [ 1]  344 	ldw	x, sp
      008194 6F 75            [ 1]  345 	clr	(117, x)
      008196 96               [ 1]  346 	ldw	x, sp
      008197 6F 76            [ 1]  347 	clr	(118, x)
      008199 96               [ 1]  348 	ldw	x, sp
      00819A 6F 77            [ 1]  349 	clr	(119, x)
      00819C 96               [ 1]  350 	ldw	x, sp
      00819D 6F 78            [ 1]  351 	clr	(120, x)
      00819F 96               [ 1]  352 	ldw	x, sp
      0081A0 6F 79            [ 1]  353 	clr	(121, x)
      0081A2 96               [ 1]  354 	ldw	x, sp
      0081A3 6F 7A            [ 1]  355 	clr	(122, x)
      0081A5 96               [ 1]  356 	ldw	x, sp
      0081A6 6F 7B            [ 1]  357 	clr	(123, x)
      0081A8 96               [ 1]  358 	ldw	x, sp
      0081A9 6F 7C            [ 1]  359 	clr	(124, x)
      0081AB 96               [ 1]  360 	ldw	x, sp
      0081AC 6F 7D            [ 1]  361 	clr	(125, x)
      0081AE 96               [ 1]  362 	ldw	x, sp
      0081AF 6F 7E            [ 1]  363 	clr	(126, x)
      0081B1 96               [ 1]  364 	ldw	x, sp
      0081B2 6F 7F            [ 1]  365 	clr	(127, x)
      0081B4 96               [ 1]  366 	ldw	x, sp
      0081B5 6F 80            [ 1]  367 	clr	(128, x)
      0081B7 96               [ 1]  368 	ldw	x, sp
      0081B8 6F 81            [ 1]  369 	clr	(129, x)
      0081BA 96               [ 1]  370 	ldw	x, sp
      0081BB 6F 82            [ 1]  371 	clr	(130, x)
      0081BD 96               [ 1]  372 	ldw	x, sp
      0081BE 6F 83            [ 1]  373 	clr	(131, x)
      0081C0 96               [ 1]  374 	ldw	x, sp
      0081C1 6F 84            [ 1]  375 	clr	(132, x)
      0081C3 96               [ 1]  376 	ldw	x, sp
      0081C4 6F 85            [ 1]  377 	clr	(133, x)
      0081C6 96               [ 1]  378 	ldw	x, sp
      0081C7 6F 86            [ 1]  379 	clr	(134, x)
      0081C9 96               [ 1]  380 	ldw	x, sp
      0081CA 6F 87            [ 1]  381 	clr	(135, x)
      0081CC 96               [ 1]  382 	ldw	x, sp
      0081CD 6F 88            [ 1]  383 	clr	(136, x)
      0081CF 96               [ 1]  384 	ldw	x, sp
      0081D0 6F 89            [ 1]  385 	clr	(137, x)
      0081D2 96               [ 1]  386 	ldw	x, sp
      0081D3 6F 8A            [ 1]  387 	clr	(138, x)
      0081D5 96               [ 1]  388 	ldw	x, sp
      0081D6 6F 8B            [ 1]  389 	clr	(139, x)
      0081D8 96               [ 1]  390 	ldw	x, sp
      0081D9 6F 8C            [ 1]  391 	clr	(140, x)
      0081DB 96               [ 1]  392 	ldw	x, sp
      0081DC 6F 8D            [ 1]  393 	clr	(141, x)
      0081DE 96               [ 1]  394 	ldw	x, sp
      0081DF 6F 8E            [ 1]  395 	clr	(142, x)
      0081E1 96               [ 1]  396 	ldw	x, sp
      0081E2 6F 8F            [ 1]  397 	clr	(143, x)
      0081E4 96               [ 1]  398 	ldw	x, sp
      0081E5 6F 90            [ 1]  399 	clr	(144, x)
      0081E7 96               [ 1]  400 	ldw	x, sp
      0081E8 6F 91            [ 1]  401 	clr	(145, x)
      0081EA 96               [ 1]  402 	ldw	x, sp
      0081EB 6F 92            [ 1]  403 	clr	(146, x)
      0081ED 96               [ 1]  404 	ldw	x, sp
      0081EE 6F 93            [ 1]  405 	clr	(147, x)
      0081F0 96               [ 1]  406 	ldw	x, sp
      0081F1 6F 94            [ 1]  407 	clr	(148, x)
      0081F3 96               [ 1]  408 	ldw	x, sp
      0081F4 6F 95            [ 1]  409 	clr	(149, x)
      0081F6 96               [ 1]  410 	ldw	x, sp
      0081F7 6F 96            [ 1]  411 	clr	(150, x)
      0081F9 96               [ 1]  412 	ldw	x, sp
      0081FA 6F 97            [ 1]  413 	clr	(151, x)
      0081FC 96               [ 1]  414 	ldw	x, sp
      0081FD 6F 98            [ 1]  415 	clr	(152, x)
      0081FF 96               [ 1]  416 	ldw	x, sp
      008200 6F 99            [ 1]  417 	clr	(153, x)
      008202 96               [ 1]  418 	ldw	x, sp
      008203 6F 9A            [ 1]  419 	clr	(154, x)
      008205 96               [ 1]  420 	ldw	x, sp
      008206 6F 9B            [ 1]  421 	clr	(155, x)
      008208 96               [ 1]  422 	ldw	x, sp
      008209 6F 9C            [ 1]  423 	clr	(156, x)
      00820B 96               [ 1]  424 	ldw	x, sp
      00820C 6F 9D            [ 1]  425 	clr	(157, x)
      00820E 96               [ 1]  426 	ldw	x, sp
      00820F 6F 9E            [ 1]  427 	clr	(158, x)
      008211 96               [ 1]  428 	ldw	x, sp
      008212 6F 9F            [ 1]  429 	clr	(159, x)
      008214 96               [ 1]  430 	ldw	x, sp
      008215 6F A0            [ 1]  431 	clr	(160, x)
      008217 96               [ 1]  432 	ldw	x, sp
      008218 6F A1            [ 1]  433 	clr	(161, x)
      00821A 96               [ 1]  434 	ldw	x, sp
      00821B 6F A2            [ 1]  435 	clr	(162, x)
      00821D 96               [ 1]  436 	ldw	x, sp
      00821E 6F A3            [ 1]  437 	clr	(163, x)
      008220 96               [ 1]  438 	ldw	x, sp
      008221 6F A4            [ 1]  439 	clr	(164, x)
      008223 96               [ 1]  440 	ldw	x, sp
      008224 6F A5            [ 1]  441 	clr	(165, x)
      008226 96               [ 1]  442 	ldw	x, sp
      008227 6F A6            [ 1]  443 	clr	(166, x)
      008229 96               [ 1]  444 	ldw	x, sp
      00822A 6F A7            [ 1]  445 	clr	(167, x)
      00822C 96               [ 1]  446 	ldw	x, sp
      00822D 6F A8            [ 1]  447 	clr	(168, x)
      00822F 96               [ 1]  448 	ldw	x, sp
      008230 6F A9            [ 1]  449 	clr	(169, x)
      008232 96               [ 1]  450 	ldw	x, sp
      008233 6F AA            [ 1]  451 	clr	(170, x)
      008235 96               [ 1]  452 	ldw	x, sp
      008236 6F AB            [ 1]  453 	clr	(171, x)
      008238 96               [ 1]  454 	ldw	x, sp
      008239 6F AC            [ 1]  455 	clr	(172, x)
      00823B 96               [ 1]  456 	ldw	x, sp
      00823C 6F AD            [ 1]  457 	clr	(173, x)
      00823E 96               [ 1]  458 	ldw	x, sp
      00823F 6F AE            [ 1]  459 	clr	(174, x)
      008241 96               [ 1]  460 	ldw	x, sp
      008242 6F AF            [ 1]  461 	clr	(175, x)
      008244 96               [ 1]  462 	ldw	x, sp
      008245 6F B0            [ 1]  463 	clr	(176, x)
      008247 96               [ 1]  464 	ldw	x, sp
      008248 6F B1            [ 1]  465 	clr	(177, x)
      00824A 96               [ 1]  466 	ldw	x, sp
      00824B 6F B2            [ 1]  467 	clr	(178, x)
      00824D 96               [ 1]  468 	ldw	x, sp
      00824E 6F B3            [ 1]  469 	clr	(179, x)
      008250 96               [ 1]  470 	ldw	x, sp
      008251 6F B4            [ 1]  471 	clr	(180, x)
      008253 96               [ 1]  472 	ldw	x, sp
      008254 6F B5            [ 1]  473 	clr	(181, x)
      008256 96               [ 1]  474 	ldw	x, sp
      008257 6F B6            [ 1]  475 	clr	(182, x)
      008259 96               [ 1]  476 	ldw	x, sp
      00825A 6F B7            [ 1]  477 	clr	(183, x)
      00825C 96               [ 1]  478 	ldw	x, sp
      00825D 6F B8            [ 1]  479 	clr	(184, x)
      00825F 96               [ 1]  480 	ldw	x, sp
      008260 6F B9            [ 1]  481 	clr	(185, x)
      008262 96               [ 1]  482 	ldw	x, sp
      008263 6F BA            [ 1]  483 	clr	(186, x)
      008265 96               [ 1]  484 	ldw	x, sp
      008266 6F BB            [ 1]  485 	clr	(187, x)
      008268 96               [ 1]  486 	ldw	x, sp
      008269 6F BC            [ 1]  487 	clr	(188, x)
      00826B 96               [ 1]  488 	ldw	x, sp
      00826C 6F BD            [ 1]  489 	clr	(189, x)
      00826E 96               [ 1]  490 	ldw	x, sp
      00826F 6F BE            [ 1]  491 	clr	(190, x)
      008271 96               [ 1]  492 	ldw	x, sp
      008272 6F BF            [ 1]  493 	clr	(191, x)
      008274 96               [ 1]  494 	ldw	x, sp
      008275 6F C0            [ 1]  495 	clr	(192, x)
      008277 96               [ 1]  496 	ldw	x, sp
      008278 6F C1            [ 1]  497 	clr	(193, x)
      00827A 96               [ 1]  498 	ldw	x, sp
      00827B 6F C2            [ 1]  499 	clr	(194, x)
      00827D 96               [ 1]  500 	ldw	x, sp
      00827E 6F C3            [ 1]  501 	clr	(195, x)
      008280 96               [ 1]  502 	ldw	x, sp
      008281 6F C4            [ 1]  503 	clr	(196, x)
      008283 96               [ 1]  504 	ldw	x, sp
      008284 6F C5            [ 1]  505 	clr	(197, x)
      008286 96               [ 1]  506 	ldw	x, sp
      008287 6F C6            [ 1]  507 	clr	(198, x)
      008289 96               [ 1]  508 	ldw	x, sp
      00828A 6F C7            [ 1]  509 	clr	(199, x)
      00828C 96               [ 1]  510 	ldw	x, sp
      00828D 6F C8            [ 1]  511 	clr	(200, x)
                                    512 ;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
      00828F 4F               [ 1]  513 	clr	a
      008290                        514 00112$:
      008290 A1 64            [ 1]  515 	cp	a, #0x64
      008292 24 0E            [ 1]  516 	jrnc	00101$
                                    517 ;	src/main.c: 26: buff[i] = i/* +7+'0' */;
      008294 96               [ 1]  518 	ldw	x, sp
      008295 5C               [ 1]  519 	incw	x
      008296 89               [ 2]  520 	pushw	x
      008297 5F               [ 1]  521 	clrw	x
      008298 97               [ 1]  522 	ld	xl, a
      008299 72 FB 01         [ 2]  523 	addw	x, (1, sp)
      00829C 5B 02            [ 2]  524 	addw	sp, #2
      00829E F7               [ 1]  525 	ld	(x), a
                                    526 ;	src/main.c: 24: for (uint8_t i = 0; i < 100; i++)
      00829F 4C               [ 1]  527 	inc	a
      0082A0 20 EE            [ 2]  528 	jra	00112$
      0082A2                        529 00101$:
                                    530 ;	src/main.c: 29: ws2812_gpio_config();
      0082A2 90 89            [ 2]  531 	pushw	y
      0082A4 CD 87 74         [ 4]  532 	call	_ws2812_gpio_config
      0082A7 CD 86 AD         [ 4]  533 	call	_spi_config
      0082AA 4B 99            [ 1]  534 	push	#0x99
      0082AC CD 85 13         [ 4]  535 	call	_uart_write_8bits
      0082AF 84               [ 1]  536 	pop	a
      0082B0 4B 64            [ 1]  537 	push	#0x64
      0082B2 4B 00            [ 1]  538 	push	#0x00
      0082B4 96               [ 1]  539 	ldw	x, sp
      0082B5 1C 00 69         [ 2]  540 	addw	x, #105
      0082B8 89               [ 2]  541 	pushw	x
      0082B9 4B 45            [ 1]  542 	push	#0x45
      0082BB 4B 23            [ 1]  543 	push	#0x23
      0082BD 4B 01            [ 1]  544 	push	#0x01
      0082BF 4B 00            [ 1]  545 	push	#0x00
      0082C1 CD 85 84         [ 4]  546 	call	_flash_read_from_addr
      0082C4 5B 08            [ 2]  547 	addw	sp, #8
      0082C6 90 85            [ 2]  548 	popw	y
                                    549 ;	src/main.c: 46: char hex_string[2] = {0};
      0082C8 0F C9            [ 1]  550 	clr	(0xc9, sp)
      0082CA 96               [ 1]  551 	ldw	x, sp
      0082CB 1C 00 CA         [ 2]  552 	addw	x, #202
      0082CE 7F               [ 1]  553 	clr	(x)
                                    554 ;	src/main.c: 49: uint8_t red = 255, green = 0, blue = 0;
      0082CF A6 FF            [ 1]  555 	ld	a, #0xff
      0082D1 6B CB            [ 1]  556 	ld	(0xcb, sp), a
      0082D3 0F CC            [ 1]  557 	clr	(0xcc, sp)
      0082D5 0F CD            [ 1]  558 	clr	(0xcd, sp)
                                    559 ;	src/main.c: 50: uint8_t r_temp = red, g_temp = green, b_temp = blue;
      0082D7 A6 FF            [ 1]  560 	ld	a, #0xff
      0082D9 6B CE            [ 1]  561 	ld	(0xce, sp), a
      0082DB 0F CF            [ 1]  562 	clr	(0xcf, sp)
      0082DD 0F D0            [ 1]  563 	clr	(0xd0, sp)
                                    564 ;	src/main.c: 58: for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
      0082DF                        565 00128$:
      0082DF 90 6F 96         [ 1]  566 	clr	(0x96, y)
      0082E2                        567 00115$:
      0082E2 90 E6 96         [ 1]  568 	ld	a, (0x96, y)
      0082E5 A1 3C            [ 1]  569 	cp	a, #0x3c
      0082E7 24 58            [ 1]  570 	jrnc	00102$
                                    571 ;	src/main.c: 60: get_next_color(&r_temp, &g_temp, &b_temp, 10);
      0082E9 90 89            [ 2]  572 	pushw	y
      0082EB 4B 0A            [ 1]  573 	push	#0x0a
      0082ED 96               [ 1]  574 	ldw	x, sp
      0082EE 1C 00 D3         [ 2]  575 	addw	x, #211
      0082F1 89               [ 2]  576 	pushw	x
      0082F2 96               [ 1]  577 	ldw	x, sp
      0082F3 1C 00 D4         [ 2]  578 	addw	x, #212
      0082F6 89               [ 2]  579 	pushw	x
      0082F7 96               [ 1]  580 	ldw	x, sp
      0082F8 1C 00 D5         [ 2]  581 	addw	x, #213
      0082FB 89               [ 2]  582 	pushw	x
      0082FC CD 83 EE         [ 4]  583 	call	_get_next_color
      0082FF 5B 07            [ 2]  584 	addw	sp, #7
      008301 90 85            [ 2]  585 	popw	y
                                    586 ;	src/main.c: 61: color_buff[led_cnt][0] = r_temp;
      008303 90 E6 96         [ 1]  587 	ld	a, (0x96, y)
      008306 97               [ 1]  588 	ld	xl, a
      008307 A6 03            [ 1]  589 	ld	a, #0x03
      008309 42               [ 4]  590 	mul	x, a
      00830A 90 EF 92         [ 2]  591 	ldw	(0x92, y), x
      00830D 93               [ 1]  592 	ldw	x, y
      00830E EE 92            [ 2]  593 	ldw	x, (0x92, x)
      008310 89               [ 2]  594 	pushw	x
      008311 96               [ 1]  595 	ldw	x, sp
      008312 1C 00 D3         [ 2]  596 	addw	x, #211
      008315 72 FB 01         [ 2]  597 	addw	x, (1, sp)
      008318 5B 02            [ 2]  598 	addw	sp, #2
      00831A 7B CE            [ 1]  599 	ld	a, (0xce, sp)
      00831C F7               [ 1]  600 	ld	(x), a
                                    601 ;	src/main.c: 62: color_buff[led_cnt][1] = g_temp;
      00831D 93               [ 1]  602 	ldw	x, y
      00831E EE 92            [ 2]  603 	ldw	x, (0x92, x)
      008320 89               [ 2]  604 	pushw	x
      008321 96               [ 1]  605 	ldw	x, sp
      008322 1C 00 D3         [ 2]  606 	addw	x, #211
      008325 72 FB 01         [ 2]  607 	addw	x, (1, sp)
      008328 90 EF 94         [ 2]  608 	ldw	(0x94, y), x
      00832B 5B 02            [ 2]  609 	addw	sp, #2
      00832D 93               [ 1]  610 	ldw	x, y
      00832E EE 94            [ 2]  611 	ldw	x, (0x94, x)
      008330 5C               [ 1]  612 	incw	x
      008331 7B CF            [ 1]  613 	ld	a, (0xcf, sp)
      008333 F7               [ 1]  614 	ld	(x), a
                                    615 ;	src/main.c: 63: color_buff[led_cnt][2] = b_temp;
      008334 93               [ 1]  616 	ldw	x, y
      008335 EE 94            [ 2]  617 	ldw	x, (0x94, x)
      008337 5C               [ 1]  618 	incw	x
      008338 5C               [ 1]  619 	incw	x
      008339 7B D0            [ 1]  620 	ld	a, (0xd0, sp)
      00833B F7               [ 1]  621 	ld	(x), a
                                    622 ;	src/main.c: 58: for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
      00833C 90 6C 96         [ 1]  623 	inc	(0x96, y)
      00833F 20 A1            [ 2]  624 	jra	00115$
      008341                        625 00102$:
                                    626 ;	src/main.c: 66: for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
      008341 90 6F 96         [ 1]  627 	clr	(0x96, y)
      008344                        628 00118$:
      008344 90 E6 96         [ 1]  629 	ld	a, (0x96, y)
      008347 A1 3C            [ 1]  630 	cp	a, #0x3c
      008349 24 47            [ 1]  631 	jrnc	00103$
                                    632 ;	src/main.c: 69: ws2812_send_pixel_24bits(color_buff[led_cnt][0], color_buff[led_cnt][1], color_buff[led_cnt][2]);
      00834B 90 E6 96         [ 1]  633 	ld	a, (0x96, y)
      00834E 97               [ 1]  634 	ld	xl, a
      00834F A6 03            [ 1]  635 	ld	a, #0x03
      008351 42               [ 4]  636 	mul	x, a
      008352 90 EF 94         [ 2]  637 	ldw	(0x94, y), x
      008355 93               [ 1]  638 	ldw	x, y
      008356 EE 94            [ 2]  639 	ldw	x, (0x94, x)
      008358 89               [ 2]  640 	pushw	x
      008359 96               [ 1]  641 	ldw	x, sp
      00835A 1C 00 D3         [ 2]  642 	addw	x, #211
      00835D 72 FB 01         [ 2]  643 	addw	x, (1, sp)
      008360 90 EF 92         [ 2]  644 	ldw	(0x92, y), x
      008363 5B 02            [ 2]  645 	addw	sp, #2
      008365 93               [ 1]  646 	ldw	x, y
      008366 EE 92            [ 2]  647 	ldw	x, (0x92, x)
      008368 E6 02            [ 1]  648 	ld	a, (0x2, x)
      00836A 90 E7 94         [ 1]  649 	ld	(0x94, y), a
      00836D 93               [ 1]  650 	ldw	x, y
      00836E EE 92            [ 2]  651 	ldw	x, (0x92, x)
      008370 E6 01            [ 1]  652 	ld	a, (0x1, x)
      008372 90 E7 95         [ 1]  653 	ld	(0x95, y), a
      008375 93               [ 1]  654 	ldw	x, y
      008376 EE 92            [ 2]  655 	ldw	x, (0x92, x)
      008378 F6               [ 1]  656 	ld	a, (x)
      008379 97               [ 1]  657 	ld	xl, a
      00837A 90 89            [ 2]  658 	pushw	y
      00837C 90 E6 94         [ 1]  659 	ld	a, (0x94, y)
      00837F 88               [ 1]  660 	push	a
      008380 90 E6 95         [ 1]  661 	ld	a, (0x95, y)
      008383 88               [ 1]  662 	push	a
      008384 9F               [ 1]  663 	ld	a, xl
      008385 88               [ 1]  664 	push	a
      008386 CD 87 BB         [ 4]  665 	call	_ws2812_send_pixel_24bits
      008389 5B 03            [ 2]  666 	addw	sp, #3
      00838B 90 85            [ 2]  667 	popw	y
                                    668 ;	src/main.c: 66: for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
      00838D 90 6C 96         [ 1]  669 	inc	(0x96, y)
      008390 20 B2            [ 2]  670 	jra	00118$
      008392                        671 00103$:
                                    672 ;	src/main.c: 73: ws2812_send_latch();
      008392 90 89            [ 2]  673 	pushw	y
      008394 CD 87 D1         [ 4]  674 	call	_ws2812_send_latch
      008397 4B 14            [ 1]  675 	push	#0x14
      008399 96               [ 1]  676 	ldw	x, sp
      00839A 1C 00 D0         [ 2]  677 	addw	x, #208
      00839D 89               [ 2]  678 	pushw	x
      00839E 96               [ 1]  679 	ldw	x, sp
      00839F 1C 00 D1         [ 2]  680 	addw	x, #209
      0083A2 89               [ 2]  681 	pushw	x
      0083A3 96               [ 1]  682 	ldw	x, sp
      0083A4 1C 00 D2         [ 2]  683 	addw	x, #210
      0083A7 89               [ 2]  684 	pushw	x
      0083A8 CD 83 EE         [ 4]  685 	call	_get_next_color
      0083AB 5B 07            [ 2]  686 	addw	sp, #7
      0083AD 90 85            [ 2]  687 	popw	y
                                    688 ;	src/main.c: 75: r_temp = red, g_temp = green, b_temp = blue;
      0083AF 7B CB            [ 1]  689 	ld	a, (0xcb, sp)
      0083B1 6B CE            [ 1]  690 	ld	(0xce, sp), a
      0083B3 7B CC            [ 1]  691 	ld	a, (0xcc, sp)
      0083B5 6B CF            [ 1]  692 	ld	(0xcf, sp), a
      0083B7 7B CD            [ 1]  693 	ld	a, (0xcd, sp)
      0083B9 6B D0            [ 1]  694 	ld	(0xd0, sp), a
                                    695 ;	src/main.c: 77: for (uint32_t jj = 0; jj < 10000; jj++);
      0083BB 5F               [ 1]  696 	clrw	x
      0083BC 90 6F 94         [ 1]  697 	clr	(0x94, y)
      0083BF 90 6F 93         [ 1]  698 	clr	(0x93, y)
      0083C2                        699 00121$:
      0083C2 A3 27 10         [ 2]  700 	cpw	x, #0x2710
      0083C5 90 E6 94         [ 1]  701 	ld	a, (0x94, y)
      0083C8 A2 00            [ 1]  702 	sbc	a, #0x00
      0083CA 90 E6 93         [ 1]  703 	ld	a, (0x93, y)
      0083CD A2 00            [ 1]  704 	sbc	a, #0x00
      0083CF 25 03            [ 1]  705 	jrc	00176$
      0083D1 CC 82 DF         [ 2]  706 	jp	00128$
      0083D4                        707 00176$:
      0083D4 1C 00 01         [ 2]  708 	addw	x, #0x0001
      0083D7 90 E6 94         [ 1]  709 	ld	a, (0x94, y)
      0083DA A9 00            [ 1]  710 	adc	a, #0x00
      0083DC 90 E7 94         [ 1]  711 	ld	(0x94, y), a
      0083DF 90 E6 93         [ 1]  712 	ld	a, (0x93, y)
      0083E2 A9 00            [ 1]  713 	adc	a, #0x00
      0083E4 90 E7 93         [ 1]  714 	ld	(0x93, y), a
      0083E7 20 D9            [ 2]  715 	jra	00121$
                                    716 ;	src/main.c: 83: while(1);
                                    717 ;	src/main.c: 84: }
      0083E9 5B FF            [ 2]  718 	addw	sp, #255
      0083EB 5B 8A            [ 2]  719 	addw	sp, #138
      0083ED 81               [ 4]  720 	ret
                                    721 ;	src/main.c: 86: void get_next_color(uint8_t *r, uint8_t *g, uint8_t *b, uint8_t step)
                                    722 ;	-----------------------------------------
                                    723 ;	 function get_next_color
                                    724 ;	-----------------------------------------
      0083EE                        725 _get_next_color:
      0083EE 52 12            [ 2]  726 	sub	sp, #18
                                    727 ;	src/main.c: 88: while (step--)
      0083F0 16 19            [ 2]  728 	ldw	y, (0x19, sp)
      0083F2 17 01            [ 2]  729 	ldw	(0x01, sp), y
      0083F4 17 03            [ 2]  730 	ldw	(0x03, sp), y
      0083F6 16 01            [ 2]  731 	ldw	y, (0x01, sp)
      0083F8 17 05            [ 2]  732 	ldw	(0x05, sp), y
      0083FA 16 01            [ 2]  733 	ldw	y, (0x01, sp)
      0083FC 17 07            [ 2]  734 	ldw	(0x07, sp), y
      0083FE 7B 1B            [ 1]  735 	ld	a, (0x1b, sp)
      008400 6B 12            [ 1]  736 	ld	(0x12, sp), a
      008402                        737 00130$:
      008402 7B 12            [ 1]  738 	ld	a, (0x12, sp)
      008404 0A 12            [ 1]  739 	dec	(0x12, sp)
      008406 4D               [ 1]  740 	tnz	a
      008407 26 03            [ 1]  741 	jrne	00236$
      008409 CC 84 CA         [ 2]  742 	jp	00133$
      00840C                        743 00236$:
                                    744 ;	src/main.c: 90: if (*r == 255 && *b == 0 && *g < 255)
      00840C 16 15            [ 2]  745 	ldw	y, (0x15, sp)
      00840E 17 09            [ 2]  746 	ldw	(0x09, sp), y
      008410 93               [ 1]  747 	ldw	x, y
      008411 F6               [ 1]  748 	ld	a, (x)
      008412 6B 0B            [ 1]  749 	ld	(0x0b, sp), a
      008414 16 17            [ 2]  750 	ldw	y, (0x17, sp)
                                    751 ;	src/main.c: 92: else if ( *g == 255 && *b == 0 && *r > 0)
      008416 17 0C            [ 2]  752 	ldw	(0x0c, sp), y
      008418 93               [ 1]  753 	ldw	x, y
      008419 F6               [ 1]  754 	ld	a, (x)
      00841A 6B 0E            [ 1]  755 	ld	(0x0e, sp), a
                                    756 ;	src/main.c: 90: if (*r == 255 && *b == 0 && *g < 255)
      00841C 7B 0B            [ 1]  757 	ld	a, (0x0b, sp)
      00841E 4C               [ 1]  758 	inc	a
      00841F 26 05            [ 1]  759 	jrne	00238$
      008421 A6 01            [ 1]  760 	ld	a, #0x01
      008423 6B 0F            [ 1]  761 	ld	(0x0f, sp), a
      008425 C5                     762 	.byte 0xc5
      008426                        763 00238$:
      008426 0F 0F            [ 1]  764 	clr	(0x0f, sp)
      008428                        765 00239$:
                                    766 ;	src/main.c: 91: (*g) += 1;
      008428 7B 0E            [ 1]  767 	ld	a, (0x0e, sp)
      00842A 6B 10            [ 1]  768 	ld	(0x10, sp), a
                                    769 ;	src/main.c: 90: if (*r == 255 && *b == 0 && *g < 255)
      00842C 0D 0F            [ 1]  770 	tnz	(0x0f, sp)
      00842E 27 13            [ 1]  771 	jreq	00126$
      008430 1E 01            [ 2]  772 	ldw	x, (0x01, sp)
      008432 F6               [ 1]  773 	ld	a, (x)
      008433 26 0E            [ 1]  774 	jrne	00126$
      008435 7B 0E            [ 1]  775 	ld	a, (0x0e, sp)
      008437 A1 FF            [ 1]  776 	cp	a, #0xff
      008439 24 08            [ 1]  777 	jrnc	00126$
                                    778 ;	src/main.c: 91: (*g) += 1;
      00843B 7B 10            [ 1]  779 	ld	a, (0x10, sp)
      00843D 4C               [ 1]  780 	inc	a
      00843E 1E 0C            [ 2]  781 	ldw	x, (0x0c, sp)
      008440 F7               [ 1]  782 	ld	(x), a
      008441 20 BF            [ 2]  783 	jra	00130$
      008443                        784 00126$:
                                    785 ;	src/main.c: 92: else if ( *g == 255 && *b == 0 && *r > 0)
      008443 7B 0E            [ 1]  786 	ld	a, (0x0e, sp)
      008445 4C               [ 1]  787 	inc	a
      008446 26 05            [ 1]  788 	jrne	00244$
      008448 A6 01            [ 1]  789 	ld	a, #0x01
      00844A 6B 11            [ 1]  790 	ld	(0x11, sp), a
      00844C C5                     791 	.byte 0xc5
      00844D                        792 00244$:
      00844D 0F 11            [ 1]  793 	clr	(0x11, sp)
      00844F                        794 00245$:
                                    795 ;	src/main.c: 93: (*r) -= 1;
      00844F 7B 0B            [ 1]  796 	ld	a, (0x0b, sp)
      008451 90 97            [ 1]  797 	ld	yl, a
                                    798 ;	src/main.c: 92: else if ( *g == 255 && *b == 0 && *r > 0)
      008453 0D 11            [ 1]  799 	tnz	(0x11, sp)
      008455 27 11            [ 1]  800 	jreq	00121$
      008457 1E 03            [ 2]  801 	ldw	x, (0x03, sp)
      008459 F6               [ 1]  802 	ld	a, (x)
      00845A 26 0C            [ 1]  803 	jrne	00121$
      00845C 0D 0B            [ 1]  804 	tnz	(0x0b, sp)
      00845E 27 08            [ 1]  805 	jreq	00121$
                                    806 ;	src/main.c: 93: (*r) -= 1;
      008460 90 9F            [ 1]  807 	ld	a, yl
      008462 4A               [ 1]  808 	dec	a
      008463 1E 09            [ 2]  809 	ldw	x, (0x09, sp)
      008465 F7               [ 1]  810 	ld	(x), a
      008466 20 9A            [ 2]  811 	jra	00130$
      008468                        812 00121$:
                                    813 ;	src/main.c: 94: else if (*r == 0 && *g == 255 && *b < 255)
      008468 0D 0B            [ 1]  814 	tnz	(0x0b, sp)
      00846A 26 11            [ 1]  815 	jrne	00116$
      00846C 0D 11            [ 1]  816 	tnz	(0x11, sp)
      00846E 27 0D            [ 1]  817 	jreq	00116$
      008470 1E 01            [ 2]  818 	ldw	x, (0x01, sp)
      008472 F6               [ 1]  819 	ld	a, (x)
      008473 A1 FF            [ 1]  820 	cp	a, #0xff
      008475 24 06            [ 1]  821 	jrnc	00116$
                                    822 ;	src/main.c: 95: (*b) += 1;
      008477 4C               [ 1]  823 	inc	a
      008478 1E 01            [ 2]  824 	ldw	x, (0x01, sp)
      00847A F7               [ 1]  825 	ld	(x), a
      00847B 20 85            [ 2]  826 	jra	00130$
      00847D                        827 00116$:
                                    828 ;	src/main.c: 96: else if (*r == 0 && *b == 255 && *g > 0)
      00847D 0D 0B            [ 1]  829 	tnz	(0x0b, sp)
      00847F 26 13            [ 1]  830 	jrne	00111$
      008481 1E 05            [ 2]  831 	ldw	x, (0x05, sp)
      008483 F6               [ 1]  832 	ld	a, (x)
      008484 4C               [ 1]  833 	inc	a
      008485 26 0D            [ 1]  834 	jrne	00111$
      008487 0D 0E            [ 1]  835 	tnz	(0x0e, sp)
      008489 27 09            [ 1]  836 	jreq	00111$
                                    837 ;	src/main.c: 97: (*g) -= 1;
      00848B 7B 10            [ 1]  838 	ld	a, (0x10, sp)
      00848D 4A               [ 1]  839 	dec	a
      00848E 1E 0C            [ 2]  840 	ldw	x, (0x0c, sp)
      008490 F7               [ 1]  841 	ld	(x), a
      008491 CC 84 02         [ 2]  842 	jp	00130$
      008494                        843 00111$:
                                    844 ;	src/main.c: 98: else if (*g == 0 && *b == 255 && *r < 255)
      008494 0D 0E            [ 1]  845 	tnz	(0x0e, sp)
      008496 26 15            [ 1]  846 	jrne	00106$
      008498 1E 07            [ 2]  847 	ldw	x, (0x07, sp)
      00849A F6               [ 1]  848 	ld	a, (x)
      00849B 4C               [ 1]  849 	inc	a
      00849C 26 0F            [ 1]  850 	jrne	00106$
      00849E 7B 0B            [ 1]  851 	ld	a, (0x0b, sp)
      0084A0 A1 FF            [ 1]  852 	cp	a, #0xff
      0084A2 24 09            [ 1]  853 	jrnc	00106$
                                    854 ;	src/main.c: 99: (*r) += 1;
      0084A4 90 9F            [ 1]  855 	ld	a, yl
      0084A6 4C               [ 1]  856 	inc	a
      0084A7 1E 09            [ 2]  857 	ldw	x, (0x09, sp)
      0084A9 F7               [ 1]  858 	ld	(x), a
      0084AA CC 84 02         [ 2]  859 	jp	00130$
      0084AD                        860 00106$:
                                    861 ;	src/main.c: 100: else if (*r == 255 && *g == 0 && *b > 0)
      0084AD 0D 0F            [ 1]  862 	tnz	(0x0f, sp)
      0084AF 26 03            [ 1]  863 	jrne	00262$
      0084B1 CC 84 02         [ 2]  864 	jp	00130$
      0084B4                        865 00262$:
      0084B4 0D 0E            [ 1]  866 	tnz	(0x0e, sp)
      0084B6 27 03            [ 1]  867 	jreq	00263$
      0084B8 CC 84 02         [ 2]  868 	jp	00130$
      0084BB                        869 00263$:
      0084BB 1E 01            [ 2]  870 	ldw	x, (0x01, sp)
      0084BD F6               [ 1]  871 	ld	a, (x)
      0084BE 26 03            [ 1]  872 	jrne	00264$
      0084C0 CC 84 02         [ 2]  873 	jp	00130$
      0084C3                        874 00264$:
                                    875 ;	src/main.c: 101: (*b) -= 1;
      0084C3 4A               [ 1]  876 	dec	a
      0084C4 1E 01            [ 2]  877 	ldw	x, (0x01, sp)
      0084C6 F7               [ 1]  878 	ld	(x), a
      0084C7 CC 84 02         [ 2]  879 	jp	00130$
      0084CA                        880 00133$:
                                    881 ;	src/main.c: 103: }
      0084CA 5B 12            [ 2]  882 	addw	sp, #18
      0084CC 81               [ 4]  883 	ret
                                    884 ;	src/main.c: 105: void uart_init()
                                    885 ;	-----------------------------------------
                                    886 ;	 function uart_init
                                    887 ;	-----------------------------------------
      0084CD                        888 _uart_init:
                                    889 ;	src/main.c: 108: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0084CD 72 16 52 35      [ 1]  890 	bset	21045, #3
                                    891 ;	src/main.c: 110: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0084D1 C6 52 36         [ 1]  892 	ld	a, 0x5236
      0084D4 A4 CF            [ 1]  893 	and	a, #0xcf
      0084D6 C7 52 36         [ 1]  894 	ld	0x5236, a
                                    895 ;	src/main.c: 112: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
      0084D9 35 01 52 33      [ 1]  896 	mov	0x5233+0, #0x01
      0084DD 35 34 52 32      [ 1]  897 	mov	0x5232+0, #0x34
                                    898 ;	src/main.c: 113: }
      0084E1 81               [ 4]  899 	ret
                                    900 ;	src/main.c: 116: uint16_t uart_write(const char *str) {
                                    901 ;	-----------------------------------------
                                    902 ;	 function uart_write
                                    903 ;	-----------------------------------------
      0084E2                        904 _uart_write:
      0084E2 52 03            [ 2]  905 	sub	sp, #3
                                    906 ;	src/main.c: 118: for(i = 0; i < strlen(str); i++) {
      0084E4 0F 03            [ 1]  907 	clr	(0x03, sp)
      0084E6                        908 00106$:
      0084E6 1E 06            [ 2]  909 	ldw	x, (0x06, sp)
      0084E8 89               [ 2]  910 	pushw	x
      0084E9 CD 87 E3         [ 4]  911 	call	_strlen
      0084EC 5B 02            [ 2]  912 	addw	sp, #2
      0084EE 1F 01            [ 2]  913 	ldw	(0x01, sp), x
      0084F0 5F               [ 1]  914 	clrw	x
      0084F1 7B 03            [ 1]  915 	ld	a, (0x03, sp)
      0084F3 97               [ 1]  916 	ld	xl, a
      0084F4 13 01            [ 2]  917 	cpw	x, (0x01, sp)
      0084F6 24 14            [ 1]  918 	jrnc	00104$
                                    919 ;	src/main.c: 119: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0084F8                        920 00101$:
      0084F8 C6 52 30         [ 1]  921 	ld	a, 0x5230
      0084FB 2A FB            [ 1]  922 	jrpl	00101$
                                    923 ;	src/main.c: 120: UART1_DR = str[i];
      0084FD 5F               [ 1]  924 	clrw	x
      0084FE 7B 03            [ 1]  925 	ld	a, (0x03, sp)
      008500 97               [ 1]  926 	ld	xl, a
      008501 72 FB 06         [ 2]  927 	addw	x, (0x06, sp)
      008504 F6               [ 1]  928 	ld	a, (x)
      008505 C7 52 31         [ 1]  929 	ld	0x5231, a
                                    930 ;	src/main.c: 118: for(i = 0; i < strlen(str); i++) {
      008508 0C 03            [ 1]  931 	inc	(0x03, sp)
      00850A 20 DA            [ 2]  932 	jra	00106$
      00850C                        933 00104$:
                                    934 ;	src/main.c: 122: return(i); // Bytes sent
      00850C 7B 03            [ 1]  935 	ld	a, (0x03, sp)
      00850E 5F               [ 1]  936 	clrw	x
      00850F 97               [ 1]  937 	ld	xl, a
                                    938 ;	src/main.c: 123: }
      008510 5B 03            [ 2]  939 	addw	sp, #3
      008512 81               [ 4]  940 	ret
                                    941 ;	src/main.c: 125: void uart_write_8bits(uint8_t d)
                                    942 ;	-----------------------------------------
                                    943 ;	 function uart_write_8bits
                                    944 ;	-----------------------------------------
      008513                        945 _uart_write_8bits:
                                    946 ;	src/main.c: 127: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008513                        947 00101$:
      008513 C6 52 30         [ 1]  948 	ld	a, 0x5230
      008516 2A FB            [ 1]  949 	jrpl	00101$
                                    950 ;	src/main.c: 128: UART1_DR = d;
      008518 AE 52 31         [ 2]  951 	ldw	x, #0x5231
      00851B 7B 03            [ 1]  952 	ld	a, (0x03, sp)
      00851D F7               [ 1]  953 	ld	(x), a
                                    954 ;	src/main.c: 129: }
      00851E 81               [ 4]  955 	ret
                                    956 ;	src/main.c: 132: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
                                    957 ;	-----------------------------------------
                                    958 ;	 function int_to_hex_str
                                    959 ;	-----------------------------------------
      00851F                        960 _int_to_hex_str:
      00851F 52 03            [ 2]  961 	sub	sp, #3
                                    962 ;	src/main.c: 135: while(hex_str_len)
      008521 7B 0C            [ 1]  963 	ld	a, (0x0c, sp)
      008523 6B 03            [ 1]  964 	ld	(0x03, sp), a
      008525                        965 00101$:
      008525 0D 03            [ 1]  966 	tnz	(0x03, sp)
      008527 27 37            [ 1]  967 	jreq	00104$
                                    968 ;	src/main.c: 137: uint8_t masked_dec = (dec & mask);
      008529 7B 09            [ 1]  969 	ld	a, (0x09, sp)
      00852B A4 0F            [ 1]  970 	and	a, #0x0f
                                    971 ;	src/main.c: 138: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
      00852D 5F               [ 1]  972 	clrw	x
      00852E 41               [ 1]  973 	exg	a, xl
      00852F 7B 03            [ 1]  974 	ld	a, (0x03, sp)
      008531 41               [ 1]  975 	exg	a, xl
      008532 5A               [ 2]  976 	decw	x
      008533 72 FB 0A         [ 2]  977 	addw	x, (0x0a, sp)
      008536 1F 01            [ 2]  978 	ldw	(0x01, sp), x
      008538 97               [ 1]  979 	ld	xl, a
      008539 A1 0A            [ 1]  980 	cp	a, #0x0a
      00853B 24 05            [ 1]  981 	jrnc	00106$
      00853D 9F               [ 1]  982 	ld	a, xl
      00853E AB 30            [ 1]  983 	add	a, #0x30
      008540 20 03            [ 2]  984 	jra	00107$
      008542                        985 00106$:
      008542 9F               [ 1]  986 	ld	a, xl
      008543 AB 37            [ 1]  987 	add	a, #0x37
      008545                        988 00107$:
      008545 1E 01            [ 2]  989 	ldw	x, (0x01, sp)
      008547 F7               [ 1]  990 	ld	(x), a
                                    991 ;	src/main.c: 140: dec >>= 4;
      008548 1E 08            [ 2]  992 	ldw	x, (0x08, sp)
      00854A 16 06            [ 2]  993 	ldw	y, (0x06, sp)
      00854C 90 54            [ 2]  994 	srlw	y
      00854E 56               [ 2]  995 	rrcw	x
      00854F 90 54            [ 2]  996 	srlw	y
      008551 56               [ 2]  997 	rrcw	x
      008552 90 54            [ 2]  998 	srlw	y
      008554 56               [ 2]  999 	rrcw	x
      008555 90 54            [ 2] 1000 	srlw	y
      008557 56               [ 2] 1001 	rrcw	x
      008558 1F 08            [ 2] 1002 	ldw	(0x08, sp), x
      00855A 17 06            [ 2] 1003 	ldw	(0x06, sp), y
                                   1004 ;	src/main.c: 141: hex_str_len--;
      00855C 0A 03            [ 1] 1005 	dec	(0x03, sp)
      00855E 20 C5            [ 2] 1006 	jra	00101$
      008560                       1007 00104$:
                                   1008 ;	src/main.c: 143: }
      008560 5B 03            [ 2] 1009 	addw	sp, #3
      008562 81               [ 4] 1010 	ret
                                   1011 	.area CODE
                                   1012 	.area CONST
                                   1013 	.area INITIALIZER
                                   1014 	.area CABS (ABS)
