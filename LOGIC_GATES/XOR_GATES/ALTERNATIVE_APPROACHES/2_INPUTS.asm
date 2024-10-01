;******************************************************************
; THAPELO LEBOHANG MAHLOKO
; mrtmahloko@gmail.com
; DESCRIPTION OF PROGRAM
; THIS IS A 4-INPUT XOR GATE
;******************************************************************
    LIST        P=16F818          ; USING THE 16F818.
    #INCLUDE    <P16F818.INC>     ; HEADER FILE FOR PIC16F818
;****************************************************************** 
; CONFIGURATION BITS
    __CONFIG    H'3FF1'           ; XT OSCILLATOR, WDT OFF, PUT ON, CODE PROTECTION DISABLED.
;******************************************************************
                    ORG     0X00           ; START ADDRESS IN MEMORY
                    GOTO    START          ; GOTO START

;******************************************************************
; SET VARIABLES
INPUT_A             EQU     0                  ; INPUT_A IS RB0 (BIT 0)
INPUT_B             EQU     1                  ; INPUT_B IS RB1 (BIT 1)
OUTPUT_PIN          EQU     0                  ; OUTPUT TO RA0 (BIT 0)
TEMP                EQU     0x20               ; TEMP REGISTER FOR INTERMEDIATE STORAGE

;******************************************************************
START:
                    BSF     STATUS,RP0        ; SELECT BANK 1
                    MOVLW   0X06              ; CONFIGURE ALL PINS AS DIGITAL INPUTS
                    MOVWF   ADCON1            ; MOVE TO ADCON1 REGISTER
                    CLRF    TRISA             ; SET PORTA AS OUTPUTS
                    MOVLW   0X0F              ; MAKE RB0 TO RB3 INPUTS
                    MOVWF   TRISB             ; SET PORTB AS INPUTS
                    BCF     STATUS,RP0        ; SWITCH BACK TO BANK 0

                    CLRF    TEMP              ; CLEAR TEMP REGISTER
                    GOTO    TEST_INPUTS       ; GOTO TEST_INPUTS

;******************************************************************
; TEST INPUTS
TEST_INPUTS:
                    BTFSC   PORTB, INPUT_A    ; TEST INPUT_A (RB0)
                    INCF    TEMP, F           ; IF SET, INCREMENT TEMP

                    BTFSC   PORTB, INPUT_B    ; TEST INPUT_B (RB1)
                    INCF    TEMP, F           ; IF SET, INCREMENT TEMP
                    ; NOW, XOR RESULT IS IN TEMP, TEST THE LOWEST BIT
                    MOVF    TEMP, W           ; MOVE TEMP TO W REGISTER
                    ANDLW   0x01              ; MASK THE LOWEST BIT (CHECK IF ODD NUMBER OF 1'S)

                    BTFSC   STATUS,Z          ; IF ZERO FLAG IS SET, CLEAR THE OUTPUT
                    GOTO    CLEAR_OUT         ; IF RESULT IS 0, GOTO CLEAR_OUT

                    GOTO    SET_OUT           ; OTHERWISE, GOTO `SET_OUT

;******************************************************************
SET_OUT:
                    BSF     PORTA, OUTPUT_PIN ; SET RA0 (OUTPUT)
                    GOTO    RESET_TEMP        ; RESET TEMP AND LOOP BACK TO TEST_INPUTS

CLEAR_OUT:
                    BCF     PORTA, OUTPUT_PIN ; CLEAR RA0 (OUTPUT)
                    GOTO    RESET_TEMP        ; RESET TEMP AND LOOP BACK TO TEST_INPUTS

RESET_TEMP:
                    CLRF    TEMP              ; CLEAR TEMP REGISTER FOR NEXT CYCLE
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

END
