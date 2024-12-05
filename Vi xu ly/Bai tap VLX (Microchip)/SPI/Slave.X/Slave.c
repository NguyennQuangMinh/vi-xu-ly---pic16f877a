/* 
 * File:   Slave.c
 * Author: win 10 pro
 *
 * Created on August 2, 2021, 11:22 AM
 */
#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

void SPI_Initialize_Slave()
{
     
     
     TRISCbits.TRISC5=0; // SDO pin should be declared as output
     TRISCbits.TRISC4=1; // SDI pin should be declared as input
     SSPSTAT = 0b00000000; //pg 74/234
     SSPCON = 0b00100000; //pg 75/234
     TRISCbits.TRISC3 = 1; //Set as in in for master mode
}

unsigned char SPI_Ready2Read()
{
    if (SSPSTAT & 0b00000001)
        return 1;
    else
        return 0;
}
void SPI_Write(char incoming)
{
    SSPBUF = incoming; //Write the user given data into buffer
}

int main(int argc, char** argv) {
    unsigned char i;
    char Rx_data[10];
    char Tx_data[10];
    
    SPI_Initialize_Slave();
    Tx_data[0]=0xaa;
    Tx_data[1]=0x11;
    Tx_data[2]=0x22;
    while(1)
    {
        if (SPI_Ready2Read())
        {
           Rx_data[i]= SSPBUF;
           SPI_Write(Tx_data[i]);
        if(i++==3) i=0;
        }   
    }
    return (EXIT_SUCCESS);
}

