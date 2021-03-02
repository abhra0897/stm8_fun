#include "stm8.h"
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
// #include "spi.h"
// #include "flash_driver.h"

void uart_init();
void spi_init();
uint16_t uart_write(const char *str);
void gpio_init();


void main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init();

    while(1)
    {
        uart_write("Hello World!\r\n");
        for(uint64_t i = 0; i < 10000; i++);
    }
    
}

void spi_init()
{

}

void uart_init()
{
    // Setup UART1 (TX=D5)
    UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
    // UART1_CR2 |= UART_CR2_REN; // Receiver enable
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see page 365 and 336 of ref manual)
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