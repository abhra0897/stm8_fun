#include "stm8.h"
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <string.h>
#include "spi.h"
#include "flash_driver.h"

void uart_init();
uint16_t uart_write(const char *str);
void uart_write_8bits(uint8_t d);
void gpio_init();


void main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init();

    uint8_t buff[100] = {0};
    uint8_t buff2[100] = {0};
    for (uint8_t i = 0; i < 100; i++)
    {
        buff[i] = i;
    }

    uart_write("Configuring SPI...\n");
    spi_config();

    uart_write("Prepare to write...\n");
    flash_write_enable();
    flash_erase_block(0, CMD_4K_BLOCK_ERASE);
    flash_busy_wait();
    // while (1)
    // {
    //     uart_write_8bits(48 + (flash_read_sreg(1) & 1));
    //     //flash_read_sreg(1);
    //     //flash_busy_wait();
    // }

    flash_write_enable();
    uart_write("Writing...\n");
    flash_write_to_addr(0, buff, 100);
    flash_busy_wait();
    uart_write("Write complete...\n");

    uart_write("Reading...\n");
    flash_read_from_addr(0, buff2, 100);
    uart_write("Read complete...\n");

    uart_write("Comparing...\n");
    uint8_t err_cnt = 0;
    for(uint8_t ii = 0; ii < 100; ii++)
    {
        uart_write_8bits(buff2[ii]);
        // if (buff[ii] != buff2[ii])
        // {
        //     err_cnt++;
        // }
        
    }
    uart_write("Error count: ");
    //uart_write_8bits(err_cnt);
    
}


void uart_init()
{
    // Setup UART1 (TX=D5)
    UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
    // UART1_CR2 |= UART_CR2_REN; // Receiver enable
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/19200 ~ 833 = 0x0341
    UART1_BRR2 = 0x01; UART1_BRR1 = 0x34; // 0x0341 coded funky way (see page 365 and 336 of ref manual)
}

void gpio_init()
{

}

uint16_t uart_write(const char *str) {
    char i;
    for(i = 0; i < strlen(str); i++) {
        while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = str[i];
    }
    return(i); // Bytes sent
}

void uart_write_8bits(uint8_t d)
{
    while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = d;
}