/*  Name     : main.c
 *  Purpose  : Main file for DS1307 RTC interfacing with PIC16F877.
 *  Author   : M.Saeed Yasin
 *  Date     : 15-12-12
 *  Website  : saeedsolutions.blogspot.com
 *  Revision : None
 */
#include"Includes.h"

// Configuration word for PIC16F877
__CONFIG( FOSC_HS & WDTE_OFF & PWRTE_ON & CP_OFF & BOREN_ON 
		& LVP_OFF & CPD_OFF & WRT_ON & DEBUG_OFF);

// Main function
void main(void)
{
	InitLCD();	// Initialize LCD	
	InitI2C();	// Initialize i2c pins											

	// Set initial time
	Set_DS1307_RTC_Time(AM_Time, 8, 32, 59);	// Set time 08:32:59 AM

	// Set initial date
	Set_DS1307_RTC_Date(15, 12, 12, Saturday); 	// Set 15-12-2012 @ Saturday

	while(1)
	{
		// Display RTC time on first line of LCD
		DisplayTimeToLCD(Get_DS1307_RTC_Time());

		// Display RTC date on second line of LCD
		DisplayDateOnLCD(Get_DS1307_RTC_Date());

		__delay_ms(1000);	// 1 second delay
	}
}

