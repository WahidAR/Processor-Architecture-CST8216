; GradesII.asm
;
; Author:               Wahid Abdul Rahim
; Course:               CST8216
; Student Number:       040 985 017
; Date:                 Nov 17 2021
;
; Purpose:              To Tally up the number of As, Bs, Cs, Ds and Fs
;                       from a Grades Array as per 21F Flowchart for GradesII
;                       which uses a Nested-IF structure
;
; Expected Result
;                       F       D       C       B       A
;                       $1020   $1021   $1022   $1023   $1024
;                       4       1       3       4       4

; Constants
STACK   equ     $2000   ; initiating the stack pointer.
A_Grade equ     'A'     ; The ASCII value of A
B_Grade equ     'B'     ; The ASCII value of B
C_Grade equ     'C'     ; The ASCII value of C
D_Grade equ     'D'     ; The ASCII value of D
F_Grade equ     'F'     ; The ASCII value of F

        org     $1000   ; as per assignment instructions
Grade                   ; Loads Grades with the code from the supplied files
#include Grades.txt     ; Grades file supplied for assignment
End_Grades              ; pointer to 1+ the last entery of the Grades array

        org     $1020   ; the starting location to store subsuqent grade counters
Num_Fs  db      0       ; a variable to hold the number of F grades.
Num_Ds  db      0       ; a variable to hold the number of D grades.
Num_Cs  db      0       ; a variable to hold the number of C grades.
Num_Bs  db      0       ; a variable to hold the number of B grades.
Num_As  db      0       ; a variable to hold the number of A grades.

        org     $2000   ; Starting the logic portion of the code at $2000
        lds     #STACK  ; Loading the Stack
        ldaa    #00     ; initalizing Num_Fs - Num_As to 0
        staa    Num_Fs
        staa    Num_Ds
        staa    Num_Cs
        staa    Num_Bs
        staa    Num_As
        ldx     #Grade  ; Loading register X with the memory aderess of Grade
B       ldaa    1,x+    ; Loading Acumulator A with X and then incrementing X
        cmpa    #F_Grade; Compares the grade in Acumulator A with the ASCII value of 'F'
        beq     Inc_F   ; if they're equal, branches to Inc_F
        cmpa    #D_Grade; Compares the grade in Acumulator A with the ASCII value of 'D'
        beq     Inc_D   ; if they're equal, branches to Inc_D
        cmpa    #C_Grade; Compares the grade in Acumulator A with the ASCII value of 'C'
        beq     Inc_C   ; if they're equal, branches to Inc_C
        cmpa    #B_Grade; Compares the grade in Acumulator A with the ASCII value of 'B'
        beq     Inc_B   ; if they're equal, branches to Inc_B
        bra     Inc_A   ; brances to Inc_A
Inc_F   ldaa    Num_Fs  ; Loads Acumulator A Num_Fs
        inca            ; Adds 1 to Acumulator A
        staa    Num_Fs  ; Stores the new value of Acumulator A back into Num_Fs
        bra     A       ; Branches to the instructions labled as A
Inc_D   ldaa    Num_Ds  ; Loads Acumulator A Num_Ds
        inca            ; Adds 1 to Acumulator A
        staa    Num_Ds  ; Stores the new value of Acumulator A back into Num_Ds
        bra     A       ; Branches to the instructions labled as A
Inc_C   ldaa    Num_Cs  ; Loads Acumulator A Num_Cs
        inca            ; Adds 1 to Acumulator A
        staa    Num_Cs  ; Stores the new value of Acumulator A back into Num_Cs
        bra     A       ; Branches to the instructions labled as A
Inc_B   ldaa    Num_Bs  ; Loads Acumulator A Num_Bs
        inca            ; Adds 1 to Acumulator A
        staa    Num_Bs  ; Stores the new value of Acumulator A back into Num_Bs
        bra     A       ; Branches to the instructions labled as A
Inc_A   ldaa    Num_As  ; Loads Acumulator A Num_As
        inca            ; Adds 1 to Acumulator A
        staa    Num_As  ; Stores the new value of Acumulator A back into Num_As
        bra     A       ; Branches to the instructions labled as A
A       cpx     #End_Grades     ;Compares x with the memory adreress of #End_Grades
        lbne    B       ; Aslong as X does not equal the memeory aderess of #End_Grades
        swi             ; forces program to quit executing in memory
        end             ; Ends the program.