#include "stm8.h"
#include <stdint.h>

#define SPI_PORT                PC
#define SPI_MOSI                PIN6
#define SPI_MISO                PIN7
#define SPI_CLK                 PIN5
#define SPI_CS                  PIN4

// Macros can be directly used instead of the function where fast operation is required
#define SPI_WRITE8(d)           do{ \
                                    SPI_DR = (uint8_t)(d); \
                                    while (!(SPI_SR & SPI_SR_TXE)); /* SPI is busy in communication or Tx buffer is not empty*/\
                                }while(0)

#define SPI_READ8(d)            do{ \
                                    SPI_WRITE8(0xFF);   /*dummy byte to keep the spi clock alive*/ \
                                    while (!(SPI_SR & SPI_SR_RxNE)); \
                                    d = SPI_DR; \
                                }while(0)

/**
 * Configure the SPI bus settings
 */
void flash_spi_config();
/**
 * Configure the GPIO settings
 */
void flash_gpio_config();
/**
 * Wait while SPI is busy
 */
void spi_busy_wait();
/**
 * Write a 24 bit data to SPI
 */
void spi_write_24bits(uint32_t data);
/**
 * Write a 8 bit data to SPI
 */
void spi_write_8bits(uint8_t data);
/**
 * Read 8 bits from SPI
 */
uint8_t spi_read_8bits();