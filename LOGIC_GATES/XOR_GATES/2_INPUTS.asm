;******************************************************************
; THAPELO LEBOHANG MAHLOKO
; mrtmahloko@gmail.com
; DESCRIPTION OF PROGRAM
; THIS IS A 2-INPUT XOR GATE TESTING FOR ALL CONDITIONS WHEN OUTPUT IS 1
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

;******************************************************************
START:
                    BSF     STATUS,RP0        ; SELECT BANK 1
                    MOVLW   0X06              ; CONFIGURE ALL PINS AS DIGITAL INPUTS
                    MOVWF   ADCON1            ; MOVE TO ADCON1 REGISTER
                    CLRF    TRISA             ; SET PORTA AS OUTPUTS
                    MOVLW   0X0F              ; MAKE RB0 TO RB3 INPUTS
                    MOVWF   TRISB             ; SET PORTB AS INPUTS
                    BCF     STATUS,RP0        ; SWITCH BACK TO BANK 0

                    GOTO    TEST_INPUTS       ; GOTO TEST_INPUTS

;******************************************************************
; TEST INPUTS
; TEST ALL CONDITIONS WHERE THE OUTPUT IS 1
TEST_INPUTS:
                    CLRF    TEMP              ; CLEAR TEMP REGISTER
                    GOTO    CASE_1            ; GOTO TO CASE 1
CASE_1:
                    ; CASE 1: A'B
                    BTFSC   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 0
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 1
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_2:
                    ; CASE 8: AB'
                    BTFSS   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 1
                    GOTO    CLEAR_OUT         ; GOTO TO CLAER_OUT
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS IS NOT ZERE
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT
                    GOTO    CLEAR_OUT         ; OTHERWISE, CLEAR THE OUTPUT

;******************************************************************
SET_OUT:
                    BSF     PORTA, OUTPUT_PIN ; SET RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

CLEAR_OUT:
                    BCF     PORTA, OUTPUT_PIN ; CLEAR RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

END
