; FX.asm
;
; Author:               Wahid Abdul Rahim
; Course:               CST 8216
; Student Number:       040 985 017
; Date:                 Nov 17 2021
;
; Purpose:      To illustrate how to solve an equation such as:
;               f(x) = 5x + 3 for x = 0 to 9, using 8-bit Multiplication
;               The calculated x in f(x) values will be placed into the X_Values array
;               The calculated f(x) values will be placed into the Results array
;
STACK           equ     $2000
ARRAY_LEN       equ     10      ; Number of values to calculate (10): x = 0 to 9
THREE           equ     3       ; Holds the value of the number 3
FIVE            equ     5       ; Holds the Valeu of the number 5

        org     $1020           ; org as per assignment instructions
X_Values
        ds      ARRAY_LEN       ; defines bytes starting at ehe memery location $1020
End_X_Values                    ; hold the memory location of the end X_Values + 1

        org     $1030           ; org as per assignment instructions
Results
        ds      ARRAY_LEN       ; Defines bytes to hold f(x)
End_Results                     ; holds the memory location of the end Results + 1

; Expected Results
;
;                       $1020   $1021   $1022   $1023   $1024   $1025   $1026   $1027   $1028   $1029
;                       0       1       2       3       4       5       6       7       8       9
;                       $1030   $1031   $1032   $1033   $1034   $1035   $1036   $1037   $1038   $1039
;                       3       8       d       12      17      1c      21      26      2b      30

        org     $2000           ; Start of RAM
        ldx     #X_Values       ; Loading X with the Aderess of X_Values
        ;ldy     #Results        ; Loading Y with the Aderess of Results
        ldaa    #0              ; Starting A at 0
Loop    staa    0,x             ; Adding A to where x is pointing
        ldab    #FIVE
        mul                     ; Muliplying A by 3 and storing the result in D NOTE: its small enough that a = 0, b = result
        addb    #THREE          ; Adding 3 to B
        ldaa    1,x+            ; Loading X into A then incrementing X
        stab    15,x            ; Storing B into Y and incrementing Y by 1
        inca                    ; Incrementing A to use for next Loop Iteration.
        cpx     #End_X_Values   ; Comparing X to End_X_Values
        lbne    Loop            ; Looping again if they're not equal. Ends the program otherwise.
        swi                     ; forces program to quit executing in memory
        end