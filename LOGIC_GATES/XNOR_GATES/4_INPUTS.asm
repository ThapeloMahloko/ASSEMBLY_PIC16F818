;******************************************************************
; THAPELO LEBOHANG MAHLOKO
; mrtmahloko@gmail.com
; DESCRIPTION OF PROGRAM
; THIS IS A 4-INPUT XNOR GATE TESTING FOR ALL CONDITIONS WHEN OUTPUT IS 1
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
INPUT_C             EQU     2                  ; INPUT_C IS RB2 (BIT 2)
INPUT_D             EQU     3                  ; INPUT_D IS RB3 (BIT 3)
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
                    ; CASE 1: A'B'C'D'
                    BTFSC   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 0
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    BTFSC   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 0
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 0
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    BTFSC   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 0
                    GOTO    CASE_2            ; GOTO TO CASE 2
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT                    

CASE_2:
                    ; CASE 2: A'B'CD
                    BTFSC   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 0
                    GOTO    CASE_3            ; GOTO TO CASE 3
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 0
                    GOTO    CASE_3            ; GOTO TO CASE 3
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 1
                    GOTO    CASE_3            ; GOTO TO CASE 3
                    BTFSS   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 1
                    GOTO    CASE_3            ; GOTO TO CASE 3
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT
                
CASE_3:
                    ; CASE 3: A'BC'D
                    BTFSC   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 0
                    GOTO    CASE_4            ; GOTO TO CASE 4
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 1
                    GOTO    CASE_4            ; GOTO TO CASE 4
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 0
                    GOTO    CASE_4            ; GOTO TO CASE 4
                    BTFSS   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 1
                    GOTO    CASE_4            ; GOTO TO CASE 4
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_4:
                    ; CASE 4: A'BCD'
                    BTFSC   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 0
                    GOTO    CASE_5            ; GOTO TO CASE 5
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 1
                    GOTO    CASE_5            ; GOTO TO CASE 5
                    BTFSS   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 1
                    GOTO    CASE_5            ; GOTO TO CASE 5
                    BTFSC   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 0
                    GOTO    CASE_5            ; GOTO TO CASE 5
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_5:
                    ; CASE 5: AB'C'D
                    BTFSS   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 1
                    GOTO    CASE_6            ; GOTO TO CASE 6
                    BTFSC   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 0
                    GOTO    CASE_6            ; GOTO TO CASE 6
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 0
                    GOTO    CASE_6            ; GOTO TO CASE 6
                    BTFSS   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 1
                    GOTO    CASE_6            ; GOTO TO CASE 6
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_6:
                    ; CASE 6: AB'CD'
                    BTFSS   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 1
                    GOTO    CASE_7            ; GOTO TO CASE 7
                    BTFSC   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 0
                    GOTO    CASE_7            ; GOTO TO CASE 7
                    BTFSS   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 1
                    GOTO    CASE_7            ; GOTO TO CASE 7
                    BTFSC   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 0
                    GOTO    CASE_7            ; GOTO TO CASE 7
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_7:
                    ; CASE 7: ABC'D'
                    BTFSS   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 1
                    GOTO    CASE_8            ; GOTO TO CASE 8
                    BTFSS   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 1
                    GOTO    CASE_8            ; GOTO TO CASE 8
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 0
                    GOTO    CASE_8            ; GOTO TO CASE 8
                    BTFSC   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 0
                    GOTO    CASE_8            ; GOTO TO CASE 8
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

CASE_8:
                    ; CASE 8: ABCD
                    BTFSS   PORTB, INPUT_A    ; CHECK IF INPUT_A IS 1
                    GOTO    CLEAR_OUT         ; GOTO TO CLAER_OUT
                    BTFSC   PORTB, INPUT_B    ; CHECK IF INPUT_B IS 1
                    GOTO    CLEAR_OUT         ; GOTO TO CLEAR_OUT
                    BTFSC   PORTB, INPUT_C    ; CHECK IF INPUT_C IS 1
                    GOTO    CLEAR_OUT         ; GOTO TO CLEAR_OUT
                    BTFSC   PORTB, INPUT_D    ; CHECK IF INPUT_D IS 1
                    GOTO    CLEAR_OUT         ; OTHERWISE, CLEAR THE OUTPUT
                    GOTO    SET_OUT           ; IF TRUE, SET THE OUTPUT

;******************************************************************
SET_OUT:
                    BSF     PORTA, OUTPUT_PIN ; SET RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

CLEAR_OUT:
                    BCF     PORTA, OUTPUT_PIN ; CLEAR RA0 (OUTPUT)
                    GOTO    TEST_INPUTS       ; LOOP BACK TO TEST_INPUTS

END
