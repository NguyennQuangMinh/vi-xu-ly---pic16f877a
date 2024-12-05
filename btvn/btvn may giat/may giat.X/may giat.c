/*
 * File:   may giat.c
 * Author: Nguy?nQuangMinh
 *
 * Created on March 14, 2023, 11:21 AM
 */

#pragma config WDTE = OFF
#define _XTAL_FREQ 20000000

#define RS RD2
#define EN RD3
#define D4 RD4
#define D5 RD5
#define D6 RD6
#define D7 RD7

#define LOCK RA1
#define H_WEIGHT RA2
#define H_WATER RA3
#define L_WATER RA4
#define M_WATER RD0
#define START RA5
#define MOTOR1 RB6
#define MOTOR2 RB7
#define MOTOR_E RB2
#define ALARM RB0
#define SOAP RB1
#define VAN_CAP RB3
#define VAN_XA RB4
#define BOILER RB5

#include <xc.h>
#include "lcd.h"



void motor(void);
void alarm_mode(void);
void washing(void);
void adc(void);
void off(void);


unsigned int adcval;
unsigned int temp;
unsigned char HEAVY,CHIEU,alarm_flag=0;
unsigned int cnt,s1,s2,p;
unsigned char MODE=0;/* 0: Stand by
                    * 1: Cap nuoc
                    * 2: Dun nuoc
                    * 3: Giat
                    * 4: Xa nuoc
                    * 5: Vat
                    * 6: Finish
                    */
                    
void main(void)
{
  TRISB = PORTB = 0;
  TRISD = PORTD = 0b00000001;
  TRISA = 0xff;
  TRISDbits.TRISD0 = 1;
  Lcd_Init();
  OPTION_REG=0b00000111;
  INTCON=0b10100000;
  ADCON0=0b10000001;
  ADCON1=0b10001110;
  __delay_ms(5);
  while(1)
  {
    washing();
  }
}

void __interrupt() isr1() 
{
    
    if (T0IF == 1)
    {
        TMR0 = 60; //10ms
        T0IF = 0; 
        cnt ++;
        if(!alarm_flag){
        switch(MODE)
        {
            case 3:
                if(cnt%10) {p++;
                            if(p==10) p = 0;
                            }   
                if(cnt%100==0){s1++;}
                
                if(cnt%200==0){CHIEU = ~CHIEU;}
                break;
            case 5:
                if(cnt%10) {p++;
                            if(p==10) p = 0;
                            }
                if(cnt%100==0) {s2++;}
                break;
        }}
        
        if(cnt%50==0) {
            if(alarm_flag)
            {ALARM = ~ALARM;} else {ALARM=0;}
        }
        if(cnt == 4000) //40s
        {
            cnt = 0;
        }
    }
}

void washing(void)
{
    switch(MODE) 
    {
        case 0: // Standby
            Lcd_Set_Cursor(1,1);
            Lcd_Write_String("Stand By      ");
            alarm_flag = 0;
            if (!H_WEIGHT) HEAVY = 1; else HEAVY = 0; // Can
            if(!START) {
                Lcd_Clear();
                MODE = 1;}
        break;
        case 6: // Finish
            Lcd_Set_Cursor(1,1);
            Lcd_Write_String("Finish       ");
            alarm_flag = 1;
            off();
            if(LOCK){Lcd_Clear();
                MODE = 0;}
        break;
    }
    
    if(!LOCK)
    {
        if(MODE!=6)alarm_flag = 0;
        switch(MODE)
    {
        case 1: // Cap nuoc
                Lcd_Set_Cursor(1,1);
                Lcd_Write_String("Cap nuoc      ");
                VAN_CAP = 1;
                SOAP = 1;
                if(HEAVY)    
                {if(!H_WATER){
                                    VAN_CAP = 0;
                                    SOAP = 0;
                                    Lcd_Clear();
                                    MODE = 2;
                                }
                }
                else
                {if(!M_WATER){
                                VAN_CAP = 0;
                                SOAP = 0;
                                Lcd_Clear();
                                MODE = 2;
                            }
                }
            break;
        case 2: // Dun nuoc
                Lcd_Set_Cursor(1,1);
                Lcd_Write_String("Heating       ");
                adc();
                if(temp<60)
                {
                    BOILER = 1;
                    adc();
                    Lcd_Set_Cursor(2,1);
                    Lcd_Write_String("Nhiet do:");
                    Lcd_Write_Char(((temp%100)/10)+48);
                    Lcd_Write_Char((temp%10)+48);
                    Lcd_Write_String("/60");
                } else {
                    BOILER = 0;
                    Lcd_Clear();
                    MODE = 3;
                }
            break;
        case 3: // Giat
                Lcd_Set_Cursor(1,1);
                Lcd_Write_String("Washing      ");
                Lcd_Set_Cursor(2,1);
                Lcd_Write_Char((10-s1)/10+48);
                Lcd_Write_Char((10-s1)%10+48);
                if(HEAVY) MOTOR_E = 1; else {
                    if(p<=5) MOTOR_E = 1; else MOTOR_E = 0;
                }
                motor();
                if(s1>10){
                    Lcd_Clear();
                    MODE = 4;
                    s1 = 0;
                    p = 0;
                }
            break;
        case 4: // Xa nuoc
                Lcd_Set_Cursor(1,1);
                Lcd_Write_String("Xa nuoc     ");
                MOTOR_E = 0;
                if (!L_WATER) VAN_XA = 1; else {VAN_XA = 0;
                                                Lcd_Clear();
                                                MODE = 5;}
            break;
        case 5: // Vat
            Lcd_Set_Cursor(1,1);
            Lcd_Write_String("Vat          ");
            Lcd_Set_Cursor(2,1);
            Lcd_Write_Char((10-s2)/10+48);
            Lcd_Write_Char((10-s2)%10+48);
            if(HEAVY) MOTOR_E = 1; else {
                    if(p<=5) MOTOR_E = 1; else MOTOR_E = 0;}
            motor();
            if(s2>10){
                Lcd_Clear();
                MODE = 6;
                s2 = 0;
                p = 0;
            }
            break;
    }        
    } else if(MODE!=0) {
        alarm_mode();}
    
}

void off(void)
{
    MOTOR1 = 0;
    MOTOR2 = 0;
    MOTOR_E = 0;
    SOAP = 0;
    VAN_CAP = 0;
    VAN_XA = 0;
    BOILER = 0;
}

void alarm_mode(void)
{
    Lcd_Set_Cursor(1,1);
    Lcd_Write_String("WARNING !!!!");
    Lcd_Set_Cursor(2,1);
    Lcd_Write_String("            ");
    alarm_flag = 1;
    off();
}

void adc(void)
{
GO_nDONE=1;
while(GO_nDONE);
adcval=((ADRESH<<8)|(ADRESL));
if(adcval>=205){
    temp=(adcval-205)*0.2445;
}
else{
    temp=(205-adcval)*0.2445;
}
}

void motor(void)
{
    MOTOR1 = CHIEU;
    MOTOR2 = ~CHIEU;
}
