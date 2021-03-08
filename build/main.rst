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
                                     13 	.globl _flash_erase_chip
                                     14 	.globl _flash_busy_wait
                                     15 	.globl _flash_read_from_addr
                                     16 	.globl _flash_write_to_addr
                                     17 	.globl _spi_cs_idle
                                     18 	.globl _spi_cs_active
                                     19 	.globl _spi_config
                                     20 	.globl _strlen
                                     21 	.globl _uart_init
                                     22 	.globl _uart_write
                                     23 	.globl _uart_write_8bits
                                     24 	.globl _int_to_hex_str
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DATA
                                     29 ;--------------------------------------------------------
                                     30 ; ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area INITIALIZED
                                     33 ;--------------------------------------------------------
                                     34 ; Stack segment in internal ram 
                                     35 ;--------------------------------------------------------
                                     36 	.area	SSEG
      FFFFFF                         37 __start__stack:
      FFFFFF                         38 	.ds	1
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; absolute external ram data
                                     42 ;--------------------------------------------------------
                                     43 	.area DABS (ABS)
                                     44 
                                     45 ; default segment ordering for linker
                                     46 	.area HOME
                                     47 	.area GSINIT
                                     48 	.area GSFINAL
                                     49 	.area CONST
                                     50 	.area INITIALIZER
                                     51 	.area CODE
                                     52 
                                     53 ;--------------------------------------------------------
                                     54 ; interrupt vector 
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
      008000                         57 __interrupt_vect:
      008000 82 00 80 07             58 	int s_GSINIT ; reset
                                     59 ;--------------------------------------------------------
                                     60 ; global & static initialisations
                                     61 ;--------------------------------------------------------
                                     62 	.area HOME
                                     63 	.area GSINIT
                                     64 	.area GSFINAL
                                     65 	.area GSINIT
      008007                         66 __sdcc_gs_init_startup:
      008007                         67 __sdcc_init_data:
                                     68 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   69 	ldw x, #l_DATA
      00800A 27 07            [ 1]   70 	jreq	00002$
      00800C                         71 00001$:
      00800C 72 4F 00 00      [ 1]   72 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   73 	decw x
      008011 26 F9            [ 1]   74 	jrne	00001$
      008013                         75 00002$:
      008013 AE 00 00         [ 2]   76 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   77 	jreq	00004$
      008018                         78 00003$:
      008018 D6 80 25         [ 1]   79 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   80 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   81 	decw	x
      00801F 26 F7            [ 1]   82 	jrne	00003$
      008021                         83 00004$:
                                     84 ; stm8_genXINIT() end
                                     85 	.area GSFINAL
      008021 CC 80 04         [ 2]   86 	jp	__sdcc_program_startup
                                     87 ;--------------------------------------------------------
                                     88 ; Home
                                     89 ;--------------------------------------------------------
                                     90 	.area HOME
                                     91 	.area HOME
      008004                         92 __sdcc_program_startup:
      008004 CC 80 26         [ 2]   93 	jp	_main
                                     94 ;	return from main will return to caller
                                     95 ;--------------------------------------------------------
                                     96 ; code
                                     97 ;--------------------------------------------------------
                                     98 	.area CODE
                                     99 ;	src/main.c: 15: void main(void)
                                    100 ;	-----------------------------------------
                                    101 ;	 function main
                                    102 ;	-----------------------------------------
      008026                        103 _main:
      008026 52 CB            [ 2]  104 	sub	sp, #203
                                    105 ;	src/main.c: 18: CLK_CKDIVR = 0;
      008028 35 00 50 C6      [ 1]  106 	mov	0x50c6+0, #0x00
                                    107 ;	src/main.c: 19: uart_init();
      00802C CD 83 06         [ 4]  108 	call	_uart_init
                                    109 ;	src/main.c: 21: uint8_t buff[100] = {0};
      00802F 0F 01            [ 1]  110 	clr	(0x01, sp)
      008031 96               [ 1]  111 	ldw	x, sp
      008032 6F 02            [ 1]  112 	clr	(2, x)
      008034 96               [ 1]  113 	ldw	x, sp
      008035 6F 03            [ 1]  114 	clr	(3, x)
      008037 96               [ 1]  115 	ldw	x, sp
      008038 6F 04            [ 1]  116 	clr	(4, x)
      00803A 96               [ 1]  117 	ldw	x, sp
      00803B 6F 05            [ 1]  118 	clr	(5, x)
      00803D 96               [ 1]  119 	ldw	x, sp
      00803E 6F 06            [ 1]  120 	clr	(6, x)
      008040 96               [ 1]  121 	ldw	x, sp
      008041 6F 07            [ 1]  122 	clr	(7, x)
      008043 96               [ 1]  123 	ldw	x, sp
      008044 6F 08            [ 1]  124 	clr	(8, x)
      008046 96               [ 1]  125 	ldw	x, sp
      008047 6F 09            [ 1]  126 	clr	(9, x)
      008049 96               [ 1]  127 	ldw	x, sp
      00804A 6F 0A            [ 1]  128 	clr	(10, x)
      00804C 96               [ 1]  129 	ldw	x, sp
      00804D 6F 0B            [ 1]  130 	clr	(11, x)
      00804F 96               [ 1]  131 	ldw	x, sp
      008050 6F 0C            [ 1]  132 	clr	(12, x)
      008052 96               [ 1]  133 	ldw	x, sp
      008053 6F 0D            [ 1]  134 	clr	(13, x)
      008055 96               [ 1]  135 	ldw	x, sp
      008056 6F 0E            [ 1]  136 	clr	(14, x)
      008058 96               [ 1]  137 	ldw	x, sp
      008059 6F 0F            [ 1]  138 	clr	(15, x)
      00805B 96               [ 1]  139 	ldw	x, sp
      00805C 6F 10            [ 1]  140 	clr	(16, x)
      00805E 96               [ 1]  141 	ldw	x, sp
      00805F 6F 11            [ 1]  142 	clr	(17, x)
      008061 96               [ 1]  143 	ldw	x, sp
      008062 6F 12            [ 1]  144 	clr	(18, x)
      008064 96               [ 1]  145 	ldw	x, sp
      008065 6F 13            [ 1]  146 	clr	(19, x)
      008067 96               [ 1]  147 	ldw	x, sp
      008068 6F 14            [ 1]  148 	clr	(20, x)
      00806A 96               [ 1]  149 	ldw	x, sp
      00806B 6F 15            [ 1]  150 	clr	(21, x)
      00806D 96               [ 1]  151 	ldw	x, sp
      00806E 6F 16            [ 1]  152 	clr	(22, x)
      008070 96               [ 1]  153 	ldw	x, sp
      008071 6F 17            [ 1]  154 	clr	(23, x)
      008073 96               [ 1]  155 	ldw	x, sp
      008074 6F 18            [ 1]  156 	clr	(24, x)
      008076 96               [ 1]  157 	ldw	x, sp
      008077 6F 19            [ 1]  158 	clr	(25, x)
      008079 96               [ 1]  159 	ldw	x, sp
      00807A 6F 1A            [ 1]  160 	clr	(26, x)
      00807C 96               [ 1]  161 	ldw	x, sp
      00807D 6F 1B            [ 1]  162 	clr	(27, x)
      00807F 96               [ 1]  163 	ldw	x, sp
      008080 6F 1C            [ 1]  164 	clr	(28, x)
      008082 96               [ 1]  165 	ldw	x, sp
      008083 6F 1D            [ 1]  166 	clr	(29, x)
      008085 96               [ 1]  167 	ldw	x, sp
      008086 6F 1E            [ 1]  168 	clr	(30, x)
      008088 96               [ 1]  169 	ldw	x, sp
      008089 6F 1F            [ 1]  170 	clr	(31, x)
      00808B 96               [ 1]  171 	ldw	x, sp
      00808C 6F 20            [ 1]  172 	clr	(32, x)
      00808E 96               [ 1]  173 	ldw	x, sp
      00808F 6F 21            [ 1]  174 	clr	(33, x)
      008091 96               [ 1]  175 	ldw	x, sp
      008092 6F 22            [ 1]  176 	clr	(34, x)
      008094 96               [ 1]  177 	ldw	x, sp
      008095 6F 23            [ 1]  178 	clr	(35, x)
      008097 96               [ 1]  179 	ldw	x, sp
      008098 6F 24            [ 1]  180 	clr	(36, x)
      00809A 96               [ 1]  181 	ldw	x, sp
      00809B 6F 25            [ 1]  182 	clr	(37, x)
      00809D 96               [ 1]  183 	ldw	x, sp
      00809E 6F 26            [ 1]  184 	clr	(38, x)
      0080A0 96               [ 1]  185 	ldw	x, sp
      0080A1 6F 27            [ 1]  186 	clr	(39, x)
      0080A3 96               [ 1]  187 	ldw	x, sp
      0080A4 6F 28            [ 1]  188 	clr	(40, x)
      0080A6 96               [ 1]  189 	ldw	x, sp
      0080A7 6F 29            [ 1]  190 	clr	(41, x)
      0080A9 96               [ 1]  191 	ldw	x, sp
      0080AA 6F 2A            [ 1]  192 	clr	(42, x)
      0080AC 96               [ 1]  193 	ldw	x, sp
      0080AD 6F 2B            [ 1]  194 	clr	(43, x)
      0080AF 96               [ 1]  195 	ldw	x, sp
      0080B0 6F 2C            [ 1]  196 	clr	(44, x)
      0080B2 96               [ 1]  197 	ldw	x, sp
      0080B3 6F 2D            [ 1]  198 	clr	(45, x)
      0080B5 96               [ 1]  199 	ldw	x, sp
      0080B6 6F 2E            [ 1]  200 	clr	(46, x)
      0080B8 96               [ 1]  201 	ldw	x, sp
      0080B9 6F 2F            [ 1]  202 	clr	(47, x)
      0080BB 96               [ 1]  203 	ldw	x, sp
      0080BC 6F 30            [ 1]  204 	clr	(48, x)
      0080BE 96               [ 1]  205 	ldw	x, sp
      0080BF 6F 31            [ 1]  206 	clr	(49, x)
      0080C1 96               [ 1]  207 	ldw	x, sp
      0080C2 6F 32            [ 1]  208 	clr	(50, x)
      0080C4 96               [ 1]  209 	ldw	x, sp
      0080C5 6F 33            [ 1]  210 	clr	(51, x)
      0080C7 96               [ 1]  211 	ldw	x, sp
      0080C8 6F 34            [ 1]  212 	clr	(52, x)
      0080CA 96               [ 1]  213 	ldw	x, sp
      0080CB 6F 35            [ 1]  214 	clr	(53, x)
      0080CD 96               [ 1]  215 	ldw	x, sp
      0080CE 6F 36            [ 1]  216 	clr	(54, x)
      0080D0 96               [ 1]  217 	ldw	x, sp
      0080D1 6F 37            [ 1]  218 	clr	(55, x)
      0080D3 96               [ 1]  219 	ldw	x, sp
      0080D4 6F 38            [ 1]  220 	clr	(56, x)
      0080D6 96               [ 1]  221 	ldw	x, sp
      0080D7 6F 39            [ 1]  222 	clr	(57, x)
      0080D9 96               [ 1]  223 	ldw	x, sp
      0080DA 6F 3A            [ 1]  224 	clr	(58, x)
      0080DC 96               [ 1]  225 	ldw	x, sp
      0080DD 6F 3B            [ 1]  226 	clr	(59, x)
      0080DF 96               [ 1]  227 	ldw	x, sp
      0080E0 6F 3C            [ 1]  228 	clr	(60, x)
      0080E2 96               [ 1]  229 	ldw	x, sp
      0080E3 6F 3D            [ 1]  230 	clr	(61, x)
      0080E5 96               [ 1]  231 	ldw	x, sp
      0080E6 6F 3E            [ 1]  232 	clr	(62, x)
      0080E8 96               [ 1]  233 	ldw	x, sp
      0080E9 6F 3F            [ 1]  234 	clr	(63, x)
      0080EB 96               [ 1]  235 	ldw	x, sp
      0080EC 6F 40            [ 1]  236 	clr	(64, x)
      0080EE 96               [ 1]  237 	ldw	x, sp
      0080EF 6F 41            [ 1]  238 	clr	(65, x)
      0080F1 96               [ 1]  239 	ldw	x, sp
      0080F2 6F 42            [ 1]  240 	clr	(66, x)
      0080F4 96               [ 1]  241 	ldw	x, sp
      0080F5 6F 43            [ 1]  242 	clr	(67, x)
      0080F7 96               [ 1]  243 	ldw	x, sp
      0080F8 6F 44            [ 1]  244 	clr	(68, x)
      0080FA 96               [ 1]  245 	ldw	x, sp
      0080FB 6F 45            [ 1]  246 	clr	(69, x)
      0080FD 96               [ 1]  247 	ldw	x, sp
      0080FE 6F 46            [ 1]  248 	clr	(70, x)
      008100 96               [ 1]  249 	ldw	x, sp
      008101 6F 47            [ 1]  250 	clr	(71, x)
      008103 96               [ 1]  251 	ldw	x, sp
      008104 6F 48            [ 1]  252 	clr	(72, x)
      008106 96               [ 1]  253 	ldw	x, sp
      008107 6F 49            [ 1]  254 	clr	(73, x)
      008109 96               [ 1]  255 	ldw	x, sp
      00810A 6F 4A            [ 1]  256 	clr	(74, x)
      00810C 96               [ 1]  257 	ldw	x, sp
      00810D 6F 4B            [ 1]  258 	clr	(75, x)
      00810F 96               [ 1]  259 	ldw	x, sp
      008110 6F 4C            [ 1]  260 	clr	(76, x)
      008112 96               [ 1]  261 	ldw	x, sp
      008113 6F 4D            [ 1]  262 	clr	(77, x)
      008115 96               [ 1]  263 	ldw	x, sp
      008116 6F 4E            [ 1]  264 	clr	(78, x)
      008118 96               [ 1]  265 	ldw	x, sp
      008119 6F 4F            [ 1]  266 	clr	(79, x)
      00811B 96               [ 1]  267 	ldw	x, sp
      00811C 6F 50            [ 1]  268 	clr	(80, x)
      00811E 96               [ 1]  269 	ldw	x, sp
      00811F 6F 51            [ 1]  270 	clr	(81, x)
      008121 96               [ 1]  271 	ldw	x, sp
      008122 6F 52            [ 1]  272 	clr	(82, x)
      008124 96               [ 1]  273 	ldw	x, sp
      008125 6F 53            [ 1]  274 	clr	(83, x)
      008127 96               [ 1]  275 	ldw	x, sp
      008128 6F 54            [ 1]  276 	clr	(84, x)
      00812A 96               [ 1]  277 	ldw	x, sp
      00812B 6F 55            [ 1]  278 	clr	(85, x)
      00812D 96               [ 1]  279 	ldw	x, sp
      00812E 6F 56            [ 1]  280 	clr	(86, x)
      008130 96               [ 1]  281 	ldw	x, sp
      008131 6F 57            [ 1]  282 	clr	(87, x)
      008133 96               [ 1]  283 	ldw	x, sp
      008134 6F 58            [ 1]  284 	clr	(88, x)
      008136 96               [ 1]  285 	ldw	x, sp
      008137 6F 59            [ 1]  286 	clr	(89, x)
      008139 96               [ 1]  287 	ldw	x, sp
      00813A 6F 5A            [ 1]  288 	clr	(90, x)
      00813C 96               [ 1]  289 	ldw	x, sp
      00813D 6F 5B            [ 1]  290 	clr	(91, x)
      00813F 96               [ 1]  291 	ldw	x, sp
      008140 6F 5C            [ 1]  292 	clr	(92, x)
      008142 96               [ 1]  293 	ldw	x, sp
      008143 6F 5D            [ 1]  294 	clr	(93, x)
      008145 96               [ 1]  295 	ldw	x, sp
      008146 6F 5E            [ 1]  296 	clr	(94, x)
      008148 96               [ 1]  297 	ldw	x, sp
      008149 6F 5F            [ 1]  298 	clr	(95, x)
      00814B 96               [ 1]  299 	ldw	x, sp
      00814C 6F 60            [ 1]  300 	clr	(96, x)
      00814E 96               [ 1]  301 	ldw	x, sp
      00814F 6F 61            [ 1]  302 	clr	(97, x)
      008151 96               [ 1]  303 	ldw	x, sp
      008152 6F 62            [ 1]  304 	clr	(98, x)
      008154 96               [ 1]  305 	ldw	x, sp
      008155 6F 63            [ 1]  306 	clr	(99, x)
      008157 96               [ 1]  307 	ldw	x, sp
      008158 6F 64            [ 1]  308 	clr	(100, x)
                                    309 ;	src/main.c: 22: uint8_t buff2[100] = {0};
      00815A 0F 65            [ 1]  310 	clr	(0x65, sp)
      00815C 96               [ 1]  311 	ldw	x, sp
      00815D 6F 66            [ 1]  312 	clr	(102, x)
      00815F 96               [ 1]  313 	ldw	x, sp
      008160 6F 67            [ 1]  314 	clr	(103, x)
      008162 96               [ 1]  315 	ldw	x, sp
      008163 6F 68            [ 1]  316 	clr	(104, x)
      008165 96               [ 1]  317 	ldw	x, sp
      008166 6F 69            [ 1]  318 	clr	(105, x)
      008168 96               [ 1]  319 	ldw	x, sp
      008169 6F 6A            [ 1]  320 	clr	(106, x)
      00816B 96               [ 1]  321 	ldw	x, sp
      00816C 6F 6B            [ 1]  322 	clr	(107, x)
      00816E 96               [ 1]  323 	ldw	x, sp
      00816F 6F 6C            [ 1]  324 	clr	(108, x)
      008171 96               [ 1]  325 	ldw	x, sp
      008172 6F 6D            [ 1]  326 	clr	(109, x)
      008174 96               [ 1]  327 	ldw	x, sp
      008175 6F 6E            [ 1]  328 	clr	(110, x)
      008177 96               [ 1]  329 	ldw	x, sp
      008178 6F 6F            [ 1]  330 	clr	(111, x)
      00817A 96               [ 1]  331 	ldw	x, sp
      00817B 6F 70            [ 1]  332 	clr	(112, x)
      00817D 96               [ 1]  333 	ldw	x, sp
      00817E 6F 71            [ 1]  334 	clr	(113, x)
      008180 96               [ 1]  335 	ldw	x, sp
      008181 6F 72            [ 1]  336 	clr	(114, x)
      008183 96               [ 1]  337 	ldw	x, sp
      008184 6F 73            [ 1]  338 	clr	(115, x)
      008186 96               [ 1]  339 	ldw	x, sp
      008187 6F 74            [ 1]  340 	clr	(116, x)
      008189 96               [ 1]  341 	ldw	x, sp
      00818A 6F 75            [ 1]  342 	clr	(117, x)
      00818C 96               [ 1]  343 	ldw	x, sp
      00818D 6F 76            [ 1]  344 	clr	(118, x)
      00818F 96               [ 1]  345 	ldw	x, sp
      008190 6F 77            [ 1]  346 	clr	(119, x)
      008192 96               [ 1]  347 	ldw	x, sp
      008193 6F 78            [ 1]  348 	clr	(120, x)
      008195 96               [ 1]  349 	ldw	x, sp
      008196 6F 79            [ 1]  350 	clr	(121, x)
      008198 96               [ 1]  351 	ldw	x, sp
      008199 6F 7A            [ 1]  352 	clr	(122, x)
      00819B 96               [ 1]  353 	ldw	x, sp
      00819C 6F 7B            [ 1]  354 	clr	(123, x)
      00819E 96               [ 1]  355 	ldw	x, sp
      00819F 6F 7C            [ 1]  356 	clr	(124, x)
      0081A1 96               [ 1]  357 	ldw	x, sp
      0081A2 6F 7D            [ 1]  358 	clr	(125, x)
      0081A4 96               [ 1]  359 	ldw	x, sp
      0081A5 6F 7E            [ 1]  360 	clr	(126, x)
      0081A7 96               [ 1]  361 	ldw	x, sp
      0081A8 6F 7F            [ 1]  362 	clr	(127, x)
      0081AA 96               [ 1]  363 	ldw	x, sp
      0081AB 6F 80            [ 1]  364 	clr	(128, x)
      0081AD 96               [ 1]  365 	ldw	x, sp
      0081AE 6F 81            [ 1]  366 	clr	(129, x)
      0081B0 96               [ 1]  367 	ldw	x, sp
      0081B1 6F 82            [ 1]  368 	clr	(130, x)
      0081B3 96               [ 1]  369 	ldw	x, sp
      0081B4 6F 83            [ 1]  370 	clr	(131, x)
      0081B6 96               [ 1]  371 	ldw	x, sp
      0081B7 6F 84            [ 1]  372 	clr	(132, x)
      0081B9 96               [ 1]  373 	ldw	x, sp
      0081BA 6F 85            [ 1]  374 	clr	(133, x)
      0081BC 96               [ 1]  375 	ldw	x, sp
      0081BD 6F 86            [ 1]  376 	clr	(134, x)
      0081BF 96               [ 1]  377 	ldw	x, sp
      0081C0 6F 87            [ 1]  378 	clr	(135, x)
      0081C2 96               [ 1]  379 	ldw	x, sp
      0081C3 6F 88            [ 1]  380 	clr	(136, x)
      0081C5 96               [ 1]  381 	ldw	x, sp
      0081C6 6F 89            [ 1]  382 	clr	(137, x)
      0081C8 96               [ 1]  383 	ldw	x, sp
      0081C9 6F 8A            [ 1]  384 	clr	(138, x)
      0081CB 96               [ 1]  385 	ldw	x, sp
      0081CC 6F 8B            [ 1]  386 	clr	(139, x)
      0081CE 96               [ 1]  387 	ldw	x, sp
      0081CF 6F 8C            [ 1]  388 	clr	(140, x)
      0081D1 96               [ 1]  389 	ldw	x, sp
      0081D2 6F 8D            [ 1]  390 	clr	(141, x)
      0081D4 96               [ 1]  391 	ldw	x, sp
      0081D5 6F 8E            [ 1]  392 	clr	(142, x)
      0081D7 96               [ 1]  393 	ldw	x, sp
      0081D8 6F 8F            [ 1]  394 	clr	(143, x)
      0081DA 96               [ 1]  395 	ldw	x, sp
      0081DB 6F 90            [ 1]  396 	clr	(144, x)
      0081DD 96               [ 1]  397 	ldw	x, sp
      0081DE 6F 91            [ 1]  398 	clr	(145, x)
      0081E0 96               [ 1]  399 	ldw	x, sp
      0081E1 6F 92            [ 1]  400 	clr	(146, x)
      0081E3 96               [ 1]  401 	ldw	x, sp
      0081E4 6F 93            [ 1]  402 	clr	(147, x)
      0081E6 96               [ 1]  403 	ldw	x, sp
      0081E7 6F 94            [ 1]  404 	clr	(148, x)
      0081E9 96               [ 1]  405 	ldw	x, sp
      0081EA 6F 95            [ 1]  406 	clr	(149, x)
      0081EC 96               [ 1]  407 	ldw	x, sp
      0081ED 6F 96            [ 1]  408 	clr	(150, x)
      0081EF 96               [ 1]  409 	ldw	x, sp
      0081F0 6F 97            [ 1]  410 	clr	(151, x)
      0081F2 96               [ 1]  411 	ldw	x, sp
      0081F3 6F 98            [ 1]  412 	clr	(152, x)
      0081F5 96               [ 1]  413 	ldw	x, sp
      0081F6 6F 99            [ 1]  414 	clr	(153, x)
      0081F8 96               [ 1]  415 	ldw	x, sp
      0081F9 6F 9A            [ 1]  416 	clr	(154, x)
      0081FB 96               [ 1]  417 	ldw	x, sp
      0081FC 6F 9B            [ 1]  418 	clr	(155, x)
      0081FE 96               [ 1]  419 	ldw	x, sp
      0081FF 6F 9C            [ 1]  420 	clr	(156, x)
      008201 96               [ 1]  421 	ldw	x, sp
      008202 6F 9D            [ 1]  422 	clr	(157, x)
      008204 96               [ 1]  423 	ldw	x, sp
      008205 6F 9E            [ 1]  424 	clr	(158, x)
      008207 96               [ 1]  425 	ldw	x, sp
      008208 6F 9F            [ 1]  426 	clr	(159, x)
      00820A 96               [ 1]  427 	ldw	x, sp
      00820B 6F A0            [ 1]  428 	clr	(160, x)
      00820D 96               [ 1]  429 	ldw	x, sp
      00820E 6F A1            [ 1]  430 	clr	(161, x)
      008210 96               [ 1]  431 	ldw	x, sp
      008211 6F A2            [ 1]  432 	clr	(162, x)
      008213 96               [ 1]  433 	ldw	x, sp
      008214 6F A3            [ 1]  434 	clr	(163, x)
      008216 96               [ 1]  435 	ldw	x, sp
      008217 6F A4            [ 1]  436 	clr	(164, x)
      008219 96               [ 1]  437 	ldw	x, sp
      00821A 6F A5            [ 1]  438 	clr	(165, x)
      00821C 96               [ 1]  439 	ldw	x, sp
      00821D 6F A6            [ 1]  440 	clr	(166, x)
      00821F 96               [ 1]  441 	ldw	x, sp
      008220 6F A7            [ 1]  442 	clr	(167, x)
      008222 96               [ 1]  443 	ldw	x, sp
      008223 6F A8            [ 1]  444 	clr	(168, x)
      008225 96               [ 1]  445 	ldw	x, sp
      008226 6F A9            [ 1]  446 	clr	(169, x)
      008228 96               [ 1]  447 	ldw	x, sp
      008229 6F AA            [ 1]  448 	clr	(170, x)
      00822B 96               [ 1]  449 	ldw	x, sp
      00822C 6F AB            [ 1]  450 	clr	(171, x)
      00822E 96               [ 1]  451 	ldw	x, sp
      00822F 6F AC            [ 1]  452 	clr	(172, x)
      008231 96               [ 1]  453 	ldw	x, sp
      008232 6F AD            [ 1]  454 	clr	(173, x)
      008234 96               [ 1]  455 	ldw	x, sp
      008235 6F AE            [ 1]  456 	clr	(174, x)
      008237 96               [ 1]  457 	ldw	x, sp
      008238 6F AF            [ 1]  458 	clr	(175, x)
      00823A 96               [ 1]  459 	ldw	x, sp
      00823B 6F B0            [ 1]  460 	clr	(176, x)
      00823D 96               [ 1]  461 	ldw	x, sp
      00823E 6F B1            [ 1]  462 	clr	(177, x)
      008240 96               [ 1]  463 	ldw	x, sp
      008241 6F B2            [ 1]  464 	clr	(178, x)
      008243 96               [ 1]  465 	ldw	x, sp
      008244 6F B3            [ 1]  466 	clr	(179, x)
      008246 96               [ 1]  467 	ldw	x, sp
      008247 6F B4            [ 1]  468 	clr	(180, x)
      008249 96               [ 1]  469 	ldw	x, sp
      00824A 6F B5            [ 1]  470 	clr	(181, x)
      00824C 96               [ 1]  471 	ldw	x, sp
      00824D 6F B6            [ 1]  472 	clr	(182, x)
      00824F 96               [ 1]  473 	ldw	x, sp
      008250 6F B7            [ 1]  474 	clr	(183, x)
      008252 96               [ 1]  475 	ldw	x, sp
      008253 6F B8            [ 1]  476 	clr	(184, x)
      008255 96               [ 1]  477 	ldw	x, sp
      008256 6F B9            [ 1]  478 	clr	(185, x)
      008258 96               [ 1]  479 	ldw	x, sp
      008259 6F BA            [ 1]  480 	clr	(186, x)
      00825B 96               [ 1]  481 	ldw	x, sp
      00825C 6F BB            [ 1]  482 	clr	(187, x)
      00825E 96               [ 1]  483 	ldw	x, sp
      00825F 6F BC            [ 1]  484 	clr	(188, x)
      008261 96               [ 1]  485 	ldw	x, sp
      008262 6F BD            [ 1]  486 	clr	(189, x)
      008264 96               [ 1]  487 	ldw	x, sp
      008265 6F BE            [ 1]  488 	clr	(190, x)
      008267 96               [ 1]  489 	ldw	x, sp
      008268 6F BF            [ 1]  490 	clr	(191, x)
      00826A 96               [ 1]  491 	ldw	x, sp
      00826B 6F C0            [ 1]  492 	clr	(192, x)
      00826D 96               [ 1]  493 	ldw	x, sp
      00826E 6F C1            [ 1]  494 	clr	(193, x)
      008270 96               [ 1]  495 	ldw	x, sp
      008271 6F C2            [ 1]  496 	clr	(194, x)
      008273 96               [ 1]  497 	ldw	x, sp
      008274 6F C3            [ 1]  498 	clr	(195, x)
      008276 96               [ 1]  499 	ldw	x, sp
      008277 6F C4            [ 1]  500 	clr	(196, x)
      008279 96               [ 1]  501 	ldw	x, sp
      00827A 6F C5            [ 1]  502 	clr	(197, x)
      00827C 96               [ 1]  503 	ldw	x, sp
      00827D 6F C6            [ 1]  504 	clr	(198, x)
      00827F 96               [ 1]  505 	ldw	x, sp
      008280 6F C7            [ 1]  506 	clr	(199, x)
      008282 96               [ 1]  507 	ldw	x, sp
      008283 6F C8            [ 1]  508 	clr	(200, x)
                                    509 ;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
      008285 4F               [ 1]  510 	clr	a
      008286                        511 00127$:
      008286 A1 64            [ 1]  512 	cp	a, #0x64
      008288 24 0E            [ 1]  513 	jrnc	00101$
                                    514 ;	src/main.c: 25: buff[i] = i/* +7+'0' */;
      00828A 96               [ 1]  515 	ldw	x, sp
      00828B 5C               [ 1]  516 	incw	x
      00828C 89               [ 2]  517 	pushw	x
      00828D 5F               [ 1]  518 	clrw	x
      00828E 97               [ 1]  519 	ld	xl, a
      00828F 72 FB 01         [ 2]  520 	addw	x, (1, sp)
      008292 5B 02            [ 2]  521 	addw	sp, #2
      008294 F7               [ 1]  522 	ld	(x), a
                                    523 ;	src/main.c: 23: for (uint8_t i = 0; i < 100; i++)
      008295 4C               [ 1]  524 	inc	a
      008296 20 EE            [ 2]  525 	jra	00127$
      008298                        526 00101$:
                                    527 ;	src/main.c: 28: spi_config();
      008298 CD 84 E6         [ 4]  528 	call	_spi_config
                                    529 ;	src/main.c: 30: flash_write_enable();
      00829B CD 84 CE         [ 4]  530 	call	_flash_write_enable
                                    531 ;	src/main.c: 32: flash_erase_chip();
      00829E CD 84 DA         [ 4]  532 	call	_flash_erase_chip
                                    533 ;	src/main.c: 33: flash_busy_wait();
      0082A1 CD 84 AB         [ 4]  534 	call	_flash_busy_wait
                                    535 ;	src/main.c: 35: flash_write_enable();
      0082A4 CD 84 CE         [ 4]  536 	call	_flash_write_enable
                                    537 ;	src/main.c: 36: flash_write_to_addr(0x012345, buff, 100);
      0082A7 4B 64            [ 1]  538 	push	#0x64
      0082A9 4B 00            [ 1]  539 	push	#0x00
      0082AB 96               [ 1]  540 	ldw	x, sp
      0082AC 1C 00 03         [ 2]  541 	addw	x, #3
      0082AF 89               [ 2]  542 	pushw	x
      0082B0 4B 45            [ 1]  543 	push	#0x45
      0082B2 4B 23            [ 1]  544 	push	#0x23
      0082B4 4B 01            [ 1]  545 	push	#0x01
      0082B6 4B 00            [ 1]  546 	push	#0x00
      0082B8 CD 83 9C         [ 4]  547 	call	_flash_write_to_addr
      0082BB 5B 08            [ 2]  548 	addw	sp, #8
                                    549 ;	src/main.c: 37: flash_busy_wait();
      0082BD CD 84 AB         [ 4]  550 	call	_flash_busy_wait
                                    551 ;	src/main.c: 39: uart_write_8bits(0x99); //indicates start
      0082C0 4B 99            [ 1]  552 	push	#0x99
      0082C2 CD 83 4C         [ 4]  553 	call	_uart_write_8bits
      0082C5 84               [ 1]  554 	pop	a
                                    555 ;	src/main.c: 78: flash_read_from_addr(0x012345, buff2, 100);
      0082C6 4B 64            [ 1]  556 	push	#0x64
      0082C8 4B 00            [ 1]  557 	push	#0x00
      0082CA 96               [ 1]  558 	ldw	x, sp
      0082CB 1C 00 67         [ 2]  559 	addw	x, #103
      0082CE 89               [ 2]  560 	pushw	x
      0082CF 4B 45            [ 1]  561 	push	#0x45
      0082D1 4B 23            [ 1]  562 	push	#0x23
      0082D3 4B 01            [ 1]  563 	push	#0x01
      0082D5 4B 00            [ 1]  564 	push	#0x00
      0082D7 CD 83 BD         [ 4]  565 	call	_flash_read_from_addr
      0082DA 5B 08            [ 2]  566 	addw	sp, #8
                                    567 ;	src/main.c: 81: char hex_string[2] = {0};
      0082DC 0F C9            [ 1]  568 	clr	(0xc9, sp)
      0082DE 96               [ 1]  569 	ldw	x, sp
      0082DF 6F CA            [ 1]  570 	clr	(202, x)
                                    571 ;	src/main.c: 82: for(uint8_t ii = 0; ii < 100; ii++)
      0082E1 0F CB            [ 1]  572 	clr	(0xcb, sp)
      0082E3                        573 00136$:
      0082E3 7B CB            [ 1]  574 	ld	a, (0xcb, sp)
      0082E5 A1 64            [ 1]  575 	cp	a, #0x64
      0082E7 24 18            [ 1]  576 	jrnc	00124$
                                    577 ;	src/main.c: 85: uart_write_8bits(buff2[ii]);
      0082E9 5F               [ 1]  578 	clrw	x
      0082EA 7B CB            [ 1]  579 	ld	a, (0xcb, sp)
      0082EC 97               [ 1]  580 	ld	xl, a
      0082ED 89               [ 2]  581 	pushw	x
      0082EE 96               [ 1]  582 	ldw	x, sp
      0082EF 1C 00 67         [ 2]  583 	addw	x, #103
      0082F2 72 FB 01         [ 2]  584 	addw	x, (1, sp)
      0082F5 5B 02            [ 2]  585 	addw	sp, #2
      0082F7 F6               [ 1]  586 	ld	a, (x)
      0082F8 88               [ 1]  587 	push	a
      0082F9 CD 83 4C         [ 4]  588 	call	_uart_write_8bits
      0082FC 84               [ 1]  589 	pop	a
                                    590 ;	src/main.c: 82: for(uint8_t ii = 0; ii < 100; ii++)
      0082FD 0C CB            [ 1]  591 	inc	(0xcb, sp)
      0082FF 20 E2            [ 2]  592 	jra	00136$
                                    593 ;	src/main.c: 89: while(1);
      008301                        594 00124$:
      008301 20 FE            [ 2]  595 	jra	00124$
                                    596 ;	src/main.c: 90: }
      008303 5B CB            [ 2]  597 	addw	sp, #203
      008305 81               [ 4]  598 	ret
                                    599 ;	src/main.c: 93: void uart_init()
                                    600 ;	-----------------------------------------
                                    601 ;	 function uart_init
                                    602 ;	-----------------------------------------
      008306                        603 _uart_init:
                                    604 ;	src/main.c: 96: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008306 72 16 52 35      [ 1]  605 	bset	21045, #3
                                    606 ;	src/main.c: 98: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      00830A C6 52 36         [ 1]  607 	ld	a, 0x5236
      00830D A4 CF            [ 1]  608 	and	a, #0xcf
      00830F C7 52 36         [ 1]  609 	ld	0x5236, a
                                    610 ;	src/main.c: 100: UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
      008312 35 01 52 33      [ 1]  611 	mov	0x5233+0, #0x01
      008316 35 34 52 32      [ 1]  612 	mov	0x5232+0, #0x34
                                    613 ;	src/main.c: 101: }
      00831A 81               [ 4]  614 	ret
                                    615 ;	src/main.c: 104: uint16_t uart_write(const char *str) {
                                    616 ;	-----------------------------------------
                                    617 ;	 function uart_write
                                    618 ;	-----------------------------------------
      00831B                        619 _uart_write:
      00831B 52 03            [ 2]  620 	sub	sp, #3
                                    621 ;	src/main.c: 106: for(i = 0; i < strlen(str); i++) {
      00831D 0F 03            [ 1]  622 	clr	(0x03, sp)
      00831F                        623 00106$:
      00831F 1E 06            [ 2]  624 	ldw	x, (0x06, sp)
      008321 89               [ 2]  625 	pushw	x
      008322 CD 85 A1         [ 4]  626 	call	_strlen
      008325 5B 02            [ 2]  627 	addw	sp, #2
      008327 1F 01            [ 2]  628 	ldw	(0x01, sp), x
      008329 5F               [ 1]  629 	clrw	x
      00832A 7B 03            [ 1]  630 	ld	a, (0x03, sp)
      00832C 97               [ 1]  631 	ld	xl, a
      00832D 13 01            [ 2]  632 	cpw	x, (0x01, sp)
      00832F 24 14            [ 1]  633 	jrnc	00104$
                                    634 ;	src/main.c: 107: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008331                        635 00101$:
      008331 C6 52 30         [ 1]  636 	ld	a, 0x5230
      008334 2A FB            [ 1]  637 	jrpl	00101$
                                    638 ;	src/main.c: 108: UART1_DR = str[i];
      008336 5F               [ 1]  639 	clrw	x
      008337 7B 03            [ 1]  640 	ld	a, (0x03, sp)
      008339 97               [ 1]  641 	ld	xl, a
      00833A 72 FB 06         [ 2]  642 	addw	x, (0x06, sp)
      00833D F6               [ 1]  643 	ld	a, (x)
      00833E C7 52 31         [ 1]  644 	ld	0x5231, a
                                    645 ;	src/main.c: 106: for(i = 0; i < strlen(str); i++) {
      008341 0C 03            [ 1]  646 	inc	(0x03, sp)
      008343 20 DA            [ 2]  647 	jra	00106$
      008345                        648 00104$:
                                    649 ;	src/main.c: 110: return(i); // Bytes sent
      008345 7B 03            [ 1]  650 	ld	a, (0x03, sp)
      008347 5F               [ 1]  651 	clrw	x
      008348 97               [ 1]  652 	ld	xl, a
                                    653 ;	src/main.c: 111: }
      008349 5B 03            [ 2]  654 	addw	sp, #3
      00834B 81               [ 4]  655 	ret
                                    656 ;	src/main.c: 113: void uart_write_8bits(uint8_t d)
                                    657 ;	-----------------------------------------
                                    658 ;	 function uart_write_8bits
                                    659 ;	-----------------------------------------
      00834C                        660 _uart_write_8bits:
                                    661 ;	src/main.c: 115: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      00834C                        662 00101$:
      00834C C6 52 30         [ 1]  663 	ld	a, 0x5230
      00834F 2A FB            [ 1]  664 	jrpl	00101$
                                    665 ;	src/main.c: 116: UART1_DR = d;
      008351 AE 52 31         [ 2]  666 	ldw	x, #0x5231
      008354 7B 03            [ 1]  667 	ld	a, (0x03, sp)
      008356 F7               [ 1]  668 	ld	(x), a
                                    669 ;	src/main.c: 117: }
      008357 81               [ 4]  670 	ret
                                    671 ;	src/main.c: 120: void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
                                    672 ;	-----------------------------------------
                                    673 ;	 function int_to_hex_str
                                    674 ;	-----------------------------------------
      008358                        675 _int_to_hex_str:
      008358 52 03            [ 2]  676 	sub	sp, #3
                                    677 ;	src/main.c: 123: while(hex_str_len)
      00835A 7B 0C            [ 1]  678 	ld	a, (0x0c, sp)
      00835C 6B 03            [ 1]  679 	ld	(0x03, sp), a
      00835E                        680 00101$:
      00835E 0D 03            [ 1]  681 	tnz	(0x03, sp)
      008360 27 37            [ 1]  682 	jreq	00104$
                                    683 ;	src/main.c: 125: uint8_t masked_dec = (dec & mask);
      008362 7B 09            [ 1]  684 	ld	a, (0x09, sp)
      008364 A4 0F            [ 1]  685 	and	a, #0x0f
                                    686 ;	src/main.c: 126: hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
      008366 5F               [ 1]  687 	clrw	x
      008367 41               [ 1]  688 	exg	a, xl
      008368 7B 03            [ 1]  689 	ld	a, (0x03, sp)
      00836A 41               [ 1]  690 	exg	a, xl
      00836B 5A               [ 2]  691 	decw	x
      00836C 72 FB 0A         [ 2]  692 	addw	x, (0x0a, sp)
      00836F 1F 01            [ 2]  693 	ldw	(0x01, sp), x
      008371 97               [ 1]  694 	ld	xl, a
      008372 A1 0A            [ 1]  695 	cp	a, #0x0a
      008374 24 05            [ 1]  696 	jrnc	00106$
      008376 9F               [ 1]  697 	ld	a, xl
      008377 AB 30            [ 1]  698 	add	a, #0x30
      008379 20 03            [ 2]  699 	jra	00107$
      00837B                        700 00106$:
      00837B 9F               [ 1]  701 	ld	a, xl
      00837C AB 37            [ 1]  702 	add	a, #0x37
      00837E                        703 00107$:
      00837E 1E 01            [ 2]  704 	ldw	x, (0x01, sp)
      008380 F7               [ 1]  705 	ld	(x), a
                                    706 ;	src/main.c: 128: dec >>= 4;
      008381 1E 08            [ 2]  707 	ldw	x, (0x08, sp)
      008383 16 06            [ 2]  708 	ldw	y, (0x06, sp)
      008385 90 54            [ 2]  709 	srlw	y
      008387 56               [ 2]  710 	rrcw	x
      008388 90 54            [ 2]  711 	srlw	y
      00838A 56               [ 2]  712 	rrcw	x
      00838B 90 54            [ 2]  713 	srlw	y
      00838D 56               [ 2]  714 	rrcw	x
      00838E 90 54            [ 2]  715 	srlw	y
      008390 56               [ 2]  716 	rrcw	x
      008391 1F 08            [ 2]  717 	ldw	(0x08, sp), x
      008393 17 06            [ 2]  718 	ldw	(0x06, sp), y
                                    719 ;	src/main.c: 129: hex_str_len--;
      008395 0A 03            [ 1]  720 	dec	(0x03, sp)
      008397 20 C5            [ 2]  721 	jra	00101$
      008399                        722 00104$:
                                    723 ;	src/main.c: 131: }
      008399 5B 03            [ 2]  724 	addw	sp, #3
      00839B 81               [ 4]  725 	ret
                                    726 	.area CODE
                                    727 	.area CONST
                                    728 	.area CONST
      008024                        729 ___str_0:
      008024 20                     730 	.ascii " "
      008025 00                     731 	.db 0x00
                                    732 	.area CODE
                                    733 	.area INITIALIZER
                                    734 	.area CABS (ABS)
