; Lerato Moji 
LIST P=PIC16F818
#INCLUDE<P16F818.INC>

BSF STATUS,5
MOVLW 0X06
MOVWF ADCON1
MOVLW 0XFF
MOVWF TRISA
MOVLW 0X00
MOVWF TRISB
BCF STATUS,5

T0 BTFSS PORTA,0
   GOTO T1
   GOTO T8
T1 BTFSS PORTA,1
   GOTO T2
   GOTO T5
T2 BTFSS PORTA,2
   GOTO T3
   GOTO T4
T3 BTFSS PORTA,3
   GOTO H0
   GOTO H1
T4 BTFSS PORTA,3
   GOTO H1
   GOTO H0
T5 BTFSS PORTA,2
   GOTO T6
   GOTO T7
T6 BTFSS PORTA,3
   GOTO H1
   GOTO H0
T7 BTFSS PORTA,3
   GOTO H0
   GOTO H1
T8 BTFSS PORTA,1
   GOTO TC
   GOTO T9
T9 BTFSS PORTA,2
   GOTO TB
   GOTO TA
TA BTFSS PORTA,3
   GOTO H1
   GOTO H0
TB BTFSS PORTA,3
   GOTO H0
   GOTO H1
TC BTFSS PORTA,2
   GOTO TD
   GOTO TE
TD BTFSS PORTA,3
   GOTO H1
   GOTO H0
TE BTFSS PORTA,3
   GOTO H0
   GOTO H1


H0 BCF PORTB,0
   GOTO T0

H1 BSF PORTB,0
   GOTO T0



END