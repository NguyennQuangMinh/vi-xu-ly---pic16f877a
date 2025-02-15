# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v2.30\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2
# 29 "main.c"
# 1 "../00-libfiles\\rtc.h" 1
# 44 "../00-libfiles\\rtc.h"
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
# 45 "../00-libfiles\\rtc.h" 2





typedef struct
{
  uint8_t sec;
  uint8_t min;
  uint8_t hour;
  uint8_t weekDay;
  uint8_t date;
  uint8_t month;
  uint8_t year;
}rtc_t;
# 82 "../00-libfiles\\rtc.h"
void RTC_Init(void);
void RTC_SetDateTime(rtc_t *rtc);
void RTC_GetDateTime(rtc_t *rtc);
# 30 "main.c" 2
# 1 "../00-libfiles\\lcd.h" 1
# 47 "../00-libfiles\\lcd.h"
# 1 "../00-libfiles/gpio.h" 1
# 48 "../00-libfiles/gpio.h"
typedef enum
{
    PA_0,PA_1,PA_2,PA_3,PA_4,PA_5,PA_6,PA_7,
    PB_0,PB_1,PB_2,PB_3,PB_4,PB_5,PB_6,PB_7,
    PC_0,PC_1,PC_2,PC_3,PC_4,PC_5,PC_6,PC_7,
    PD_0,PD_1,PD_2,PD_3,PD_4,PD_5,PD_6,PD_7,
    PE_0,PE_1,PE_2,PE_3,PE_4,PE_5,PE_6,PE_7,
    P_NC = 0xff
}gpioPins_et;
# 66 "../00-libfiles/gpio.h"
void GPIO_PinDirection(gpioPins_et enm_pinNumber, uint8_t var_pinDirn_u8);
void GPIO_PinWrite(gpioPins_et enm_pinNumber, uint8_t var_pinValue_u8);
uint8_t GPIO_PinRead(gpioPins_et enm_pinNumber);
# 48 "../00-libfiles\\lcd.h" 2
# 123 "../00-libfiles\\lcd.h"
typedef struct
{
    uint8_t v_MaxSupportedLines_U8;
    uint8_t v_MaxSupportedChars_U8;
    uint8_t v_LcdMode_U8;
    gpioPins_et RS;
    gpioPins_et RW;
    gpioPins_et EN;
    gpioPins_et D0;
    gpioPins_et D1;
    gpioPins_et D2;
    gpioPins_et D3;
    gpioPins_et D4;
    gpioPins_et D5;
    gpioPins_et D6;
    gpioPins_et D7;
}LcdConfig_st;
# 150 "../00-libfiles\\lcd.h"
void LCD_Init(uint8_t v_lcdNoOfLines_u8, uint8_t v_MaxCharsPerLine_u8);
void LCD_CmdWrite( uint8_t v_lcdCmd_u8);
void LCD_DisplayChar( char v_lcdData_u8);
void LCD_Clear();
void LCD_GoToLine(uint8_t v_lineNumber_u8);
void LCD_GoToNextLine();
void LCD_SetCursor(uint8_t v_lineNumber_u8, uint8_t v_charNumber_u8);
void LCD_DisplayString(const char *ptr_stringPointer_u8);
void LCD_ScrollMessage(uint8_t v_lineNumber_u8, char *ptr_msgPointer_u8);
void LCD_DisplayNumber(uint8_t v_numericSystem_u8, uint32_t v_number_u32, uint8_t v_numOfDigitsToDisplay_u8);
void LCD_DisplayFloatNumber(double v_floatNum_f32);
void LCD_Printf(const char *argList, ...);
void LCD_SetUp(gpioPins_et RS,
               gpioPins_et RW,
               gpioPins_et EN,
               gpioPins_et D0,
               gpioPins_et D1,
               gpioPins_et D2,
               gpioPins_et D3,
               gpioPins_et D4,
               gpioPins_et D5,
               gpioPins_et D6,
               gpioPins_et D7 );
# 31 "main.c" 2


int main()
{
    rtc_t rtc;


    LCD_SetUp(PB_0,PB_1,PB_2,P_NC,P_NC,P_NC,P_NC,PB_4,PB_5,PB_6,PB_7);
    LCD_Init(2,16);

    RTC_Init();
    rtc.hour = 0x10;
    rtc.min = 0x40;
    rtc.sec = 0x00;

    rtc.date = 0x01;
    rtc.month = 0x01;
    rtc.year = 0x16;
    rtc.weekDay = 5;






    RTC_SetDateTime(&rtc);



    while(1)
    {
        RTC_GetDateTime(&rtc);
        LCD_GoToLine(0);
        LCD_Printf("time:%2x:%2x:%2x  \nDate:%2x/%2x/%2x",(uint16_t)rtc.hour,(uint16_t)rtc.min,(uint16_t)rtc.sec,(uint16_t)rtc.date,(uint16_t)rtc.month,(uint16_t)rtc.year);
    }

    return (0);
}
