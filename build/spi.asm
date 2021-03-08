;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module spi
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _spi_config
	.globl _spi_busy_wait
	.globl _spi_write_24bits
	.globl _spi_write_8bits
	.globl _spi_read_8bits
	.globl _spi_cs_active
	.globl _spi_cs_idle
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/spi.c: 6: void spi_config()
;	-----------------------------------------
;	 function spi_config
;	-----------------------------------------
_spi_config:
;	src/spi.c: 9: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
	ld	a, 0x500c
	or	a, #0x60
	ld	0x500c, a
;	src/spi.c: 10: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;
	ld	a, 0x500d
	or	a, #0xe0
	ld	0x500d, a
;	src/spi.c: 13: PORT(SPI_PORT, DDR) |= SPI_CS;
	bset	20492, #4
;	src/spi.c: 14: PORT(SPI_PORT, CR1) |= SPI_CS;
	bset	20493, #4
;	src/spi.c: 15: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
	bset	20490, #4
;	src/spi.c: 19: SPI_CR1 = 0;
	mov	0x5200+0, #0x00
;	src/spi.c: 20: SPI_CR2 = 0;
	mov	0x5201+0, #0x00
;	src/spi.c: 23: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
	bres	20992, #7
;	src/spi.c: 25: SPI_CR1 |= SPI_CR1_BR(0b111);
	ld	a, 0x5200
	or	a, #0x38
	ld	0x5200, a
;	src/spi.c: 29: SPI_CR1 &= ~SPI_CR1_CPOL;
	bres	20992, #1
;	src/spi.c: 31: SPI_CR1 &= ~SPI_CR1_CPHA;
	bres	20992, #0
;	src/spi.c: 33: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
	bset	20993, #1
;	src/spi.c: 34: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
	bset	20993, #0
;	src/spi.c: 35: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
	bset	20992, #2
;	src/spi.c: 36: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
	bset	20992, #6
;	src/spi.c: 37: }
	ret
;	src/spi.c: 43: void spi_busy_wait()
;	-----------------------------------------
;	 function spi_busy_wait
;	-----------------------------------------
_spi_busy_wait:
;	src/spi.c: 45: while (SPI_SR & SPI_SR_BSY);
00101$:
	ld	a, 0x5203
	jrmi	00101$
;	src/spi.c: 46: }
	ret
;	src/spi.c: 52: void spi_write_24bits(uint32_t data)
;	-----------------------------------------
;	 function spi_write_24bits
;	-----------------------------------------
_spi_write_24bits:
;	src/spi.c: 59: SPI_WRITE8(data >> 16);
	ldw	x, (0x03, sp)
	ld	a, xl
	ld	0x5204, a
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
	ld	a, 0x5204
;	src/spi.c: 60: SPI_WRITE8(data >> 8);
	ldw	x, (0x05, sp)
	ld	a, xh
	clrw	x
	ld	0x5204, a
00107$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00107$
	ld	a, 0x5204
;	src/spi.c: 61: SPI_WRITE8(data >> 0);
	ld	a, (0x06, sp)
	ld	0x5204, a
00113$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00113$
	ld	a, 0x5204
;	src/spi.c: 62: }
	ret
;	src/spi.c: 68: void spi_write_8bits(uint8_t data)
;	-----------------------------------------
;	 function spi_write_8bits
;	-----------------------------------------
_spi_write_8bits:
;	src/spi.c: 70: SPI_WRITE8(data);
	ldw	x, #0x5204
	ld	a, (0x03, sp)
	ld	(x), a
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
	ld	a, 0x5204
;	src/spi.c: 71: }
	ret
;	src/spi.c: 77: uint8_t spi_read_8bits()
;	-----------------------------------------
;	 function spi_read_8bits
;	-----------------------------------------
_spi_read_8bits:
;	src/spi.c: 80: SPI_READ8(d);
	mov	0x5204+0, #0xff
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
	ld	a, 0x5204
00107$:
	ld	a, 0x5203
	srl	a
	jrnc	00107$
	ld	a, 0x5204
	ld	a, 0x5204
;	src/spi.c: 81: return d;
;	src/spi.c: 82: }
	ret
;	src/spi.c: 88: void spi_cs_active()
;	-----------------------------------------
;	 function spi_cs_active
;	-----------------------------------------
_spi_cs_active:
;	src/spi.c: 90: SPI_CS_ACTIVE();
	bres	20490, #4
;	src/spi.c: 91: }
	ret
;	src/spi.c: 97: void spi_cs_idle()
;	-----------------------------------------
;	 function spi_cs_idle
;	-----------------------------------------
_spi_cs_idle:
;	src/spi.c: 99: SPI_CS_IDLE();
00101$:
	ld	a, 0x5203
	jrmi	00101$
	bset	20490, #4
;	src/spi.c: 100: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
