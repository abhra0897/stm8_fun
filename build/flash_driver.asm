;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module flash_driver
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _spi_cs_idle
	.globl _spi_cs_active
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
;	src/flash_driver.c: 17: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 18: flash_set_write_addr(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_flash_set_write_addr
	addw	sp, #4
;	src/flash_driver.c: 19: flash_write_nbytes(buff, nbytes);
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	_flash_write_nbytes
	addw	sp, #4
;	src/flash_driver.c: 20: spi_cs_idle();
;	src/flash_driver.c: 21: }
	jp	_spi_cs_idle
;	src/flash_driver.c: 30: void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_read_from_addr
;	-----------------------------------------
_flash_read_from_addr:
;	src/flash_driver.c: 32: if (buff == NULL)
	ldw	x, (0x07, sp)
	jrne	00102$
;	src/flash_driver.c: 33: return;
	ret
00102$:
;	src/flash_driver.c: 34: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 35: flash_set_read_addr(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_flash_set_read_addr
	addw	sp, #4
;	src/flash_driver.c: 36: flash_read_nbytes(buff, nbytes);
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	_flash_read_nbytes
	addw	sp, #4
;	src/flash_driver.c: 37: spi_cs_idle();
;	src/flash_driver.c: 38: }
	jp	_spi_cs_idle
;	src/flash_driver.c: 45: void flash_set_write_addr(uint32_t addr)
;	-----------------------------------------
;	 function flash_set_write_addr
;	-----------------------------------------
_flash_set_write_addr:
;	src/flash_driver.c: 47: spi_write_8bits(CMD_PAGE_WRITE);
	push	#0x02
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 48: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 49: }
	ret
;	src/flash_driver.c: 56: void flash_set_read_addr(uint32_t addr)
;	-----------------------------------------
;	 function flash_set_read_addr
;	-----------------------------------------
_flash_set_read_addr:
;	src/flash_driver.c: 58: spi_write_8bits(CMD_READ_ARRAY);
	push	#0x03
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 59: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 60: }
	ret
;	src/flash_driver.c: 71: void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_write_nbytes
;	-----------------------------------------
_flash_write_nbytes:
;	src/flash_driver.c: 73: if (buff == NULL)
	ldw	x, (0x03, sp)
	jrne	00118$
;	src/flash_driver.c: 74: return;
	ret
;	src/flash_driver.c: 76: while (i < nbytes)
00118$:
	clrw	x
00109$:
	cpw	x, (0x05, sp)
	jrc	00141$
	ret
00141$:
;	src/flash_driver.c: 78: SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
	ldw	y, x
	addw	y, (0x03, sp)
	ld	a, (y)
	ld	0x5204, a
00103$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00103$
	ld	a, 0x5204
;	src/flash_driver.c: 79: i++;
	incw	x
	jra	00109$
;	src/flash_driver.c: 81: }
	ret
;	src/flash_driver.c: 92: void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
;	-----------------------------------------
;	 function flash_read_nbytes
;	-----------------------------------------
_flash_read_nbytes:
;	src/flash_driver.c: 94: if (buff == NULL)
	ldw	x, (0x03, sp)
	jrne	00126$
;	src/flash_driver.c: 95: return;
	ret
;	src/flash_driver.c: 97: while (i < nbytes)
00126$:
	clrw	x
00115$:
	cpw	x, (0x05, sp)
	jrc	00157$
	ret
00157$:
;	src/flash_driver.c: 99: SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
	mov	0x5204+0, #0xff
00103$:
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00103$
	ld	a, 0x5204
00109$:
	ld	a, 0x5203
	srl	a
	jrnc	00109$
	ldw	y, x
	addw	y, (0x03, sp)
	ld	a, 0x5204
	ld	(y), a
	ld	a, 0x5204
	ld	(y), a
;	src/flash_driver.c: 100: i++;
	incw	x
	jra	00115$
;	src/flash_driver.c: 102: }
	ret
;	src/flash_driver.c: 110: uint8_t flash_read_sreg(uint8_t sreg_no)
;	-----------------------------------------
;	 function flash_read_sreg
;	-----------------------------------------
_flash_read_sreg:
	push	a
;	src/flash_driver.c: 112: uint8_t sreg_val = 0; 
	clr	(0x01, sp)
;	src/flash_driver.c: 114: if (sreg_no == 1 || sreg_no == 2)
	ld	a, (0x04, sp)
	dec	a
	jrne	00120$
	ld	a, #0x01
	.byte 0x21
00120$:
	clr	a
00121$:
	tnz	a
	jrne	00104$
	push	a
	ld	a, (0x05, sp)
	cp	a, #0x02
	pop	a
	jrne	00105$
00104$:
;	src/flash_driver.c: 116: spi_cs_active();
	push	a
	call	_spi_cs_active
	pop	a
;	src/flash_driver.c: 117: if (sreg_no == 1)
	tnz	a
	jreq	00102$
;	src/flash_driver.c: 118: spi_write_8bits(CMD_READ_SREG_BYTE1);
	push	#0x05
	call	_spi_write_8bits
	pop	a
	jra	00103$
00102$:
;	src/flash_driver.c: 120: spi_write_8bits(CMD_READ_SREG_BYTE2);
	push	#0x35
	call	_spi_write_8bits
	pop	a
00103$:
;	src/flash_driver.c: 122: sreg_val = spi_read_8bits();
	call	_spi_read_8bits
	ld	(0x01, sp), a
;	src/flash_driver.c: 123: spi_cs_idle();
	call	_spi_cs_idle
00105$:
;	src/flash_driver.c: 126: return sreg_val;
	ld	a, (0x01, sp)
;	src/flash_driver.c: 127: }
	addw	sp, #1
	ret
;	src/flash_driver.c: 135: void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
;	-----------------------------------------
;	 function flash_write_sreg
;	-----------------------------------------
_flash_write_sreg:
;	src/flash_driver.c: 137: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 138: spi_write_8bits(CMD_WRITE_SREG);
	push	#0x01
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 139: spi_write_8bits(sreg_byte1);
	ld	a, (0x03, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 140: spi_write_8bits(sreg_byte2);
	ld	a, (0x04, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 141: spi_cs_idle();
;	src/flash_driver.c: 142: }
	jp	_spi_cs_idle
;	src/flash_driver.c: 148: void flash_busy_wait()
;	-----------------------------------------
;	 function flash_busy_wait
;	-----------------------------------------
_flash_busy_wait:
;	src/flash_driver.c: 153: do
00101$:
;	src/flash_driver.c: 155: sreg_val = flash_read_sreg(1);
	push	#0x01
	call	_flash_read_sreg
	addw	sp, #1
;	src/flash_driver.c: 156: } while (sreg_val & (1 << SREG_BYTE1_BSY));
	srl	a
	jrc	00101$
;	src/flash_driver.c: 158: }
	ret
;	src/flash_driver.c: 167: void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
;	-----------------------------------------
;	 function flash_erase_block
;	-----------------------------------------
_flash_erase_block:
;	src/flash_driver.c: 169: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 170: spi_write_8bits(cmd_block_erase);
	ld	a, (0x07, sp)
	push	a
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 171: spi_write_24bits(addr);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	_spi_write_24bits
	addw	sp, #4
;	src/flash_driver.c: 172: spi_cs_idle();
;	src/flash_driver.c: 173: }
	jp	_spi_cs_idle
;	src/flash_driver.c: 179: void flash_write_enable()
;	-----------------------------------------
;	 function flash_write_enable
;	-----------------------------------------
_flash_write_enable:
;	src/flash_driver.c: 181: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 182: spi_write_8bits(CMD_WRITE_ENABLE);
	push	#0x06
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 183: spi_cs_idle();
;	src/flash_driver.c: 184: }
	jp	_spi_cs_idle
;	src/flash_driver.c: 189: void flash_erase_chip()
;	-----------------------------------------
;	 function flash_erase_chip
;	-----------------------------------------
_flash_erase_chip:
;	src/flash_driver.c: 191: spi_cs_active();
	call	_spi_cs_active
;	src/flash_driver.c: 192: spi_write_8bits(CMD_CHIP_ERASE);
	push	#0x60
	call	_spi_write_8bits
	pop	a
;	src/flash_driver.c: 193: spi_cs_idle();
;	src/flash_driver.c: 194: }
	jp	_spi_cs_idle
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
