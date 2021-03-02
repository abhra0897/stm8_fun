;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module flash_driver
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _spi_read_8bits
	.globl _spi_write_8bits
	.globl _spi_write_24bits
	.globl _flash_write_to_addr
	.globl _flash_read_from_addr
	.globl _flash_set_write_addr
	.globl _flash_set_read_addr
	.globl _flash_write_nbytes
	.globl _flash_read_nbytes
	.globl _flash_read_sreg
	.globl _flash_write_sreg
	.globl _flash_busy_wait
	.globl _flash_erase_block
	.globl _flash_write_enable
	.globl _flash_erase_chip
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
;	src/flash_driver.c: 13: void flash_write_to_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_write_to_addr
;	-----------------------------------------
_flash_write_to_addr:
;	src/flash_driver.c: 15: if (buff == NULL)
	ldw	x, (0x07, sp)
	jrne	00102$
;	src/flash_driver.c: 16: return;
	ret
00102$:
;	src/flash_driver.c: 17: flash_set_write_addr(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_flash_set_write_addr
	addw	sp, #4
;	src/flash_driver.c: 18: flash_write_nbytes(buff, nbytes);
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	_flash_write_nbytes
	addw	sp, #4
;	src/flash_driver.c: 19: }
	ret
;	src/flash_driver.c: 28: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_read_from_addr
;	-----------------------------------------
_flash_read_from_addr:
;	src/flash_driver.c: 30: if (buff == NULL)
	ldw	x, (0x07, sp)
	jrne	00102$
;	src/flash_driver.c: 31: return;
	ret
00102$:
;	src/flash_driver.c: 32: flash_set_read_addr(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_flash_set_read_addr
	addw	sp, #4
;	src/flash_driver.c: 33: flash_read_nbytes(buff, nbytes);
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	_flash_read_nbytes
	addw	sp, #4
;	src/flash_driver.c: 34: }
	ret
;	src/flash_driver.c: 41: void flash_set_write_addr(uint32_t addr)
;	-----------------------------------------
;	 function flash_set_write_addr
;	-----------------------------------------
_flash_set_write_addr:
;	src/flash_driver.c: 43: spi_write_8bits(CMD_PAGE_WRITE);
	push	#0x02
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 44: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 45: }
	ret
;	src/flash_driver.c: 52: void flash_set_read_addr(uint32_t addr)
;	-----------------------------------------
;	 function flash_set_read_addr
;	-----------------------------------------
_flash_set_read_addr:
;	src/flash_driver.c: 54: spi_write_8bits(CMD_READ_ARRAY);
	push	#0x03
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 55: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 56: }
	ret
;	src/flash_driver.c: 67: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_write_nbytes
;	-----------------------------------------
_flash_write_nbytes:
;	src/flash_driver.c: 69: if (buff == NULL)
	ldw	x, (0x03, sp)
	jrne	00118$
;	src/flash_driver.c: 70: return;
	ret
;	src/flash_driver.c: 72: while (i < nbytes)
00118$:
	clrw	x
00109$:
	cpw	x, (0x05, sp)
	jrc	00141$
	ret
00141$:
;	src/flash_driver.c: 74: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
	ldw	y, x
	addw	y, (0x03, sp)
	ld	a, (y)
	ld	0x5204, a
00103$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00103$
;	src/flash_driver.c: 75: i++;
	incw	x
	jra	00109$
;	src/flash_driver.c: 77: }
	ret
;	src/flash_driver.c: 88: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_read_nbytes
;	-----------------------------------------
_flash_read_nbytes:
;	src/flash_driver.c: 90: if (buff == NULL)
	ldw	x, (0x03, sp)
	jrne	00125$
;	src/flash_driver.c: 91: return;
	ret
;	src/flash_driver.c: 93: while (i < nbytes)
00125$:
	clrw	x
00115$:
	cpw	x, (0x05, sp)
	jrc	00152$
	ret
00152$:
;	src/flash_driver.c: 95: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
	mov	0x5204+0, #0xff
00103$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00103$
00109$:
	ld	a, 0x5203
	srl	a
	jrnc	00109$
	ldw	y, x
	addw	y, (0x03, sp)
	ld	a, 0x5204
	ld	(y), a
;	src/flash_driver.c: 96: i++;
	incw	x
	jra	00115$
;	src/flash_driver.c: 98: }
	ret
;	src/flash_driver.c: 106: uint8_t flash_read_sreg(uint8_t sreg_no)
;	-----------------------------------------
;	 function flash_read_sreg
;	-----------------------------------------
_flash_read_sreg:
;	src/flash_driver.c: 109: if (sreg_no == 1)
	ld	a, (0x03, sp)
	dec	a
	jrne	00105$
;	src/flash_driver.c: 110: spi_write_8bits(CMD_READ_SREG_BYTE1);
	push	#0x05
	call	_spi_write_8bits
	pop	a
	jra	00106$
00105$:
;	src/flash_driver.c: 111: else if (sreg_no == 2)
	ld	a, (0x03, sp)
	cp	a, #0x02
	jrne	00102$
;	src/flash_driver.c: 112: spi_write_8bits(CMD_READ_SREG_BYTE2);
	push	#0x35
	call	_spi_write_8bits
	pop	a
	jra	00106$
00102$:
;	src/flash_driver.c: 114: return 0;
	clr	a
	ret
00106$:
;	src/flash_driver.c: 116: sreg_val = spi_read_8bits();
;	src/flash_driver.c: 118: return sreg_val;
;	src/flash_driver.c: 119: }
	jp	_spi_read_8bits
;	src/flash_driver.c: 127: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
;	-----------------------------------------
;	 function flash_write_sreg
;	-----------------------------------------
_flash_write_sreg:
;	src/flash_driver.c: 129: spi_write_8bits(CMD_WRITE_SREG);
	push	#0x01
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 130: spi_write_8bits(sreg_byte1);
	ld	a, (0x03, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 131: spi_write_8bits(sreg_byte2);
	ld	a, (0x04, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 132: }
	ret
;	src/flash_driver.c: 138: void flash_busy_wait()
;	-----------------------------------------
;	 function flash_busy_wait
;	-----------------------------------------
_flash_busy_wait:
;	src/flash_driver.c: 140: while (flash_read_sreg(1) & (1 << SREG_BYTE1_BSY));
00101$:
	push	#0x01
	call	_flash_read_sreg
	addw	sp, #1
	srl	a
	jrc	00101$
;	src/flash_driver.c: 141: }
	ret
;	src/flash_driver.c: 150: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
;	-----------------------------------------
;	 function flash_erase_block
;	-----------------------------------------
_flash_erase_block:
;	src/flash_driver.c: 152: spi_write_8bits(cmd_block_erase);
	ld	a, (0x07, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 153: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 154: }
	ret
;	src/flash_driver.c: 160: void flash_write_enable()
;	-----------------------------------------
;	 function flash_write_enable
;	-----------------------------------------
_flash_write_enable:
;	src/flash_driver.c: 162: spi_write_8bits(CMD_WRITE_ENABLE);
	push	#0x06
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 163: }
	ret
;	src/flash_driver.c: 168: void flash_erase_chip()
;	-----------------------------------------
;	 function flash_erase_chip
;	-----------------------------------------
_flash_erase_chip:
;	src/flash_driver.c: 170: spi_write_8bits(CMD_CHIP_ERASE);
	push	#0x60
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 171: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
