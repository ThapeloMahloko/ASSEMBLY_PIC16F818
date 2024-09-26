;******************************************************************
; THAPELO LEBOHANG MAHLOKO
; mrtmahloko@gmail.com
; DESCRIPTION OF PROGRAM
; THIS IS A 4 INPUT OR GATE
;*****************************************************************************************************************
    LIST        P=16F818          ; USING THE 16F818.
    #INCLUDE    <P16F818.INC>     ; HEADER FILE FOR PIC16F818
;*****************************************************************************************************************
; CONFIGURATION BITS
    __CONFIG    H'3FF1'           ; XT OSCILLATOR, WDT OFF, PUT ON, CODE PROTECTION DISABLED.
;*****************************************************************************************************************
                    ORG     0X00           ; START ADDRESS IN MEMORY
                    GOTO    START          ; GOTO START

;*****************************************************************************************************************
; SET VARIABLES
INPUT_A             EQU     0                  ; INPUT_A IS RB0 (BIT 0)
INPUT_B             EQU     1                  ; INPUT_B IS RB1 (BIT 1)
INPUT_C             EQU     2                  ; INPUT_C IS RB2 (BIT 2)
INPUT_D             EQU     3                  ; INPUT_D IS RB3 (BIT 3)
OUTPUT_PIN          EQU     0                  ; OUTPUT TO RA0 (BIT 0)

;*****************************************************************************************************************
START:
                    BSF     STATUS,RP0        ; SELECT BANK 1
                    MOVLW   0X06              ; CONFIGURE ALL PINS AS DIGITAL INPUTS
                    MOVWF   ADCON1            ; MOVE TO ADCON1 REGISTER
                    CLRF    TRISA             ; SET PORTA AS OUTPUTS
                    MOVLW   0X0F              ; MAKE RB0 AND RB1 INPUTS
                    MOVWF   TRISB             ; SET PORTB AS INPUTS
                    BCF     STATUS,RP0        ; SWITCH BACK TO BANK 0

                    GOTO    TEST_INPUTS       ; GOTO TEST_INPUTS

;*****************************************************************************************************************
; TEST INPUTS
TEST_INPUTS:
                    BTFSC   PORTB, INPUT_A    ; TEST INPUT_A (RB0)
                    GOTO    SET_OUT           ; GOTO SET_OUT
                    BTFSC   PORTB, INPUT_B    ; TEST INPUT_B (RB1)
                    GOTO    SET_OUT           ; GOTO SET_OUT
                    BTFSC   PORTB, INPUT_C    ; TEST INPUT_C (RB2)
                    GOTO    SET_OUT           ; GOTO SET_OUT
                    BTFSC   PORTB, INPUT_D    ; TEST INPUT_D (RB3)
                    GOTO    SET_OUT           ; GOTO SET_OUT
                    GOTO    CLEAR_OUT         ; GOTO CLEAR_OUT


SET_OUT:
                    BSF     PORTA, OUTPUT_PIN ; SET RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

CLEAR_OUT:
                    BCF     PORTA, OUTPUT_PIN ; CLEAR RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS


END