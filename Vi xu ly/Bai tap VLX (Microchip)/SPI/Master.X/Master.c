/* 
 * File:   Master.c
 * Author: win 10 pro
 *
 * Created on August 2, 2021, 11:20 AM
 */
#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include "lcd_hd44780_pic16.h" 
#include "ADC0808.h"



#define SS PORTDbits.RD7
#define Tris_SS TRISDbits.TRISD7

#define Input  1
#define Out    0

unsigned int i;
float Dong,Dienap;
unsigned int count, count1,count_s;
unsigned char do_dienap;
float Dong,Dienap;
unsigned char adc_ok;


// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

void timer2_initialize ()  
{
    T2CKPS0=1;
    T2CKPS1=0;
    PR2=100;  //0.1ms
    TOUTPS0=1;
    TOUTPS1=1;
    TOUTPS2=1;
    TOUTPS2=1; //0.1/16
    TMR2ON=1;
    TMR2IE=1; 
    PEIE=1;
    GIE=1;
}
void __interrupt()  Count_Up(void)    //1ms
{
  if (TMR2IE && TMR2IF) 
   {
  TMR2IF=0;
    count++;
       if(count==20)  //20ms
       {
         count=0;
         count1++;
        if(do_dienap)
        {
          Dienap=(float)(ReadADC(AN0));     
          Dienap=Dienap*1.962;
          adc_ok=1;       
        }
         else
         {
         Dong = (float)(ReadADC(AN1));		// Read ADC value from Channel 1 
         Dong=Dong/2.55;
         } 
         do_dienap=~do_dienap;    
       }
  }
}

void SPI_Initialize_Master()
{
     Tris_SS=0; // SS pin should be declared as output
     TRISCbits.TRISC5=0;     
     SSPSTAT = 0b10000000; //bit 7=1  Input data sampled at end of data output time
     SSPCON = 0b00100000; //SSPEN:1
     TRISCbits.TRISC3=0;
     TRISCbits.TRISC4=1;
}

void SPI_Write(char incoming)
{
    
    SSPBUF = incoming; //Write the user given data into buffer
    
}

char SPI_Read() //Read the received data
{
    while ( !SSPSTATbits.BF ); // Hold till BF bit is set, to make sure the complete data is read
    return(SSPBUF); // return the read data
}

int main(int argc, char** argv) {
    unsigned char i_spi;
    char Rx_data[10];
    char Tx_data[10];
     unsigned char Digit[3] = { 0,0,0 };	// To make digits to display on LCD
    unsigned int ADC_Value = 0;	
    
    SPI_Initialize_Master();
     ADCON1 = 0x06;
   LCDInit(LS_NONE);
   InitADC();
   timer2_initialize ();
  //Clear the display
  LCDClear();
  
   LCDWriteString("Do U/I ...");	// Show Welcome Message
    
    __delay_ms(100);
    LCDClear();
    
    Tx_data[0]=0x0A;
    Tx_data[1]=0x0F;
    Tx_data[2]=0x15;
    SS=0;
    while(1)
    {
       
        if(adc_ok&&count1>=50)  //500ms
       {        
         count1=0;
         SPI_Write(Tx_data[i_spi]);
         Rx_data[0]=SPI_Read();
         i_spi++;
         if(i_spi==3) i_spi=0;
         
         ADC_Value=(unsigned int)Dong;
		//Digit[2] = (ADC_Value/100);		  			// Find out first digit
         Digit[2] =  Rx_data[0];		  			// Find out first digit
		Digit[1] =  (ADC_Value%100)/10;
		Digit[0] = (ADC_Value%100)%10;

		//ClearLCDScreen();											// Clear LCD
      LCDGotoXY(1,0);
	LCDWriteString("Gia tri I= ");							// Display string
	LCDData(Digit[2]+0x30);
	LCDData('.');						// Display first digit
	LCDData(Digit[1]+0x30);								// Display second digit
	LCDData(Digit[0]+0x30);								// Display third digit
		
		//lcd_putch(Didit);
        
		ADC_Value=(unsigned int)Dienap;
		Digit[2] = (ADC_Value/100);		  			// Find out first digit
		Digit[1] =  (ADC_Value%100)/10;
		Digit[0] = (ADC_Value%100)%10;

     LCDGotoXY(1,1);
	LCDWriteString("Gia tri U= ");							// Display string
	LCDData(Digit[2]+0x30);
	LCDData('.');						// Display first digit
	LCDData(Digit[1]+0x30);								// Display second digit
	LCDData(Digit[0]+0x30);	
     } 
    }             
    return (EXIT_SUCCESS);
}

