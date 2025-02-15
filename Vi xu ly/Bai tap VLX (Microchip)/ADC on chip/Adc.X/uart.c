
#include <xc.h>
#define STX '{'
//#define STX  0x7b
#define ETX  0x7d   // '}'
char commbuffer[10];

void Init_uart(void)
{
    TXSTA=0x20;  // TXEN=1 
    RCSTA=0x90;// SPEN=1 CREN=1
    SPBRG=25;// 9600 16mHZ
    RCIE=1;
}

void Send_data(unsigned int Value)
{
    unsigned char i;
    unsigned int k;
    
	commbuffer[0]='{';
    
	commbuffer[1]=Value/100+0x30; //'1';
    commbuffer[2]='.';
    k=Value%100;
	commbuffer[3]=k/10+0x30;
	commbuffer[4]=k%10+0x30;
	commbuffer[5]='}';//ETX;
    commbuffer[6]='\r';//0x0d;
    
     for(i=0;i<7;i++)
    {
      TXREG=commbuffer[i];
      while(TRMT==0);      
    }
}

/*void Sent_data(char* st)
{
    while(*st)
    {
        TXREG=*st;
       while(TRMT==0); 
       st++;
    }  
}*/