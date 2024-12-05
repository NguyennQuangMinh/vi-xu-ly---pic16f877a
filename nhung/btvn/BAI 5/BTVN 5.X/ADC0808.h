#include <xc.h>
// Define ADC Channels
#define AN0 0
#define AN1 1
#define AN2 2
#define AN3 3
#define AN4 4
#define AN5 5
#define AN6 6
#define AN7 7#define Add_A PORTCbits.RC0 // Address Pin A
#define Add_B PORTCbits.RC1
#define Add_C PORTCbits.RC2
#define ALE PORTCbits.RC3
#define EOC PORTCbits.RC4
#define OE PORTCbits.RC5
#define START PORTCbits.RC6
#define CLK PORTCbits.RC7
#define Data_Bus PORTB
#define HalfCycleDelay 10
void InitADC(void); // Hàm kh?i t?o ADC
unsigned int ReadADC(unsigned char); //Hàm ??c ADC
