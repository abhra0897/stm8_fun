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
                                     12 	.globl _flash_write_enable
                                     13 	.globl _flash_erase_block
                                     14 	.globl _flash_busy_wait
                                     15 	.globl _flash_read_from_addr
                                     16 	.globl _flash_write_to_addr
                                     17 	.globl _spi_config
                                     18 	.globl _strlen
                                     19 	.globl _uart_init
                                     20 	.globl _gpio_init
                                     21 	.globl _uart_write
                                     22 	.globl _uart_write_8bits
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
      008018 D6 80 A5         [ 1]   77 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 A6         [ 2]   91 	jp	_main
                                     92 ;	return from main will return to caller
                                     93 ;--------------------------------------------------------
                                     94 ; code
                                     95 ;--------------------------------------------------------
                                     96 	.area CODE
                                     97 ;	src/main.c: 15: void main(void)
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
      0080A6                        101 _main:
      0080A6 52 C9            [ 2]  102 	sub	sp, #201
                                    103 ;	src/main.c: 18: CLK_CKDIVR = 0;
      0080A8 35 00 50 C6      [ 1]  104 	mov	0x50c6+0, #0x00
                                    105 ;	src/main.c: 19: uart_init();
      0080AC CD 83 BF         [ 4]  106 	call	_uart_init
                                    107 ;	src/main.c: 21: uint8_t buff[100] = {0};
      0080AF 0F 01            [ 1]  108 	clr	(0x01, sp)
      0080B1 96               [ 1]  109 	ldw	x, sp
      0080B2 6F 02            [ 1]  110 	clr	(2, x)
      0080B4 96               [ 1]  111 	ldw	x, sp
      0080B5 6F 03            [ 1]  112 	clr	(3, x)
      0080B7 96               [ 1]  113 	ldw	x, sp
      0080B8 6F 04            [ 1]  114 	clr	(4, x)
      0080BA 96               [ 1]  115 	ldw	x, sp
      0080BB 6F 05            [ 1]  116 	clr	(5, x)
      0080BD 96               [ 1]  117 	ldw	x, sp
      0080BE 6F 06            [ 1]  118 	clr	(6, x)
      0080C0 96               [ 1]  119 	ldw	x, sp
      0080C1 6F 07            [ 1]  120 	clr	(7, x)
      0080C3 96               [ 1]  121 	ldw	x, sp
      0080C4 6F 08            [ 1]  122 	clr	(8, x)
      0080C6 96               [ 1]  123 	ldw	x, sp
      0080C7 6F 09            [ 1]  124 	clr	(9, x)
      0080C9 96               [ 1]  125 	ldw	x, sp
      0080CA 6F 0A            [ 1]  126 	clr	(10, x)
      0080CC 96               [ 1]  127 	ldw	x, sp
      0080CD 6F 0B            [ 1]  128 	clr	(11, x)
      0080CF 96               [ 1]  129 	ldw	x, sp
      0080D0 6F 0C            [ 1]  130 	clr	(12, x)
      0080D2 96               [ 1]  131 	ldw	x, sp
      0080D3 6F 0D            [ 1]  132 	clr	(13, x)
      0080D5 96               [ 1]  133 	ldw	x, sp
      0080D6 6F 0E            [ 1]  134 	clr	(14, x)
      0080D8 96               [ 1]  135 	ldw	x, sp
      0080D9 6F 0F            [ 1]  136 	clr	(15, x)
      0080DB 96               [ 1]  137 	ldw	x, sp
      0080DC 6F 10            [ 1]  138 	clr	(16, x)
      0080DE 96               [ 1]  139 	ldw	x, sp
      0080DF 6F 11            [ 1]  140 	clr	(17, x)
      0080E1 96               [ 1]  141 	ldw	x, sp
      0080E2 6F 12            [ 1]  142 	clr	(18, x)
      0080E4 96               [ 1]  143 	ldw	x, sp
      0080E5 6F 13            [ 1]  144 	clr	(19, x)
      0080E7 96               [ 1]  145 	ldw	x, sp
      0080E8 6F 14            [ 1]  146 	clr	(20, x)
      0080EA 96               [ 1]  147 	ldw	x, sp
      0080EB 6F 15            [ 1]  148 	clr	(21, x)
      0080ED 96               [ 1]  149 	ldw	x, sp
      0080EE 6F 16            [ 1]  150 	clr	(22, x)
      0080F0 96               [ 1]  151 	ldw	x, sp
      0080F1 6F 17            [ 1]  152 	clr	(23, x)
      0080F3 96               [ 1]  153 	ldw	x, sp
      0080F4 6F 18            [ 1]  154 	clr	(24, x)
      0080F6 96               [ 1]  155 	ldw	x, sp
      0080F7 6F 19            [ 1]  156 	clr	(25, x)
      0080F9 96               [ 1]  157 	ldw	x, sp
      0080FA 6F 1A            [ 1]  158 	clr	(26, x)
      0080FC 96               [ 1]  159 	ldw	x, sp
      0080FD 6F 1B            [ 1]  160 	clr	(27, x)
      0080FF 96               [ 1]  161 	ldw	x, sp
      008100 6F 1C            [ 1]  162 	clr	(28, x)
      008102 96               [ 1]  163 	ldw	x, sp
      008103 6F 1D            [ 1]  164 	clr	(29, x)
      008105 96               [ 1]  165 	ldw	x, sp
      008106 6F 1E            [ 1]  166 	clr	(30, x)
      008108 96               [ 1]  167 	ldw	x, sp
      008109 6F 1F            [ 1]  168 	clr	(31, x)
      00810B 96               [ 1]  169 	ldw	x, sp
      00810C 6F 20            [ 1]  170 	clr	(32, x)
      00810E 96               [ 1]  171 	ldw	x, sp
      00810F 6F 21            [ 1]  172 	clr	(33, x)
      008111 96               [ 1]  173 	ldw	x, sp
      008112 6F 22            [ 1]  174 	clr	(34, x)
      008114 96               [ 1]  175 	ldw	x, sp
      008115 6F 23            [ 1]  176 	clr	(35, x)
      008117 96               [ 1]  177 	ldw	x, sp
      008118 6F 24            [ 1]  178 	clr	(36, x)
      00811A 96               [ 1]  179 	ldw	x, sp
      00811B 6F 25            [ 1]  180 	clr	(37, x)
      00811D 96               [ 1]  181 	ldw	x, sp
      00811E 6F 26            [ 1]  182 	clr	(38, x)
      008120 96               [ 1]  183 	ldw	x, sp
      008121 6F 27            [ 1]  184 	clr	(39, x)
      008123 96               [ 1]  185 	ldw	x, sp
      008124 6F 28            [ 1]  186 	clr	(40, x)
      008126 96               [ 1]  187 	ldw	x, sp
      008127 6F 29            [ 1]  188 	clr	(41, x)
      008129 96               [ 1]  189 	ldw	x, sp
      00812A 6F 2A            [ 1]  190 	clr	(42, x)
      00812C 96               [ 1]  191 	ldw	x, sp
      00812D 6F 2B            [ 1]  192 	clr	(43, x)
      00812F 96               [ 1]  193 	ldw	x, sp
      008130 6F 2C            [ 1]  194 	clr	(44, x)
      008132 96               [ 1]  195 	ldw	x, sp
      008133 6F 2D            [ 1]  196 	clr	(45, x)
      008135 96               [ 1]  197 	ldw	x, sp
      008136 6F 2E            [ 1]  198 	clr	(46, x)
      008138 96               [ 1]  199 	ldw	x, sp
      008139 6F 2F            [ 1]  200 	clr	(47, x)
      00813B 96               [ 1]  201 	ldw	x, sp
      00813C 6F 30            [ 1]  202 	clr	(48, x)
      00813E 96               [ 1]  203 	ldw	x, sp
      00813F 6F 31            [ 1]  204 	clr	(49, x)
      008141 96               [ 1]  205 	ldw	x, sp
      008142 6F 32            [ 1]  206 	clr	(50, x)
      008144 96               [ 1]  207 	ldw	x, sp
      008145 6F 33            [ 1]  208 	clr	(51, x)
      008147 96               [ 1]  209 	ldw	x, sp
      008148 6F 34            [ 1]  210 	clr	(52, x)
      00814A 96               [ 1]  211 	ldw	x, sp
      00814B 6F 35            [ 1]  212 	clr	(53, x)
      00814D 96               [ 1]  213 	ldw	x, sp
      00814E 6F 36            [ 1]  214 	clr	(54, x)
      008150 96               [ 1]  215 	ldw	x, sp
      008151 6F 37            [ 1]  216 	clr	(55, x)
      008153 96               [ 1]  217 	ldw	x, sp
      008154 6F 38            [ 1]  218 	clr	(56, x)
      008156 96               [ 1]  219 	ldw	x, sp
      008157 6F 39            [ 1]  220 	clr	(57, x)
      008159 96               [ 1]  221 	ldw	x, sp
      00815A 6F 3A            [ 1]  222 	clr	(58, x)
      00815C 96               [ 1]  223 	ldw	x, sp
      00815D 6F 3B            [ 1]  224 	clr	(59, x)
      00815F 96               [ 1]  225 	ldw	x, sp
      008160 6F 3C            [ 1]  226 	clr	(60, x)
      008162 96               [ 1]  227 	ldw	x, sp
      008163 6F 3D            [ 1]  228 	clr	(61, x)
      008165 96               [ 1]  229 	ldw	x, sp
      008166 6F 3E            [ 1]  230 	clr	(62, x)
      008168 96               [ 1]  231 	ldw	x, sp
      008169 6F 3F            [ 1]  232 	clr	(63, x)
      00816B 96               [ 1]  233 	ldw	x, sp
      00816C 6F 40            [ 1]  234 	clr	(64, x)
      00816E 96               [ 1]  235 	ldw	x, sp
      00816F 6F 41            [ 1]  236 	clr	(65, x)
      008171 96               [ 1]  237 	ldw	x, sp
      008172 6F 42            [ 1]  238 	clr	(66, x)
      008174 96               [ 1]  239 	ldw	x, sp
      008175 6F 43            [ 1]  240 	clr	(67, x)
      008177 96               [ 1]  241 	ldw	x, sp
      008178 6F 44            [ 1]  242 	clr	(68, x)
      00817A 96               [ 1]  243 	ldw	x, sp
      00817B 6F 45            [ 1]  244 	clr	(69, x)
      00817D 96               [ 1]  245 	ldw	x, sp
      00817E 6F 46            [ 1]  246 	clr	(70, x)
      008180 96               [ 1]  247 	ldw	x, sp
      008181 6F 47            [ 1]  248 	clr	(71, x)
      008183 96               [ 1]  249 	ldw	x, sp
      008184 6F 48            [ 1]  250 	clr	(72, x)
      008186 96               [ 1]  251 	ldw	x, sp
      008187 6F 49            [ 1]  252 	clr	(73, x)
      008189 96               [ 1]  253 	ldw	x, sp
      00818A 6F 4A            [ 1]  254 	clr	(74, x)
      00818C 96               [ 1]  255 	ldw	x, sp
      00818D 6F 4B            [ 1]  256 	clr	(75, x)
      00818F 96               [ 1]  257 	ldw	x, sp
      008190 6F 4C            [ 1]  258 	clr	(76, x)
      008192 96               [ 1]  259 	ldw	x, sp
      008193 6F 4D            [ 1]  260 	clr	(77, x)
      008195 96               [ 1]  261 	ldw	x, sp
      008196 6F 4E            [ 1]  262 	clr	(78, x)
      008198 96               [ 1]  263 	ldw	x, sp
      008199 6F 4F            [ 1]  264 	clr	(79, x)
      00819B 96               [ 1]  265 	ldw	x, sp
      00819C 6F 50            [ 1]  266 	clr	(80, x)
      00819E 96               [ 1]  267 	ldw	x, sp
      00819F 6F 51            [ 1]  268 	clr	(81, x)
      0081A1 96               [ 1]  269 	ldw	x, sp
      0081A2 6F 52            [ 1]  270 	clr	(82, x)
      0081A4 96               [ 1]  271 	ldw	x, sp
      0081A5 6F 53            [ 1]  272 	clr	(83, x)
      0081A7 96               [ 1]  273 	ldw	x, sp
      0081A8 6F 54            [ 1]  274 	clr	(84, x)
      0081AA 96               [ 1]  275 	ldw	x, sp
      0081AB 6F 55            [ 1]  276 	clr	(85, x)
      0081AD 96               [ 1]  277 	ldw	x, sp
      0081AE 6F 56            [ 1]  278 	clr	(86, x)
      0081B0 96               [ 1]  279 	ldw	x, sp
      0081B1 6F 57            [ 1]  280 	clr	(87, x)
      0081B3 96               [ 1]  281 	ldw	x, sp
      0081B4 6F 58            [ 1]  282 	clr	(88, x)
      0081B6 96               [ 1]  283 	ldw	x, sp
      0081B7 6F 59            [ 1]  284 	clr	(89, x)
      0081B9 96               [ 1]  285 	ldw	x, sp
      0081BA 6F 5A            [ 1]  286 	clr	(90, x)
      0081BC 96               [ 1]  287 	ldw	x, sp
      0081BD 6F 5B            [ 1]  288 	clr	(91, x)
      0081BF 96               [ 1]  289 	ldw	x, sp
      0081C0 6F 5C            [ 1]  290 	clr	(92, x)
      0081C2 96               [ 1]  291 	ldw	x, sp
      0081C3 6F 5D            [ 1]  292 	clr	(93, x)
      0081C5 96               [ 1]  293 	ldw	x, sp
      0081C6 6F 5E            [ 1]  294 	clr	(94, x)
      0081C8 96               [ 1]  295 	ldw	x, sp
      0081C9 6F 5F            [ 1]  296 	clr	(95, x)
      0081CB 96               [ 1]  297 	ldw	x, sp
      0081CC 6F 60            [ 1]  298 	clr	(96, x)
      0081CE 96               [ 1]  299 	ldw	x, sp
      0081CF 6F 61            [ 1]  300 	clr	(97, x)
      0081D1 96               [ 1]  301 	ldw	x, sp
      0081D2 6F 62            [ 1]  302 	clr	(98, x)
      0081D4 96               [ 1]  303 	ldw	x, sp
      0081D5 6F 63            [ 1]  304 	clr	(99, x)
      0081D7 96               [ 1]  305 	ldw	x, sp
      0081D8 6F 64            [ 1]  306 	clr	(100, x)
                                    307 ;	src/main.c: 22: uint8_t buff2[100] = {0};
      0081DA 0F 65            [ 1]  308 	clr	(0x65, sp)
      0081DC 96               [ 1]  309 	ldw	x, sp
      0081DD 6F 66            [ 1]  310 	clr	(102, x)
      0081DF 96               [ 1]  311 	ldw	x, sp
      0081E0 6F 67            [ 1]  312 	clr	(103, x)
      0081E2 96               [ 1]  313 	ldw	x, sp
      0081E3 6F 68            [ 1]  314 	clr	(104, x)
      0081E5 96               [ 1]  315 	ldw	x, sp
      0081E6 6F 69            [ 1]  316 	clr	(105, x)
      0081E8 96               [ 1]  317 	ldw	x, sp
      0081E9 6F 6A            [ 1]  318 	clr	(106, x)
      0081EB 96               [ 1]  319 	ldw	x, sp
      0081EC 6F 6B            [ 1]  320 	clr	(107, x)
      0081EE 96               [ 1]  321 	ldw	x, sp
      0081EF 6F 6C            [ 1]  322 	clr	(108, x)
      0081F1 96               [ 1]  323 	ldw	x, sp
      0081F2 6F 6D            [ 1]  324 	clr	(109, x)
      0081F4 96               [ 1]  325 	ldw	x, sp
      0081F5 6F 6E            [ 1]  326 	clr	(110, x)
      0081F7 96               [ 1]  327 	ldw	x, sp
      0081F8 6F 6F            [ 1]  328 	clr	(111, x)
      0081FA 96               [ 1]  329 	ldw	x, sp
      0081FB 6F 70            [ 1]  330 	clr	(112, x)
      0081FD 96               [ 1]  331 	ldw	x, sp
      0081FE 6F 71            [ 1]  332 	clr	(113, x)
      008200 96               [ 1]  333 	ldw	x, sp
      008201 6F 72            [ 1]  334 	clr	(114, x)
      008203 96               [ 1]  335 	ldw	x, sp
      008204 6F 73            [ 1]  336 	clr	(115, x)
      008206 96               [ 1]  337 	ldw	x, sp
      008207 6F 74            [ 1]  338 	clr	(116, x)
      008209 96               [ 1]  339 	ldw	x, sp
      00820A 6F 75            [ 1]  340 	clr	(117, x)
      00820C 96               [ 1]  341 	ldw	x, sp
      00820D 6F 76            [ 1]  342 	clr	(118, x)
      00820F 96               [ 1]  343 	ldw	x, sp
      008210 6F 77            [ 1]  344 	clr	(119, x)
      008212 96               [ 1]  345 	ldw	x, sp
      008213 6F 78            [ 1]  346 	clr	(120, x)
      008215 96               [ 1]  347 	ldw	x, sp
      008216 6F 79            [ 1]  348 	clr	(121, x)
      008218 96               [ 1]  349 	ldw	x, sp
      008219 6F 7A            [ 1]  350 	clr	(122, x)
      00821B 96               [ 1]  351 	ldw	x, sp
      00821C 6F 7B            [ 1]  352 	clr	(123, x)
      00821E 96               [ 1]  353 	ldw	x, sp
      00821F 6F 7C            [ 1]  354 	clr	(124, x)
      008221 96               [ 1]  355 	ldw	x, sp
      008222 6F 7D            [ 1]  356 	clr	(125, x)
      008224 96               [ 1]  357 	ldw	x, sp
      008225 6F 7E            [ 1]  358 	clr	(126, x)
      008227 96               [ 1]  359 	ldw	x, sp
      008228 6F 7F            [ 1]  360 	clr	(127, x)
      00822A 96               [ 1]  361 	ldw	x, sp
      00822B 6F 80            [ 1]  362 	clr	(128, x)
      00822D 96               [ 1]  363 	ldw	x, sp
      00822E 6F 81            [ 1]  364 	clr	(129, x)
      008230 96               [ 1]  365 	ldw	x, sp
      008231 6F 82            [ 1]  366 	clr	(130, x)
      008233 96               [ 1]  367 	ldw	x, sp
      008234 6F 83            [ 1]  368 	clr	(131, x)
      008236 96               [ 1]  369 	ldw	x, sp
      008237 6F 84            [ 1]  370 	clr	(132, x)
      008239 96               [ 1]  371 	ldw	x, sp
      00823A 6F 85            [ 1]  372 	clr	(133, x)
      00823C 96               [ 1]  373 	ldw	x, sp
      00823D 6F 86            [ 1]  374 	clr	(134, x)
      00823F 96               [ 1]  375 	ldw	x, sp
      008240 6F 87            [ 1]  376 	clr	(135, x)
      008242 96               [ 1]  377 	ldw	x, sp
      008243 6F 88            [ 1]  378 	clr	(136, x)
      008245 96               [ 1]  379 	ldw	x, sp
      008246 6F 89            [ 1]  380 	clr	(137, x)
      008248 96               [ 1]  381 	ldw	x, sp
      008249 6F 8A            [ 1]  382 	clr	(138, x)
      00824B 96               [ 1]  383 	ldw	x, sp
      00824C 6F 8B            [ 1]  384 	clr	(139, x)
      00824E 96               [ 1]  385 	ldw	x, sp
      00824F 6F 8C            [ 1]  386 	clr	(140, x)
      008251 96               [ 1]  387 	ldw	x, sp
      008252 6F 8D            [ 1]  388 	clr	(141, x)
      008254 96               [ 1]  389 	ldw	x, sp
      008255 6F 8E            [ 1]  390 	clr	(142, x)
      008257 96               [ 1]  391 	ldw	x, sp
      008258 6F 8F            [ 1]  392 	clr	(143, x)
      00825A 96               [ 1]  393 	ldw	x, sp
      00825B 6F 90            [ 1]  394 	clr	(144, x)
      00825D 96               [ 1]  395 	ldw	x, sp
      00825E 6F 91            [ 1]  396 	clr	(145, x)
      008260 96               [ 1]  397 	ldw	x, sp
      008261 6F 92            [ 1]  398 	clr	(146, x)
      008263 96               [ 1]  399 	ldw	x, sp
      008264 6F 93            [ 1]  400 	clr	(147, x)
      008266 96               [ 1]  401 	ldw	x, sp
      008267 6F 94            [ 1]  402 	clr	(148, x)
      008269 96               [ 1]  403 	ldw	x, sp
      00826A 6F 95            [ 1]  404 	clr	(149, x)
      00826C 96               [ 1]  405 	ldw	x, sp
      00826D 6F 96            [ 1]  406 	clr	(150, x)
      00826F 96               [ 1]  407 	ldw	x, sp
      008270 6F 97            [ 1]  408 	clr	(151, x)
      008272 96               [ 1]  409 	ldw	x, sp
      008273 6F 98            [ 1]  410 	clr	(152, x)
      008275 96               [ 1]  411 	ldw	x, sp
      008276 6F 99            [ 1]  412 	clr	(153, x)
      008278 96               [ 1]  413 	ldw	x, sp
      008279 6F 9A            [ 1]  414 	clr	(154, x)
      00827B 96               [ 1]  415 	ldw	x, sp
      00827C 6F 9B            [ 1]  416 	clr	(155, x)
      00827E 96               [ 1]  417 	ldw	x, sp
      00827F 6F 9C            [ 1]  418 	clr	(156, x)
      008281 96               [ 1]  419 	ldw	x, sp
      008282 6F 9D            [ 1]  420 	clr	(157, x)
      008284 96               [ 1]  421 	ldw	x, sp
      008285 6F 9E            [ 1]  422 	clr	(158, x)
      008287 96               [ 1]  423 	ldw	x, sp
      008288 6F 9F            [ 1]  424 	clr	(159, x)
      00828A 96               [ 1]  425 	ldw	x, sp
      00828B 6F A0            [ 1]  426 	clr	(160, x)
      00828D 96               [ 1]  427 	ldw	x, sp
      00828E 6F A1            [ 1]  428 	clr	(161, x)
      008290 96               [ 1]  429 	ldw	x, sp
      008291 6F A2            [ 1]  430 	clr	(162, x)
      008293 96               [ 1]  431 	ldw	x, sp
      008294 6F A3            [ 1]  432 	clr	(163, x)
      008296 96               [ 1]  433 	ldw	x, sp
      008297 6F A4            [ 1]  434 	clr	(164, x)
      008299 96               [ 1]  435 	ldw	x, sp
      00829A 6F A5            [ 1]  436 	clr	(165, x)
      00829C 96               [ 1]  437 	ldw	x, sp
      00829D 6F A6            [ 1]  438 	clr	(166, x)
      00829F 96               [ 1]  439 	ldw	x, sp
      0082A0 6F A7            [ 1]  440 	clr	(167, x)
      0082A2 96               [ 1]  441 	ldw	x, sp
      0082A3 6F A8            [ 1]  442 	clr	(168, x)
      0082A5 96               [ 1]  443 	ldw	x, sp
      0082A6 6F A9            [ 1]  444 	clr	(169, x)
      0082A8 96               [ 1]  445 	ldw	x, sp
      0082A9 6F AA            [ 1]  446 	clr	(170, x)
      0082AB 96               [ 1]  447 	ldw	x, sp
      0082AC 6F AB            [ 1]  448 	clr	(171, x)
      0082AE 96               [ 1]  449 	ldw	x, sp
      0082AF 6F AC            [ 1]  450 	clr	(172, x)
      0082B1 96               [ 1]  451 	ldw	x, sp
      0082B2 6F AD            [ 1]  452 	clr	(173, x)
      0082B4 96               [ 1]  453 	ldw	x, sp
      0082B5 6F AE            [ 1]  454 	clr	(174, x)
      0082B7 96               [ 1]  455 	ldw	x, sp
      0082B8 6F AF            [ 1]  456 	clr	(175, x)
      0082BA 96               [ 1]  457 	ldw	x, sp
      0082BB 6F B0            [ 1]  458 	clr	(176, x)
      0082BD 96               [ 1]  459 	ldw	x, sp
      0082BE 6F B1            [ 1]  460 	clr	(177, x)
      0082C0 96               [ 1]  461 	ldw	x, sp
      0082C1 6F B2            [ 1]  462 	clr	(178, x)
      0082C3 96               [ 1]  463 	ldw	x, sp
      0082C4 6F B3            [ 1]  464 	clr	(179, x)
      0082C6 96               [ 1]  465 	ldw	x, sp
      0082C7 6F B4            [ 1]  466 	clr	(180, x)
      0082C9 96               [ 1]  467 	ldw	x, sp
      0082CA 6F B5            [ 1]  468 	clr	(181, x)
      0082CC 96               [ 1]  469 	ldw	x, sp
      0082CD 6F B6            [ 1]  470 	clr	(182, x)
      0082CF 96               [ 1]  471 	ldw	x, sp
      0082D0 6F B7            [ 1]  472 	clr	(183, x)
      0082D2 96               [ 1]  473 	ldw	x, sp
      0082D3 6F B8            [ 1]  474 	clr	(184, x)
      0082D5 96               [ 1]  475 	ldw	x, sp
      0082D6 6F B9            [ 1]  476 	clr	(185, x)
      0082D8 96               [ 1]  477 	ldw	x, sp
      0082D9 6F BA            [ 1]  478 	clr	(186, x)
      0082DB 96               [ 1]  479 	ldw	x, sp
      0082DC 6F BB            [ 1]  480 	clr	(187, x)
      0082DE 96               [ 1]  481 	ldw	x, sp
      0082DF 6F BC            [ 1]  482 	clr	(188, x)
      0082E1 96               [ 1]  483 	ldw	x, sp
      0082E2 6F BD            [ 1]  484 	clr	(189, x)
      0082E4 96               [ 1]  485 	ldw	x, sp
      0082E5 6F BE            [ 1]  486 	clr	(190, x)
      0082E7 96               [ 1]  487 	ldw	x, sp
      0082E8 6F BF            [ 1]  488 	clr	(191, x)
      0082EA 96               [ 1]  489 	ldw	x, sp
      0082EB 6F C0            [ 1]  490 	clr	(192, x)
      0082ED 96               [ 1]  491 	ldw	x, sp
      0082EE 6F C1            [ 1]  492 	clr	(193, x)
      0082F0 96               [ 1]  493 	ldw	x, sp
      0082F1 6F C2            [ 1]  494 	clr	(194, x)
      0082F3 96               [ 1]  495 	ldw	x, sp
      0082F4 6F C3            [ 1]  496 	clr	(195, x)
      0082F6 96               [ 1]  497 	ldw	x, sp
      0082F7 6F C4            [ 1]  498 	clr	(196, x)
      0082F9 96               [ 1]  499 	ldw	x, sp
      0082FA 6F C5            [ 1]  500 	clr	(197, x)
      0082FC 96               [ 1]  501 	ldw	x, sp
      0082FD 6F C6            [ 1]  502 	clr	(198, x)
      0082FF 96               [ 1]  503 	ldw	x, sp
      008300 6F C7            [ 1]  504 	clr	(199, x)
      008302 96               [ 1]  505 	ldw	x, sp
      008303 6F C8            [ 1]  506 	clr	(200, x)
                                    507 ;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
      008305 4F               [ 1]  508 	clr	a
      008306                        509 00104$:
      008306 A1 64            [ 1]  510 	cp	a, #0x64
      008308 24 0E            [ 1]  511 	jrnc	00101$
                                    512 ;	src/main.c: 25: buff[i] = i;
      00830A 96               [ 1]  513 	ldw	x, sp
      00830B 5C               [ 1]  514 	incw	x
      00830C 89               [ 2]  515 	pushw	x
      00830D 5F               [ 1]  516 	clrw	x
      00830E 97               [ 1]  517 	ld	xl, a
      00830F 72 FB 01         [ 2]  518 	addw	x, (1, sp)
      008312 5B 02            [ 2]  519 	addw	sp, #2
      008314 F7               [ 1]  520 	ld	(x), a
                                    521 ;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
      008315 4C               [ 1]  522 	inc	a
      008316 20 EE            [ 2]  523 	jra	00104$
      008318                        524 00101$:
                                    525 ;	src/main.c: 28: uart_write("Configuring SPI...\n");
      008318 4B 24            [ 1]  526 	push	#<(___str_0 + 0)
      00831A 4B 80            [ 1]  527 	push	#((___str_0 + 0) >> 8)
      00831C CD 83 D5         [ 4]  528 	call	_uart_write
      00831F 5B 02            [ 2]  529 	addw	sp, #2
                                    530 ;	src/main.c: 29: spi_config();
      008321 CD 85 51         [ 4]  531 	call	_spi_config
                                    532 ;	src/main.c: 31: uart_write("Prepare to write...\n");
      008324 4B 38            [ 1]  533 	push	#<(___str_1 + 0)
      008326 4B 80            [ 1]  534 	push	#((___str_1 + 0) >> 8)
      008328 CD 83 D5         [ 4]  535 	call	_uart_write
      00832B 5B 02            [ 2]  536 	addw	sp, #2
                                    537 ;	src/main.c: 32: flash_write_enable();
      00832D CD 85 39         [ 4]  538 	call	_flash_write_enable
                                    539 ;	src/main.c: 33: flash_erase_block(0, CMD_4K_BLOCK_ERASE);
      008330 4B 20            [ 1]  540 	push	#0x20
      008332 5F               [ 1]  541 	clrw	x
      008333 89               [ 2]  542 	pushw	x
      008334 5F               [ 1]  543 	clrw	x
      008335 89               [ 2]  544 	pushw	x
      008336 CD 85 21         [ 4]  545 	call	_flash_erase_block
      008339 5B 05            [ 2]  546 	addw	sp, #5
                                    547 ;	src/main.c: 34: flash_busy_wait();
      00833B CD 85 16         [ 4]  548 	call	_flash_busy_wait
                                    549 ;	src/main.c: 42: flash_write_enable();
      00833E CD 85 39         [ 4]  550 	call	_flash_write_enable
                                    551 ;	src/main.c: 43: uart_write("Writing...\n");
      008341 4B 4D            [ 1]  552 	push	#<(___str_2 + 0)
      008343 4B 80            [ 1]  553 	push	#((___str_2 + 0) >> 8)
      008345 CD 83 D5         [ 4]  554 	call	_uart_write
      008348 5B 02            [ 2]  555 	addw	sp, #2
                                    556 ;	src/main.c: 44: flash_write_to_addr(0, buff, 100);
      00834A 4B 64            [ 1]  557 	push	#0x64
      00834C 4B 00            [ 1]  558 	push	#0x00
      00834E 96               [ 1]  559 	ldw	x, sp
      00834F 1C 00 03         [ 2]  560 	addw	x, #3
      008352 89               [ 2]  561 	pushw	x
      008353 5F               [ 1]  562 	clrw	x
      008354 89               [ 2]  563 	pushw	x
      008355 5F               [ 1]  564 	clrw	x
      008356 89               [ 2]  565 	pushw	x
      008357 CD 84 12         [ 4]  566 	call	_flash_write_to_addr
      00835A 5B 08            [ 2]  567 	addw	sp, #8
                                    568 ;	src/main.c: 45: flash_busy_wait();
      00835C CD 85 16         [ 4]  569 	call	_flash_busy_wait
                                    570 ;	src/main.c: 46: uart_write("Write complete...\n");
      00835F 4B 59            [ 1]  571 	push	#<(___str_3 + 0)
      008361 4B 80            [ 1]  572 	push	#((___str_3 + 0) >> 8)
      008363 CD 83 D5         [ 4]  573 	call	_uart_write
      008366 5B 02            [ 2]  574 	addw	sp, #2
                                    575 ;	src/main.c: 48: uart_write("Reading...\n");
      008368 4B 6C            [ 1]  576 	push	#<(___str_4 + 0)
      00836A 4B 80            [ 1]  577 	push	#((___str_4 + 0) >> 8)
      00836C CD 83 D5         [ 4]  578 	call	_uart_write
      00836F 5B 02            [ 2]  579 	addw	sp, #2
                                    580 ;	src/main.c: 49: flash_read_from_addr(0, buff2, 100);
      008371 4B 64            [ 1]  581 	push	#0x64
      008373 4B 00            [ 1]  582 	push	#0x00
      008375 96               [ 1]  583 	ldw	x, sp
      008376 1C 00 67         [ 2]  584 	addw	x, #103
      008379 89               [ 2]  585 	pushw	x
      00837A 5F               [ 1]  586 	clrw	x
      00837B 89               [ 2]  587 	pushw	x
      00837C 5F               [ 1]  588 	clrw	x
      00837D 89               [ 2]  589 	pushw	x
      00837E CD 84 33         [ 4]  590 	call	_flash_read_from_addr
      008381 5B 08            [ 2]  591 	addw	sp, #8
                                    592 ;	src/main.c: 50: uart_write("Read complete...\n");
      008383 4B 78            [ 1]  593 	push	#<(___str_5 + 0)
      008385 4B 80            [ 1]  594 	push	#((___str_5 + 0) >> 8)
      008387 CD 83 D5         [ 4]  595 	call	_uart_write
      00838A 5B 02            [ 2]  596 	addw	sp, #2
                                    597 ;	src/main.c: 52: uart_write("Comparing...\n");
      00838C 4B 8A            [ 1]  598 	push	#<(___str_6 + 0)
      00838E 4B 80            [ 1]  599 	push	#((___str_6 + 0) >> 8)
      008390 CD 83 D5         [ 4]  600 	call	_uart_write
      008393 5B 02            [ 2]  601 	addw	sp, #2
                                    602 ;	src/main.c: 54: for(uint8_t ii = 0; ii < 100; ii++)
      008395 0F C9            [ 1]  603 	clr	(0xc9, sp)
      008397                        604 00107$:
      008397 7B C9            [ 1]  605 	ld	a, (0xc9, sp)
      008399 A1 64            [ 1]  606 	cp	a, #0x64
      00839B 24 18            [ 1]  607 	jrnc	00102$
                                    608 ;	src/main.c: 56: uart_write_8bits(buff2[ii]);
      00839D 5F               [ 1]  609 	clrw	x
      00839E 7B C9            [ 1]  610 	ld	a, (0xc9, sp)
      0083A0 97               [ 1]  611 	ld	xl, a
      0083A1 89               [ 2]  612 	pushw	x
      0083A2 96               [ 1]  613 	ldw	x, sp
      0083A3 1C 00 67         [ 2]  614 	addw	x, #103
      0083A6 72 FB 01         [ 2]  615 	addw	x, (1, sp)
      0083A9 5B 02            [ 2]  616 	addw	sp, #2
      0083AB F6               [ 1]  617 	ld	a, (x)
      0083AC 88               [ 1]  618 	push	a
      0083AD CD 84 06         [ 4]  619 	call	_uart_write_8bits
      0083B0 84               [ 1]  620 	pop	a
                                    621 ;	src/main.c: 54: for(uint8_t ii = 0; ii < 100; ii++)
      0083B1 0C C9            [ 1]  622 	inc	(0xc9, sp)
      0083B3 20 E2            [ 2]  623 	jra	00107$
      0083B5                        624 00102$:
                                    625 ;	src/main.c: 63: uart_write("Error count: ");
      0083B5 4B 98            [ 1]  626 	push	#<(___str_7 + 0)
      0083B7 4B 80            [ 1]  627 	push	#((___str_7 + 0) >> 8)
      0083B9 CD 83 D5         [ 4]  628 	call	_uart_write
                                    629 ;	src/main.c: 66: }
      0083BC 5B CB            [ 2]  630 	addw	sp, #203
      0083BE 81               [ 4]  631 	ret
                                    632 ;	src/main.c: 69: void uart_init()
                                    633 ;	-----------------------------------------
                                    634 ;	 function uart_init
                                    635 ;	-----------------------------------------
      0083BF                        636 _uart_init:
                                    637 ;	src/main.c: 72: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0083BF 72 16 52 35      [ 1]  638 	bset	21045, #3
                                    639 ;	src/main.c: 74: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0083C3 C6 52 36         [ 1]  640 	ld	a, 0x5236
      0083C6 A4 CF            [ 1]  641 	and	a, #0xcf
      0083C8 C7 52 36         [ 1]  642 	ld	0x5236, a
                                    643 ;	src/main.c: 76: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
      0083CB 35 01 52 33      [ 1]  644 	mov	0x5233+0, #0x01
      0083CF 35 34 52 32      [ 1]  645 	mov	0x5232+0, #0x34
                                    646 ;	src/main.c: 77: }
      0083D3 81               [ 4]  647 	ret
                                    648 ;	src/main.c: 79: void gpio_init()
                                    649 ;	-----------------------------------------
                                    650 ;	 function gpio_init
                                    651 ;	-----------------------------------------
      0083D4                        652 _gpio_init:
                                    653 ;	src/main.c: 82: }
      0083D4 81               [ 4]  654 	ret
                                    655 ;	src/main.c: 84: uint16_t uart_write(const char *str) {
                                    656 ;	-----------------------------------------
                                    657 ;	 function uart_write
                                    658 ;	-----------------------------------------
      0083D5                        659 _uart_write:
      0083D5 52 03            [ 2]  660 	sub	sp, #3
                                    661 ;	src/main.c: 86: for(i = 0; i < strlen(str); i++) {
      0083D7 0F 03            [ 1]  662 	clr	(0x03, sp)
      0083D9                        663 00106$:
      0083D9 1E 06            [ 2]  664 	ldw	x, (0x06, sp)
      0083DB 89               [ 2]  665 	pushw	x
      0083DC CD 85 FD         [ 4]  666 	call	_strlen
      0083DF 5B 02            [ 2]  667 	addw	sp, #2
      0083E1 1F 01            [ 2]  668 	ldw	(0x01, sp), x
      0083E3 5F               [ 1]  669 	clrw	x
      0083E4 7B 03            [ 1]  670 	ld	a, (0x03, sp)
      0083E6 97               [ 1]  671 	ld	xl, a
      0083E7 13 01            [ 2]  672 	cpw	x, (0x01, sp)
      0083E9 24 14            [ 1]  673 	jrnc	00104$
                                    674 ;	src/main.c: 87: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0083EB                        675 00101$:
      0083EB C6 52 30         [ 1]  676 	ld	a, 0x5230
      0083EE 2A FB            [ 1]  677 	jrpl	00101$
                                    678 ;	src/main.c: 88: UART1_DR = str[i];
      0083F0 5F               [ 1]  679 	clrw	x
      0083F1 7B 03            [ 1]  680 	ld	a, (0x03, sp)
      0083F3 97               [ 1]  681 	ld	xl, a
      0083F4 72 FB 06         [ 2]  682 	addw	x, (0x06, sp)
      0083F7 F6               [ 1]  683 	ld	a, (x)
      0083F8 C7 52 31         [ 1]  684 	ld	0x5231, a
                                    685 ;	src/main.c: 86: for(i = 0; i < strlen(str); i++) {
      0083FB 0C 03            [ 1]  686 	inc	(0x03, sp)
      0083FD 20 DA            [ 2]  687 	jra	00106$
      0083FF                        688 00104$:
                                    689 ;	src/main.c: 90: return(i); // Bytes sent
      0083FF 7B 03            [ 1]  690 	ld	a, (0x03, sp)
      008401 5F               [ 1]  691 	clrw	x
      008402 97               [ 1]  692 	ld	xl, a
                                    693 ;	src/main.c: 91: }
      008403 5B 03            [ 2]  694 	addw	sp, #3
      008405 81               [ 4]  695 	ret
                                    696 ;	src/main.c: 93: void uart_write_8bits(uint8_t d)
                                    697 ;	-----------------------------------------
                                    698 ;	 function uart_write_8bits
                                    699 ;	-----------------------------------------
      008406                        700 _uart_write_8bits:
                                    701 ;	src/main.c: 95: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008406                        702 00101$:
      008406 C6 52 30         [ 1]  703 	ld	a, 0x5230
      008409 2A FB            [ 1]  704 	jrpl	00101$
                                    705 ;	src/main.c: 96: UART1_DR = d;
      00840B AE 52 31         [ 2]  706 	ldw	x, #0x5231
      00840E 7B 03            [ 1]  707 	ld	a, (0x03, sp)
      008410 F7               [ 1]  708 	ld	(x), a
                                    709 ;	src/main.c: 97: }
      008411 81               [ 4]  710 	ret
                                    711 	.area CODE
                                    712 	.area CONST
                                    713 	.area CONST
      008024                        714 ___str_0:
      008024 43 6F 6E 66 69 67 75   715 	.ascii "Configuring SPI..."
             72 69 6E 67 20 53 50
             49 2E 2E 2E
      008036 0A                     716 	.db 0x0a
      008037 00                     717 	.db 0x00
                                    718 	.area CODE
                                    719 	.area CONST
      008038                        720 ___str_1:
      008038 50 72 65 70 61 72 65   721 	.ascii "Prepare to write..."
             20 74 6F 20 77 72 69
             74 65 2E 2E 2E
      00804B 0A                     722 	.db 0x0a
      00804C 00                     723 	.db 0x00
                                    724 	.area CODE
                                    725 	.area CONST
      00804D                        726 ___str_2:
      00804D 57 72 69 74 69 6E 67   727 	.ascii "Writing..."
             2E 2E 2E
      008057 0A                     728 	.db 0x0a
      008058 00                     729 	.db 0x00
                                    730 	.area CODE
                                    731 	.area CONST
      008059                        732 ___str_3:
      008059 57 72 69 74 65 20 63   733 	.ascii "Write complete..."
             6F 6D 70 6C 65 74 65
             2E 2E 2E
      00806A 0A                     734 	.db 0x0a
      00806B 00                     735 	.db 0x00
                                    736 	.area CODE
                                    737 	.area CONST
      00806C                        738 ___str_4:
      00806C 52 65 61 64 69 6E 67   739 	.ascii "Reading..."
             2E 2E 2E
      008076 0A                     740 	.db 0x0a
      008077 00                     741 	.db 0x00
                                    742 	.area CODE
                                    743 	.area CONST
      008078                        744 ___str_5:
      008078 52 65 61 64 20 63 6F   745 	.ascii "Read complete..."
             6D 70 6C 65 74 65 2E
             2E 2E
      008088 0A                     746 	.db 0x0a
      008089 00                     747 	.db 0x00
                                    748 	.area CODE
                                    749 	.area CONST
      00808A                        750 ___str_6:
      00808A 43 6F 6D 70 61 72 69   751 	.ascii "Comparing..."
             6E 67 2E 2E 2E
      008096 0A                     752 	.db 0x0a
      008097 00                     753 	.db 0x00
                                    754 	.area CODE
                                    755 	.area CONST
      008098                        756 ___str_7:
      008098 45 72 72 6F 72 20 63   757 	.ascii "Error count: "
             6F 75 6E 74 3A 20
      0080A5 00                     758 	.db 0x00
                                    759 	.area CODE
                                    760 	.area INITIALIZER
                                    761 	.area CABS (ABS)
