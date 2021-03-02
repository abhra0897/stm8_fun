;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module spi
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _flash_spi_config
	.globl _flash_gpio_config
	.globl _spi_busy_wait
	.globl _spi_write_24bits
	.globl _spi_write_8bits
	.globl _spi_read_8bits
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
;	src/spi.c: 6: void flash_spi_config()
;	-----------------------------------------
;	 function flash_spi_config
;	-----------------------------------------
_flash_spi_config:
;	src/spi.c: 9: SPI_CR1 = 0;
	mov	0x5200+0, #0x00
;	src/spi.c: 10: SPI_CR2 = 0;
	mov	0x5201+0, #0x00
;	src/spi.c: 13: SPI_CR1 &= ~SPI_CR1_LSBFIRST;
	bres	20992, #7
;	src/spi.c: 15: SPI_CR1 |= SPI_CR1_BR(0b111);
	ld	a, 0x5200
	or	a, #0x38
	ld	0x5200, a
;	src/spi.c: 19: SPI_CR1 &= ~SPI_CR1_CPOL;
	bres	20992, #1
;	src/spi.c: 21: SPI_CR1 &= ~SPI_CR1_CPHA;
	bres	20992, #0
;	src/spi.c: 23: SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
	bset	20993, #1
;	src/spi.c: 24: SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
	bset	20993, #0
;	src/spi.c: 25: SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
	bset	20992, #2
;	src/spi.c: 26: SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
	bset	20992, #6
;	src/spi.c: 27: }
	ret
;	src/spi.c: 33: void flash_gpio_config()
;	-----------------------------------------
;	 function flash_gpio_config
;	-----------------------------------------
_flash_gpio_config:
;	src/spi.c: 36: PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
	ld	a, 0x500c
	or	a, #0x60
	ld	0x500c, a
;	src/spi.c: 37: PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;
	ld	a, 0x500d
	or	a, #0xe0
	ld	0x500d, a
;	src/spi.c: 40: PORT(SPI_PORT, DDR) |= SPI_CS;
	bset	20492, #4
;	src/spi.c: 41: PORT(SPI_PORT, CR1) |= SPI_CS;
	bset	20493, #4
;	src/spi.c: 42: PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
	bset	20490, #4
;	src/spi.c: 43: }
	ret
;	src/spi.c: 49: void spi_busy_wait()
;	-----------------------------------------
;	 function spi_busy_wait
;	-----------------------------------------
_spi_busy_wait:
;	src/spi.c: 51: while (SPI_SR & SPI_SR_BSY);
00101$:
	ld	a, 0x5203
	jrmi	00101$
;	src/spi.c: 52: }
	ret
;	src/spi.c: 58: void spi_write_24bits(uint32_t data)
;	-----------------------------------------
;	 function spi_write_24bits
;	-----------------------------------------
_spi_write_24bits:
	push	a
;	src/spi.c: 60: for (int8_t i = 2; i >= 0; i--)
	ld	a, #0x02
	ld	(0x01, sp), a
00109$:
	tnz	(0x01, sp)
	jrmi	00111$
;	src/spi.c: 62: SPI_WRITE8(0xFF & (data >> (i << 4)));   // Explanation: i<<4 = i*8 = 16, 8, 0 for i = 2, 1, 0 respectively. So, we're shifting data and then sending
	ld	a, (0x01, sp)
	swap	a
	and	a, #0xf0
	ldw	x, (0x06, sp)
	ldw	y, (0x04, sp)
	tnz	a
	jreq	00136$
00135$:
	srlw	y
	rrcw	x
	dec	a
	jrne	00135$
00136$:
	ld	a, xl
	ld	0x5204, a
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
;	src/spi.c: 60: for (int8_t i = 2; i >= 0; i--)
	dec	(0x01, sp)
	jra	00109$
00111$:
;	src/spi.c: 64: }
	pop	a
	ret
;	src/spi.c: 70: void spi_write_8bits(uint8_t data)
;	-----------------------------------------
;	 function spi_write_8bits
;	-----------------------------------------
_spi_write_8bits:
;	src/spi.c: 72: SPI_WRITE8(0xFF & data);
	ld	a, (0x03, sp)
	ld	0x5204, a
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
;	src/spi.c: 73: }
	ret
;	src/spi.c: 79: uint8_t spi_read_8bits()
;	-----------------------------------------
;	 function spi_read_8bits
;	-----------------------------------------
_spi_read_8bits:
;	src/spi.c: 82: SPI_READ8(d);
	mov	0x5204+0, #0xff
00101$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00101$
00107$:
	ld	a, 0x5203
	srl	a
	jrnc	00107$
	ld	a, 0x5204
;	src/spi.c: 83: return d;
;	src/spi.c: 84: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
