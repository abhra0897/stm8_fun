#include <stdint.h>
#include "spi.h"


#define ERASE_BLOCK_4K          1
#define ERASE_BLOCK_32K         2
#define ERASE_BLOCK_64K         3

#define MEM_START_ADDRESS       0x000000
#define MEM_END_ADDRESS         0x07FFFF

#define CMD_READ_ARRAY          0x03
#define CMD_4K_BLOCK_ERASE      0x20
#define CMD_32K_BLOCK_ERASE     0x52
#define CMD_64K_BLOCK_ERASE     0xD8
#define CMD_CHIP_ERASE          0x60
#define CMD_PAGE_WRITE          0x02
#define CMD_WRITE_ENABLE        0x06
#define CMD_WRITE_DISABLE       0x06
#define CMD_READ_SREG_BYTE1     0x05
#define CMD_READ_SREG_BYTE2     0x35
#define CMD_WRITE_SREG          0x01
#define CMD_WR_EN_VLTL_SREG     0x50
#define CMD_READ_DEVICE_ID      0x9F
#define CMD_READ_ID             0x90
#define CMD_DEEP_PWR_DOWN       0xB9
#define CMD_RESUME_FRM_DPD      0xAB

#define SREG_BYTE1_SRP0         7
#define SREG_BYTE1_SEC          6
#define SREG_BYTE1_TB           5
#define SREG_BYTE1_BP2          4
#define SREG_BYTE1_BP1          3
#define SREG_BYTE1_BP0          2
#define SREG_BYTE1_WEL          1
#define SREG_BYTE1_BSY          0

#define SREG_BYTE2_CMP          6
#define SREG_BYTE2_LB3          5
#define SREG_BYTE2_LB2          4
#define SREG_BYTE2_LB1          3
#define SREG_BYTE2_QE           1
#define SREG_BYTE2_SRP1         0


/**
 * Write n bytes from a buffer to a given address.
 * @param addr The 24 bit address to write to.
 * @param buff  The array from where data will be written.
 * @param nbytes Number of bytes to be written. Size of buff must be at least this much.
 */
void flash_write_to_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes);
/**
 * Read n bytes to a buffer from a given address.
 * @param addr The 24 bit address to read from.
 * @param buff  The array where data will be stored.
 * @param nbytes Number of bytes to be stored. Size of buff must be at least this much.
 */
void flash_read_from_addr(uint32_t addr, uint8_t *buff, uint16_t nbytes);
/**
 * Issue the CMD_PAGE_WRITE command and then set the 24 bit address for writing
 * @param addr The 24 bit address
 */
void flash_set_write_addr(uint32_t addr);
/**
 * Issue the CMD_READ_ARRAY command and then set the 24 bit address for reading
 * @param addr The 24 bit address
 */
void flash_set_read_addr(uint32_t addr);
/**
 * write n bytes to flash. 
 * call flash_set_write_addr() once and then call this function multiple times without any other command in between.
 * The write address is based on either the flash_set_write_addr() or the flash's built in adress counter.
 * If any other command is issued after a flash_write_nbytes() call, have to call flash_set_write_addr() before calling this function again.
 * @param buff pointer of the array where the dta will be stored
 * @param nbytes number of bytes to be read and stored in buff. Size of buff must be at least this much
 */
void flash_write_nbytes(uint8_t *buff, uint16_t nbytes);
/**
 * read n bytes from flash. 
 * call flash_set_read_addr() once and then call this function multiple times without any other command in between.
 * The read address is based on either the flash_set_read_addr() or the flash's built in adress counter.
 * If any other command is issued after a flash_read_nbytes() call, have to call flash_set_read_addr() before calling this function again.
 * @param buff pointer of the array where the dta will be stored
 * @param nbytes number of bytes to be read and stored in buff. Size of buff must be at least this much
 */
void flash_read_nbytes(uint8_t *buff, uint16_t nbytes);
/**
 * Write data to status register (byte1 or byte2)
 * @param sreg_no Number of status register byte (1 or 2). Any other value than 1 or 2 will make the function return 0
 * @return Returns the status register value (uint8_t)
 */
uint8_t flash_read_sreg(uint8_t sreg_no);
/**
 * Write status register byte1 and byte2 successively.
 * @param sreg_byte1 Data of status register byte 1
 * @param sreg_byte2 Data of status register byte 2
 */
void flash_write_sreg(uint8_t sreg_byte1, uint8_t sreg_byte2);
/**
 * Wait while the flash chip is busy
 */
void flash_busy_wait();
/**
 * Erase a certain block in the flash
 * @param addr The 24 bits start address of the block to be erased
 * @param cmd_block_erase The command opcode for erasing a specific size of block.
 *                        Possible values are: CMD_4K_BLOCK_ERASE, CMD_32K_BLOCK_ERASE, CMD_64K_BLOCK_ERASE
 */
void flash_erase_block(uint32_t addr, uint8_t cmd_block_erase);
/**
 * Erase the entire flash chip
 */
void flash_erase_chip();
/**
 * Write enable the flash chip
 */
void flash_write_enable();