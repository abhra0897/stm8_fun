#ifndef _WS2812_DRIVER_H
#define _WS2812_DRIVER_H

#include "stm8.h"
#include <stdint.h>


#define STR(x) #x
#define XSTR(s) STR(s)

#define WS2812_PORT                 PD
#define WS2812_PIN_POS              2
#define WS2812_ODR_ADDR             0x500F /*0x500A works as PC 4*/  /* For PB_ODR. If port is changed, change it accordingly*/


void ws2812_gpio_config();
void ws2812_send_8bits(uint8_t d);
void ws2812_send_reset();


#endif