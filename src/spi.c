#include "spi.h"

/**
 * Configure the SPI bus settings
 */
void flash_spi_config()
{
    // SPI registers: First reset everything
    SPI_CR1 = 0;
    SPI_CR2 = 0;

    // SPI_CR1 LSBFIRST=0 (MSB is transmitted first)
    SPI_CR1 &= ~SPI_CR1_LSBFIRST;
    // Baud Rate Control: 0b111 = fmaster / 256 (62,500 baud)
    SPI_CR1 |= SPI_CR1_BR(0b111);

    // Selecting SPI Mode: 0 (CPOL = 0, CPHA = 0)
    // SPI_CR1 CPOL=0 (Clock Phase, The first clock transition is the first data capture edge)
    SPI_CR1 &= ~SPI_CR1_CPOL;
    // SPI_CR1 CPHA=0 (Clock Polarity, SCK to 0 when idle)
    SPI_CR1 &= ~SPI_CR1_CPHA;

    SPI_CR2 |= SPI_CR2_SSM; // bit 1 SSM=1 Software slave management, enabled
    SPI_CR2 |= SPI_CR2_SSI; // bit 0 SSI=1 Internal slave select, Master mode
    SPI_CR1 |= SPI_CR1_MSTR;  // CR1 bit 2 MSTR = 1, Master configuration.
    SPI_CR1 |= SPI_CR1_SPE; // Enable SPI
}


/**
 * Configure the GPIO settings
 */
void flash_gpio_config()
{
    // SPI port setup: MISO is pullup in, MOSI & SCK are push-pull out
    PORT(SPI_PORT, DDR) |= SPI_CLK | SPI_MOSI; // clock and MOSI
    PORT(SPI_PORT, CR1) |= SPI_CLK | SPI_MOSI | SPI_MISO;

    // CS/SS (PC4) as output
    PORT(SPI_PORT, DDR) |= SPI_CS;
    PORT(SPI_PORT, CR1) |= SPI_CS;
    PORT(SPI_PORT, ODR) |= SPI_CS; // CS high
}


/**
 * Wait while SPI is busy
 */
void spi_busy_wait()
{
    while (SPI_SR & SPI_SR_BSY);
}


/**
 * Write a 24 bit data to SPI
 */
void spi_write_24bits(uint32_t data)
{
    for (int8_t i = 2; i >= 0; i--)
    {
        SPI_WRITE8(0xFF & (data >> (i << 4)));   // Explanation: i<<4 = i*8 = 16, 8, 0 for i = 2, 1, 0 respectively. So, we're shifting data and then sending
    }
}


/**
 * Write a 8 bit data to SPI
 */
void spi_write_8bits(uint8_t data)
{
    SPI_WRITE8(0xFF & data);
}


/**
 * Read 8 bits from SPI
 */
uint8_t spi_read_8bits()
{
    uint8_t d;
    SPI_READ8(d);
    return d;
}