#include <xc.h>
#define LCD_DATA D
#define LCD_DATA_POS 0 
#define LCD_RS_PORT D
#define LCD_RS_POS 4 
#define LCD_RW_PORT D
#define LCD_RW_POS 5 
#define LCD_E_PORT D
#define LCD_E_POS 6 
#define LS_BLINK 0B00000001
#define LS_ULINE 0B00000010
#define LS_NONE 0B00000000
void LCDInit(uint8_t style); 
void LCDWriteString(const char *msg); 
void LCDWriteInt(int val,int8_t field_length); 
void LCDGotoXY(uint8_t x,uint8_t y); 
void LCDByte(uint8_t,uint8_t);
#define LCDCmd(c) (LCDByte(c,0))
#define LCDData(d) (LCDByte(d,1))
void LCDBusyLoop();
#define LCDClear() LCDCmd(0b00000001)
#define LCDHome() LCDCmd(0b00000010)
#define LCDWriteStringXY(x,y,msg) {\
LCDGotoXY(x,y);\
LCDWriteString(msg);\
}
#define LCDWriteIntXY(x,y,val,fl) {\
LCDGotoXY(x,y);\
LCDWriteInt(val,fl);\
}