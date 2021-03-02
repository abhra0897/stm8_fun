#include "flash_driver.h"
#include <stdint.h>

#define NULL            ((void *)0)


/**
 * Write n bytes from a buffer to a given address.
 * @param addr The 24 bit address to write to.
 * @param buff  The array from where data will be written.
 * @param nbytes Number of bytes to be written. Size of buff must be at least this much.
 */
void flash_write_to_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
{
    if (buff == NULL)
        return;
    flash_set_write_addr(addr);
    flash_write_nbytes(buff, nbytes);
}


/**
 * Read n bytes to a buffer from a given address.
 * @param addr The 24 bit address to read from.
 * @param buff  The array where data will be stored.
 * @param nbytes Number of bytes to be stored. Size of buff must be at least this much.
 */
void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes)
{
    if (buff == NULL)
        return;
    flash_set_read_addr(addr);
    flash_read_nbytes(buff, nbytes);
}


/**
 * Issue the CMD_PAGE_WRITE command and then set the 24 bit address for writing
 * @param addr The 24 bit address
 */
void flash_set_write_addr(uint32_t addr)
{
    spi_write_8bits(CMD_PAGE_WRITE);
    spi_write_24bits(addr);
}


/**
 * Issue the CMD_READ_ARRAY command and then set the 24 bit address for reading
 * @param addr The 24 bit address
 */
void flash_set_read_addr(uint32_t addr)
{
    spi_write_8bits(CMD_READ_ARRAY);
    spi_write_24bits(addr);
}


/**
 * write n bytes to flash. 
 * call flash_set_write_addr() once and then call this function multiple times without any other command in between.
 * The write address is based on either the flash_set_write_addr() or the flash's built in adress counter.
 * If any other command is issued after a flash_write_nbytes() call, have to call flash_set_write_addr() before calling this function again.
 * @param buff pointer of the array where the dta will be stored
 * @param nbytes number of bytes to be read and stored in buff. Size of buff must be at least this much
 */
void flash_write_nbytes(uint8_t *buff, uint16_t nbytes)
{
    if (buff == NULL)
        return;
    uint16_t i = 0;
    while (i < nbytes)
    {
        SPI_WRITE8(buff[i]);    // since fast operation is required, directly calling the macro here
        i++;
    }
}


/**
 * read n bytes from flash. 
 * call flash_set_read_addr() once and then call this function multiple times without any other command in between.
 * The read address is based on either the flash_set_read_addr() or the flash's built in adress counter.
 * If any other command is issued after a flash_read_nbytes() call, have to call flash_set_read_addr() before calling this function again.
 * @param buff pointer of the array where the dta will be stored
 * @param nbytes number of bytes to be read and stored in buff. Size of buff must be at least this much
 */
void flash_read_nbytes(uint8_t *buff, uint16_t nbytes)
{
    if (buff == NULL)
        return;
    uint16_t i = 0;
    while (i < nbytes)
    {
        SPI_READ8(buff[i]); // since fast operation is required, directly calling the macro here
        i++;
    }
}


/**
 * Write data to status register (byte1 or byte2)
 * @param sreg_no Number of status register byte (1 or 2). Any other value than 1 or 2 will make the function return 0
 * @return Returns the status register value (uint8_t)
 */
uint8_t flash_read_sreg(uint8_t sreg_no)
{
    uint8_t sreg_val = 0; 
    if (sreg_no == 1)
        spi_write_8bits(CMD_READ_SREG_BYTE1);
    else if (sreg_no == 2)
        spi_write_8bits(CMD_READ_SREG_BYTE2);
    else
        return 0;

    sreg_val = spi_read_8bits();

    return sreg_val;
}


/**
 * Write status register byte1 and byte2 successively.
 * @param sreg_byte1 Data of status register byte 1
 * @param sreg_byte2 Data of status register byte 2
 */
void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2)
{
    spi_write_8bits(CMD_WRITE_SREG);
    spi_write_8bits(sreg_byte1);
    spi_write_8bits(sreg_byte2);
}


/**
 * Wait while the flash chip is busy
 */
void flash_busy_wait()
{
    while (flash_read_sreg(1) & (1 << SREG_BYTE1_BSY));
}


/**
 * Erase a certain block in the flash
 * @param addr The 24 bits start address of the block to be erased
 * @param cmd_block_erase The command opcode for erasing a specific size of block.
 *                        Possible values are: CMD_4K_BLOCK_ERASE, CMD_32K_BLOCK_ERASE, CMD_64K_BLOCK_ERASE
 */
void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase)
{
    spi_write_8bits(cmd_block_erase);
    spi_write_24bits(addr);
}


/**
 * Write enable the flash chip
 */
void flash_write_enable()
{
    spi_write_8bits(CMD_WRITE_ENABLE);
}

/**
 * Erase the entire flash chip
 */
void flash_erase_chip()
{
    spi_write_8bits(CMD_CHIP_ERASE);
}


