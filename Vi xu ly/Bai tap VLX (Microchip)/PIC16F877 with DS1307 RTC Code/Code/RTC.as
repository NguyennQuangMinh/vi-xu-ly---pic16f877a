opt subtitle "HI-TECH Software Omniscient Code Generator (PRO mode) build 10920"

opt pagewidth 120

	opt pm

	processor	16F877
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 11 "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\Main.c"
	psect config,class=CONFIG,delta=2 ;#
# 11 "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\Main.c"
	dw 0xFFFE & 0xFFFB & 0xFFF7 & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_InitLCD
	FNCALL	_main,_InitI2C
	FNCALL	_main,_Set_DS1307_RTC_Time
	FNCALL	_main,_Set_DS1307_RTC_Date
	FNCALL	_main,_Get_DS1307_RTC_Time
	FNCALL	_main,_DisplayTimeToLCD
	FNCALL	_main,_Get_DS1307_RTC_Date
	FNCALL	_main,_DisplayDateOnLCD
	FNCALL	_DisplayDateOnLCD,_WriteCommandToLCD
	FNCALL	_DisplayDateOnLCD,___lbdiv
	FNCALL	_DisplayDateOnLCD,_WriteDataToLCD
	FNCALL	_DisplayDateOnLCD,___lbmod
	FNCALL	_DisplayDateOnLCD,_WriteStringToLCD
	FNCALL	_DisplayTimeToLCD,_ClearLCDScreen
	FNCALL	_DisplayTimeToLCD,___lbdiv
	FNCALL	_DisplayTimeToLCD,_WriteDataToLCD
	FNCALL	_DisplayTimeToLCD,___lbmod
	FNCALL	_DisplayTimeToLCD,_WriteStringToLCD
	FNCALL	_ClearLCDScreen,_WriteCommandToLCD
	FNCALL	_WriteStringToLCD,_WriteDataToLCD
	FNCALL	_InitLCD,_ToggleEpinOfLCD
	FNCALL	_InitLCD,_WriteCommandToLCD
	FNCALL	_WriteDataToLCD,_ToggleEpinOfLCD
	FNCALL	_WriteCommandToLCD,_ToggleEpinOfLCD
	FNCALL	_Get_DS1307_RTC_Date,_Read_Bytes_From_DS1307_RTC
	FNCALL	_Get_DS1307_RTC_Date,___bmul
	FNCALL	_Set_DS1307_RTC_Date,___lbmod
	FNCALL	_Set_DS1307_RTC_Date,___lbdiv
	FNCALL	_Set_DS1307_RTC_Date,_Write_Bytes_To_DS1307_RTC
	FNCALL	_Get_DS1307_RTC_Time,_Read_Bytes_From_DS1307_RTC
	FNCALL	_Get_DS1307_RTC_Time,___bmul
	FNCALL	_Set_DS1307_RTC_Time,___lbmod
	FNCALL	_Set_DS1307_RTC_Time,___lbdiv
	FNCALL	_Set_DS1307_RTC_Time,_Write_Bytes_To_DS1307_RTC
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Start
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Write_Byte
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_ReStart
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Read_Byte
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Send_ACK
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Send_NACK
	FNCALL	_Read_Bytes_From_DS1307_RTC,_I2C_Stop
	FNCALL	_Write_Bytes_To_DS1307_RTC,_I2C_Start
	FNCALL	_Write_Bytes_To_DS1307_RTC,_I2C_Write_Byte
	FNCALL	_Write_Bytes_To_DS1307_RTC,_I2C_Stop
	FNROOT	_main
	global	_Temp
	global	_pRTCArray
	global	_PORTB
psect	text565,local,class=CODE,delta=2
global __ptext565
__ptext565:
_PORTB	set	6
	global	_SSPBUF
_SSPBUF	set	19
	global	_SSPCON
_SSPCON	set	20
	global	_RB0
_RB0	set	48
	global	_RB1
_RB1	set	49
	global	_RB4
_RB4	set	52
	global	_RB5
_RB5	set	53
	global	_RB6
_RB6	set	54
	global	_RB7
_RB7	set	55
	global	_SSPIF
_SSPIF	set	99
	global	_SSPADD
_SSPADD	set	147
	global	_SSPSTAT
_SSPSTAT	set	148
	global	_ACKDT
_ACKDT	set	1165
	global	_ACKEN
_ACKEN	set	1164
	global	_ACKSTAT
_ACKSTAT	set	1166
	global	_PEN
_PEN	set	1162
	global	_RCEN
_RCEN	set	1163
	global	_RSEN
_RSEN	set	1161
	global	_SEN
_SEN	set	1160
	global	_TRISB0
_TRISB0	set	1072
	global	_TRISB1
_TRISB1	set	1073
	global	_TRISB4
_TRISB4	set	1076
	global	_TRISB5
_TRISB5	set	1077
	global	_TRISB6
_TRISB6	set	1078
	global	_TRISB7
_TRISB7	set	1079
	global	_TRISC3
_TRISC3	set	1083
	global	_TRISC4
_TRISC4	set	1084
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	
STR_10:	
	retlw	63	;'?'
	retlw	63	;'?'
	retlw	63	;'?'
	retlw	0
psect	strings
	
STR_5:	
	retlw	87	;'W'
	retlw	69	;'E'
	retlw	68	;'D'
	retlw	0
psect	strings
	
STR_4:	
	retlw	84	;'T'
	retlw	85	;'U'
	retlw	69	;'E'
	retlw	0
psect	strings
	
STR_7:	
	retlw	70	;'F'
	retlw	82	;'R'
	retlw	73	;'I'
	retlw	0
psect	strings
	
STR_3:	
	retlw	77	;'M'
	retlw	79	;'O'
	retlw	78	;'N'
	retlw	0
psect	strings
	
STR_9:	
	retlw	83	;'S'
	retlw	85	;'U'
	retlw	78	;'N'
	retlw	0
psect	strings
	
STR_8:	
	retlw	83	;'S'
	retlw	65	;'A'
	retlw	84	;'T'
	retlw	0
psect	strings
	
STR_6:	
	retlw	84	;'T'
	retlw	72	;'H'
	retlw	85	;'U'
	retlw	0
psect	strings
	
STR_1:	
	retlw	65	;'A'
	retlw	77	;'M'
	retlw	0
psect	strings
	
STR_2:	
	retlw	80	;'P'
	retlw	77	;'M'
	retlw	0
psect	strings
	file	"RTC.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_Temp:
       ds      1

_pRTCArray:
       ds      4

; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
	clrf	((__pbssBANK0)+2)&07Fh
	clrf	((__pbssBANK0)+3)&07Fh
	clrf	((__pbssBANK0)+4)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_I2C_Start
?_I2C_Start:	; 0 bytes @ 0x0
	global	??_I2C_Start
??_I2C_Start:	; 0 bytes @ 0x0
	global	?_I2C_Write_Byte
?_I2C_Write_Byte:	; 1 bit 
	global	??_I2C_Write_Byte
??_I2C_Write_Byte:	; 0 bytes @ 0x0
	global	?_I2C_Stop
?_I2C_Stop:	; 0 bytes @ 0x0
	global	??_I2C_Stop
??_I2C_Stop:	; 0 bytes @ 0x0
	global	?_I2C_ReStart
?_I2C_ReStart:	; 0 bytes @ 0x0
	global	??_I2C_ReStart
??_I2C_ReStart:	; 0 bytes @ 0x0
	global	??_I2C_Read_Byte
??_I2C_Read_Byte:	; 0 bytes @ 0x0
	global	?_I2C_Send_NACK
?_I2C_Send_NACK:	; 0 bytes @ 0x0
	global	??_I2C_Send_NACK
??_I2C_Send_NACK:	; 0 bytes @ 0x0
	global	?_I2C_Send_ACK
?_I2C_Send_ACK:	; 0 bytes @ 0x0
	global	??_I2C_Send_ACK
??_I2C_Send_ACK:	; 0 bytes @ 0x0
	global	?_InitI2C
?_InitI2C:	; 0 bytes @ 0x0
	global	??_InitI2C
??_InitI2C:	; 0 bytes @ 0x0
	global	?_ToggleEpinOfLCD
?_ToggleEpinOfLCD:	; 0 bytes @ 0x0
	global	??_ToggleEpinOfLCD
??_ToggleEpinOfLCD:	; 0 bytes @ 0x0
	global	?_WriteCommandToLCD
?_WriteCommandToLCD:	; 0 bytes @ 0x0
	global	?_WriteDataToLCD
?_WriteDataToLCD:	; 0 bytes @ 0x0
	global	?_InitLCD
?_InitLCD:	; 0 bytes @ 0x0
	global	?_WriteStringToLCD
?_WriteStringToLCD:	; 0 bytes @ 0x0
	global	?_ClearLCDScreen
?_ClearLCDScreen:	; 0 bytes @ 0x0
	global	?_DisplayTimeToLCD
?_DisplayTimeToLCD:	; 0 bytes @ 0x0
	global	?_DisplayDateOnLCD
?_DisplayDateOnLCD:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_I2C_Read_Byte
?_I2C_Read_Byte:	; 1 bytes @ 0x0
	global	?_Get_DS1307_RTC_Time
?_Get_DS1307_RTC_Time:	; 1 bytes @ 0x0
	global	?_Get_DS1307_RTC_Date
?_Get_DS1307_RTC_Date:	; 1 bytes @ 0x0
	global	?___bmul
?___bmul:	; 1 bytes @ 0x0
	global	?___lbdiv
?___lbdiv:	; 1 bytes @ 0x0
	global	?___lbmod
?___lbmod:	; 1 bytes @ 0x0
	global	I2C_Write_Byte@Byte
I2C_Write_Byte@Byte:	; 1 bytes @ 0x0
	global	___bmul@multiplicand
___bmul@multiplicand:	; 1 bytes @ 0x0
	global	___lbdiv@divisor
___lbdiv@divisor:	; 1 bytes @ 0x0
	global	___lbmod@divisor
___lbmod@divisor:	; 1 bytes @ 0x0
	ds	1
	global	?_Write_Bytes_To_DS1307_RTC
?_Write_Bytes_To_DS1307_RTC:	; 0 bytes @ 0x1
	global	?_Read_Bytes_From_DS1307_RTC
?_Read_Bytes_From_DS1307_RTC:	; 0 bytes @ 0x1
	global	??___bmul
??___bmul:	; 0 bytes @ 0x1
	global	??___lbdiv
??___lbdiv:	; 0 bytes @ 0x1
	global	??___lbmod
??___lbmod:	; 0 bytes @ 0x1
	global	Write_Bytes_To_DS1307_RTC@pData
Write_Bytes_To_DS1307_RTC@pData:	; 1 bytes @ 0x1
	global	Read_Bytes_From_DS1307_RTC@pData
Read_Bytes_From_DS1307_RTC@pData:	; 1 bytes @ 0x1
	global	___bmul@product
___bmul@product:	; 1 bytes @ 0x1
	global	___lbdiv@dividend
___lbdiv@dividend:	; 1 bytes @ 0x1
	ds	1
	global	??_WriteCommandToLCD
??_WriteCommandToLCD:	; 0 bytes @ 0x2
	global	??_WriteDataToLCD
??_WriteDataToLCD:	; 0 bytes @ 0x2
	global	Write_Bytes_To_DS1307_RTC@NoOfBytes
Write_Bytes_To_DS1307_RTC@NoOfBytes:	; 1 bytes @ 0x2
	global	WriteCommandToLCD@Command
WriteCommandToLCD@Command:	; 1 bytes @ 0x2
	global	WriteDataToLCD@LCDChar
WriteDataToLCD@LCDChar:	; 1 bytes @ 0x2
	global	___bmul@multiplier
___bmul@multiplier:	; 1 bytes @ 0x2
	global	___lbdiv@counter
___lbdiv@counter:	; 1 bytes @ 0x2
	global	___lbmod@dividend
___lbmod@dividend:	; 1 bytes @ 0x2
	global	Read_Bytes_From_DS1307_RTC@NoOfBytes
Read_Bytes_From_DS1307_RTC@NoOfBytes:	; 2 bytes @ 0x2
	ds	1
	global	??_Write_Bytes_To_DS1307_RTC
??_Write_Bytes_To_DS1307_RTC:	; 0 bytes @ 0x3
	global	??_InitLCD
??_InitLCD:	; 0 bytes @ 0x3
	global	??_WriteStringToLCD
??_WriteStringToLCD:	; 0 bytes @ 0x3
	global	??_ClearLCDScreen
??_ClearLCDScreen:	; 0 bytes @ 0x3
	global	WriteStringToLCD@s
WriteStringToLCD@s:	; 1 bytes @ 0x3
	global	___lbdiv@quotient
___lbdiv@quotient:	; 1 bytes @ 0x3
	global	___lbmod@counter
___lbmod@counter:	; 1 bytes @ 0x3
	ds	1
	global	??_Read_Bytes_From_DS1307_RTC
??_Read_Bytes_From_DS1307_RTC:	; 0 bytes @ 0x4
	global	___lbmod@rem
___lbmod@rem:	; 1 bytes @ 0x4
	ds	1
	global	??_DisplayTimeToLCD
??_DisplayTimeToLCD:	; 0 bytes @ 0x5
	global	??_DisplayDateOnLCD
??_DisplayDateOnLCD:	; 0 bytes @ 0x5
	global	Write_Bytes_To_DS1307_RTC@Address
Write_Bytes_To_DS1307_RTC@Address:	; 1 bytes @ 0x5
	global	Read_Bytes_From_DS1307_RTC@Address
Read_Bytes_From_DS1307_RTC@Address:	; 1 bytes @ 0x5
	global	DisplayTimeToLCD@pTimeArray
DisplayTimeToLCD@pTimeArray:	; 1 bytes @ 0x5
	global	DisplayDateOnLCD@pDateArray
DisplayDateOnLCD@pDateArray:	; 1 bytes @ 0x5
	ds	1
	global	Write_Bytes_To_DS1307_RTC@i
Write_Bytes_To_DS1307_RTC@i:	; 2 bytes @ 0x6
	global	Read_Bytes_From_DS1307_RTC@i
Read_Bytes_From_DS1307_RTC@i:	; 2 bytes @ 0x6
	ds	2
	global	?_Set_DS1307_RTC_Time
?_Set_DS1307_RTC_Time:	; 0 bytes @ 0x8
	global	??_Get_DS1307_RTC_Time
??_Get_DS1307_RTC_Time:	; 0 bytes @ 0x8
	global	?_Set_DS1307_RTC_Date
?_Set_DS1307_RTC_Date:	; 0 bytes @ 0x8
	global	??_Get_DS1307_RTC_Date
??_Get_DS1307_RTC_Date:	; 0 bytes @ 0x8
	global	Set_DS1307_RTC_Time@Hours
Set_DS1307_RTC_Time@Hours:	; 1 bytes @ 0x8
	global	Set_DS1307_RTC_Date@Month
Set_DS1307_RTC_Date@Month:	; 1 bytes @ 0x8
	ds	1
	global	Set_DS1307_RTC_Time@Mins
Set_DS1307_RTC_Time@Mins:	; 1 bytes @ 0x9
	global	Set_DS1307_RTC_Date@Year
Set_DS1307_RTC_Date@Year:	; 1 bytes @ 0x9
	ds	1
	global	Set_DS1307_RTC_Time@Secs
Set_DS1307_RTC_Time@Secs:	; 1 bytes @ 0xA
	global	Set_DS1307_RTC_Date@Day
Set_DS1307_RTC_Date@Day:	; 1 bytes @ 0xA
	ds	1
	global	??_Set_DS1307_RTC_Time
??_Set_DS1307_RTC_Time:	; 0 bytes @ 0xB
	global	??_Set_DS1307_RTC_Date
??_Set_DS1307_RTC_Date:	; 0 bytes @ 0xB
	ds	2
	global	Set_DS1307_RTC_Time@Mode
Set_DS1307_RTC_Time@Mode:	; 1 bytes @ 0xD
	global	Set_DS1307_RTC_Date@Date
Set_DS1307_RTC_Date@Date:	; 1 bytes @ 0xD
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_main
??_main:	; 0 bytes @ 0x0
	ds	3
;;Data sizes: Strings 38, constant 0, data 0, bss 5, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     14      14
;; BANK0           80      3       8
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; ?_Get_DS1307_RTC_Date	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; ?_Get_DS1307_RTC_Time	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; DisplayDateOnLCD@pDateArray	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; DisplayTimeToLCD@pTimeArray	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; WriteStringToLCD@s	PTR const unsigned char  size(1) Largest target is 4
;;		 -> STR_10(CODE[4]), STR_9(CODE[4]), STR_8(CODE[4]), STR_7(CODE[4]), 
;;		 -> STR_6(CODE[4]), STR_5(CODE[4]), STR_4(CODE[4]), STR_3(CODE[4]), 
;;		 -> STR_2(CODE[3]), STR_1(CODE[3]), 
;;
;; sp__Get_DS1307_RTC_Date	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; sp__Get_DS1307_RTC_Time	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; Read_Bytes_From_DS1307_RTC@pData	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;
;; Write_Bytes_To_DS1307_RTC@pData	PTR unsigned char  size(1) Largest target is 4
;;		 -> pRTCArray(BANK0[4]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_Set_DS1307_RTC_Time
;;   _main->_Set_DS1307_RTC_Date
;;   _DisplayDateOnLCD->___lbmod
;;   _DisplayTimeToLCD->_ClearLCDScreen
;;   _DisplayTimeToLCD->___lbmod
;;   _ClearLCDScreen->_WriteCommandToLCD
;;   _WriteStringToLCD->_WriteDataToLCD
;;   _InitLCD->_WriteCommandToLCD
;;   _WriteDataToLCD->_ToggleEpinOfLCD
;;   _WriteCommandToLCD->_ToggleEpinOfLCD
;;   _Get_DS1307_RTC_Date->_Read_Bytes_From_DS1307_RTC
;;   _Set_DS1307_RTC_Date->_Write_Bytes_To_DS1307_RTC
;;   _Get_DS1307_RTC_Time->_Read_Bytes_From_DS1307_RTC
;;   _Set_DS1307_RTC_Time->_Write_Bytes_To_DS1307_RTC
;;   _Read_Bytes_From_DS1307_RTC->_I2C_Write_Byte
;;   _Write_Bytes_To_DS1307_RTC->_I2C_Write_Byte
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 3, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 3     3      0    3084
;;                                              0 BANK0      3     3      0
;;                            _InitLCD
;;                            _InitI2C
;;                _Set_DS1307_RTC_Time
;;                _Set_DS1307_RTC_Date
;;                _Get_DS1307_RTC_Time
;;                   _DisplayTimeToLCD
;;                _Get_DS1307_RTC_Date
;;                   _DisplayDateOnLCD
;; ---------------------------------------------------------------------------------
;; (1) _DisplayDateOnLCD                                     1     1      0     652
;;                                              5 COMMON     1     1      0
;;                  _WriteCommandToLCD
;;                            ___lbdiv
;;                     _WriteDataToLCD
;;                            ___lbmod
;;                   _WriteStringToLCD
;; ---------------------------------------------------------------------------------
;; (1) _DisplayTimeToLCD                                     1     1      0     652
;;                                              5 COMMON     1     1      0
;;                     _ClearLCDScreen
;;                            ___lbdiv
;;                     _WriteDataToLCD
;;                            ___lbmod
;;                   _WriteStringToLCD
;; ---------------------------------------------------------------------------------
;; (2) _ClearLCDScreen                                       2     2      0      44
;;                                              3 COMMON     2     2      0
;;                  _WriteCommandToLCD
;; ---------------------------------------------------------------------------------
;; (2) _WriteStringToLCD                                     1     1      0      89
;;                                              3 COMMON     1     1      0
;;                     _WriteDataToLCD
;; ---------------------------------------------------------------------------------
;; (1) _InitLCD                                              3     3      0      44
;;                                              3 COMMON     3     3      0
;;                    _ToggleEpinOfLCD
;;                  _WriteCommandToLCD
;; ---------------------------------------------------------------------------------
;; (3) _WriteDataToLCD                                       1     1      0      44
;;                                              2 COMMON     1     1      0
;;                    _ToggleEpinOfLCD
;; ---------------------------------------------------------------------------------
;; (2) _WriteCommandToLCD                                    1     1      0      44
;;                                              2 COMMON     1     1      0
;;                    _ToggleEpinOfLCD
;; ---------------------------------------------------------------------------------
;; (1) _Get_DS1307_RTC_Date                                  1     1      0     248
;;                                              8 COMMON     1     1      0
;;         _Read_Bytes_From_DS1307_RTC
;;                             ___bmul
;; ---------------------------------------------------------------------------------
;; (1) _Set_DS1307_RTC_Date                                  6     3      3     631
;;                                              8 COMMON     6     3      3
;;                            ___lbmod
;;                            ___lbdiv
;;          _Write_Bytes_To_DS1307_RTC
;; ---------------------------------------------------------------------------------
;; (1) _Get_DS1307_RTC_Time                                  1     1      0     248
;;                                              8 COMMON     1     1      0
;;         _Read_Bytes_From_DS1307_RTC
;;                             ___bmul
;; ---------------------------------------------------------------------------------
;; (1) _Set_DS1307_RTC_Time                                  6     3      3     609
;;                                              8 COMMON     6     3      3
;;                            ___lbmod
;;                            ___lbdiv
;;          _Write_Bytes_To_DS1307_RTC
;; ---------------------------------------------------------------------------------
;; (4) _ToggleEpinOfLCD                                      2     2      0       0
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; (2) _Read_Bytes_From_DS1307_RTC                           7     4      3     156
;;                                              1 COMMON     7     4      3
;;                          _I2C_Start
;;                     _I2C_Write_Byte
;;                        _I2C_ReStart
;;                      _I2C_Read_Byte
;;                       _I2C_Send_ACK
;;                      _I2C_Send_NACK
;;                           _I2C_Stop
;; ---------------------------------------------------------------------------------
;; (2) _Write_Bytes_To_DS1307_RTC                            7     5      2     134
;;                                              1 COMMON     7     5      2
;;                          _I2C_Start
;;                     _I2C_Write_Byte
;;                           _I2C_Stop
;; ---------------------------------------------------------------------------------
;; (2) ___lbmod                                              5     4      1     159
;;                                              0 COMMON     5     4      1
;; ---------------------------------------------------------------------------------
;; (2) ___lbdiv                                              4     3      1     162
;;                                              0 COMMON     4     3      1
;; ---------------------------------------------------------------------------------
;; (2) ___bmul                                               3     2      1      92
;;                                              0 COMMON     3     2      1
;; ---------------------------------------------------------------------------------
;; (1) _InitI2C                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Send_ACK                                         0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Send_NACK                                        0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Read_Byte                                        0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_ReStart                                          0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Stop                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Write_Byte                                       1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (3) _I2C_Start                                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 4
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _InitLCD
;;     _ToggleEpinOfLCD
;;     _WriteCommandToLCD
;;       _ToggleEpinOfLCD
;;   _InitI2C
;;   _Set_DS1307_RTC_Time
;;     ___lbmod
;;     ___lbdiv
;;     _Write_Bytes_To_DS1307_RTC
;;       _I2C_Start
;;       _I2C_Write_Byte
;;       _I2C_Stop
;;   _Set_DS1307_RTC_Date
;;     ___lbmod
;;     ___lbdiv
;;     _Write_Bytes_To_DS1307_RTC
;;       _I2C_Start
;;       _I2C_Write_Byte
;;       _I2C_Stop
;;   _Get_DS1307_RTC_Time
;;     _Read_Bytes_From_DS1307_RTC
;;       _I2C_Start
;;       _I2C_Write_Byte
;;       _I2C_ReStart
;;       _I2C_Read_Byte
;;       _I2C_Send_ACK
;;       _I2C_Send_NACK
;;       _I2C_Stop
;;     ___bmul
;;   _DisplayTimeToLCD
;;     _ClearLCDScreen
;;       _WriteCommandToLCD
;;         _ToggleEpinOfLCD
;;     ___lbdiv
;;     _WriteDataToLCD
;;       _ToggleEpinOfLCD
;;     ___lbmod
;;     _WriteStringToLCD
;;       _WriteDataToLCD
;;         _ToggleEpinOfLCD
;;   _Get_DS1307_RTC_Date
;;     _Read_Bytes_From_DS1307_RTC
;;       _I2C_Start
;;       _I2C_Write_Byte
;;       _I2C_ReStart
;;       _I2C_Read_Byte
;;       _I2C_Send_ACK
;;       _I2C_Send_NACK
;;       _I2C_Stop
;;     ___bmul
;;   _DisplayDateOnLCD
;;     _WriteCommandToLCD
;;       _ToggleEpinOfLCD
;;     ___lbdiv
;;     _WriteDataToLCD
;;       _ToggleEpinOfLCD
;;     ___lbmod
;;     _WriteStringToLCD
;;       _WriteDataToLCD
;;         _ToggleEpinOfLCD
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      E       E       1      100.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       4       2        0.0%
;;ABS                  0      0      16       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      3       8       5       10.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      1A      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\Main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       3       0       0       0
;;      Totals:         0       3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_InitLCD
;;		_InitI2C
;;		_Set_DS1307_RTC_Time
;;		_Set_DS1307_RTC_Date
;;		_Get_DS1307_RTC_Time
;;		_DisplayTimeToLCD
;;		_Get_DS1307_RTC_Date
;;		_DisplayDateOnLCD
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\Main.c"
	line	16
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 4
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	17
	
l4977:	
;Main.c: 17: InitLCD();
	fcall	_InitLCD
	line	18
;Main.c: 18: InitI2C();
	fcall	_InitI2C
	line	21
	
l4979:	
;Main.c: 21: Set_DS1307_RTC_Time(0, 8, 32, 59);
	movlw	(08h)
	movwf	(?_Set_DS1307_RTC_Time)
	movlw	(020h)
	movwf	0+(?_Set_DS1307_RTC_Time)+01h
	movlw	(03Bh)
	movwf	0+(?_Set_DS1307_RTC_Time)+02h
	movlw	(0)
	fcall	_Set_DS1307_RTC_Time
	line	24
	
l4981:	
;Main.c: 24: Set_DS1307_RTC_Date(15, 12, 12, 6);
	movlw	(0Ch)
	movwf	(?_Set_DS1307_RTC_Date)
	movlw	(0Ch)
	movwf	0+(?_Set_DS1307_RTC_Date)+01h
	movlw	(06h)
	movwf	0+(?_Set_DS1307_RTC_Date)+02h
	movlw	(0Fh)
	fcall	_Set_DS1307_RTC_Date
	line	29
	
l4983:	
;Main.c: 27: {
;Main.c: 29: DisplayTimeToLCD(Get_DS1307_RTC_Time());
	fcall	_Get_DS1307_RTC_Time
	fcall	_DisplayTimeToLCD
	line	32
	
l4985:	
;Main.c: 32: DisplayDateOnLCD(Get_DS1307_RTC_Date());
	fcall	_Get_DS1307_RTC_Date
	fcall	_DisplayDateOnLCD
	line	34
	
l4987:	
;Main.c: 34: _delay((unsigned long)((1000)*(20000000/4000.0)));
	opt asmopt_off
movlw  26
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_main+0)+0+2),f
movlw	94
movwf	((??_main+0)+0+1),f
	movlw	134
movwf	((??_main+0)+0),f
u497:
	decfsz	((??_main+0)+0),f
	goto	u497
	decfsz	((??_main+0)+0+1),f
	goto	u497
	decfsz	((??_main+0)+0+2),f
	goto	u497
	clrwdt
opt asmopt_on

	goto	l4983
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	36
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_DisplayDateOnLCD
psect	text566,local,class=CODE,delta=2
global __ptext566
__ptext566:

;; *************** function _DisplayDateOnLCD *****************
;; Defined at:
;;		line 146 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;  pDateArray      1    wreg     PTR unsigned char 
;;		 -> pRTCArray(4), 
;; Auto vars:     Size  Location     Type
;;  pDateArray      1    5[COMMON] PTR unsigned char 
;;		 -> pRTCArray(4), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 160/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_WriteCommandToLCD
;;		___lbdiv
;;		_WriteDataToLCD
;;		___lbmod
;;		_WriteStringToLCD
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text566
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	146
	global	__size_of_DisplayDateOnLCD
	__size_of_DisplayDateOnLCD	equ	__end_of_DisplayDateOnLCD-_DisplayDateOnLCD
	
_DisplayDateOnLCD:	
	opt	stack 4
; Regs used in _DisplayDateOnLCD: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;DisplayDateOnLCD@pDateArray stored from wreg
	movwf	(DisplayDateOnLCD@pDateArray)
	line	147
	
l4943:	
;LCD.c: 147: WriteCommandToLCD(0xc0);
	movlw	(0C0h)
	fcall	_WriteCommandToLCD
	line	150
	
l4945:	
;LCD.c: 150: WriteDataToLCD( (pDateArray[1]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	01h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	151
	
l4947:	
;LCD.c: 151: WriteDataToLCD( (pDateArray[1]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	01h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	154
;LCD.c: 154: WriteDataToLCD('/');
	movlw	(02Fh)
	fcall	_WriteDataToLCD
	line	157
	
l4949:	
;LCD.c: 157: WriteDataToLCD( (pDateArray[2]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	02h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	158
	
l4951:	
;LCD.c: 158: WriteDataToLCD( (pDateArray[2]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	02h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	161
;LCD.c: 161: WriteDataToLCD('/');
	movlw	(02Fh)
	fcall	_WriteDataToLCD
	line	164
	
l4953:	
;LCD.c: 164: WriteDataToLCD( (pDateArray[3]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	03h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	165
	
l4955:	
;LCD.c: 165: WriteDataToLCD( (pDateArray[3]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayDateOnLCD@pDateArray),w
	addlw	03h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	168
;LCD.c: 168: WriteDataToLCD(' ');
	movlw	(020h)
	fcall	_WriteDataToLCD
	line	171
;LCD.c: 171: switch(pDateArray[0])
	goto	l4975
	line	173
	
l4957:	
	movlw	((STR_3-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	174
	
l4959:	
	movlw	((STR_4-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	175
	
l4961:	
	movlw	((STR_5-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	176
	
l4963:	
	movlw	((STR_6-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	177
	
l4965:	
	movlw	((STR_7-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	178
	
l4967:	
	movlw	((STR_8-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	179
	
l4969:	
	movlw	((STR_9-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	181
	
l4971:	
	movlw	((STR_10-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2072
	line	171
	
l4975:	
	movf	(DisplayDateOnLCD@pDateArray),w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	; Switch size 1, requested type "space"
; Number of cases is 7, Range of values is 1 to 7
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           22    12 (average)
; direct_byte           32    11 (fixed)
; jumptable            263     9 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	1^0	; case 1
	skipnz
	goto	l4957
	xorlw	2^1	; case 2
	skipnz
	goto	l4959
	xorlw	3^2	; case 3
	skipnz
	goto	l4961
	xorlw	4^3	; case 4
	skipnz
	goto	l4963
	xorlw	5^4	; case 5
	skipnz
	goto	l4965
	xorlw	6^5	; case 6
	skipnz
	goto	l4967
	xorlw	7^6	; case 7
	skipnz
	goto	l4969
	goto	l4971
	opt asmopt_on

	line	183
	
l2072:	
	return
	opt stack 0
GLOBAL	__end_of_DisplayDateOnLCD
	__end_of_DisplayDateOnLCD:
;; =============== function _DisplayDateOnLCD ends ============

	signat	_DisplayDateOnLCD,4216
	global	_DisplayTimeToLCD
psect	text567,local,class=CODE,delta=2
global __ptext567
__ptext567:

;; *************** function _DisplayTimeToLCD *****************
;; Defined at:
;;		line 108 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;  pTimeArray      1    wreg     PTR unsigned char 
;;		 -> pRTCArray(4), 
;; Auto vars:     Size  Location     Type
;;  pTimeArray      1    5[COMMON] PTR unsigned char 
;;		 -> pRTCArray(4), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 160/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_ClearLCDScreen
;;		___lbdiv
;;		_WriteDataToLCD
;;		___lbmod
;;		_WriteStringToLCD
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text567
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	108
	global	__size_of_DisplayTimeToLCD
	__size_of_DisplayTimeToLCD	equ	__end_of_DisplayTimeToLCD-_DisplayTimeToLCD
	
_DisplayTimeToLCD:	
	opt	stack 4
; Regs used in _DisplayTimeToLCD: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;DisplayTimeToLCD@pTimeArray stored from wreg
	movwf	(DisplayTimeToLCD@pTimeArray)
	line	109
	
l4919:	
;LCD.c: 109: ClearLCDScreen();
	fcall	_ClearLCDScreen
	line	112
	
l4921:	
;LCD.c: 112: WriteDataToLCD( (pTimeArray[2]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayTimeToLCD@pTimeArray),w
	addlw	02h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	113
	
l4923:	
;LCD.c: 113: WriteDataToLCD( (pTimeArray[2]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayTimeToLCD@pTimeArray),w
	addlw	02h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	116
;LCD.c: 116: WriteDataToLCD(':');
	movlw	(03Ah)
	fcall	_WriteDataToLCD
	line	119
	
l4925:	
;LCD.c: 119: WriteDataToLCD( (pTimeArray[1]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayTimeToLCD@pTimeArray),w
	addlw	01h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	120
	
l4927:	
;LCD.c: 120: WriteDataToLCD( (pTimeArray[1]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayTimeToLCD@pTimeArray),w
	addlw	01h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	123
;LCD.c: 123: WriteDataToLCD(':');
	movlw	(03Ah)
	fcall	_WriteDataToLCD
	line	126
	
l4929:	
;LCD.c: 126: WriteDataToLCD( (pTimeArray[0]/10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(DisplayTimeToLCD@pTimeArray),w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbdiv
	addlw	030h
	fcall	_WriteDataToLCD
	line	127
	
l4931:	
;LCD.c: 127: WriteDataToLCD( (pTimeArray[0]%10)+0x30 );
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(DisplayTimeToLCD@pTimeArray),w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	___lbmod
	addlw	030h
	fcall	_WriteDataToLCD
	line	130
;LCD.c: 130: WriteDataToLCD(' ');
	movlw	(020h)
	fcall	_WriteDataToLCD
	line	133
;LCD.c: 133: switch(pTimeArray[3])
	goto	l4941
	line	135
	
l4933:	
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2059
	line	136
	
l4935:	
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_WriteStringToLCD
	goto	l2059
	line	138
	
l4937:	
	movlw	(048h)
	fcall	_WriteDataToLCD
	goto	l2059
	line	133
	
l4941:	
	movf	(DisplayTimeToLCD@pTimeArray),w
	addlw	03h
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	; Switch size 1, requested type "space"
; Number of cases is 2, Range of values is 0 to 1
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            7     4 (average)
; direct_byte           14     8 (fixed)
; jumptable            260     6 (fixed)
; rangetable             6     6 (fixed)
; spacedrange           10     9 (fixed)
; locatedrange           2     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l4933
	xorlw	1^0	; case 1
	skipnz
	goto	l4935
	goto	l4937
	opt asmopt_on

	line	140
	
l2059:	
	return
	opt stack 0
GLOBAL	__end_of_DisplayTimeToLCD
	__end_of_DisplayTimeToLCD:
;; =============== function _DisplayTimeToLCD ends ============

	signat	_DisplayTimeToLCD,4216
	global	_ClearLCDScreen
psect	text568,local,class=CODE,delta=2
global __ptext568
__ptext568:

;; *************** function _ClearLCDScreen *****************
;; Defined at:
;;		line 99 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 160/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_WriteCommandToLCD
;; This function is called by:
;;		_DisplayTimeToLCD
;; This function uses a non-reentrant model
;;
psect	text568
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	99
	global	__size_of_ClearLCDScreen
	__size_of_ClearLCDScreen	equ	__end_of_ClearLCDScreen-_ClearLCDScreen
	
_ClearLCDScreen:	
	opt	stack 4
; Regs used in _ClearLCDScreen: [wreg+status,2+status,0+pclath+cstack]
	line	100
	
l4915:	
;LCD.c: 100: WriteCommandToLCD(0x01);
	movlw	(01h)
	fcall	_WriteCommandToLCD
	line	101
	
l4917:	
;LCD.c: 101: _delay((unsigned long)((2)*(20000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_ClearLCDScreen+0)+0+1),f
	movlw	251
movwf	((??_ClearLCDScreen+0)+0),f
u507:
	decfsz	((??_ClearLCDScreen+0)+0),f
	goto	u507
	decfsz	((??_ClearLCDScreen+0)+0+1),f
	goto	u507
	nop2
opt asmopt_on

	line	102
	
l2051:	
	return
	opt stack 0
GLOBAL	__end_of_ClearLCDScreen
	__end_of_ClearLCDScreen:
;; =============== function _ClearLCDScreen ends ============

	signat	_ClearLCDScreen,88
	global	_WriteStringToLCD
psect	text569,local,class=CODE,delta=2
global __ptext569
__ptext569:

;; *************** function _WriteStringToLCD *****************
;; Defined at:
;;		line 92 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR const unsigned char 
;;		 -> STR_10(4), STR_9(4), STR_8(4), STR_7(4), 
;;		 -> STR_6(4), STR_5(4), STR_4(4), STR_3(4), 
;;		 -> STR_2(3), STR_1(3), 
;; Auto vars:     Size  Location     Type
;;  s               1    3[COMMON] PTR const unsigned char 
;;		 -> STR_10(4), STR_9(4), STR_8(4), STR_7(4), 
;;		 -> STR_6(4), STR_5(4), STR_4(4), STR_3(4), 
;;		 -> STR_2(3), STR_1(3), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 100/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_WriteDataToLCD
;; This function is called by:
;;		_DisplayTimeToLCD
;;		_DisplayDateOnLCD
;; This function uses a non-reentrant model
;;
psect	text569
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	92
	global	__size_of_WriteStringToLCD
	__size_of_WriteStringToLCD	equ	__end_of_WriteStringToLCD-_WriteStringToLCD
	
_WriteStringToLCD:	
	opt	stack 4
; Regs used in _WriteStringToLCD: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;WriteStringToLCD@s stored from wreg
	movwf	(WriteStringToLCD@s)
	line	93
	
l4907:	
;LCD.c: 93: while(*s)
	goto	l4913
	line	94
	
l4909:	
;LCD.c: 94: WriteDataToLCD(*s++);
	movf	(WriteStringToLCD@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_WriteDataToLCD
	
l4911:	
	incf	(WriteStringToLCD@s),f
	line	93
	
l4913:	
	movf	(WriteStringToLCD@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u481
	goto	u480
u481:
	goto	l4909
u480:
	line	95
	
l2048:	
	return
	opt stack 0
GLOBAL	__end_of_WriteStringToLCD
	__end_of_WriteStringToLCD:
;; =============== function _WriteStringToLCD ends ============

	signat	_WriteStringToLCD,4216
	global	_InitLCD
psect	text570,local,class=CODE,delta=2
global __ptext570
__ptext570:

;; *************** function _InitLCD *****************
;; Defined at:
;;		line 42 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          3       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_ToggleEpinOfLCD
;;		_WriteCommandToLCD
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text570
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	42
	global	__size_of_InitLCD
	__size_of_InitLCD	equ	__end_of_InitLCD-_InitLCD
	
_InitLCD:	
	opt	stack 5
; Regs used in _InitLCD: [wreg+status,2+status,0+pclath+cstack]
	line	44
	
l4867:	
;LCD.c: 44: RB0 = 0;
	bcf	(48/8),(48)&7
	line	45
;LCD.c: 45: RB1 = 0;
	bcf	(49/8),(49)&7
	line	46
;LCD.c: 46: RB4 = 0;
	bcf	(52/8),(52)&7
	line	47
;LCD.c: 47: RB5 = 0;
	bcf	(53/8),(53)&7
	line	48
;LCD.c: 48: RB6 = 0;
	bcf	(54/8),(54)&7
	line	49
;LCD.c: 49: RB7 = 0;
	bcf	(55/8),(55)&7
	line	50
;LCD.c: 50: TRISB0 = 0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	(1072/8)^080h,(1072)&7
	line	51
;LCD.c: 51: TRISB1 = 0;
	bcf	(1073/8)^080h,(1073)&7
	line	52
;LCD.c: 52: TRISB4 = 0;
	bcf	(1076/8)^080h,(1076)&7
	line	53
;LCD.c: 53: TRISB5 = 0;
	bcf	(1077/8)^080h,(1077)&7
	line	54
;LCD.c: 54: TRISB6 = 0;
	bcf	(1078/8)^080h,(1078)&7
	line	55
;LCD.c: 55: TRISB7 = 0;
	bcf	(1079/8)^080h,(1079)&7
	line	58
	
l4869:	
;LCD.c: 58: _delay((unsigned long)((40)*(20000000/4000.0)));
	opt asmopt_off
movlw  2
movwf	((??_InitLCD+0)+0+2),f
movlw	4
movwf	((??_InitLCD+0)+0+1),f
	movlw	186
movwf	((??_InitLCD+0)+0),f
u517:
	decfsz	((??_InitLCD+0)+0),f
	goto	u517
	decfsz	((??_InitLCD+0)+0+1),f
	goto	u517
	decfsz	((??_InitLCD+0)+0+2),f
	goto	u517
	clrwdt
opt asmopt_on

	line	60
	
l4871:	
;LCD.c: 60: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	61
	
l4873:	
;LCD.c: 61: PORTB |= 0x30;
	movlw	(030h)
	iorwf	(6),f	;volatile
	line	62
	
l4875:	
;LCD.c: 62: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	64
	
l4877:	
;LCD.c: 64: _delay((unsigned long)((6)*(20000000/4000.0)));
	opt asmopt_off
movlw	39
movwf	((??_InitLCD+0)+0+1),f
	movlw	245
movwf	((??_InitLCD+0)+0),f
u527:
	decfsz	((??_InitLCD+0)+0),f
	goto	u527
	decfsz	((??_InitLCD+0)+0+1),f
	goto	u527
opt asmopt_on

	line	66
	
l4879:	
;LCD.c: 66: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	67
	
l4881:	
;LCD.c: 67: PORTB |= 0x30;
	movlw	(030h)
	iorwf	(6),f	;volatile
	line	68
;LCD.c: 68: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	70
	
l4883:	
;LCD.c: 70: _delay((unsigned long)((300)*(20000000/4000000.0)));
	opt asmopt_off
movlw	214
movwf	(??_InitLCD+0)+0,f
u537:
	nop2
	nop2
decfsz	(??_InitLCD+0)+0,f
	goto	u537
	clrwdt
opt asmopt_on

	line	72
	
l4885:	
;LCD.c: 72: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	73
	
l4887:	
;LCD.c: 73: PORTB |= 0x30;
	movlw	(030h)
	iorwf	(6),f	;volatile
	line	74
	
l4889:	
;LCD.c: 74: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	76
;LCD.c: 76: _delay((unsigned long)((2)*(20000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_InitLCD+0)+0+1),f
	movlw	251
movwf	((??_InitLCD+0)+0),f
u547:
	decfsz	((??_InitLCD+0)+0),f
	goto	u547
	decfsz	((??_InitLCD+0)+0+1),f
	goto	u547
	nop2
opt asmopt_on

	line	78
	
l4891:	
;LCD.c: 78: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	79
	
l4893:	
;LCD.c: 79: PORTB |= 0x20;
	bsf	(6)+(5/8),(5)&7	;volatile
	line	80
	
l4895:	
;LCD.c: 80: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	82
	
l4897:	
;LCD.c: 82: _delay((unsigned long)((2)*(20000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_InitLCD+0)+0+1),f
	movlw	251
movwf	((??_InitLCD+0)+0),f
u557:
	decfsz	((??_InitLCD+0)+0),f
	goto	u557
	decfsz	((??_InitLCD+0)+0+1),f
	goto	u557
	nop2
opt asmopt_on

	line	84
	
l4899:	
;LCD.c: 84: WriteCommandToLCD(0x28);
	movlw	(028h)
	fcall	_WriteCommandToLCD
	line	85
	
l4901:	
;LCD.c: 85: WriteCommandToLCD(0x0c);
	movlw	(0Ch)
	fcall	_WriteCommandToLCD
	line	86
	
l4903:	
;LCD.c: 86: WriteCommandToLCD(0x01);
	movlw	(01h)
	fcall	_WriteCommandToLCD
	line	87
	
l4905:	
;LCD.c: 87: WriteCommandToLCD(0x06);
	movlw	(06h)
	fcall	_WriteCommandToLCD
	line	88
	
l2042:	
	return
	opt stack 0
GLOBAL	__end_of_InitLCD
	__end_of_InitLCD:
;; =============== function _InitLCD ends ============

	signat	_InitLCD,88
	global	_WriteDataToLCD
psect	text571,local,class=CODE,delta=2
global __ptext571
__ptext571:

;; *************** function _WriteDataToLCD *****************
;; Defined at:
;;		line 28 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;  LCDChar         1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  LCDChar         1    2[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_ToggleEpinOfLCD
;; This function is called by:
;;		_WriteStringToLCD
;;		_DisplayTimeToLCD
;;		_DisplayDateOnLCD
;; This function uses a non-reentrant model
;;
psect	text571
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	28
	global	__size_of_WriteDataToLCD
	__size_of_WriteDataToLCD	equ	__end_of_WriteDataToLCD-_WriteDataToLCD
	
_WriteDataToLCD:	
	opt	stack 4
; Regs used in _WriteDataToLCD: [wreg+status,2+status,0+pclath+cstack]
;WriteDataToLCD@LCDChar stored from wreg
	movwf	(WriteDataToLCD@LCDChar)
	line	29
	
l4855:	
;LCD.c: 29: RB1 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(49/8),(49)&7
	line	31
	
l4857:	
;LCD.c: 31: PORTB &= 0x0F;
	movlw	(0Fh)
	andwf	(6),f	;volatile
	line	32
;LCD.c: 32: PORTB |= (LCDChar&0xF0);
	movf	(WriteDataToLCD@LCDChar),w
	andlw	0F0h
	iorwf	(6),f	;volatile
	line	33
	
l4859:	
;LCD.c: 33: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	35
	
l4861:	
;LCD.c: 35: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	36
	
l4863:	
;LCD.c: 36: PORTB |= ((LCDChar<<4)&0xF0);
	swapf	(WriteDataToLCD@LCDChar),w
	andlw	(0ffh shl 4) & 0ffh
	andlw	0F0h
	iorwf	(6),f	;volatile
	line	37
	
l4865:	
;LCD.c: 37: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	38
	
l2039:	
	return
	opt stack 0
GLOBAL	__end_of_WriteDataToLCD
	__end_of_WriteDataToLCD:
;; =============== function _WriteDataToLCD ends ============

	signat	_WriteDataToLCD,4216
	global	_WriteCommandToLCD
psect	text572,local,class=CODE,delta=2
global __ptext572
__ptext572:

;; *************** function _WriteCommandToLCD *****************
;; Defined at:
;;		line 14 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;  Command         1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  Command         1    2[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_ToggleEpinOfLCD
;; This function is called by:
;;		_InitLCD
;;		_ClearLCDScreen
;;		_DisplayDateOnLCD
;; This function uses a non-reentrant model
;;
psect	text572
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	14
	global	__size_of_WriteCommandToLCD
	__size_of_WriteCommandToLCD	equ	__end_of_WriteCommandToLCD-_WriteCommandToLCD
	
_WriteCommandToLCD:	
	opt	stack 5
; Regs used in _WriteCommandToLCD: [wreg+status,2+status,0+pclath+cstack]
;WriteCommandToLCD@Command stored from wreg
	movwf	(WriteCommandToLCD@Command)
	line	15
	
l4843:	
;LCD.c: 15: RB1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(49/8),(49)&7
	line	17
	
l4845:	
;LCD.c: 17: PORTB &= 0x0F;
	movlw	(0Fh)
	andwf	(6),f	;volatile
	line	18
;LCD.c: 18: PORTB |= (Command&0xF0);
	movf	(WriteCommandToLCD@Command),w
	andlw	0F0h
	iorwf	(6),f	;volatile
	line	19
	
l4847:	
;LCD.c: 19: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	21
	
l4849:	
;LCD.c: 21: PORTB &= 0x0F;
	movlw	(0Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	22
	
l4851:	
;LCD.c: 22: PORTB |= ((Command<<4)&0xF0);
	swapf	(WriteCommandToLCD@Command),w
	andlw	(0ffh shl 4) & 0ffh
	andlw	0F0h
	iorwf	(6),f	;volatile
	line	23
	
l4853:	
;LCD.c: 23: ToggleEpinOfLCD();
	fcall	_ToggleEpinOfLCD
	line	24
	
l2036:	
	return
	opt stack 0
GLOBAL	__end_of_WriteCommandToLCD
	__end_of_WriteCommandToLCD:
;; =============== function _WriteCommandToLCD ends ============

	signat	_WriteCommandToLCD,4216
	global	_Get_DS1307_RTC_Date
psect	text573,local,class=CODE,delta=2
global __ptext573
__ptext573:

;; *************** function _Get_DS1307_RTC_Date *****************
;; Defined at:
;;		line 210 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      PTR unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 160/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_Read_Bytes_From_DS1307_RTC
;;		___bmul
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text573
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	210
	global	__size_of_Get_DS1307_RTC_Date
	__size_of_Get_DS1307_RTC_Date	equ	__end_of_Get_DS1307_RTC_Date-_Get_DS1307_RTC_Date
	
_Get_DS1307_RTC_Date:	
	opt	stack 5
; Regs used in _Get_DS1307_RTC_Date: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	212
	
l4825:	
;DS1307.c: 212: Read_Bytes_From_DS1307_RTC(0x03, pRTCArray, 4);
	movlw	(_pRTCArray)&0ffh
	movwf	(?_Read_Bytes_From_DS1307_RTC)
	movlw	04h
	movwf	0+(?_Read_Bytes_From_DS1307_RTC)+01h
	clrf	1+(?_Read_Bytes_From_DS1307_RTC)+01h
	movlw	(03h)
	fcall	_Read_Bytes_From_DS1307_RTC
	line	215
	
l4827:	
;DS1307.c: 215: Temp = pRTCArray[1];
	movf	0+(_pRTCArray)+01h,w
	movwf	(_Temp)
	line	216
	
l4829:	
;DS1307.c: 216: pRTCArray[1] = (Temp>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Date+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+01h
	line	219
	
l4831:	
;DS1307.c: 219: Temp = pRTCArray[2];
	movf	0+(_pRTCArray)+02h,w
	movwf	(_Temp)
	line	220
	
l4833:	
;DS1307.c: 220: pRTCArray[2] = (Temp>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Date+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+02h
	line	223
	
l4835:	
;DS1307.c: 223: Temp = pRTCArray[3];
	movf	0+(_pRTCArray)+03h,w
	movwf	(_Temp)
	line	224
	
l4837:	
;DS1307.c: 224: pRTCArray[3] = (Temp>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Date+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+03h
	line	226
	
l4839:	
;DS1307.c: 226: return pRTCArray;
	movlw	(_pRTCArray)&0ffh
	line	227
	
l707:	
	return
	opt stack 0
GLOBAL	__end_of_Get_DS1307_RTC_Date
	__end_of_Get_DS1307_RTC_Date:
;; =============== function _Get_DS1307_RTC_Date ends ============

	signat	_Get_DS1307_RTC_Date,89
	global	_Set_DS1307_RTC_Date
psect	text574,local,class=CODE,delta=2
global __ptext574
__ptext574:

;; *************** function _Set_DS1307_RTC_Date *****************
;; Defined at:
;;		line 189 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;  Date            1    wreg     unsigned char 
;;  Month           1    8[COMMON] unsigned char 
;;  Year            1    9[COMMON] unsigned char 
;;  Day             1   10[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  Date            1   13[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         3       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		___lbmod
;;		___lbdiv
;;		_Write_Bytes_To_DS1307_RTC
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text574
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	189
	global	__size_of_Set_DS1307_RTC_Date
	__size_of_Set_DS1307_RTC_Date	equ	__end_of_Set_DS1307_RTC_Date-_Set_DS1307_RTC_Date
	
_Set_DS1307_RTC_Date:	
	opt	stack 5
; Regs used in _Set_DS1307_RTC_Date: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;Set_DS1307_RTC_Date@Date stored from wreg
	line	191
	movwf	(Set_DS1307_RTC_Date@Date)
	
l4821:	
;DS1307.c: 191: pRTCArray[0] = (((unsigned char)(Day/10))<<4)|((unsigned char)(Day%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Date@Day),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Date+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Date@Day),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Date+1)+0
	swapf	(??_Set_DS1307_RTC_Date+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Date+0)+0,w
	movwf	(_pRTCArray)
	line	192
;DS1307.c: 192: pRTCArray[1] = (((unsigned char)(Date/10))<<4)|((unsigned char)(Date%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Date@Date),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Date+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Date@Date),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Date+1)+0
	swapf	(??_Set_DS1307_RTC_Date+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+01h
	line	193
;DS1307.c: 193: pRTCArray[2] = (((unsigned char)(Month/10))<<4)|((unsigned char)(Month%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Date@Month),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Date+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Date@Month),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Date+1)+0
	swapf	(??_Set_DS1307_RTC_Date+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+02h
	line	194
;DS1307.c: 194: pRTCArray[3] = (((unsigned char)(Year/10))<<4)|((unsigned char)(Year%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Date@Year),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Date+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Date@Year),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Date+1)+0
	swapf	(??_Set_DS1307_RTC_Date+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Date+0)+0,w
	movwf	0+(_pRTCArray)+03h
	line	197
	
l4823:	
;DS1307.c: 197: Write_Bytes_To_DS1307_RTC(0x03, pRTCArray, 4);
	movlw	(_pRTCArray)&0ffh
	movwf	(?_Write_Bytes_To_DS1307_RTC)
	movlw	(04h)
	movwf	0+(?_Write_Bytes_To_DS1307_RTC)+01h
	movlw	(03h)
	fcall	_Write_Bytes_To_DS1307_RTC
	line	198
	
l704:	
	return
	opt stack 0
GLOBAL	__end_of_Set_DS1307_RTC_Date
	__end_of_Set_DS1307_RTC_Date:
;; =============== function _Set_DS1307_RTC_Date ends ============

	signat	_Set_DS1307_RTC_Date,16504
	global	_Get_DS1307_RTC_Time
psect	text575,local,class=CODE,delta=2
global __ptext575
__ptext575:

;; *************** function _Get_DS1307_RTC_Time *****************
;; Defined at:
;;		line 146 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      PTR unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 160/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_Read_Bytes_From_DS1307_RTC
;;		___bmul
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text575
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	146
	global	__size_of_Get_DS1307_RTC_Time
	__size_of_Get_DS1307_RTC_Time	equ	__end_of_Get_DS1307_RTC_Time-_Get_DS1307_RTC_Time
	
_Get_DS1307_RTC_Time:	
	opt	stack 5
; Regs used in _Get_DS1307_RTC_Time: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	148
	
l4789:	
;DS1307.c: 148: Read_Bytes_From_DS1307_RTC(0x00, pRTCArray, 3);
	movlw	(_pRTCArray)&0ffh
	movwf	(?_Read_Bytes_From_DS1307_RTC)
	movlw	03h
	movwf	0+(?_Read_Bytes_From_DS1307_RTC)+01h
	clrf	1+(?_Read_Bytes_From_DS1307_RTC)+01h
	movlw	(0)
	fcall	_Read_Bytes_From_DS1307_RTC
	line	151
	
l4791:	
;DS1307.c: 151: Temp = pRTCArray[0];
	movf	(_pRTCArray),w
	movwf	(_Temp)
	line	152
	
l4793:	
;DS1307.c: 152: pRTCArray[0] = ((Temp&0x7F)>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	andlw	07h
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Time+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Time+0)+0,w
	movwf	(_pRTCArray)
	line	155
	
l4795:	
;DS1307.c: 155: Temp = pRTCArray[1];
	movf	0+(_pRTCArray)+01h,w
	movwf	(_Temp)
	line	156
	
l4797:	
;DS1307.c: 156: pRTCArray[1] = (Temp>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Time+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Time+0)+0,w
	movwf	0+(_pRTCArray)+01h
	line	159
	
l4799:	
;DS1307.c: 159: if(pRTCArray[2]&0x40)
	btfss	0+(_pRTCArray)+02h,(6)&7
	goto	u461
	goto	u460
u461:
	goto	l4811
u460:
	line	161
	
l4801:	
;DS1307.c: 160: {
;DS1307.c: 161: if(pRTCArray[2]&0x20)
	btfss	0+(_pRTCArray)+02h,(5)&7
	goto	u471
	goto	u470
u471:
	goto	l4805
u470:
	line	162
	
l4803:	
;DS1307.c: 162: pRTCArray[3] = 1;
	clrf	0+(_pRTCArray)+03h
	incf	0+(_pRTCArray)+03h,f
	goto	l4807
	line	164
	
l4805:	
;DS1307.c: 163: else
;DS1307.c: 164: pRTCArray[3] = 0;
	clrf	0+(_pRTCArray)+03h
	line	166
	
l4807:	
;DS1307.c: 166: Temp = pRTCArray[2];
	movf	0+(_pRTCArray)+02h,w
	movwf	(_Temp)
	line	167
	
l4809:	
;DS1307.c: 167: pRTCArray[2] = ((Temp&0x1F)>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	andlw	01h
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Time+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Time+0)+0,w
	movwf	0+(_pRTCArray)+02h
	line	168
;DS1307.c: 168: }
	goto	l4817
	line	171
	
l4811:	
;DS1307.c: 169: else
;DS1307.c: 170: {
;DS1307.c: 171: Temp = pRTCArray[2];
	movf	0+(_pRTCArray)+02h,w
	movwf	(_Temp)
	line	172
	
l4813:	
;DS1307.c: 172: pRTCArray[2] = (Temp>>4)*10 + (Temp&0x0F);
	movlw	(0Ah)
	movwf	(?___bmul)
	swapf	(_Temp),w
	andlw	(0ffh shr 4) & 0ffh
	fcall	___bmul
	movwf	(??_Get_DS1307_RTC_Time+0)+0
	movf	(_Temp),w
	andlw	0Fh
	addwf	0+(??_Get_DS1307_RTC_Time+0)+0,w
	movwf	0+(_pRTCArray)+02h
	line	173
	
l4815:	
;DS1307.c: 173: pRTCArray[3] = 2;
	movlw	(02h)
	movwf	0+(_pRTCArray)+03h
	line	176
	
l4817:	
;DS1307.c: 174: }
;DS1307.c: 176: return pRTCArray;
	movlw	(_pRTCArray)&0ffh
	line	177
	
l701:	
	return
	opt stack 0
GLOBAL	__end_of_Get_DS1307_RTC_Time
	__end_of_Get_DS1307_RTC_Time:
;; =============== function _Get_DS1307_RTC_Time ends ============

	signat	_Get_DS1307_RTC_Time,89
	global	_Set_DS1307_RTC_Time
psect	text576,local,class=CODE,delta=2
global __ptext576
__ptext576:

;; *************** function _Set_DS1307_RTC_Time *****************
;; Defined at:
;;		line 117 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;  Mode            1    wreg     unsigned char 
;;  Hours           1    8[COMMON] unsigned char 
;;  Mins            1    9[COMMON] unsigned char 
;;  Secs            1   10[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  Mode            1   13[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         3       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		___lbmod
;;		___lbdiv
;;		_Write_Bytes_To_DS1307_RTC
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text576
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	117
	global	__size_of_Set_DS1307_RTC_Time
	__size_of_Set_DS1307_RTC_Time	equ	__end_of_Set_DS1307_RTC_Time-_Set_DS1307_RTC_Time
	
_Set_DS1307_RTC_Time:	
	opt	stack 5
; Regs used in _Set_DS1307_RTC_Time: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;Set_DS1307_RTC_Time@Mode stored from wreg
	line	119
	movwf	(Set_DS1307_RTC_Time@Mode)
	
l4779:	
;DS1307.c: 119: pRTCArray[0] = (((unsigned char)(Secs/10))<<4)|((unsigned char)(Secs%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Time@Secs),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Time+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Time@Secs),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Time+1)+0
	swapf	(??_Set_DS1307_RTC_Time+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Time+0)+0,w
	movwf	(_pRTCArray)
	line	120
;DS1307.c: 120: pRTCArray[1] = (((unsigned char)(Mins/10))<<4)|((unsigned char)(Mins%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Time@Mins),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Time+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Time@Mins),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Time+1)+0
	swapf	(??_Set_DS1307_RTC_Time+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Time+0)+0,w
	movwf	0+(_pRTCArray)+01h
	line	121
;DS1307.c: 121: pRTCArray[2] = (((unsigned char)(Hours/10))<<4)|((unsigned char)(Hours%10));
	movlw	(0Ah)
	movwf	(?___lbmod)
	movf	(Set_DS1307_RTC_Time@Hours),w
	fcall	___lbmod
	movwf	(??_Set_DS1307_RTC_Time+0)+0
	movlw	(0Ah)
	movwf	(?___lbdiv)
	movf	(Set_DS1307_RTC_Time@Hours),w
	fcall	___lbdiv
	movwf	(??_Set_DS1307_RTC_Time+1)+0
	swapf	(??_Set_DS1307_RTC_Time+1)+0,w
	andlw	(0ffh shl 4) & 0ffh
	iorwf	0+(??_Set_DS1307_RTC_Time+0)+0,w
	movwf	0+(_pRTCArray)+02h
	line	123
;DS1307.c: 123: switch(Mode)
	goto	l4785
	line	125
;DS1307.c: 124: {
;DS1307.c: 125: case 0: pRTCArray[2] |= 0x40; break;
	
l690:	
	bsf	0+(_pRTCArray)+02h+(6/8),(6)&7
	goto	l4787
	line	126
	
l4781:	
	movlw	(060h)
	iorwf	0+(_pRTCArray)+02h,f
	goto	l4787
	line	123
	
l4785:	
	movf	(Set_DS1307_RTC_Time@Mode),w
	; Switch size 1, requested type "space"
; Number of cases is 2, Range of values is 0 to 1
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            7     4 (average)
; direct_byte           14     8 (fixed)
; jumptable            260     6 (fixed)
; rangetable             6     6 (fixed)
; spacedrange           10     9 (fixed)
; locatedrange           2     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l690
	xorlw	1^0	; case 1
	skipnz
	goto	l4781
	goto	l4787
	opt asmopt_on

	line	132
	
l4787:	
;DS1307.c: 132: Write_Bytes_To_DS1307_RTC(0x00, pRTCArray, 3);
	movlw	(_pRTCArray)&0ffh
	movwf	(?_Write_Bytes_To_DS1307_RTC)
	movlw	(03h)
	movwf	0+(?_Write_Bytes_To_DS1307_RTC)+01h
	movlw	(0)
	fcall	_Write_Bytes_To_DS1307_RTC
	line	133
	
l694:	
	return
	opt stack 0
GLOBAL	__end_of_Set_DS1307_RTC_Time
	__end_of_Set_DS1307_RTC_Time:
;; =============== function _Set_DS1307_RTC_Time ends ============

	signat	_Set_DS1307_RTC_Time,16504
	global	_ToggleEpinOfLCD
psect	text577,local,class=CODE,delta=2
global __ptext577
__ptext577:

;; *************** function _ToggleEpinOfLCD *****************
;; Defined at:
;;		line 5 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_WriteCommandToLCD
;;		_WriteDataToLCD
;;		_InitLCD
;; This function uses a non-reentrant model
;;
psect	text577
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\LCD.c"
	line	5
	global	__size_of_ToggleEpinOfLCD
	__size_of_ToggleEpinOfLCD	equ	__end_of_ToggleEpinOfLCD-_ToggleEpinOfLCD
	
_ToggleEpinOfLCD:	
	opt	stack 4
; Regs used in _ToggleEpinOfLCD: [wreg]
	line	6
	
l4773:	
;LCD.c: 6: RB0 = 1;
	bsf	(48/8),(48)&7
	line	7
	
l4775:	
;LCD.c: 7: _delay((unsigned long)((500)*(20000000/4000000.0)));
	opt asmopt_off
movlw	4
movwf	((??_ToggleEpinOfLCD+0)+0+1),f
	movlw	61
movwf	((??_ToggleEpinOfLCD+0)+0),f
u567:
	decfsz	((??_ToggleEpinOfLCD+0)+0),f
	goto	u567
	decfsz	((??_ToggleEpinOfLCD+0)+0+1),f
	goto	u567
	nop2
opt asmopt_on

	line	8
	
l4777:	
;LCD.c: 8: RB0 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(48/8),(48)&7
	line	9
;LCD.c: 9: _delay((unsigned long)((500)*(20000000/4000000.0)));
	opt asmopt_off
movlw	4
movwf	((??_ToggleEpinOfLCD+0)+0+1),f
	movlw	61
movwf	((??_ToggleEpinOfLCD+0)+0),f
u577:
	decfsz	((??_ToggleEpinOfLCD+0)+0),f
	goto	u577
	decfsz	((??_ToggleEpinOfLCD+0)+0+1),f
	goto	u577
	nop2
opt asmopt_on

	line	10
	
l2033:	
	return
	opt stack 0
GLOBAL	__end_of_ToggleEpinOfLCD
	__end_of_ToggleEpinOfLCD:
;; =============== function _ToggleEpinOfLCD ends ============

	signat	_ToggleEpinOfLCD,88
	global	_Read_Bytes_From_DS1307_RTC
psect	text578,local,class=CODE,delta=2
global __ptext578
__ptext578:

;; *************** function _Read_Bytes_From_DS1307_RTC *****************
;; Defined at:
;;		line 81 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;  Address         1    wreg     unsigned char 
;;  pData           1    1[COMMON] PTR unsigned char 
;;		 -> pRTCArray(4), 
;;  NoOfBytes       2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  Address         1    5[COMMON] unsigned char 
;;  i               2    6[COMMON] unsigned int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 160/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         3       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         7       0       0       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_I2C_Start
;;		_I2C_Write_Byte
;;		_I2C_ReStart
;;		_I2C_Read_Byte
;;		_I2C_Send_ACK
;;		_I2C_Send_NACK
;;		_I2C_Stop
;; This function is called by:
;;		_Get_DS1307_RTC_Time
;;		_Get_DS1307_RTC_Date
;; This function uses a non-reentrant model
;;
psect	text578
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	81
	global	__size_of_Read_Bytes_From_DS1307_RTC
	__size_of_Read_Bytes_From_DS1307_RTC	equ	__end_of_Read_Bytes_From_DS1307_RTC-_Read_Bytes_From_DS1307_RTC
	
_Read_Bytes_From_DS1307_RTC:	
	opt	stack 5
; Regs used in _Read_Bytes_From_DS1307_RTC: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;Read_Bytes_From_DS1307_RTC@Address stored from wreg
	line	84
	movwf	(Read_Bytes_From_DS1307_RTC@Address)
	
l4747:	
;DS1307.c: 82: unsigned int i;
;DS1307.c: 84: I2C_Start();
	fcall	_I2C_Start
	line	87
;DS1307.c: 87: while(I2C_Write_Byte(0xD0 + 0) == 1)
	
l4751:	
	movlw	(0D0h)
	fcall	_I2C_Write_Byte
	btfsc	status,0
	goto	u441
	goto	u440
u441:
	goto	l4747
u440:
	line	90
	
l4753:	
;DS1307.c: 90: I2C_Write_Byte(Address);
	movf	(Read_Bytes_From_DS1307_RTC@Address),w
	fcall	_I2C_Write_Byte
	line	91
	
l4755:	
;DS1307.c: 91: I2C_ReStart();
	fcall	_I2C_ReStart
	line	94
	
l4757:	
;DS1307.c: 94: I2C_Write_Byte(0xD0 + 1);
	movlw	(0D1h)
	fcall	_I2C_Write_Byte
	line	96
	
l4759:	
;DS1307.c: 96: pData[0] = I2C_Read_Byte();
	movf	(Read_Bytes_From_DS1307_RTC@pData),w
	movwf	fsr0
	fcall	_I2C_Read_Byte
	bcf	status, 7	;select IRP bank0
	movwf	indf
	line	98
	
l4761:	
;DS1307.c: 98: for(i=1;i<NoOfBytes;i++)
	clrf	(Read_Bytes_From_DS1307_RTC@i)
	incf	(Read_Bytes_From_DS1307_RTC@i),f
	clrf	(Read_Bytes_From_DS1307_RTC@i+1)
	goto	l4769
	line	100
	
l4763:	
;DS1307.c: 99: {
;DS1307.c: 100: I2C_Send_ACK();
	fcall	_I2C_Send_ACK
	line	101
	
l4765:	
;DS1307.c: 101: pData[i] = I2C_Read_Byte();
	movf	(Read_Bytes_From_DS1307_RTC@i),w
	addwf	(Read_Bytes_From_DS1307_RTC@pData),w
	movwf	(??_Read_Bytes_From_DS1307_RTC+0)+0
	movf	0+(??_Read_Bytes_From_DS1307_RTC+0)+0,w
	movwf	fsr0
	fcall	_I2C_Read_Byte
	movwf	indf
	line	98
	
l4767:	
	incf	(Read_Bytes_From_DS1307_RTC@i),f
	skipnz
	incf	(Read_Bytes_From_DS1307_RTC@i+1),f
	
l4769:	
	movf	(Read_Bytes_From_DS1307_RTC@NoOfBytes+1),w
	subwf	(Read_Bytes_From_DS1307_RTC@i+1),w
	skipz
	goto	u455
	movf	(Read_Bytes_From_DS1307_RTC@NoOfBytes),w
	subwf	(Read_Bytes_From_DS1307_RTC@i),w
u455:
	skipc
	goto	u451
	goto	u450
u451:
	goto	l4763
u450:
	line	104
	
l4771:	
;DS1307.c: 102: }
;DS1307.c: 104: I2C_Send_NACK();
	fcall	_I2C_Send_NACK
	line	105
;DS1307.c: 105: I2C_Stop();
	fcall	_I2C_Stop
	line	106
	
l686:	
	return
	opt stack 0
GLOBAL	__end_of_Read_Bytes_From_DS1307_RTC
	__end_of_Read_Bytes_From_DS1307_RTC:
;; =============== function _Read_Bytes_From_DS1307_RTC ends ============

	signat	_Read_Bytes_From_DS1307_RTC,12408
	global	_Write_Bytes_To_DS1307_RTC
psect	text579,local,class=CODE,delta=2
global __ptext579
__ptext579:

;; *************** function _Write_Bytes_To_DS1307_RTC *****************
;; Defined at:
;;		line 57 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
;; Parameters:    Size  Location     Type
;;  Address         1    wreg     unsigned char 
;;  pData           1    1[COMMON] PTR unsigned char 
;;		 -> pRTCArray(4), 
;;  NoOfBytes       1    2[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  Address         1    5[COMMON] unsigned char 
;;  i               2    6[COMMON] unsigned int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         2       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         7       0       0       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_I2C_Start
;;		_I2C_Write_Byte
;;		_I2C_Stop
;; This function is called by:
;;		_Set_DS1307_RTC_Time
;;		_Set_DS1307_RTC_Date
;; This function uses a non-reentrant model
;;
psect	text579
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\DS1307.c"
	line	57
	global	__size_of_Write_Bytes_To_DS1307_RTC
	__size_of_Write_Bytes_To_DS1307_RTC	equ	__end_of_Write_Bytes_To_DS1307_RTC-_Write_Bytes_To_DS1307_RTC
	
_Write_Bytes_To_DS1307_RTC:	
	opt	stack 5
; Regs used in _Write_Bytes_To_DS1307_RTC: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;Write_Bytes_To_DS1307_RTC@Address stored from wreg
	line	60
	movwf	(Write_Bytes_To_DS1307_RTC@Address)
	
l4729:	
;DS1307.c: 58: unsigned int i;
;DS1307.c: 60: I2C_Start();
	fcall	_I2C_Start
	line	63
;DS1307.c: 63: while(I2C_Write_Byte(0xD0 + 0) == 1)
	
l4733:	
	movlw	(0D0h)
	fcall	_I2C_Write_Byte
	btfsc	status,0
	goto	u421
	goto	u420
u421:
	goto	l4729
u420:
	line	66
	
l4735:	
;DS1307.c: 66: I2C_Write_Byte(Address);
	movf	(Write_Bytes_To_DS1307_RTC@Address),w
	fcall	_I2C_Write_Byte
	line	68
	
l4737:	
;DS1307.c: 68: for(i=0;i<NoOfBytes;i++)
	clrf	(Write_Bytes_To_DS1307_RTC@i)
	clrf	(Write_Bytes_To_DS1307_RTC@i+1)
	goto	l4743
	line	69
	
l4739:	
;DS1307.c: 69: I2C_Write_Byte(pData[i]);
	movf	(Write_Bytes_To_DS1307_RTC@i),w
	addwf	(Write_Bytes_To_DS1307_RTC@pData),w
	movwf	(??_Write_Bytes_To_DS1307_RTC+0)+0
	movf	0+(??_Write_Bytes_To_DS1307_RTC+0)+0,w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	_I2C_Write_Byte
	line	68
	
l4741:	
	incf	(Write_Bytes_To_DS1307_RTC@i),f
	skipnz
	incf	(Write_Bytes_To_DS1307_RTC@i+1),f
	
l4743:	
	movf	(Write_Bytes_To_DS1307_RTC@NoOfBytes),w
	movwf	(??_Write_Bytes_To_DS1307_RTC+0)+0
	clrf	(??_Write_Bytes_To_DS1307_RTC+0)+0+1
	movf	1+(??_Write_Bytes_To_DS1307_RTC+0)+0,w
	subwf	(Write_Bytes_To_DS1307_RTC@i+1),w
	skipz
	goto	u435
	movf	0+(??_Write_Bytes_To_DS1307_RTC+0)+0,w
	subwf	(Write_Bytes_To_DS1307_RTC@i),w
u435:
	skipc
	goto	u431
	goto	u430
u431:
	goto	l4739
u430:
	line	71
	
l4745:	
;DS1307.c: 71: I2C_Stop();
	fcall	_I2C_Stop
	line	72
	
l677:	
	return
	opt stack 0
GLOBAL	__end_of_Write_Bytes_To_DS1307_RTC
	__end_of_Write_Bytes_To_DS1307_RTC:
;; =============== function _Write_Bytes_To_DS1307_RTC ends ============

	signat	_Write_Bytes_To_DS1307_RTC,12408
	global	___lbmod
psect	text580,local,class=CODE,delta=2
global __ptext580
__ptext580:

;; *************** function ___lbmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lbmod.c"
;; Parameters:    Size  Location     Type
;;  dividend        1    wreg     unsigned char 
;;  divisor         1    0[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  dividend        1    2[COMMON] unsigned char 
;;  rem             1    4[COMMON] unsigned char 
;;  counter         1    3[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: FFFFF/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         1       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         5       0       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Set_DS1307_RTC_Time
;;		_Set_DS1307_RTC_Date
;;		_DisplayTimeToLCD
;;		_DisplayDateOnLCD
;; This function uses a non-reentrant model
;;
psect	text580
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lbmod.c"
	line	5
	global	__size_of___lbmod
	__size_of___lbmod	equ	__end_of___lbmod-___lbmod
	
___lbmod:	
	opt	stack 6
; Regs used in ___lbmod: [wreg+status,2+status,0]
;___lbmod@dividend stored from wreg
	line	9
	movwf	(___lbmod@dividend)
	
l4711:	
	movlw	(08h)
	movwf	(___lbmod@counter)
	line	10
	
l4713:	
	clrf	(___lbmod@rem)
	line	12
	
l4715:	
	movf	(___lbmod@dividend),w
	movwf	(??___lbmod+0)+0
	movlw	07h
u395:
	clrc
	rrf	(??___lbmod+0)+0,f
	addlw	-1
	skipz
	goto	u395
	clrc
	rlf	(___lbmod@rem),w
	iorwf	0+(??___lbmod+0)+0,w
	movwf	(___lbmod@rem)
	line	13
	
l4717:	
	clrc
	rlf	(___lbmod@dividend),f
	line	14
	
l4719:	
	movf	(___lbmod@divisor),w
	subwf	(___lbmod@rem),w
	skipc
	goto	u401
	goto	u400
u401:
	goto	l4723
u400:
	line	15
	
l4721:	
	movf	(___lbmod@divisor),w
	subwf	(___lbmod@rem),f
	line	16
	
l4723:	
	decfsz	(___lbmod@counter),f
	goto	u411
	goto	u410
u411:
	goto	l4715
u410:
	line	17
	
l4725:	
	movf	(___lbmod@rem),w
	line	18
	
l3416:	
	return
	opt stack 0
GLOBAL	__end_of___lbmod
	__end_of___lbmod:
;; =============== function ___lbmod ends ============

	signat	___lbmod,8313
	global	___lbdiv
psect	text581,local,class=CODE,delta=2
global __ptext581
__ptext581:

;; *************** function ___lbdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lbdiv.c"
;; Parameters:    Size  Location     Type
;;  dividend        1    wreg     unsigned char 
;;  divisor         1    0[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  dividend        1    1[COMMON] unsigned char 
;;  quotient        1    3[COMMON] unsigned char 
;;  counter         1    2[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: FFFFF/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         1       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         4       0       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Set_DS1307_RTC_Time
;;		_Set_DS1307_RTC_Date
;;		_DisplayTimeToLCD
;;		_DisplayDateOnLCD
;; This function uses a non-reentrant model
;;
psect	text581
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lbdiv.c"
	line	5
	global	__size_of___lbdiv
	__size_of___lbdiv	equ	__end_of___lbdiv-___lbdiv
	
___lbdiv:	
	opt	stack 6
; Regs used in ___lbdiv: [wreg+status,2+status,0]
;___lbdiv@dividend stored from wreg
	line	9
	movwf	(___lbdiv@dividend)
	
l4687:	
	clrf	(___lbdiv@quotient)
	line	10
	
l4689:	
	movf	(___lbdiv@divisor),w
	skipz
	goto	u350
	goto	l4707
u350:
	line	11
	
l4691:	
	clrf	(___lbdiv@counter)
	incf	(___lbdiv@counter),f
	line	12
	goto	l4695
	
l3405:	
	line	13
	clrc
	rlf	(___lbdiv@divisor),f
	line	14
	
l4693:	
	incf	(___lbdiv@counter),f
	line	12
	
l4695:	
	btfss	(___lbdiv@divisor),(7)&7
	goto	u361
	goto	u360
u361:
	goto	l3405
u360:
	line	16
	
l3407:	
	line	17
	clrc
	rlf	(___lbdiv@quotient),f
	line	18
	
l4697:	
	movf	(___lbdiv@divisor),w
	subwf	(___lbdiv@dividend),w
	skipc
	goto	u371
	goto	u370
u371:
	goto	l4703
u370:
	line	19
	
l4699:	
	movf	(___lbdiv@divisor),w
	subwf	(___lbdiv@dividend),f
	line	20
	
l4701:	
	bsf	(___lbdiv@quotient)+(0/8),(0)&7
	line	22
	
l4703:	
	clrc
	rrf	(___lbdiv@divisor),f
	line	23
	
l4705:	
	decfsz	(___lbdiv@counter),f
	goto	u381
	goto	u380
u381:
	goto	l3407
u380:
	line	25
	
l4707:	
	movf	(___lbdiv@quotient),w
	line	26
	
l3410:	
	return
	opt stack 0
GLOBAL	__end_of___lbdiv
	__end_of___lbdiv:
;; =============== function ___lbdiv ends ============

	signat	___lbdiv,8313
	global	___bmul
psect	text582,local,class=CODE,delta=2
global __ptext582
__ptext582:

;; *************** function ___bmul *****************
;; Defined at:
;;		line 3 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\bmul.c"
;; Parameters:    Size  Location     Type
;;  multiplier      1    wreg     unsigned char 
;;  multiplicand    1    0[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  multiplier      1    2[COMMON] unsigned char 
;;  product         1    1[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 160/0
;;		On exit  : 160/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         1       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Get_DS1307_RTC_Time
;;		_Get_DS1307_RTC_Date
;; This function uses a non-reentrant model
;;
psect	text582
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\bmul.c"
	line	3
	global	__size_of___bmul
	__size_of___bmul	equ	__end_of___bmul-___bmul
	
___bmul:	
	opt	stack 6
; Regs used in ___bmul: [wreg+status,2+status,0]
;___bmul@multiplier stored from wreg
	movwf	(___bmul@multiplier)
	line	4
	
l4671:	
	clrf	(___bmul@product)
	line	7
	
l4673:	
	btfss	(___bmul@multiplier),(0)&7
	goto	u331
	goto	u330
u331:
	goto	l4677
u330:
	line	8
	
l4675:	
	movf	(___bmul@multiplicand),w
	addwf	(___bmul@product),f
	line	9
	
l4677:	
	clrc
	rlf	(___bmul@multiplicand),f
	line	10
	
l4679:	
	clrc
	rrf	(___bmul@multiplier),f
	line	11
	
l4681:	
	movf	(___bmul@multiplier),f
	skipz
	goto	u341
	goto	u340
u341:
	goto	l4673
u340:
	line	12
	
l4683:	
	movf	(___bmul@product),w
	line	13
	
l3374:	
	return
	opt stack 0
GLOBAL	__end_of___bmul
	__end_of___bmul:
;; =============== function ___bmul ends ============

	signat	___bmul,8313
	global	_InitI2C
psect	text583,local,class=CODE,delta=2
global __ptext583
__ptext583:

;; *************** function _InitI2C *****************
;; Defined at:
;;		line 7 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text583
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	7
	global	__size_of_InitI2C
	__size_of_InitI2C	equ	__end_of_InitI2C-_InitI2C
	
_InitI2C:	
	opt	stack 7
; Regs used in _InitI2C: [wreg]
	line	8
	
l4255:	
;I2C.c: 8: TRISC4 = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1084/8)^080h,(1084)&7
	line	9
;I2C.c: 9: TRISC3 = 1;
	bsf	(1083/8)^080h,(1083)&7
	line	11
	
l4257:	
;I2C.c: 11: SSPADD = ((20000000/4000)/100) - 1;
	movlw	(031h)
	movwf	(147)^080h	;volatile
	line	12
;I2C.c: 12: SSPSTAT = 0x80;
	movlw	(080h)
	movwf	(148)^080h	;volatile
	line	13
;I2C.c: 13: SSPCON = 0x28;
	movlw	(028h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(20)	;volatile
	line	14
	
l1348:	
	return
	opt stack 0
GLOBAL	__end_of_InitI2C
	__end_of_InitI2C:
;; =============== function _InitI2C ends ============

	signat	_InitI2C,88
	global	_I2C_Send_ACK
psect	text584,local,class=CODE,delta=2
global __ptext584
__ptext584:

;; *************** function _I2C_Send_ACK *****************
;; Defined at:
;;		line 47 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text584
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	47
	global	__size_of_I2C_Send_ACK
	__size_of_I2C_Send_ACK	equ	__end_of_I2C_Send_ACK-_I2C_Send_ACK
	
_I2C_Send_ACK:	
	opt	stack 5
; Regs used in _I2C_Send_ACK: []
	line	48
	
l4669:	
;I2C.c: 48: ACKDT = 0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1165/8)^080h,(1165)&7
	line	49
;I2C.c: 49: ACKEN = 1;
	bsf	(1164/8)^080h,(1164)&7
	line	50
;I2C.c: 50: while(!SSPIF);
	
l1369:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u321
	goto	u320
u321:
	goto	l1369
u320:
	
l1371:	
	line	51
;I2C.c: 51: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	52
	
l1372:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Send_ACK
	__end_of_I2C_Send_ACK:
;; =============== function _I2C_Send_ACK ends ============

	signat	_I2C_Send_ACK,88
	global	_I2C_Send_NACK
psect	text585,local,class=CODE,delta=2
global __ptext585
__ptext585:

;; *************** function _I2C_Send_NACK *****************
;; Defined at:
;;		line 57 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 160/0
;;		On exit  : 160/0
;;		Unchanged: FFE9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text585
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	57
	global	__size_of_I2C_Send_NACK
	__size_of_I2C_Send_NACK	equ	__end_of_I2C_Send_NACK-_I2C_Send_NACK
	
_I2C_Send_NACK:	
	opt	stack 5
; Regs used in _I2C_Send_NACK: []
	line	58
	
l4667:	
;I2C.c: 58: ACKDT = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1165/8)^080h,(1165)&7
	line	59
;I2C.c: 59: ACKEN = 1;
	bsf	(1164/8)^080h,(1164)&7
	line	60
;I2C.c: 60: while(!SSPIF);
	
l1375:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u311
	goto	u310
u311:
	goto	l1375
u310:
	
l1377:	
	line	61
;I2C.c: 61: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	62
	
l1378:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Send_NACK
	__end_of_I2C_Send_NACK:
;; =============== function _I2C_Send_NACK ends ============

	signat	_I2C_Send_NACK,88
	global	_I2C_Read_Byte
psect	text586,local,class=CODE,delta=2
global __ptext586
__ptext586:

;; *************** function _I2C_Read_Byte *****************
;; Defined at:
;;		line 78 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 40/20
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text586
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	78
	global	__size_of_I2C_Read_Byte
	__size_of_I2C_Read_Byte	equ	__end_of_I2C_Read_Byte-_I2C_Read_Byte
	
_I2C_Read_Byte:	
	opt	stack 5
; Regs used in _I2C_Read_Byte: [wreg]
	line	79
	
l4661:	
;I2C.c: 79: RCEN = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1163/8)^080h,(1163)&7
	line	80
;I2C.c: 80: while(!SSPIF);
	
l1387:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u301
	goto	u300
u301:
	goto	l1387
u300:
	
l1389:	
	line	81
;I2C.c: 81: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	83
	
l4663:	
;I2C.c: 83: return SSPBUF;
	movf	(19),w	;volatile
	line	84
	
l1390:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Read_Byte
	__end_of_I2C_Read_Byte:
;; =============== function _I2C_Read_Byte ends ============

	signat	_I2C_Read_Byte,89
	global	_I2C_ReStart
psect	text587,local,class=CODE,delta=2
global __ptext587
__ptext587:

;; *************** function _I2C_ReStart *****************
;; Defined at:
;;		line 28 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 60/20
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text587
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	28
	global	__size_of_I2C_ReStart
	__size_of_I2C_ReStart	equ	__end_of_I2C_ReStart-_I2C_ReStart
	
_I2C_ReStart:	
	opt	stack 5
; Regs used in _I2C_ReStart: []
	line	29
	
l4659:	
;I2C.c: 29: RSEN = 1;
	bsf	(1161/8)^080h,(1161)&7
	line	30
;I2C.c: 30: while(!SSPIF);
	
l1357:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u291
	goto	u290
u291:
	goto	l1357
u290:
	
l1359:	
	line	31
;I2C.c: 31: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	32
	
l1360:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_ReStart
	__end_of_I2C_ReStart:
;; =============== function _I2C_ReStart ends ============

	signat	_I2C_ReStart,88
	global	_I2C_Stop
psect	text588,local,class=CODE,delta=2
global __ptext588
__ptext588:

;; *************** function _I2C_Stop *****************
;; Defined at:
;;		line 37 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 40/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Write_Bytes_To_DS1307_RTC
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text588
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	37
	global	__size_of_I2C_Stop
	__size_of_I2C_Stop	equ	__end_of_I2C_Stop-_I2C_Stop
	
_I2C_Stop:	
	opt	stack 5
; Regs used in _I2C_Stop: []
	line	38
	
l4657:	
;I2C.c: 38: PEN = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1162/8)^080h,(1162)&7
	line	39
;I2C.c: 39: while(!SSPIF);
	
l1363:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u281
	goto	u280
u281:
	goto	l1363
u280:
	
l1365:	
	line	40
;I2C.c: 40: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	41
	
l1366:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Stop
	__end_of_I2C_Stop:
;; =============== function _I2C_Stop ends ============

	signat	_I2C_Stop,88
	global	_I2C_Write_Byte
psect	text589,local,class=CODE,delta=2
global __ptext589
__ptext589:

;; *************** function _I2C_Write_Byte *****************
;; Defined at:
;;		line 67 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;  Byte            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  Byte            1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 40/0
;;		On exit  : 60/20
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Write_Bytes_To_DS1307_RTC
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text589
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	67
	global	__size_of_I2C_Write_Byte
	__size_of_I2C_Write_Byte	equ	__end_of_I2C_Write_Byte-_I2C_Write_Byte
	
_I2C_Write_Byte:	
	opt	stack 5
; Regs used in _I2C_Write_Byte: [wreg+status,2+status,0]
;I2C_Write_Byte@Byte stored from wreg
	movwf	(I2C_Write_Byte@Byte)
	line	68
	
l4649:	
;I2C.c: 68: SSPBUF = Byte;
	movf	(I2C_Write_Byte@Byte),w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(19)	;volatile
	line	69
;I2C.c: 69: while(!SSPIF);
	
l1381:	
	btfss	(99/8),(99)&7
	goto	u261
	goto	u260
u261:
	goto	l1381
u260:
	
l1383:	
	line	70
;I2C.c: 70: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	72
;I2C.c: 72: return ACKSTAT;
	bsf	status, 5	;RP0=1, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u271
	goto	u270
u271:
	goto	l4653
u270:
	
l4651:	
	clrc
	
	goto	l1384
	
l4653:	
	setc
	
	line	73
	
l1384:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Write_Byte
	__end_of_I2C_Write_Byte:
;; =============== function _I2C_Write_Byte ends ============

	signat	_I2C_Write_Byte,4216
	global	_I2C_Start
psect	text590,local,class=CODE,delta=2
global __ptext590
__ptext590:

;; *************** function _I2C_Start *****************
;; Defined at:
;;		line 19 in file "C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Write_Bytes_To_DS1307_RTC
;;		_Read_Bytes_From_DS1307_RTC
;; This function uses a non-reentrant model
;;
psect	text590
	file	"C:\Users\Saeed\Desktop\PIC16F877 with DS1307 RTC Code\Code\I2C.c"
	line	19
	global	__size_of_I2C_Start
	__size_of_I2C_Start	equ	__end_of_I2C_Start-_I2C_Start
	
_I2C_Start:	
	opt	stack 5
; Regs used in _I2C_Start: []
	line	20
	
l4647:	
;I2C.c: 20: SEN = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1160/8)^080h,(1160)&7
	line	21
;I2C.c: 21: while(!SSPIF);
	
l1351:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u251
	goto	u250
u251:
	goto	l1351
u250:
	
l1353:	
	line	22
;I2C.c: 22: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	23
	
l1354:	
	return
	opt stack 0
GLOBAL	__end_of_I2C_Start
	__end_of_I2C_Start:
;; =============== function _I2C_Start ends ============

	signat	_I2C_Start,88
psect	text591,local,class=CODE,delta=2
global __ptext591
__ptext591:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
