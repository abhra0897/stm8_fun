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
      008018 D6 81 23         [ 1]   77 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 81 24         [ 2]   91 	jp	_main
                                     92 ;	return from main will return to caller
                                     93 ;--------------------------------------------------------
                                     94 ; code
                                     95 ;--------------------------------------------------------
                                     96 	.area CODE
                                     97 ;	src/main.c: 47: void main(void)
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
      008124                        101 _main:
      008124 52 EE            [ 2]  102 	sub	sp, #238
                                    103 ;	src/main.c: 50: CLK_CKDIVR = 0;
      008126 35 00 50 C6      [ 1]  104 	mov	0x50c6+0, #0x00
                                    105 ;	src/main.c: 51: uart_init();
      00812A CD 85 8B         [ 4]  106 	call	_uart_init
                                    107 ;	src/main.c: 53: uint8_t buff[100] = {0};
      00812D 0F 03            [ 1]  108 	clr	(0x03, sp)
      00812F 96               [ 1]  109 	ldw	x, sp
      008130 6F 04            [ 1]  110 	clr	(4, x)
      008132 96               [ 1]  111 	ldw	x, sp
      008133 6F 05            [ 1]  112 	clr	(5, x)
      008135 96               [ 1]  113 	ldw	x, sp
      008136 6F 06            [ 1]  114 	clr	(6, x)
      008138 96               [ 1]  115 	ldw	x, sp
      008139 6F 07            [ 1]  116 	clr	(7, x)
      00813B 96               [ 1]  117 	ldw	x, sp
      00813C 6F 08            [ 1]  118 	clr	(8, x)
      00813E 96               [ 1]  119 	ldw	x, sp
      00813F 6F 09            [ 1]  120 	clr	(9, x)
      008141 96               [ 1]  121 	ldw	x, sp
      008142 6F 0A            [ 1]  122 	clr	(10, x)
      008144 96               [ 1]  123 	ldw	x, sp
      008145 6F 0B            [ 1]  124 	clr	(11, x)
      008147 96               [ 1]  125 	ldw	x, sp
      008148 6F 0C            [ 1]  126 	clr	(12, x)
      00814A 96               [ 1]  127 	ldw	x, sp
      00814B 6F 0D            [ 1]  128 	clr	(13, x)
      00814D 96               [ 1]  129 	ldw	x, sp
      00814E 6F 0E            [ 1]  130 	clr	(14, x)
      008150 96               [ 1]  131 	ldw	x, sp
      008151 6F 0F            [ 1]  132 	clr	(15, x)
      008153 96               [ 1]  133 	ldw	x, sp
      008154 6F 10            [ 1]  134 	clr	(16, x)
      008156 96               [ 1]  135 	ldw	x, sp
      008157 6F 11            [ 1]  136 	clr	(17, x)
      008159 96               [ 1]  137 	ldw	x, sp
      00815A 6F 12            [ 1]  138 	clr	(18, x)
      00815C 96               [ 1]  139 	ldw	x, sp
      00815D 6F 13            [ 1]  140 	clr	(19, x)
      00815F 96               [ 1]  141 	ldw	x, sp
      008160 6F 14            [ 1]  142 	clr	(20, x)
      008162 96               [ 1]  143 	ldw	x, sp
      008163 6F 15            [ 1]  144 	clr	(21, x)
      008165 96               [ 1]  145 	ldw	x, sp
      008166 6F 16            [ 1]  146 	clr	(22, x)
      008168 96               [ 1]  147 	ldw	x, sp
      008169 6F 17            [ 1]  148 	clr	(23, x)
      00816B 96               [ 1]  149 	ldw	x, sp
      00816C 6F 18            [ 1]  150 	clr	(24, x)
      00816E 96               [ 1]  151 	ldw	x, sp
      00816F 6F 19            [ 1]  152 	clr	(25, x)
      008171 96               [ 1]  153 	ldw	x, sp
      008172 6F 1A            [ 1]  154 	clr	(26, x)
      008174 96               [ 1]  155 	ldw	x, sp
      008175 6F 1B            [ 1]  156 	clr	(27, x)
      008177 96               [ 1]  157 	ldw	x, sp
      008178 6F 1C            [ 1]  158 	clr	(28, x)
      00817A 96               [ 1]  159 	ldw	x, sp
      00817B 6F 1D            [ 1]  160 	clr	(29, x)
      00817D 96               [ 1]  161 	ldw	x, sp
      00817E 6F 1E            [ 1]  162 	clr	(30, x)
      008180 96               [ 1]  163 	ldw	x, sp
      008181 6F 1F            [ 1]  164 	clr	(31, x)
      008183 96               [ 1]  165 	ldw	x, sp
      008184 6F 20            [ 1]  166 	clr	(32, x)
      008186 96               [ 1]  167 	ldw	x, sp
      008187 6F 21            [ 1]  168 	clr	(33, x)
      008189 96               [ 1]  169 	ldw	x, sp
      00818A 6F 22            [ 1]  170 	clr	(34, x)
      00818C 96               [ 1]  171 	ldw	x, sp
      00818D 6F 23            [ 1]  172 	clr	(35, x)
      00818F 96               [ 1]  173 	ldw	x, sp
      008190 6F 24            [ 1]  174 	clr	(36, x)
      008192 96               [ 1]  175 	ldw	x, sp
      008193 6F 25            [ 1]  176 	clr	(37, x)
      008195 96               [ 1]  177 	ldw	x, sp
      008196 6F 26            [ 1]  178 	clr	(38, x)
      008198 96               [ 1]  179 	ldw	x, sp
      008199 6F 27            [ 1]  180 	clr	(39, x)
      00819B 96               [ 1]  181 	ldw	x, sp
      00819C 6F 28            [ 1]  182 	clr	(40, x)
      00819E 96               [ 1]  183 	ldw	x, sp
      00819F 6F 29            [ 1]  184 	clr	(41, x)
      0081A1 96               [ 1]  185 	ldw	x, sp
      0081A2 6F 2A            [ 1]  186 	clr	(42, x)
      0081A4 96               [ 1]  187 	ldw	x, sp
      0081A5 6F 2B            [ 1]  188 	clr	(43, x)
      0081A7 96               [ 1]  189 	ldw	x, sp
      0081A8 6F 2C            [ 1]  190 	clr	(44, x)
      0081AA 96               [ 1]  191 	ldw	x, sp
      0081AB 6F 2D            [ 1]  192 	clr	(45, x)
      0081AD 96               [ 1]  193 	ldw	x, sp
      0081AE 6F 2E            [ 1]  194 	clr	(46, x)
      0081B0 96               [ 1]  195 	ldw	x, sp
      0081B1 6F 2F            [ 1]  196 	clr	(47, x)
      0081B3 96               [ 1]  197 	ldw	x, sp
      0081B4 6F 30            [ 1]  198 	clr	(48, x)
      0081B6 96               [ 1]  199 	ldw	x, sp
      0081B7 6F 31            [ 1]  200 	clr	(49, x)
      0081B9 96               [ 1]  201 	ldw	x, sp
      0081BA 6F 32            [ 1]  202 	clr	(50, x)
      0081BC 96               [ 1]  203 	ldw	x, sp
      0081BD 6F 33            [ 1]  204 	clr	(51, x)
      0081BF 96               [ 1]  205 	ldw	x, sp
      0081C0 6F 34            [ 1]  206 	clr	(52, x)
      0081C2 96               [ 1]  207 	ldw	x, sp
      0081C3 6F 35            [ 1]  208 	clr	(53, x)
      0081C5 96               [ 1]  209 	ldw	x, sp
      0081C6 6F 36            [ 1]  210 	clr	(54, x)
      0081C8 96               [ 1]  211 	ldw	x, sp
      0081C9 6F 37            [ 1]  212 	clr	(55, x)
      0081CB 96               [ 1]  213 	ldw	x, sp
      0081CC 6F 38            [ 1]  214 	clr	(56, x)
      0081CE 96               [ 1]  215 	ldw	x, sp
      0081CF 6F 39            [ 1]  216 	clr	(57, x)
      0081D1 96               [ 1]  217 	ldw	x, sp
      0081D2 6F 3A            [ 1]  218 	clr	(58, x)
      0081D4 96               [ 1]  219 	ldw	x, sp
      0081D5 6F 3B            [ 1]  220 	clr	(59, x)
      0081D7 96               [ 1]  221 	ldw	x, sp
      0081D8 6F 3C            [ 1]  222 	clr	(60, x)
      0081DA 96               [ 1]  223 	ldw	x, sp
      0081DB 6F 3D            [ 1]  224 	clr	(61, x)
      0081DD 96               [ 1]  225 	ldw	x, sp
      0081DE 6F 3E            [ 1]  226 	clr	(62, x)
      0081E0 96               [ 1]  227 	ldw	x, sp
      0081E1 6F 3F            [ 1]  228 	clr	(63, x)
      0081E3 96               [ 1]  229 	ldw	x, sp
      0081E4 6F 40            [ 1]  230 	clr	(64, x)
      0081E6 96               [ 1]  231 	ldw	x, sp
      0081E7 6F 41            [ 1]  232 	clr	(65, x)
      0081E9 96               [ 1]  233 	ldw	x, sp
      0081EA 6F 42            [ 1]  234 	clr	(66, x)
      0081EC 96               [ 1]  235 	ldw	x, sp
      0081ED 6F 43            [ 1]  236 	clr	(67, x)
      0081EF 96               [ 1]  237 	ldw	x, sp
      0081F0 6F 44            [ 1]  238 	clr	(68, x)
      0081F2 96               [ 1]  239 	ldw	x, sp
      0081F3 6F 45            [ 1]  240 	clr	(69, x)
      0081F5 96               [ 1]  241 	ldw	x, sp
      0081F6 6F 46            [ 1]  242 	clr	(70, x)
      0081F8 96               [ 1]  243 	ldw	x, sp
      0081F9 6F 47            [ 1]  244 	clr	(71, x)
      0081FB 96               [ 1]  245 	ldw	x, sp
      0081FC 6F 48            [ 1]  246 	clr	(72, x)
      0081FE 96               [ 1]  247 	ldw	x, sp
      0081FF 6F 49            [ 1]  248 	clr	(73, x)
      008201 96               [ 1]  249 	ldw	x, sp
      008202 6F 4A            [ 1]  250 	clr	(74, x)
      008204 96               [ 1]  251 	ldw	x, sp
      008205 6F 4B            [ 1]  252 	clr	(75, x)
      008207 96               [ 1]  253 	ldw	x, sp
      008208 6F 4C            [ 1]  254 	clr	(76, x)
      00820A 96               [ 1]  255 	ldw	x, sp
      00820B 6F 4D            [ 1]  256 	clr	(77, x)
      00820D 96               [ 1]  257 	ldw	x, sp
      00820E 6F 4E            [ 1]  258 	clr	(78, x)
      008210 96               [ 1]  259 	ldw	x, sp
      008211 6F 4F            [ 1]  260 	clr	(79, x)
      008213 96               [ 1]  261 	ldw	x, sp
      008214 6F 50            [ 1]  262 	clr	(80, x)
      008216 96               [ 1]  263 	ldw	x, sp
      008217 6F 51            [ 1]  264 	clr	(81, x)
      008219 96               [ 1]  265 	ldw	x, sp
      00821A 6F 52            [ 1]  266 	clr	(82, x)
      00821C 96               [ 1]  267 	ldw	x, sp
      00821D 6F 53            [ 1]  268 	clr	(83, x)
      00821F 96               [ 1]  269 	ldw	x, sp
      008220 6F 54            [ 1]  270 	clr	(84, x)
      008222 96               [ 1]  271 	ldw	x, sp
      008223 6F 55            [ 1]  272 	clr	(85, x)
      008225 96               [ 1]  273 	ldw	x, sp
      008226 6F 56            [ 1]  274 	clr	(86, x)
      008228 96               [ 1]  275 	ldw	x, sp
      008229 6F 57            [ 1]  276 	clr	(87, x)
      00822B 96               [ 1]  277 	ldw	x, sp
      00822C 6F 58            [ 1]  278 	clr	(88, x)
      00822E 96               [ 1]  279 	ldw	x, sp
      00822F 6F 59            [ 1]  280 	clr	(89, x)
      008231 96               [ 1]  281 	ldw	x, sp
      008232 6F 5A            [ 1]  282 	clr	(90, x)
      008234 96               [ 1]  283 	ldw	x, sp
      008235 6F 5B            [ 1]  284 	clr	(91, x)
      008237 96               [ 1]  285 	ldw	x, sp
      008238 6F 5C            [ 1]  286 	clr	(92, x)
      00823A 96               [ 1]  287 	ldw	x, sp
      00823B 6F 5D            [ 1]  288 	clr	(93, x)
      00823D 96               [ 1]  289 	ldw	x, sp
      00823E 6F 5E            [ 1]  290 	clr	(94, x)
      008240 96               [ 1]  291 	ldw	x, sp
      008241 6F 5F            [ 1]  292 	clr	(95, x)
      008243 96               [ 1]  293 	ldw	x, sp
      008244 6F 60            [ 1]  294 	clr	(96, x)
      008246 96               [ 1]  295 	ldw	x, sp
      008247 6F 61            [ 1]  296 	clr	(97, x)
      008249 96               [ 1]  297 	ldw	x, sp
      00824A 6F 62            [ 1]  298 	clr	(98, x)
      00824C 96               [ 1]  299 	ldw	x, sp
      00824D 6F 63            [ 1]  300 	clr	(99, x)
      00824F 96               [ 1]  301 	ldw	x, sp
      008250 6F 64            [ 1]  302 	clr	(100, x)
      008252 96               [ 1]  303 	ldw	x, sp
      008253 6F 65            [ 1]  304 	clr	(101, x)
      008255 96               [ 1]  305 	ldw	x, sp
      008256 6F 66            [ 1]  306 	clr	(102, x)
                                    307 ;	src/main.c: 54: uint8_t buff2[100] = {0};
      008258 0F 67            [ 1]  308 	clr	(0x67, sp)
      00825A 96               [ 1]  309 	ldw	x, sp
      00825B 6F 68            [ 1]  310 	clr	(104, x)
      00825D 96               [ 1]  311 	ldw	x, sp
      00825E 6F 69            [ 1]  312 	clr	(105, x)
      008260 96               [ 1]  313 	ldw	x, sp
      008261 6F 6A            [ 1]  314 	clr	(106, x)
      008263 96               [ 1]  315 	ldw	x, sp
      008264 6F 6B            [ 1]  316 	clr	(107, x)
      008266 96               [ 1]  317 	ldw	x, sp
      008267 6F 6C            [ 1]  318 	clr	(108, x)
      008269 96               [ 1]  319 	ldw	x, sp
      00826A 6F 6D            [ 1]  320 	clr	(109, x)
      00826C 96               [ 1]  321 	ldw	x, sp
      00826D 6F 6E            [ 1]  322 	clr	(110, x)
      00826F 96               [ 1]  323 	ldw	x, sp
      008270 6F 6F            [ 1]  324 	clr	(111, x)
      008272 96               [ 1]  325 	ldw	x, sp
      008273 6F 70            [ 1]  326 	clr	(112, x)
      008275 96               [ 1]  327 	ldw	x, sp
      008276 6F 71            [ 1]  328 	clr	(113, x)
      008278 96               [ 1]  329 	ldw	x, sp
      008279 6F 72            [ 1]  330 	clr	(114, x)
      00827B 96               [ 1]  331 	ldw	x, sp
      00827C 6F 73            [ 1]  332 	clr	(115, x)
      00827E 96               [ 1]  333 	ldw	x, sp
      00827F 6F 74            [ 1]  334 	clr	(116, x)
      008281 96               [ 1]  335 	ldw	x, sp
      008282 6F 75            [ 1]  336 	clr	(117, x)
      008284 96               [ 1]  337 	ldw	x, sp
      008285 6F 76            [ 1]  338 	clr	(118, x)
      008287 96               [ 1]  339 	ldw	x, sp
      008288 6F 77            [ 1]  340 	clr	(119, x)
      00828A 96               [ 1]  341 	ldw	x, sp
      00828B 6F 78            [ 1]  342 	clr	(120, x)
      00828D 96               [ 1]  343 	ldw	x, sp
      00828E 6F 79            [ 1]  344 	clr	(121, x)
      008290 96               [ 1]  345 	ldw	x, sp
      008291 6F 7A            [ 1]  346 	clr	(122, x)
      008293 96               [ 1]  347 	ldw	x, sp
      008294 6F 7B            [ 1]  348 	clr	(123, x)
      008296 96               [ 1]  349 	ldw	x, sp
      008297 6F 7C            [ 1]  350 	clr	(124, x)
      008299 96               [ 1]  351 	ldw	x, sp
      00829A 6F 7D            [ 1]  352 	clr	(125, x)
      00829C 96               [ 1]  353 	ldw	x, sp
      00829D 6F 7E            [ 1]  354 	clr	(126, x)
      00829F 96               [ 1]  355 	ldw	x, sp
      0082A0 6F 7F            [ 1]  356 	clr	(127, x)
      0082A2 96               [ 1]  357 	ldw	x, sp
      0082A3 6F 80            [ 1]  358 	clr	(128, x)
      0082A5 96               [ 1]  359 	ldw	x, sp
      0082A6 6F 81            [ 1]  360 	clr	(129, x)
      0082A8 96               [ 1]  361 	ldw	x, sp
      0082A9 6F 82            [ 1]  362 	clr	(130, x)
      0082AB 96               [ 1]  363 	ldw	x, sp
      0082AC 6F 83            [ 1]  364 	clr	(131, x)
      0082AE 96               [ 1]  365 	ldw	x, sp
      0082AF 6F 84            [ 1]  366 	clr	(132, x)
      0082B1 96               [ 1]  367 	ldw	x, sp
      0082B2 6F 85            [ 1]  368 	clr	(133, x)
      0082B4 96               [ 1]  369 	ldw	x, sp
      0082B5 6F 86            [ 1]  370 	clr	(134, x)
      0082B7 96               [ 1]  371 	ldw	x, sp
      0082B8 6F 87            [ 1]  372 	clr	(135, x)
      0082BA 96               [ 1]  373 	ldw	x, sp
      0082BB 6F 88            [ 1]  374 	clr	(136, x)
      0082BD 96               [ 1]  375 	ldw	x, sp
      0082BE 6F 89            [ 1]  376 	clr	(137, x)
      0082C0 96               [ 1]  377 	ldw	x, sp
      0082C1 6F 8A            [ 1]  378 	clr	(138, x)
      0082C3 96               [ 1]  379 	ldw	x, sp
      0082C4 6F 8B            [ 1]  380 	clr	(139, x)
      0082C6 96               [ 1]  381 	ldw	x, sp
      0082C7 6F 8C            [ 1]  382 	clr	(140, x)
      0082C9 96               [ 1]  383 	ldw	x, sp
      0082CA 6F 8D            [ 1]  384 	clr	(141, x)
      0082CC 96               [ 1]  385 	ldw	x, sp
      0082CD 6F 8E            [ 1]  386 	clr	(142, x)
      0082CF 96               [ 1]  387 	ldw	x, sp
      0082D0 6F 8F            [ 1]  388 	clr	(143, x)
      0082D2 96               [ 1]  389 	ldw	x, sp
      0082D3 6F 90            [ 1]  390 	clr	(144, x)
      0082D5 96               [ 1]  391 	ldw	x, sp
      0082D6 6F 91            [ 1]  392 	clr	(145, x)
      0082D8 96               [ 1]  393 	ldw	x, sp
      0082D9 6F 92            [ 1]  394 	clr	(146, x)
      0082DB 96               [ 1]  395 	ldw	x, sp
      0082DC 6F 93            [ 1]  396 	clr	(147, x)
      0082DE 96               [ 1]  397 	ldw	x, sp
      0082DF 6F 94            [ 1]  398 	clr	(148, x)
      0082E1 96               [ 1]  399 	ldw	x, sp
      0082E2 6F 95            [ 1]  400 	clr	(149, x)
      0082E4 96               [ 1]  401 	ldw	x, sp
      0082E5 6F 96            [ 1]  402 	clr	(150, x)
      0082E7 96               [ 1]  403 	ldw	x, sp
      0082E8 6F 97            [ 1]  404 	clr	(151, x)
      0082EA 96               [ 1]  405 	ldw	x, sp
      0082EB 6F 98            [ 1]  406 	clr	(152, x)
      0082ED 96               [ 1]  407 	ldw	x, sp
      0082EE 6F 99            [ 1]  408 	clr	(153, x)
      0082F0 96               [ 1]  409 	ldw	x, sp
      0082F1 6F 9A            [ 1]  410 	clr	(154, x)
      0082F3 96               [ 1]  411 	ldw	x, sp
      0082F4 6F 9B            [ 1]  412 	clr	(155, x)
      0082F6 96               [ 1]  413 	ldw	x, sp
      0082F7 6F 9C            [ 1]  414 	clr	(156, x)
      0082F9 96               [ 1]  415 	ldw	x, sp
      0082FA 6F 9D            [ 1]  416 	clr	(157, x)
      0082FC 96               [ 1]  417 	ldw	x, sp
      0082FD 6F 9E            [ 1]  418 	clr	(158, x)
      0082FF 96               [ 1]  419 	ldw	x, sp
      008300 6F 9F            [ 1]  420 	clr	(159, x)
      008302 96               [ 1]  421 	ldw	x, sp
      008303 6F A0            [ 1]  422 	clr	(160, x)
      008305 96               [ 1]  423 	ldw	x, sp
      008306 6F A1            [ 1]  424 	clr	(161, x)
      008308 96               [ 1]  425 	ldw	x, sp
      008309 6F A2            [ 1]  426 	clr	(162, x)
      00830B 96               [ 1]  427 	ldw	x, sp
      00830C 6F A3            [ 1]  428 	clr	(163, x)
      00830E 96               [ 1]  429 	ldw	x, sp
      00830F 6F A4            [ 1]  430 	clr	(164, x)
      008311 96               [ 1]  431 	ldw	x, sp
      008312 6F A5            [ 1]  432 	clr	(165, x)
      008314 96               [ 1]  433 	ldw	x, sp
      008315 6F A6            [ 1]  434 	clr	(166, x)
      008317 96               [ 1]  435 	ldw	x, sp
      008318 6F A7            [ 1]  436 	clr	(167, x)
      00831A 96               [ 1]  437 	ldw	x, sp
      00831B 6F A8            [ 1]  438 	clr	(168, x)
      00831D 96               [ 1]  439 	ldw	x, sp
      00831E 6F A9            [ 1]  440 	clr	(169, x)
      008320 96               [ 1]  441 	ldw	x, sp
      008321 6F AA            [ 1]  442 	clr	(170, x)
      008323 96               [ 1]  443 	ldw	x, sp
      008324 6F AB            [ 1]  444 	clr	(171, x)
      008326 96               [ 1]  445 	ldw	x, sp
      008327 6F AC            [ 1]  446 	clr	(172, x)
      008329 96               [ 1]  447 	ldw	x, sp
      00832A 6F AD            [ 1]  448 	clr	(173, x)
      00832C 96               [ 1]  449 	ldw	x, sp
      00832D 6F AE            [ 1]  450 	clr	(174, x)
      00832F 96               [ 1]  451 	ldw	x, sp
      008330 6F AF            [ 1]  452 	clr	(175, x)
      008332 96               [ 1]  453 	ldw	x, sp
      008333 6F B0            [ 1]  454 	clr	(176, x)
      008335 96               [ 1]  455 	ldw	x, sp
      008336 6F B1            [ 1]  456 	clr	(177, x)
      008338 96               [ 1]  457 	ldw	x, sp
      008339 6F B2            [ 1]  458 	clr	(178, x)
      00833B 96               [ 1]  459 	ldw	x, sp
      00833C 6F B3            [ 1]  460 	clr	(179, x)
      00833E 96               [ 1]  461 	ldw	x, sp
      00833F 6F B4            [ 1]  462 	clr	(180, x)
      008341 96               [ 1]  463 	ldw	x, sp
      008342 6F B5            [ 1]  464 	clr	(181, x)
      008344 96               [ 1]  465 	ldw	x, sp
      008345 6F B6            [ 1]  466 	clr	(182, x)
      008347 96               [ 1]  467 	ldw	x, sp
      008348 6F B7            [ 1]  468 	clr	(183, x)
      00834A 96               [ 1]  469 	ldw	x, sp
      00834B 6F B8            [ 1]  470 	clr	(184, x)
      00834D 96               [ 1]  471 	ldw	x, sp
      00834E 6F B9            [ 1]  472 	clr	(185, x)
      008350 96               [ 1]  473 	ldw	x, sp
      008351 6F BA            [ 1]  474 	clr	(186, x)
      008353 96               [ 1]  475 	ldw	x, sp
      008354 6F BB            [ 1]  476 	clr	(187, x)
      008356 96               [ 1]  477 	ldw	x, sp
      008357 6F BC            [ 1]  478 	clr	(188, x)
      008359 96               [ 1]  479 	ldw	x, sp
      00835A 6F BD            [ 1]  480 	clr	(189, x)
      00835C 96               [ 1]  481 	ldw	x, sp
      00835D 6F BE            [ 1]  482 	clr	(190, x)
      00835F 96               [ 1]  483 	ldw	x, sp
      008360 6F BF            [ 1]  484 	clr	(191, x)
      008362 96               [ 1]  485 	ldw	x, sp
      008363 6F C0            [ 1]  486 	clr	(192, x)
      008365 96               [ 1]  487 	ldw	x, sp
      008366 6F C1            [ 1]  488 	clr	(193, x)
      008368 96               [ 1]  489 	ldw	x, sp
      008369 6F C2            [ 1]  490 	clr	(194, x)
      00836B 96               [ 1]  491 	ldw	x, sp
      00836C 6F C3            [ 1]  492 	clr	(195, x)
      00836E 96               [ 1]  493 	ldw	x, sp
      00836F 6F C4            [ 1]  494 	clr	(196, x)
      008371 96               [ 1]  495 	ldw	x, sp
      008372 6F C5            [ 1]  496 	clr	(197, x)
      008374 96               [ 1]  497 	ldw	x, sp
      008375 6F C6            [ 1]  498 	clr	(198, x)
      008377 96               [ 1]  499 	ldw	x, sp
      008378 6F C7            [ 1]  500 	clr	(199, x)
      00837A 96               [ 1]  501 	ldw	x, sp
      00837B 6F C8            [ 1]  502 	clr	(200, x)
      00837D 96               [ 1]  503 	ldw	x, sp
      00837E 6F C9            [ 1]  504 	clr	(201, x)
      008380 96               [ 1]  505 	ldw	x, sp
      008381 6F CA            [ 1]  506 	clr	(202, x)
                                    507 ;	src/main.c: 55: for (uint8_t i = 0; i < 100; i++)
      008383 4F               [ 1]  508 	clr	a
      008384                        509 00112$:
      008384 A1 64            [ 1]  510 	cp	a, #0x64
      008386 24 10            [ 1]  511 	jrnc	00101$
                                    512 ;	src/main.c: 57: buff[i] = i/* +7+'0' */;
      008388 96               [ 1]  513 	ldw	x, sp
      008389 1C 00 03         [ 2]  514 	addw	x, #3
      00838C 89               [ 2]  515 	pushw	x
      00838D 5F               [ 1]  516 	clrw	x
      00838E 97               [ 1]  517 	ld	xl, a
      00838F 72 FB 01         [ 2]  518 	addw	x, (1, sp)
      008392 5B 02            [ 2]  519 	addw	sp, #2
      008394 F7               [ 1]  520 	ld	(x), a
                                    521 ;	src/main.c: 55: for (uint8_t i = 0; i < 100; i++)
      008395 4C               [ 1]  522 	inc	a
      008396 20 EC            [ 2]  523 	jra	00112$
      008398                        524 00101$:
                                    525 ;	src/main.c: 60: ws2812_gpio_config();
      008398 CD 88 32         [ 4]  526 	call	_ws2812_gpio_config
                                    527 ;	src/main.c: 61: spi_config();
      00839B CD 87 6B         [ 4]  528 	call	_spi_config
                                    529 ;	src/main.c: 72: uart_write_8bits(0x99); //indicates start
      00839E 4B 99            [ 1]  530 	push	#0x99
      0083A0 CD 85 D1         [ 4]  531 	call	_uart_write_8bits
      0083A3 84               [ 1]  532 	pop	a
                                    533 ;	src/main.c: 74: flash_read_from_addr(0x012345, buff2, 100);
      0083A4 4B 64            [ 1]  534 	push	#0x64
      0083A6 4B 00            [ 1]  535 	push	#0x00
      0083A8 96               [ 1]  536 	ldw	x, sp
      0083A9 1C 00 69         [ 2]  537 	addw	x, #105
      0083AC 89               [ 2]  538 	pushw	x
      0083AD 4B 45            [ 1]  539 	push	#0x45
      0083AF 4B 23            [ 1]  540 	push	#0x23
      0083B1 4B 01            [ 1]  541 	push	#0x01
      0083B3 4B 00            [ 1]  542 	push	#0x00
      0083B5 CD 86 42         [ 4]  543 	call	_flash_read_from_addr
      0083B8 5B 08            [ 2]  544 	addw	sp, #8
                                    545 ;	src/main.c: 77: char hex_string[2] = {0};
      0083BA 0F CB            [ 1]  546 	clr	(0xcb, sp)
      0083BC 96               [ 1]  547 	ldw	x, sp
      0083BD 1C 00 CC         [ 2]  548 	addw	x, #204
      0083C0 7F               [ 1]  549 	clr	(x)
                                    550 ;	src/main.c: 80: uint8_t red = 255, green = 0, blue = 0;
      0083C1 A6 FF            [ 1]  551 	ld	a, #0xff
      0083C3 6B CD            [ 1]  552 	ld	(0xcd, sp), a
      0083C5 0F CE            [ 1]  553 	clr	(0xce, sp)
      0083C7 0F CF            [ 1]  554 	clr	(0xcf, sp)
                                    555 ;	src/main.c: 81: uint8_t r_temp = red, g_temp = green, b_temp = blue;
      0083C9 A6 FF            [ 1]  556 	ld	a, #0xff
      0083CB 6B D0            [ 1]  557 	ld	(0xd0, sp), a
      0083CD 0F D1            [ 1]  558 	clr	(0xd1, sp)
      0083CF 0F D2            [ 1]  559 	clr	(0xd2, sp)
                                    560 ;	src/main.c: 89: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
      0083D1                        561 00128$:
      0083D1 0F EE            [ 1]  562 	clr	(0xee, sp)
      0083D3                        563 00115$:
      0083D3 7B EE            [ 1]  564 	ld	a, (0xee, sp)
      0083D5 A1 08            [ 1]  565 	cp	a, #0x08
      0083D7 24 5B            [ 1]  566 	jrnc	00102$
                                    567 ;	src/main.c: 91: get_next_color(&r_temp, &g_temp, &b_temp, 100);
      0083D9 4B 64            [ 1]  568 	push	#0x64
      0083DB 96               [ 1]  569 	ldw	x, sp
      0083DC 1C 00 D3         [ 2]  570 	addw	x, #211
      0083DF 89               [ 2]  571 	pushw	x
      0083E0 96               [ 1]  572 	ldw	x, sp
      0083E1 1C 00 D4         [ 2]  573 	addw	x, #212
      0083E4 89               [ 2]  574 	pushw	x
      0083E5 96               [ 1]  575 	ldw	x, sp
      0083E6 1C 00 D5         [ 2]  576 	addw	x, #213
      0083E9 89               [ 2]  577 	pushw	x
      0083EA CD 84 AC         [ 4]  578 	call	_get_next_color
      0083ED 5B 07            [ 2]  579 	addw	sp, #7
                                    580 ;	src/main.c: 92: color_buff[led_cnt][0] = CIE_CORRECTION[r_temp];
      0083EF 7B EE            [ 1]  581 	ld	a, (0xee, sp)
      0083F1 97               [ 1]  582 	ld	xl, a
      0083F2 A6 03            [ 1]  583 	ld	a, #0x03
      0083F4 42               [ 4]  584 	mul	x, a
      0083F5 1F EC            [ 2]  585 	ldw	(0xec, sp), x
      0083F7 90 96            [ 1]  586 	ldw	y, sp
      0083F9 72 A9 00 D3      [ 2]  587 	addw	y, #211
      0083FD 72 F9 EC         [ 2]  588 	addw	y, (0xec, sp)
      008400 5F               [ 1]  589 	clrw	x
      008401 7B D0            [ 1]  590 	ld	a, (0xd0, sp)
      008403 97               [ 1]  591 	ld	xl, a
      008404 1C 80 24         [ 2]  592 	addw	x, #(_CIE_CORRECTION + 0)
      008407 F6               [ 1]  593 	ld	a, (x)
      008408 90 F7            [ 1]  594 	ld	(y), a
                                    595 ;	src/main.c: 93: color_buff[led_cnt][1] = CIE_CORRECTION[g_temp];
      00840A 90 96            [ 1]  596 	ldw	y, sp
      00840C 72 A9 00 D3      [ 2]  597 	addw	y, #211
      008410 72 F9 EC         [ 2]  598 	addw	y, (0xec, sp)
      008413 93               [ 1]  599 	ldw	x, y
      008414 5C               [ 1]  600 	incw	x
      008415 1F EC            [ 2]  601 	ldw	(0xec, sp), x
      008417 5F               [ 1]  602 	clrw	x
      008418 7B D1            [ 1]  603 	ld	a, (0xd1, sp)
      00841A 97               [ 1]  604 	ld	xl, a
      00841B 1C 80 24         [ 2]  605 	addw	x, #(_CIE_CORRECTION + 0)
      00841E F6               [ 1]  606 	ld	a, (x)
      00841F 1E EC            [ 2]  607 	ldw	x, (0xec, sp)
      008421 F7               [ 1]  608 	ld	(x), a
                                    609 ;	src/main.c: 94: color_buff[led_cnt][2] = CIE_CORRECTION[b_temp];
      008422 72 A9 00 02      [ 2]  610 	addw	y, #0x0002
      008426 5F               [ 1]  611 	clrw	x
      008427 7B D2            [ 1]  612 	ld	a, (0xd2, sp)
      008429 97               [ 1]  613 	ld	xl, a
      00842A 1C 80 24         [ 2]  614 	addw	x, #(_CIE_CORRECTION + 0)
      00842D F6               [ 1]  615 	ld	a, (x)
      00842E 90 F7            [ 1]  616 	ld	(y), a
                                    617 ;	src/main.c: 89: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
      008430 0C EE            [ 1]  618 	inc	(0xee, sp)
      008432 20 9F            [ 2]  619 	jra	00115$
      008434                        620 00102$:
                                    621 ;	src/main.c: 101: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
      008434 0F EE            [ 1]  622 	clr	(0xee, sp)
      008436                        623 00118$:
      008436 7B EE            [ 1]  624 	ld	a, (0xee, sp)
      008438 A1 08            [ 1]  625 	cp	a, #0x08
      00843A 24 2F            [ 1]  626 	jrnc	00103$
                                    627 ;	src/main.c: 104: ws2812_send_pixel_24bits(color_buff[led_cnt][0], color_buff[led_cnt][1], color_buff[led_cnt][2]);
      00843C 7B EE            [ 1]  628 	ld	a, (0xee, sp)
      00843E 97               [ 1]  629 	ld	xl, a
      00843F A6 03            [ 1]  630 	ld	a, #0x03
      008441 42               [ 4]  631 	mul	x, a
      008442 1F 01            [ 2]  632 	ldw	(0x01, sp), x
      008444 96               [ 1]  633 	ldw	x, sp
      008445 1C 00 D3         [ 2]  634 	addw	x, #211
      008448 72 FB 01         [ 2]  635 	addw	x, (0x01, sp)
      00844B 1F EB            [ 2]  636 	ldw	(0xeb, sp), x
      00844D E6 02            [ 1]  637 	ld	a, (0x2, x)
      00844F 6B ED            [ 1]  638 	ld	(0xed, sp), a
      008451 1E EB            [ 2]  639 	ldw	x, (0xeb, sp)
      008453 E6 01            [ 1]  640 	ld	a, (0x1, x)
      008455 97               [ 1]  641 	ld	xl, a
      008456 16 EB            [ 2]  642 	ldw	y, (0xeb, sp)
      008458 90 F6            [ 1]  643 	ld	a, (y)
      00845A 95               [ 1]  644 	ld	xh, a
      00845B 7B ED            [ 1]  645 	ld	a, (0xed, sp)
      00845D 88               [ 1]  646 	push	a
      00845E 9F               [ 1]  647 	ld	a, xl
      00845F 88               [ 1]  648 	push	a
      008460 9E               [ 1]  649 	ld	a, xh
      008461 88               [ 1]  650 	push	a
      008462 CD 88 79         [ 4]  651 	call	_ws2812_send_pixel_24bits
      008465 5B 03            [ 2]  652 	addw	sp, #3
                                    653 ;	src/main.c: 101: for (uint8_t led_cnt = 0; led_cnt < LED_COUNT; led_cnt++)
      008467 0C EE            [ 1]  654 	inc	(0xee, sp)
      008469 20 CB            [ 2]  655 	jra	00118$
      00846B                        656 00103$:
                                    657 ;	src/main.c: 108: ws2812_send_latch();
      00846B CD 88 8F         [ 4]  658 	call	_ws2812_send_latch
                                    659 ;	src/main.c: 109: get_next_color(&red, &green, &blue, 10);
      00846E 4B 0A            [ 1]  660 	push	#0x0a
      008470 96               [ 1]  661 	ldw	x, sp
      008471 1C 00 D0         [ 2]  662 	addw	x, #208
      008474 89               [ 2]  663 	pushw	x
      008475 96               [ 1]  664 	ldw	x, sp
      008476 1C 00 D1         [ 2]  665 	addw	x, #209
      008479 89               [ 2]  666 	pushw	x
      00847A 96               [ 1]  667 	ldw	x, sp
      00847B 1C 00 D2         [ 2]  668 	addw	x, #210
      00847E 89               [ 2]  669 	pushw	x
      00847F CD 84 AC         [ 4]  670 	call	_get_next_color
      008482 5B 07            [ 2]  671 	addw	sp, #7
                                    672 ;	src/main.c: 110: r_temp = red, g_temp = green, b_temp = blue;
      008484 7B CD            [ 1]  673 	ld	a, (0xcd, sp)
      008486 6B D0            [ 1]  674 	ld	(0xd0, sp), a
      008488 7B CE            [ 1]  675 	ld	a, (0xce, sp)
      00848A 6B D1            [ 1]  676 	ld	(0xd1, sp), a
      00848C 7B CF            [ 1]  677 	ld	a, (0xcf, sp)
      00848E 6B D2            [ 1]  678 	ld	(0xd2, sp), a
                                    679 ;	src/main.c: 112: for (uint32_t jj = 0; jj < 10000; jj++);
      008490 90 5F            [ 1]  680 	clrw	y
      008492 5F               [ 1]  681 	clrw	x
      008493                        682 00121$:
      008493 90 A3 27 10      [ 2]  683 	cpw	y, #0x2710
      008497 9F               [ 1]  684 	ld	a, xl
      008498 A2 00            [ 1]  685 	sbc	a, #0x00
      00849A 9E               [ 1]  686 	ld	a, xh
      00849B A2 00            [ 1]  687 	sbc	a, #0x00
      00849D 25 03            [ 1]  688 	jrc	00176$
      00849F CC 83 D1         [ 2]  689 	jp	00128$
      0084A2                        690 00176$:
      0084A2 90 5C            [ 1]  691 	incw	y
      0084A4 26 ED            [ 1]  692 	jrne	00121$
      0084A6 5C               [ 1]  693 	incw	x
      0084A7 20 EA            [ 2]  694 	jra	00121$
                                    695 ;	src/main.c: 118: while(1);
                                    696 ;	src/main.c: 119: }
      0084A9 5B EE            [ 2]  697 	addw	sp, #238
      0084AB 81               [ 4]  698 	ret
                                    699 ;	src/main.c: 121: void get_next_color(uint8_t *r, uint8_t *g, uint8_t *b, uint8_t step)
                                    700 ;	-----------------------------------------
                                    701 ;	 function get_next_color
                                    702 ;	-----------------------------------------
      0084AC                        703 _get_next_color:
      0084AC 52 12            [ 2]  704 	sub	sp, #18
                                    705 ;	src/main.c: 123: while (step--)
      0084AE 16 19            [ 2]  706 	ldw	y, (0x19, sp)
      0084B0 17 01            [ 2]  707 	ldw	(0x01, sp), y
      0084B2 17 03            [ 2]  708 	ldw	(0x03, sp), y
      0084B4 16 01            [ 2]  709 	ldw	y, (0x01, sp)
      0084B6 17 05            [ 2]  710 	ldw	(0x05, sp), y
      0084B8 16 01            [ 2]  711 	ldw	y, (0x01, sp)
      0084BA 17 07            [ 2]  712 	ldw	(0x07, sp), y
      0084BC 7B 1B            [ 1]  713 	ld	a, (0x1b, sp)
      0084BE 6B 12            [ 1]  714 	ld	(0x12, sp), a
      0084C0                        715 00130$:
      0084C0 7B 12            [ 1]  716 	ld	a, (0x12, sp)
      0084C2 0A 12            [ 1]  717 	dec	(0x12, sp)
      0084C4 4D               [ 1]  718 	tnz	a
      0084C5 26 03            [ 1]  719 	jrne	00236$
      0084C7 CC 85 88         [ 2]  720 	jp	00133$
      0084CA                        721 00236$:
                                    722 ;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
      0084CA 16 15            [ 2]  723 	ldw	y, (0x15, sp)
      0084CC 17 09            [ 2]  724 	ldw	(0x09, sp), y
      0084CE 93               [ 1]  725 	ldw	x, y
      0084CF F6               [ 1]  726 	ld	a, (x)
      0084D0 6B 0B            [ 1]  727 	ld	(0x0b, sp), a
      0084D2 16 17            [ 2]  728 	ldw	y, (0x17, sp)
                                    729 ;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
      0084D4 17 0C            [ 2]  730 	ldw	(0x0c, sp), y
      0084D6 93               [ 1]  731 	ldw	x, y
      0084D7 F6               [ 1]  732 	ld	a, (x)
      0084D8 6B 0E            [ 1]  733 	ld	(0x0e, sp), a
                                    734 ;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
      0084DA 7B 0B            [ 1]  735 	ld	a, (0x0b, sp)
      0084DC 4C               [ 1]  736 	inc	a
      0084DD 26 05            [ 1]  737 	jrne	00238$
      0084DF A6 01            [ 1]  738 	ld	a, #0x01
      0084E1 6B 0F            [ 1]  739 	ld	(0x0f, sp), a
      0084E3 C5                     740 	.byte 0xc5
      0084E4                        741 00238$:
      0084E4 0F 0F            [ 1]  742 	clr	(0x0f, sp)
      0084E6                        743 00239$:
                                    744 ;	src/main.c: 126: (*g) += 1;
      0084E6 7B 0E            [ 1]  745 	ld	a, (0x0e, sp)
      0084E8 6B 10            [ 1]  746 	ld	(0x10, sp), a
                                    747 ;	src/main.c: 125: if (*r == 255 && *b == 0 && *g < 255)
      0084EA 0D 0F            [ 1]  748 	tnz	(0x0f, sp)
      0084EC 27 13            [ 1]  749 	jreq	00126$
      0084EE 1E 01            [ 2]  750 	ldw	x, (0x01, sp)
      0084F0 F6               [ 1]  751 	ld	a, (x)
      0084F1 26 0E            [ 1]  752 	jrne	00126$
      0084F3 7B 0E            [ 1]  753 	ld	a, (0x0e, sp)
      0084F5 A1 FF            [ 1]  754 	cp	a, #0xff
      0084F7 24 08            [ 1]  755 	jrnc	00126$
                                    756 ;	src/main.c: 126: (*g) += 1;
      0084F9 7B 10            [ 1]  757 	ld	a, (0x10, sp)
      0084FB 4C               [ 1]  758 	inc	a
      0084FC 1E 0C            [ 2]  759 	ldw	x, (0x0c, sp)
      0084FE F7               [ 1]  760 	ld	(x), a
      0084FF 20 BF            [ 2]  761 	jra	00130$
      008501                        762 00126$:
                                    763 ;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
      008501 7B 0E            [ 1]  764 	ld	a, (0x0e, sp)
      008503 4C               [ 1]  765 	inc	a
      008504 26 05            [ 1]  766 	jrne	00244$
      008506 A6 01            [ 1]  767 	ld	a, #0x01
      008508 6B 11            [ 1]  768 	ld	(0x11, sp), a
      00850A C5                     769 	.byte 0xc5
      00850B                        770 00244$:
      00850B 0F 11            [ 1]  771 	clr	(0x11, sp)
      00850D                        772 00245$:
                                    773 ;	src/main.c: 128: (*r) -= 1;
      00850D 7B 0B            [ 1]  774 	ld	a, (0x0b, sp)
      00850F 90 97            [ 1]  775 	ld	yl, a
                                    776 ;	src/main.c: 127: else if ( *g == 255 && *b == 0 && *r > 0)
      008511 0D 11            [ 1]  777 	tnz	(0x11, sp)
      008513 27 11            [ 1]  778 	jreq	00121$
      008515 1E 03            [ 2]  779 	ldw	x, (0x03, sp)
      008517 F6               [ 1]  780 	ld	a, (x)
      008518 26 0C            [ 1]  781 	jrne	00121$
      00851A 0D 0B            [ 1]  782 	tnz	(0x0b, sp)
      00851C 27 08            [ 1]  783 	jreq	00121$
                                    784 ;	src/main.c: 128: (*r) -= 1;
      00851E 90 9F            [ 1]  785 	ld	a, yl
      008520 4A               [ 1]  786 	dec	a
      008521 1E 09            [ 2]  787 	ldw	x, (0x09, sp)
      008523 F7               [ 1]  788 	ld	(x), a
      008524 20 9A            [ 2]  789 	jra	00130$
      008526                        790 00121$:
                                    791 ;	src/main.c: 129: else if (*r == 0 && *g == 255 && *b < 255)
      008526 0D 0B            [ 1]  792 	tnz	(0x0b, sp)
      008528 26 11            [ 1]  793 	jrne	00116$
      00852A 0D 11            [ 1]  794 	tnz	(0x11, sp)
      00852C 27 0D            [ 1]  795 	jreq	00116$
      00852E 1E 01            [ 2]  796 	ldw	x, (0x01, sp)
      008530 F6               [ 1]  797 	ld	a, (x)
      008531 A1 FF            [ 1]  798 	cp	a, #0xff
      008533 24 06            [ 1]  799 	jrnc	00116$
                                    800 ;	src/main.c: 130: (*b) += 1;
      008535 4C               [ 1]  801 	inc	a
      008536 1E 01            [ 2]  802 	ldw	x, (0x01, sp)
      008538 F7               [ 1]  803 	ld	(x), a
      008539 20 85            [ 2]  804 	jra	00130$
      00853B                        805 00116$:
                                    806 ;	src/main.c: 131: else if (*r == 0 && *b == 255 && *g > 0)
      00853B 0D 0B            [ 1]  807 	tnz	(0x0b, sp)
      00853D 26 13            [ 1]  808 	jrne	00111$
      00853F 1E 05            [ 2]  809 	ldw	x, (0x05, sp)
      008541 F6               [ 1]  810 	ld	a, (x)
      008542 4C               [ 1]  811 	inc	a
      008543 26 0D            [ 1]  812 	jrne	00111$
      008545 0D 0E            [ 1]  813 	tnz	(0x0e, sp)
      008547 27 09            [ 1]  814 	jreq	00111$
                                    815 ;	src/main.c: 132: (*g) -= 1;
      008549 7B 10            [ 1]  816 	ld	a, (0x10, sp)
      00854B 4A               [ 1]  817 	dec	a
      00854C 1E 0C            [ 2]  818 	ldw	x, (0x0c, sp)
      00854E F7               [ 1]  819 	ld	(x), a
      00854F CC 84 C0         [ 2]  820 	jp	00130$
      008552                        821 00111$:
                                    822 ;	src/main.c: 133: else if (*g == 0 && *b == 255 && *r < 255)
      008552 0D 0E            [ 1]  823 	tnz	(0x0e, sp)
      008554 26 15            [ 1]  824 	jrne	00106$
      008556 1E 07            [ 2]  825 	ldw	x, (0x07, sp)
      008558 F6               [ 1]  826 	ld	a, (x)
      008559 4C               [ 1]  827 	inc	a
      00855A 26 0F            [ 1]  828 	jrne	00106$
      00855C 7B 0B            [ 1]  829 	ld	a, (0x0b, sp)
      00855E A1 FF            [ 1]  830 	cp	a, #0xff
      008560 24 09            [ 1]  831 	jrnc	00106$
                                    832 ;	src/main.c: 134: (*r) += 1;
      008562 90 9F            [ 1]  833 	ld	a, yl
      008564 4C               [ 1]  834 	inc	a
      008565 1E 09            [ 2]  835 	ldw	x, (0x09, sp)
      008567 F7               [ 1]  836 	ld	(x), a
      008568 CC 84 C0         [ 2]  837 	jp	00130$
      00856B                        838 00106$:
                                    839 ;	src/main.c: 135: else if (*r == 255 && *g == 0 && *b > 0)
      00856B 0D 0F            [ 1]  840 	tnz	(0x0f, sp)
      00856D 26 03            [ 1]  841 	jrne	00262$
      00856F CC 84 C0         [ 2]  842 	jp	00130$
      008572                        843 00262$:
      008572 0D 0E            [ 1]  844 	tnz	(0x0e, sp)
      008574 27 03            [ 1]  845 	jreq	00263$
      008576 CC 84 C0         [ 2]  846 	jp	00130$
      008579                        847 00263$:
      008579 1E 01            [ 2]  848 	ldw	x, (0x01, sp)
      00857B F6               [ 1]  849 	ld	a, (x)
      00857C 26 03            [ 1]  850 	jrne	00264$
      00857E CC 84 C0         [ 2]  851 	jp	00130$
      008581                        852 00264$:
                                    853 ;	src/main.c: 136: (*b) -= 1;
      008581 4A               [ 1]  854 	dec	a
      008582 1E 01            [ 2]  855 	ldw	x, (0x01, sp)
      008584 F7               [ 1]  856 	ld	(x), a
      008585 CC 84 C0         [ 2]  857 	jp	00130$
      008588                        858 00133$:
                                    859 ;	src/main.c: 138: }
      008588 5B 12            [ 2]  860 	addw	sp, #18
      00858A 81               [ 4]  861 	ret
                                    862 ;	src/main.c: 140: void uart_init()
                                    863 ;	-----------------------------------------
                                    864 ;	 function uart_init
                                    865 ;	-----------------------------------------
      00858B                        866 _uart_init:
                                    867 ;	src/main.c: 143: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00858B 72 16 52 35      [ 1]  868 	bset	21045, #3
                                    869 ;	src/main.c: 145: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      00858F C6 52 36         [ 1]  870 	ld	a, 0x5236
      008592 A4 CF            [ 1]  871 	and	a, #0xcf
      008594 C7 52 36         [ 1]  872 	ld	0x5236, a
                                    873 ;	src/main.c: 147: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
      008597 35 01 52 33      [ 1]  874 	mov	0x5233+0, #0x01
      00859B 35 34 52 32      [ 1]  875 	mov	0x5232+0, #0x34
                                    876 ;	src/main.c: 148: }
      00859F 81               [ 4]  877 	ret
                                    878 ;	src/main.c: 151: uint16_t uart_write(const char *str) {
                                    879 ;	-----------------------------------------
                                    880 ;	 function uart_write
                                    881 ;	-----------------------------------------
      0085A0                        882 _uart_write:
      0085A0 52 03            [ 2]  883 	sub	sp, #3
                                    884 ;	src/main.c: 153: for(i = 0; i < strlen(str); i++) {
      0085A2 0F 03            [ 1]  885 	clr	(0x03, sp)
      0085A4                        886 00106$:
      0085A4 1E 06            [ 2]  887 	ldw	x, (0x06, sp)
      0085A6 89               [ 2]  888 	pushw	x
      0085A7 CD 88 A1         [ 4]  889 	call	_strlen
      0085AA 5B 02            [ 2]  890 	addw	sp, #2
      0085AC 1F 01            [ 2]  891 	ldw	(0x01, sp), x
      0085AE 5F               [ 1]  892 	clrw	x
      0085AF 7B 03            [ 1]  893 	ld	a, (0x03, sp)
      0085B1 97               [ 1]  894 	ld	xl, a
      0085B2 13 01            [ 2]  895 	cpw	x, (0x01, sp)
      0085B4 24 14            [ 1]  896 	jrnc	00104$
                                    897 ;	src/main.c: 154: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0085B6                        898 00101$:
      0085B6 C6 52 30         [ 1]  899 	ld	a, 0x5230
      0085B9 2A FB            [ 1]  900 	jrpl	00101$
                                    901 ;	src/main.c: 155: UART1_DR = str[i];
      0085BB 5F               [ 1]  902 	clrw	x
      0085BC 7B 03            [ 1]  903 	ld	a, (0x03, sp)
      0085BE 97               [ 1]  904 	ld	xl, a
      0085BF 72 FB 06         [ 2]  905 	addw	x, (0x06, sp)
      0085C2 F6               [ 1]  906 	ld	a, (x)
      0085C3 C7 52 31         [ 1]  907 	ld	0x5231, a
                                    908 ;	src/main.c: 153: for(i = 0; i < strlen(str); i++) {
      0085C6 0C 03            [ 1]  909 	inc	(0x03, sp)
      0085C8 20 DA            [ 2]  910 	jra	00106$
      0085CA                        911 00104$:
                                    912 ;	src/main.c: 157: return(i); // Bytes sent
      0085CA 7B 03            [ 1]  913 	ld	a, (0x03, sp)
      0085CC 5F               [ 1]  914 	clrw	x
      0085CD 97               [ 1]  915 	ld	xl, a
                                    916 ;	src/main.c: 158: }
      0085CE 5B 03            [ 2]  917 	addw	sp, #3
      0085D0 81               [ 4]  918 	ret
                                    919 ;	src/main.c: 160: void uart_write_8bits(uint8_t d)
                                    920 ;	-----------------------------------------
                                    921 ;	 function uart_write_8bits
                                    922 ;	-----------------------------------------
      0085D1                        923 _uart_write_8bits:
                                    924 ;	src/main.c: 162: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0085D1                        925 00101$:
      0085D1 C6 52 30         [ 1]  926 	ld	a, 0x5230
      0085D4 2A FB            [ 1]  927 	jrpl	00101$
                                    928 ;	src/main.c: 163: UART1_DR = d;
      0085D6 AE 52 31         [ 2]  929 	ldw	x, #0x5231
      0085D9 7B 03            [ 1]  930 	ld	a, (0x03, sp)
      0085DB F7               [ 1]  931 	ld	(x), a
                                    932 ;	src/main.c: 164: }
      0085DC 81               [ 4]  933 	ret
                                    934 ;	src/main.c: 167: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
                                    935 ;	-----------------------------------------
                                    936 ;	 function int_to_hex_str
                                    937 ;	-----------------------------------------
      0085DD                        938 _int_to_hex_str:
      0085DD 52 03            [ 2]  939 	sub	sp, #3
                                    940 ;	src/main.c: 170: while(hex_str_len)
      0085DF 7B 0C            [ 1]  941 	ld	a, (0x0c, sp)
      0085E1 6B 03            [ 1]  942 	ld	(0x03, sp), a
      0085E3                        943 00101$:
      0085E3 0D 03            [ 1]  944 	tnz	(0x03, sp)
      0085E5 27 37            [ 1]  945 	jreq	00104$
                                    946 ;	src/main.c: 172: uint8_t masked_dec = (dec & mask);
      0085E7 7B 09            [ 1]  947 	ld	a, (0x09, sp)
      0085E9 A4 0F            [ 1]  948 	and	a, #0x0f
                                    949 ;	src/main.c: 173: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
      0085EB 5F               [ 1]  950 	clrw	x
      0085EC 41               [ 1]  951 	exg	a, xl
      0085ED 7B 03            [ 1]  952 	ld	a, (0x03, sp)
      0085EF 41               [ 1]  953 	exg	a, xl
      0085F0 5A               [ 2]  954 	decw	x
      0085F1 72 FB 0A         [ 2]  955 	addw	x, (0x0a, sp)
      0085F4 1F 01            [ 2]  956 	ldw	(0x01, sp), x
      0085F6 97               [ 1]  957 	ld	xl, a
      0085F7 A1 0A            [ 1]  958 	cp	a, #0x0a
      0085F9 24 05            [ 1]  959 	jrnc	00106$
      0085FB 9F               [ 1]  960 	ld	a, xl
      0085FC AB 30            [ 1]  961 	add	a, #0x30
      0085FE 20 03            [ 2]  962 	jra	00107$
      008600                        963 00106$:
      008600 9F               [ 1]  964 	ld	a, xl
      008601 AB 37            [ 1]  965 	add	a, #0x37
      008603                        966 00107$:
      008603 1E 01            [ 2]  967 	ldw	x, (0x01, sp)
      008605 F7               [ 1]  968 	ld	(x), a
                                    969 ;	src/main.c: 175: dec >>= 4;
      008606 1E 08            [ 2]  970 	ldw	x, (0x08, sp)
      008608 16 06            [ 2]  971 	ldw	y, (0x06, sp)
      00860A 90 54            [ 2]  972 	srlw	y
      00860C 56               [ 2]  973 	rrcw	x
      00860D 90 54            [ 2]  974 	srlw	y
      00860F 56               [ 2]  975 	rrcw	x
      008610 90 54            [ 2]  976 	srlw	y
      008612 56               [ 2]  977 	rrcw	x
      008613 90 54            [ 2]  978 	srlw	y
      008615 56               [ 2]  979 	rrcw	x
      008616 1F 08            [ 2]  980 	ldw	(0x08, sp), x
      008618 17 06            [ 2]  981 	ldw	(0x06, sp), y
                                    982 ;	src/main.c: 176: hex_str_len--;
      00861A 0A 03            [ 1]  983 	dec	(0x03, sp)
      00861C 20 C5            [ 2]  984 	jra	00101$
      00861E                        985 00104$:
                                    986 ;	src/main.c: 178: }
      00861E 5B 03            [ 2]  987 	addw	sp, #3
      008620 81               [ 4]  988 	ret
                                    989 	.area CODE
                                    990 	.area CONST
      008024                        991 _CIE_CORRECTION:
      008024 00                     992 	.db #0x00	; 0
      008025 00                     993 	.db #0x00	; 0
      008026 00                     994 	.db #0x00	; 0
      008027 00                     995 	.db #0x00	; 0
      008028 00                     996 	.db #0x00	; 0
      008029 01                     997 	.db #0x01	; 1
      00802A 01                     998 	.db #0x01	; 1
      00802B 01                     999 	.db #0x01	; 1
      00802C 01                    1000 	.db #0x01	; 1
      00802D 01                    1001 	.db #0x01	; 1
      00802E 01                    1002 	.db #0x01	; 1
      00802F 01                    1003 	.db #0x01	; 1
      008030 01                    1004 	.db #0x01	; 1
      008031 01                    1005 	.db #0x01	; 1
      008032 02                    1006 	.db #0x02	; 2
      008033 02                    1007 	.db #0x02	; 2
      008034 02                    1008 	.db #0x02	; 2
      008035 02                    1009 	.db #0x02	; 2
      008036 02                    1010 	.db #0x02	; 2
      008037 02                    1011 	.db #0x02	; 2
      008038 02                    1012 	.db #0x02	; 2
      008039 02                    1013 	.db #0x02	; 2
      00803A 02                    1014 	.db #0x02	; 2
      00803B 03                    1015 	.db #0x03	; 3
      00803C 03                    1016 	.db #0x03	; 3
      00803D 03                    1017 	.db #0x03	; 3
      00803E 03                    1018 	.db #0x03	; 3
      00803F 03                    1019 	.db #0x03	; 3
      008040 03                    1020 	.db #0x03	; 3
      008041 03                    1021 	.db #0x03	; 3
      008042 03                    1022 	.db #0x03	; 3
      008043 04                    1023 	.db #0x04	; 4
      008044 04                    1024 	.db #0x04	; 4
      008045 04                    1025 	.db #0x04	; 4
      008046 04                    1026 	.db #0x04	; 4
      008047 04                    1027 	.db #0x04	; 4
      008048 04                    1028 	.db #0x04	; 4
      008049 05                    1029 	.db #0x05	; 5
      00804A 05                    1030 	.db #0x05	; 5
      00804B 05                    1031 	.db #0x05	; 5
      00804C 05                    1032 	.db #0x05	; 5
      00804D 05                    1033 	.db #0x05	; 5
      00804E 06                    1034 	.db #0x06	; 6
      00804F 06                    1035 	.db #0x06	; 6
      008050 06                    1036 	.db #0x06	; 6
      008051 06                    1037 	.db #0x06	; 6
      008052 06                    1038 	.db #0x06	; 6
      008053 07                    1039 	.db #0x07	; 7
      008054 07                    1040 	.db #0x07	; 7
      008055 07                    1041 	.db #0x07	; 7
      008056 07                    1042 	.db #0x07	; 7
      008057 08                    1043 	.db #0x08	; 8
      008058 08                    1044 	.db #0x08	; 8
      008059 08                    1045 	.db #0x08	; 8
      00805A 08                    1046 	.db #0x08	; 8
      00805B 09                    1047 	.db #0x09	; 9
      00805C 09                    1048 	.db #0x09	; 9
      00805D 09                    1049 	.db #0x09	; 9
      00805E 0A                    1050 	.db #0x0a	; 10
      00805F 0A                    1051 	.db #0x0a	; 10
      008060 0A                    1052 	.db #0x0a	; 10
      008061 0A                    1053 	.db #0x0a	; 10
      008062 0B                    1054 	.db #0x0b	; 11
      008063 0B                    1055 	.db #0x0b	; 11
      008064 0B                    1056 	.db #0x0b	; 11
      008065 0C                    1057 	.db #0x0c	; 12
      008066 0C                    1058 	.db #0x0c	; 12
      008067 0C                    1059 	.db #0x0c	; 12
      008068 0D                    1060 	.db #0x0d	; 13
      008069 0D                    1061 	.db #0x0d	; 13
      00806A 0D                    1062 	.db #0x0d	; 13
      00806B 0E                    1063 	.db #0x0e	; 14
      00806C 0E                    1064 	.db #0x0e	; 14
      00806D 0F                    1065 	.db #0x0f	; 15
      00806E 0F                    1066 	.db #0x0f	; 15
      00806F 0F                    1067 	.db #0x0f	; 15
      008070 10                    1068 	.db #0x10	; 16
      008071 10                    1069 	.db #0x10	; 16
      008072 11                    1070 	.db #0x11	; 17
      008073 11                    1071 	.db #0x11	; 17
      008074 11                    1072 	.db #0x11	; 17
      008075 12                    1073 	.db #0x12	; 18
      008076 12                    1074 	.db #0x12	; 18
      008077 13                    1075 	.db #0x13	; 19
      008078 13                    1076 	.db #0x13	; 19
      008079 14                    1077 	.db #0x14	; 20
      00807A 14                    1078 	.db #0x14	; 20
      00807B 15                    1079 	.db #0x15	; 21
      00807C 15                    1080 	.db #0x15	; 21
      00807D 16                    1081 	.db #0x16	; 22
      00807E 16                    1082 	.db #0x16	; 22
      00807F 17                    1083 	.db #0x17	; 23
      008080 17                    1084 	.db #0x17	; 23
      008081 18                    1085 	.db #0x18	; 24
      008082 18                    1086 	.db #0x18	; 24
      008083 19                    1087 	.db #0x19	; 25
      008084 19                    1088 	.db #0x19	; 25
      008085 1A                    1089 	.db #0x1a	; 26
      008086 1A                    1090 	.db #0x1a	; 26
      008087 1B                    1091 	.db #0x1b	; 27
      008088 1C                    1092 	.db #0x1c	; 28
      008089 1C                    1093 	.db #0x1c	; 28
      00808A 1D                    1094 	.db #0x1d	; 29
      00808B 1D                    1095 	.db #0x1d	; 29
      00808C 1E                    1096 	.db #0x1e	; 30
      00808D 1F                    1097 	.db #0x1f	; 31
      00808E 1F                    1098 	.db #0x1f	; 31
      00808F 20                    1099 	.db #0x20	; 32
      008090 20                    1100 	.db #0x20	; 32
      008091 21                    1101 	.db #0x21	; 33
      008092 22                    1102 	.db #0x22	; 34
      008093 22                    1103 	.db #0x22	; 34
      008094 23                    1104 	.db #0x23	; 35
      008095 24                    1105 	.db #0x24	; 36
      008096 25                    1106 	.db #0x25	; 37
      008097 25                    1107 	.db #0x25	; 37
      008098 26                    1108 	.db #0x26	; 38
      008099 27                    1109 	.db #0x27	; 39
      00809A 27                    1110 	.db #0x27	; 39
      00809B 28                    1111 	.db #0x28	; 40
      00809C 29                    1112 	.db #0x29	; 41
      00809D 2A                    1113 	.db #0x2a	; 42
      00809E 2B                    1114 	.db #0x2b	; 43
      00809F 2B                    1115 	.db #0x2b	; 43
      0080A0 2C                    1116 	.db #0x2c	; 44
      0080A1 2D                    1117 	.db #0x2d	; 45
      0080A2 2E                    1118 	.db #0x2e	; 46
      0080A3 2F                    1119 	.db #0x2f	; 47
      0080A4 2F                    1120 	.db #0x2f	; 47
      0080A5 30                    1121 	.db #0x30	; 48	'0'
      0080A6 31                    1122 	.db #0x31	; 49	'1'
      0080A7 32                    1123 	.db #0x32	; 50	'2'
      0080A8 33                    1124 	.db #0x33	; 51	'3'
      0080A9 34                    1125 	.db #0x34	; 52	'4'
      0080AA 35                    1126 	.db #0x35	; 53	'5'
      0080AB 36                    1127 	.db #0x36	; 54	'6'
      0080AC 36                    1128 	.db #0x36	; 54	'6'
      0080AD 37                    1129 	.db #0x37	; 55	'7'
      0080AE 38                    1130 	.db #0x38	; 56	'8'
      0080AF 39                    1131 	.db #0x39	; 57	'9'
      0080B0 3A                    1132 	.db #0x3a	; 58
      0080B1 3B                    1133 	.db #0x3b	; 59
      0080B2 3C                    1134 	.db #0x3c	; 60
      0080B3 3D                    1135 	.db #0x3d	; 61
      0080B4 3E                    1136 	.db #0x3e	; 62
      0080B5 3F                    1137 	.db #0x3f	; 63
      0080B6 40                    1138 	.db #0x40	; 64
      0080B7 41                    1139 	.db #0x41	; 65	'A'
      0080B8 42                    1140 	.db #0x42	; 66	'B'
      0080B9 43                    1141 	.db #0x43	; 67	'C'
      0080BA 44                    1142 	.db #0x44	; 68	'D'
      0080BB 46                    1143 	.db #0x46	; 70	'F'
      0080BC 47                    1144 	.db #0x47	; 71	'G'
      0080BD 48                    1145 	.db #0x48	; 72	'H'
      0080BE 49                    1146 	.db #0x49	; 73	'I'
      0080BF 4A                    1147 	.db #0x4a	; 74	'J'
      0080C0 4B                    1148 	.db #0x4b	; 75	'K'
      0080C1 4C                    1149 	.db #0x4c	; 76	'L'
      0080C2 4D                    1150 	.db #0x4d	; 77	'M'
      0080C3 4F                    1151 	.db #0x4f	; 79	'O'
      0080C4 50                    1152 	.db #0x50	; 80	'P'
      0080C5 51                    1153 	.db #0x51	; 81	'Q'
      0080C6 52                    1154 	.db #0x52	; 82	'R'
      0080C7 53                    1155 	.db #0x53	; 83	'S'
      0080C8 55                    1156 	.db #0x55	; 85	'U'
      0080C9 56                    1157 	.db #0x56	; 86	'V'
      0080CA 57                    1158 	.db #0x57	; 87	'W'
      0080CB 58                    1159 	.db #0x58	; 88	'X'
      0080CC 5A                    1160 	.db #0x5a	; 90	'Z'
      0080CD 5B                    1161 	.db #0x5b	; 91
      0080CE 5C                    1162 	.db #0x5c	; 92
      0080CF 5E                    1163 	.db #0x5e	; 94
      0080D0 5F                    1164 	.db #0x5f	; 95
      0080D1 60                    1165 	.db #0x60	; 96
      0080D2 62                    1166 	.db #0x62	; 98	'b'
      0080D3 63                    1167 	.db #0x63	; 99	'c'
      0080D4 64                    1168 	.db #0x64	; 100	'd'
      0080D5 66                    1169 	.db #0x66	; 102	'f'
      0080D6 67                    1170 	.db #0x67	; 103	'g'
      0080D7 69                    1171 	.db #0x69	; 105	'i'
      0080D8 6A                    1172 	.db #0x6a	; 106	'j'
      0080D9 6C                    1173 	.db #0x6c	; 108	'l'
      0080DA 6D                    1174 	.db #0x6d	; 109	'm'
      0080DB 6E                    1175 	.db #0x6e	; 110	'n'
      0080DC 70                    1176 	.db #0x70	; 112	'p'
      0080DD 71                    1177 	.db #0x71	; 113	'q'
      0080DE 73                    1178 	.db #0x73	; 115	's'
      0080DF 74                    1179 	.db #0x74	; 116	't'
      0080E0 76                    1180 	.db #0x76	; 118	'v'
      0080E1 78                    1181 	.db #0x78	; 120	'x'
      0080E2 79                    1182 	.db #0x79	; 121	'y'
      0080E3 7B                    1183 	.db #0x7b	; 123
      0080E4 7C                    1184 	.db #0x7c	; 124
      0080E5 7E                    1185 	.db #0x7e	; 126
      0080E6 80                    1186 	.db #0x80	; 128
      0080E7 81                    1187 	.db #0x81	; 129
      0080E8 83                    1188 	.db #0x83	; 131
      0080E9 84                    1189 	.db #0x84	; 132
      0080EA 86                    1190 	.db #0x86	; 134
      0080EB 88                    1191 	.db #0x88	; 136
      0080EC 8A                    1192 	.db #0x8a	; 138
      0080ED 8B                    1193 	.db #0x8b	; 139
      0080EE 8D                    1194 	.db #0x8d	; 141
      0080EF 8F                    1195 	.db #0x8f	; 143
      0080F0 91                    1196 	.db #0x91	; 145
      0080F1 92                    1197 	.db #0x92	; 146
      0080F2 94                    1198 	.db #0x94	; 148
      0080F3 96                    1199 	.db #0x96	; 150
      0080F4 98                    1200 	.db #0x98	; 152
      0080F5 9A                    1201 	.db #0x9a	; 154
      0080F6 9B                    1202 	.db #0x9b	; 155
      0080F7 9D                    1203 	.db #0x9d	; 157
      0080F8 9F                    1204 	.db #0x9f	; 159
      0080F9 A1                    1205 	.db #0xa1	; 161
      0080FA A3                    1206 	.db #0xa3	; 163
      0080FB A5                    1207 	.db #0xa5	; 165
      0080FC A7                    1208 	.db #0xa7	; 167
      0080FD A9                    1209 	.db #0xa9	; 169
      0080FE AB                    1210 	.db #0xab	; 171
      0080FF AD                    1211 	.db #0xad	; 173
      008100 AF                    1212 	.db #0xaf	; 175
      008101 B1                    1213 	.db #0xb1	; 177
      008102 B3                    1214 	.db #0xb3	; 179
      008103 B5                    1215 	.db #0xb5	; 181
      008104 B7                    1216 	.db #0xb7	; 183
      008105 B9                    1217 	.db #0xb9	; 185
      008106 BB                    1218 	.db #0xbb	; 187
      008107 BD                    1219 	.db #0xbd	; 189
      008108 BF                    1220 	.db #0xbf	; 191
      008109 C1                    1221 	.db #0xc1	; 193
      00810A C4                    1222 	.db #0xc4	; 196
      00810B C6                    1223 	.db #0xc6	; 198
      00810C C8                    1224 	.db #0xc8	; 200
      00810D CA                    1225 	.db #0xca	; 202
      00810E CC                    1226 	.db #0xcc	; 204
      00810F CF                    1227 	.db #0xcf	; 207
      008110 D1                    1228 	.db #0xd1	; 209
      008111 D3                    1229 	.db #0xd3	; 211
      008112 D6                    1230 	.db #0xd6	; 214
      008113 D8                    1231 	.db #0xd8	; 216
      008114 DA                    1232 	.db #0xda	; 218
      008115 DC                    1233 	.db #0xdc	; 220
      008116 DF                    1234 	.db #0xdf	; 223
      008117 E1                    1235 	.db #0xe1	; 225
      008118 E4                    1236 	.db #0xe4	; 228
      008119 E6                    1237 	.db #0xe6	; 230
      00811A E8                    1238 	.db #0xe8	; 232
      00811B EB                    1239 	.db #0xeb	; 235
      00811C ED                    1240 	.db #0xed	; 237
      00811D F0                    1241 	.db #0xf0	; 240
      00811E F2                    1242 	.db #0xf2	; 242
      00811F F5                    1243 	.db #0xf5	; 245
      008120 F7                    1244 	.db #0xf7	; 247
      008121 FA                    1245 	.db #0xfa	; 250
      008122 FC                    1246 	.db #0xfc	; 252
      008123 FF                    1247 	.db #0xff	; 255
                                   1248 	.area INITIALIZER
                                   1249 	.area CABS (ABS)
