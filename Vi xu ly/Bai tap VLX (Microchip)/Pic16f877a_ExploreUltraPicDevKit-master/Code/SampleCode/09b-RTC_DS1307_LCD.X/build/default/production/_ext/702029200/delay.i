# 1 "../00-libfiles/delay.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v2.30\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "../00-libfiles/delay.c" 2
# 42 "../00-libfiles/delay.c"
# 1 "../00-libfiles/delay.h" 1
# 44 "../00-libfiles/delay.h"
# 1 "../00-libfiles/stdutils.h" 1
# 68 "../00-libfiles/stdutils.h"
typedef signed char sint8_t;
typedef unsigned char uint8_t;

typedef signed int sint16_t;
typedef unsigned int uint16_t;

typedef signed long int sint32_t;
typedef unsigned long int uint32_t;
# 180 "../00-libfiles/stdutils.h"
typedef enum
{
   E_FALSE,
   E_TRUE
}Boolean_et;


typedef enum
{
    E_FAILED,
    E_SUCCESS,
    E_BUSY,
    E_TIMEOUT
}Status_et;


typedef enum
{
 E_BINARY=2,
 E_DECIMAL = 10,
 E_HEX = 16
}NumericSystem_et;
# 302 "../00-libfiles/stdutils.h"
#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config BOREN = OFF
#pragma config LVP = OFF
#pragma config CPD = OFF
#pragma config WRT = OFF
#pragma config CP = OFF
# 45 "../00-libfiles/delay.h" 2
# 67 "../00-libfiles/delay.h"
void DELAY_us(uint16_t us_count);
void DELAY_ms(uint16_t ms_count);
void DELAY_sec(uint16_t var_delaySecCount_u16);
# 43 "../00-libfiles/delay.c" 2
# 56 "../00-libfiles/delay.c"
void DELAY_us(uint16_t us_count)
{
    while (us_count != 0)
    {
        us_count--;
    }
}
# 75 "../00-libfiles/delay.c"
void DELAY_ms(uint16_t ms_count)
{
    while (ms_count != 0)
    {
        DELAY_us(300u);
        ms_count--;
    }
}
# 102 "../00-libfiles/delay.c"
void DELAY_sec(uint16_t sec_count)
{
    while (sec_count != 0) {
        DELAY_ms(1000);
        sec_count--;
    }
}
