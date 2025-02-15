# 1 "../00-libfiles/lcd.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v2.30\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "../00-libfiles/lcd.c" 2
# 70 "../00-libfiles/lcd.c"
# 1 "C:\\Program Files\\Microchip\\xc8\\v2.30\\pic\\include\\c90\\stdarg.h" 1 3






typedef void * va_list[1];

#pragma intrinsic(__va_start)
extern void * __va_start(void);

#pragma intrinsic(__va_arg)
extern void * __va_arg(void *, ...);
# 71 "../00-libfiles/lcd.c" 2
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
# 72 "../00-libfiles/lcd.c" 2
# 1 "../00-libfiles/lcd.h" 1
# 47 "../00-libfiles/lcd.h"
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
# 48 "../00-libfiles/lcd.h" 2
# 123 "../00-libfiles/lcd.h"
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
# 150 "../00-libfiles/lcd.h"
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
# 73 "../00-libfiles/lcd.c" 2



#pragma warning push
#pragma warning disable 752
#pragma warning disable 1496
#pragma warning disable 520
#pragma warning disable 1498
#pragma warning disable 356





uint8_t v_LcdTrackLineNum_U8;
uint8_t v_LcdTrackCursorPos_U8;
LcdConfig_st LCDConfig;
uint8_t ARR_LcdLineNumAddress_U8[]={0x80,0xc0,0x90,0xd0};
# 99 "../00-libfiles/lcd.c"
static void lcd_DataWrite( uint8_t dat);
static void lcd_BusyCheck(void);
static void lcd_Reset(void);
static void lcd_SendCmdSignals(void);
static void lcd_SendDataSignals(void);
static void lcd_SendHigherNibble(uint8_t dataByte);
static void lcd_SendLowerNibble(uint8_t dataByte);
# 135 "../00-libfiles/lcd.c"
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
               gpioPins_et D7 )
{

    LCDConfig.RS = RS;
    LCDConfig.RW = RW;
    LCDConfig.EN = EN;

    LCDConfig.D0 = D0;
    LCDConfig.D1 = D1;
    LCDConfig.D2 = D2;
    LCDConfig.D3 = D3;
    LCDConfig.D4 = D4;
    LCDConfig.D5 = D5;
    LCDConfig.D6 = D6;
    LCDConfig.D7 = D7;


    if((D0 == P_NC) || (D1 == P_NC) || (D2 == P_NC) || (D3 == P_NC))
    {
        LCDConfig.v_LcdMode_U8 = 4;
    }
    else
    {
        LCDConfig.v_LcdMode_U8 = 8;
        GPIO_PinDirection(D0,0x00u);
        GPIO_PinDirection(D1,0x00u);
        GPIO_PinDirection(D2,0x00u);
        GPIO_PinDirection(D3,0x00u);
    }


    GPIO_PinDirection(RS,0x00u);
    GPIO_PinDirection(RW,0x00u);
    GPIO_PinDirection(EN,0x00u);

    GPIO_PinDirection(D4,0x00u);
    GPIO_PinDirection(D5,0x00u);
    GPIO_PinDirection(D6,0x00u);
    GPIO_PinDirection(D7,0x00u);
}
# 198 "../00-libfiles/lcd.c"
void LCD_Init(uint8_t v_lcdNoOfLines_u8, uint8_t v_MaxCharsPerLine_u8)
{


    LCDConfig.v_MaxSupportedChars_U8 = v_MaxCharsPerLine_u8;
    LCDConfig.v_MaxSupportedLines_U8 = v_lcdNoOfLines_u8;
    if(v_lcdNoOfLines_u8 > 0x02)
    {
        ARR_LcdLineNumAddress_U8[0x02] = 0x90 + (v_MaxCharsPerLine_u8 & 0x0fu);
        ARR_LcdLineNumAddress_U8[0x03] = 0xd0 + (v_MaxCharsPerLine_u8 & 0x0fu);
    }

    DELAY_ms(100);

    if(LCDConfig.v_LcdMode_U8 == 8u)
    {
        LCD_CmdWrite(0x38u);
    }
    else if(LCDConfig.v_LcdMode_U8 == 4u)
    {
        lcd_Reset();
        LCD_CmdWrite(0x28u);
    }

    LCD_CmdWrite(0x0Eu);
    LCD_Clear();
}
# 237 "../00-libfiles/lcd.c"
void LCD_Clear()
{
    LCD_CmdWrite(0x01u);
    LCD_GoToLine(0x00);
}
# 265 "../00-libfiles/lcd.c"
void LCD_GoToLine(uint8_t v_lineNumber_u8)
{
    if(v_lineNumber_u8 < LCDConfig.v_MaxSupportedLines_U8)
    {


        v_LcdTrackCursorPos_U8 = 0x00;
        v_LcdTrackLineNum_U8 = v_lineNumber_u8;
        LCD_CmdWrite(ARR_LcdLineNumAddress_U8[v_lineNumber_u8]);
    }
}
# 292 "../00-libfiles/lcd.c"
void LCD_GoToNextLine(void)
{


    v_LcdTrackLineNum_U8++;
    v_LcdTrackCursorPos_U8 = 0x00;
    if(v_LcdTrackLineNum_U8 >= LCDConfig.v_MaxSupportedLines_U8)
        v_LcdTrackLineNum_U8 = 0x00;
    LCD_CmdWrite(ARR_LcdLineNumAddress_U8[v_LcdTrackLineNum_U8]);
}
# 358 "../00-libfiles/lcd.c"
void LCD_CmdWrite( uint8_t v_lcdCmd_u8)
{
    lcd_BusyCheck();
    if(LCDConfig.v_LcdMode_U8 == 8u)
     {
         lcd_SendLowerNibble(v_lcdCmd_u8);
     }
     else
     {
         lcd_SendHigherNibble(v_lcdCmd_u8);
         lcd_SendCmdSignals();
         v_lcdCmd_u8 = v_lcdCmd_u8 << 4;
     }

     lcd_SendHigherNibble(v_lcdCmd_u8);
     lcd_SendCmdSignals();
}
# 392 "../00-libfiles/lcd.c"
void LCD_DisplayChar(char v_lcdData_u8)
{
    if((v_LcdTrackCursorPos_U8>=LCDConfig.v_MaxSupportedChars_U8) || (v_lcdData_u8=='\n'))
    {


        LCD_GoToNextLine();
    }
    if(v_lcdData_u8!='\n')
    {

        lcd_DataWrite(v_lcdData_u8);
        v_LcdTrackCursorPos_U8++;
    }
}
# 427 "../00-libfiles/lcd.c"
void LCD_DisplayString(const char *ptr_stringPointer_u8)
{
    while((*ptr_stringPointer_u8)!=0)
        LCD_DisplayChar(*ptr_stringPointer_u8++);
}
# 529 "../00-libfiles/lcd.c"
void LCD_DisplayNumber(uint8_t v_numericSystem_u8, uint32_t v_number_u32, uint8_t v_numOfDigitsToDisplay_u8)
{
    uint8_t i=0,a[10];

    if(2u == v_numericSystem_u8)
    {
        while(v_numOfDigitsToDisplay_u8!=0)
        {


          i = (((v_number_u32)&((1<<((v_numOfDigitsToDisplay_u8-1)))))!=0u);
          LCD_DisplayChar(((i)+0x30));
          v_numOfDigitsToDisplay_u8--;
        }
    }
    else if(v_number_u32==0)
    {



            LCD_DisplayChar('0');
    }
    else
    {
        for(i=0;i<v_numOfDigitsToDisplay_u8;i++)
        {


            if(v_number_u32!=0)
            {






                a[i]=(uint32_t)(v_number_u32 - (v_numericSystem_u8 * (uint32_t)(v_number_u32/v_numericSystem_u8)));
                v_number_u32=v_number_u32/v_numericSystem_u8;
            }
            else if( (v_numOfDigitsToDisplay_u8 == 0xffu) ||
                     (v_numOfDigitsToDisplay_u8 > 10u))
            {


                break;
            }
            else
            {



                a[i]=0;
            }
        }

         while(i!=0)
        {

          LCD_DisplayChar((((a[i-1])>0x09) ? ((a[i-1]) + 0x37): ((a[i-1]) + 0x30)));
          i--;
        }
    }
}
# 676 "../00-libfiles/lcd.c"
void LCD_Printf(const char *argList, ...)
{
    const char *ptr;
    va_list argp;
    sint16_t v_num_s16;
    sint32_t v_num_s32;
    uint16_t v_num_u16;
    uint32_t v_num_u32;
    char *str;
    char ch;
    uint8_t v_numOfDigitsToDisp_u8;




    *argp = __va_start();


    for(ptr = argList; *ptr != '\0'; ptr++)
    {

        ch= *ptr;
        if(ch == '%')
        {
            ptr++;
            ch = *ptr;
           if((ch>=0x30) && (ch<=0x39))
            {
               v_numOfDigitsToDisp_u8 = 0;
               while((ch>=0x30) && (ch<=0x39))
                {
                   v_numOfDigitsToDisp_u8 = (v_numOfDigitsToDisp_u8 * 10) + (ch-0x30);
                   ptr++;
                   ch = *ptr;
                }
            }
            else
            {
              v_numOfDigitsToDisp_u8 = 0xffu;
            }


            switch(ch)
            {
            case 'C':
            case 'c':
                ch = (*(int *)__va_arg((*(int **)argp), (int)0));
                LCD_DisplayChar(ch);
                break;

            case 'd':
                v_num_s16 = (*(int *)__va_arg((*(int **)argp), (int)0));
                if(v_num_s16<0)
                 {
                   v_num_s16 = -v_num_s16;
                   LCD_DisplayChar('-');
                 }
                LCD_DisplayNumber(10u,v_num_s16,v_numOfDigitsToDisp_u8);
                break;

            case 'D':
                v_num_s32 = (*(sint32_t *)__va_arg((*(sint32_t **)argp), (sint32_t)0));
                if(v_num_s32<0)
                 {
                   v_num_s32 = -v_num_s32;
                   LCD_DisplayChar('-');
                 }
                LCD_DisplayNumber(10u,v_num_s32,v_numOfDigitsToDisp_u8);
                break;

            case 'u':
                v_num_u16 = (*(int *)__va_arg((*(int **)argp), (int)0));
                LCD_DisplayNumber(10u,v_num_u16,v_numOfDigitsToDisp_u8);
                break;

            case 'U':
                v_num_u32 = (*(uint32_t *)__va_arg((*(uint32_t **)argp), (uint32_t)0));
                LCD_DisplayNumber(10u,v_num_u32,v_numOfDigitsToDisp_u8);
                break;

            case 'x':
                v_num_u16 = (*(int *)__va_arg((*(int **)argp), (int)0));
                LCD_DisplayNumber(16u,v_num_u16,v_numOfDigitsToDisp_u8);
                break;

            case 'X':
                v_num_u32 = (*(uint32_t *)__va_arg((*(uint32_t **)argp), (uint32_t)0));
                LCD_DisplayNumber(16u,v_num_u32,v_numOfDigitsToDisp_u8);
                break;


            case 'b':
                v_num_u16 = (*(int *)__va_arg((*(int **)argp), (int)0));
                if(v_numOfDigitsToDisp_u8 == 0xffu)
                   v_numOfDigitsToDisp_u8 = 16;
                LCD_DisplayNumber(2u,v_num_u16,v_numOfDigitsToDisp_u8);
                break;

            case 'B':
                v_num_u32 = (*(uint32_t *)__va_arg((*(uint32_t **)argp), (uint32_t)0));
                if(v_numOfDigitsToDisp_u8 == 0xffu)
                   v_numOfDigitsToDisp_u8 = 16;
                LCD_DisplayNumber(2u,v_num_u32,v_numOfDigitsToDisp_u8);
                break;


            case 'F':
            case 'f':




                break;


            case 'S':
            case 's':
                str = (*(char * *)__va_arg((*(char * **)argp), (char *)0));
                LCD_DisplayString(str);
                break;

            case '%':
                LCD_DisplayChar('%');
                break;
            }
        }
        else
        {

            LCD_DisplayChar(ch);
        }
    }

                ;
}
# 826 "../00-libfiles/lcd.c"
static void lcd_DataWrite( uint8_t dataByte)
{
    lcd_BusyCheck();
    if(LCDConfig.v_LcdMode_U8 == 8u)
     {
         lcd_SendLowerNibble(dataByte);
     }
     else
     {
         lcd_SendHigherNibble(dataByte);
         lcd_SendDataSignals();
         dataByte = dataByte << 4;
     }

     lcd_SendHigherNibble(dataByte);
     lcd_SendDataSignals();
}
# 860 "../00-libfiles/lcd.c"
static void lcd_BusyCheck(void)
{
    uint8_t busyflag;

  if(LCDConfig.RW != P_NC)
   {
    GPIO_PinDirection(LCDConfig.D7,0x01u);
    GPIO_PinWrite(LCDConfig.RS,0);
    GPIO_PinWrite(LCDConfig.RW,1);
    do
    {

        GPIO_PinWrite(LCDConfig.EN,0);
        DELAY_us(10);
        GPIO_PinWrite(LCDConfig.EN,1);
        DELAY_us(10);
        busyflag = GPIO_PinRead(LCDConfig.D7);


        if(LCDConfig.v_LcdMode_U8 == 4)
        {

            GPIO_PinWrite(LCDConfig.EN,0);
            DELAY_us(10);
            GPIO_PinWrite(LCDConfig.EN,1);
            DELAY_us(10);
        }
    }while(busyflag!=0);

    GPIO_PinDirection(LCDConfig.D7,0x00u);
  }
else
 {


    DELAY_ms(1);
 }
}
# 913 "../00-libfiles/lcd.c"
static void lcd_Reset(void)
{

    lcd_SendHigherNibble(0x30);
    lcd_SendCmdSignals();
    DELAY_ms(100);
    lcd_SendHigherNibble(0x30);
    lcd_SendCmdSignals();
    DELAY_us(200);
    lcd_SendHigherNibble(0x30);
    lcd_SendCmdSignals();
    DELAY_us(200);
    lcd_SendHigherNibble(0x20);
    lcd_SendCmdSignals();
    DELAY_us(200);
}
# 943 "../00-libfiles/lcd.c"
static void lcd_SendHigherNibble(uint8_t dataByte)
{
    GPIO_PinWrite(LCDConfig.D4,(((dataByte)&((1<<(4))))!=0u));
    GPIO_PinWrite(LCDConfig.D5,(((dataByte)&((1<<(5))))!=0u));
    GPIO_PinWrite(LCDConfig.D6,(((dataByte)&((1<<(6))))!=0u));
    GPIO_PinWrite(LCDConfig.D7,(((dataByte)&((1<<(7))))!=0u));
}
# 962 "../00-libfiles/lcd.c"
static void lcd_SendLowerNibble(uint8_t dataByte)
{
    GPIO_PinWrite(LCDConfig.D0,(((dataByte)&((1<<(0))))!=0u));
    GPIO_PinWrite(LCDConfig.D1,(((dataByte)&((1<<(1))))!=0u));
    GPIO_PinWrite(LCDConfig.D2,(((dataByte)&((1<<(2))))!=0u));
    GPIO_PinWrite(LCDConfig.D3,(((dataByte)&((1<<(3))))!=0u));
}
# 981 "../00-libfiles/lcd.c"
static void lcd_SendCmdSignals(void)
{
     GPIO_PinWrite(LCDConfig.RS,0);
     GPIO_PinWrite(LCDConfig.RW,0);
     GPIO_PinWrite(LCDConfig.EN,1);
     DELAY_us(10);
     GPIO_PinWrite(LCDConfig.EN,0);

}
# 1002 "../00-libfiles/lcd.c"
static void lcd_SendDataSignals(void)
{
     GPIO_PinWrite(LCDConfig.RS,1);
     GPIO_PinWrite(LCDConfig.RW,0);
     GPIO_PinWrite(LCDConfig.EN,1);
     DELAY_us(10);
     GPIO_PinWrite(LCDConfig.EN,0);
}


#pragma warning pop
# 1012 "../00-libfiles/lcd.c"

