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
void get_next_color(uint8_t *r, uint8_t *g, uint8_t *b, uint8_t step);

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

	// colour value for calculation
	uint8_t red = 255, green = 0, blue = 0;
    uint8_t r_temp = red, g_temp = green, b_temp = blue;
    uint8_t color_buff[60][3];

    

    while(1)
    {

        for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
        {
            get_next_color(&r_temp, &g_temp, &b_temp, 10);
            color_buff[led_cnt][0] = r_temp;
            color_buff[led_cnt][1] = g_temp;
            color_buff[led_cnt][2] = b_temp;
        }

        for (uint8_t led_cnt = 0; led_cnt < 60; led_cnt++)
        {
            //get_next_color(&r_temp, &g_temp, &b_temp, 30);        
            ws2812_send_pixel_24bits(color_buff[led_cnt][0], color_buff[led_cnt][1], color_buff[led_cnt][2]);
            //ws2812_send_pixel_24bits(r_temp, g_temp, b_temp);
            
        }
        ws2812_send_latch();
        get_next_color(&red, &green, &blue, 20);
        r_temp = red, g_temp = green, b_temp = blue;

        for (uint32_t jj = 0; jj < 10000; jj++);
    
    }


    //uart_write_8bits(err_cnt);
    while(1);
}

void get_next_color(uint8_t *r, uint8_t *g, uint8_t *b, uint8_t step)
{
    while (step--)
    {
        if (*r == 255 && *b == 0 && *g < 255)
            (*g) += 1;
        else if ( *g == 255 && *b == 0 && *r > 0)
            (*r) -= 1;
        else if (*r == 0 && *g == 255 && *b < 255)
            (*b) += 1;
        else if (*r == 0 && *b == 255 && *g > 0)
            (*g) -= 1;
        else if (*g == 0 && *b == 255 && *r < 255)
            (*r) += 1;
        else if (*r == 255 && *g == 0 && *b > 0)
            (*b) -= 1;
    }
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