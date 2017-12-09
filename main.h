#ifndef MAIN_H
#define MAIN_H

#include "stm32f3xx_hal.h"

#define LED_PIN                                GPIO_PIN_8
#define LED_GPIO_PORT                          GPIOE
#define LED_GPIO_CLK_ENABLE()                  __HAL_RCC_GPIOE_CLK_ENABLE()

#endif // MAIN_H
