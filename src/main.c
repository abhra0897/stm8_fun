#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <string.h>
#include "stm8.h"
#include "spi.h"
#include "flash_driver.h"
#include "ws2812_driver.h"

void uart_init();
uint16_t uart_write(const char *str);
void uart_write_8bits(uint8_t d);
void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len);


void main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init();

    uint8_t buff[100] = {0};
    uint8_t buff2[100] = {0};
    for (uint8_t i = 0; i < 100; i++)
    {
        buff[i] = i/* +7+'0' */;
    }

    ws2812_gpio_config();
    spi_config();

    //flash_write_enable();
    //flash_erase_block(0, CMD_4K_BLOCK_ERASE);
    //flash_erase_chip();
    //flash_busy_wait();

    //flash_write_enable();
    //flash_write_to_addr(0x012345, buff, 100);
    //flash_busy_wait();

    uart_write_8bits(0x99); //indicates start

    flash_read_from_addr(0x012345, buff2, 100);

    uint8_t err_cnt = 0;
    char hex_string[2] = {0};


    while(1)
    {
        for(uint8_t ii = 0; ii < 100; ii++)
        {
            //int_to_hex_str(buff2[ii], hex_string, 2);
            uart_write_8bits(buff2[ii]);
            ws2812_send_8bits(buff2[ii]);
            ws2812_send_8bits(buff2[ii]);
            ws2812_send_8bits(buff2[ii]);

            ws2812_send_reset();

            for (uint32_t jj = 0; jj < 32000; jj++);
        }
    }


    //uart_write_8bits(err_cnt);
    while(1);
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


void int_to_hex_str(uint32_t dec, char *hex_str, uint8_t hex_str_len)
{
    uint32_t mask = 15; // LSB 4 bits are 15 (0b.........1111) 
    while(hex_str_len)
    {
        uint8_t masked_dec = (dec & mask);
        hex_str[hex_str_len - 1] = (masked_dec < 10) ? (masked_dec + '0') : (masked_dec + '7');
        
        dec >>= 4;
        hex_str_len--;
    }
}