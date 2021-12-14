; Array_Fun.asm
; Author: D. Haley, Faculty, 26 Nov 2021
;
; Student Name(s):      < Shahram Ahmad  &&  Wahid Abdul Rahim >
; Student Number(s):    <   040971488    &&      040985017     >
; Lab Section(s):       <      301       &&         302        >
; Modification Date:    <          December 10 2021            >
;
;
; Purpose:      The purpose of this program is to gain further experience with
;               the use of Arrays in 68HCS12 Assembly Language by performing
;               the following Tasks:
;
;               a. Determine the Maximum value in the Array and store the
;                  value at Max
;               b. Determine the Minumum value in the Array and store the
;                  value at Min
;               c. Using the value stored at Max, determine how often that
;                  value occurs in the Array and store that value at NumMax
;               d. Using the value stored at Min, determine how often that
;                  value occurs in the Array and store that value at NumMin
;               e. Range tells how far apart the Max and Min numbers are in a set
;                  It is the positive difference between the two values
;                  Using the values in Max and Min, subtract those two
;                  values a store the result at Range
;               f. MidRange is the Average of the Range - e.g. Range / 2
;                  Using the Values of Range and DIVISOR, calculate the
;                  MidRange using idiv (mandatory) and store an 8-bit version of
;                  the Answer at MidRange and an 8-bit version of the Reminder
;                  at MidRange+1
;               g. Display NumMax and NumMin on the two right-most HEX Displays
;                  (like you did with the Counter), alternating their
;                  displayed values every 250 ms. This coding is provided for you.
;                  NOTE: API.s19 must be loaded in order for this feature to work.
;               h. Code must run correctly for more than one program run
;                  e.g. File -> Reset, the GO on Simulator must give same results

; --- Do Not Change Code marker ---
; Library Routines used in this software
;
Config_Hex_Displays         equ        $2117
Delay_Ms                    equ        $211F
Hex_Display                 equ        $2139

                                ; Port P (PPT) Display Selection Values
DIGIT1_PP2      equ     %1011   ; 2nd from Right-most display MSB
DIGIT0_PP3      equ     %0111   ; Right-most display LSB

; Delay Subroutine Values
DVALUE  equ     #250            ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second <- good for Dragon12 Board

DIVISOR equ     $02

        org     $1000
Array
#include 21F_Array.txt
EndArray

        org     $1030
Max     ds      1
Min     ds      1

        org     $1040
NumMax  ds      1
NumMin  ds      1

        org     $1050
Range           ds      1
MidRange        ds      2

        org     $2000
        lds     #$2000

; --- End of Do Not Change Code marker ---

; your code goes here (as many lines at it takes)
        ldx     #Array          ; Loading register (x) with the memory address of the Array.txt file, which will point to the zeroth index.
        clr     NumMin          ; Clearing the value of NumMax so it resets on every run.
        clr     NumMax          ; Clearing the value of NumMax so it resets on every run.
        ldaa    0,x             ; Loading accumulator (a) with the value at memory address (x) which points to Array.txt and it's $1000.
        staa    Min             ; Storing into accumulator (a) the value thats at Min.
; goes through Array, finds Max and Min. also finds the range. also, puts the sum of Array into A.
Start   cpx     #EndArray       ; Checks to see if we've reached the end of the array.
        lbeq    Next            ; If we reached the end of the array, goes to the next step of the assigment.
        ldab    1,x+            ; Loads b with the next value of the array then, has x incrment by 1.
        cmpb    Max             ; Compares B with whats in Max.
        blo     cmpMIN          ; If B is lower, does nothing and goes to cmpMIN.
        stab    Max             ; If B is greater, replaces whats in Max with B.
cmpMIN  cmpb    Min             ; Compares B with whats in Min.
        bhi     Start           ; If B is greater, does nothing and goes back to the start of the loop.
        stab    Min             ; If B is lower, replaces whats in Min with B.
        bra     Start           ; Brances back to the start of the loop.
; goes through the array and counts the number of min and max occurences.
Next    ldx     #Array          ; Reloads X with the adderess of the Array.
Start2  cpx     #EndArray       ; Checks to see if we've reached the end of the array.
        lbeq    Next2           ; If we reached the end of the array, goes to the next step of the assigment.
        ldab    1,x+            ; Loads b with the next value of the array then, has x incrment by 1.
        cmpb    Min             ; Compares B with whats in Min.
        bne     IMAX            ; if B is not equal to Min, does nothing and goes to IMAX.
        inc     NumMin          ; incrementing NumMin to get the total amount of times the NumMin is repeated.
IMAX    cmpb    Max             ; Compares B with whats in Max.
        bne     Start2          ; if B is not equal to Max, does nothing and goes back to the start of the loop.
        inc     NumMax          ; Incrementing NumMax to get the total amount of times the NumMax is repeated.
        bra     Start2          ; Brances back to the start of the loop.
; finds the range, mid-Range and mid-rage-quotiont
Next2   ldaa    #0              ; Loading accumulator (a) with the value 0 as to not interfear with whats in (D).
        ldab    Max             ; Loading accumulator (b) with the value at Max.
        subb    Min             ; (b) is now containing the value Max. Subtracting the value at accumulator (b) with the value at Min.
        stab    Range           ; Stores (b) in Range and (b) now becomes our range.
        ldx     #DIVISOR        ; Loads X with DIVISOR (2).
        idiv                    ; Divides whats in D by whats in X. stores the result in X, stores the remainder in D.
        stab    MidRange+1      ; Storing the Last 8 bits of D (B). into MidRange+1 which is MidRangeQuotient as per assignment instructions.
        tfr     x,d             ; Transferring the values from register (x) to register (d) because (x) contains the answer.
        stab    MidRange        ; Storing the Last 8 bits of D (B) into MidRange.

; --- Do Not Change Code marker ---

        ; Output Results to Hex Displays

        ; NOTE 1 : API.s19 must be loaded in order for this feature
        ; NOTE 2 : Once you STOP the execution of the code in simulator,
        ;          you will be able to see the calculated values in memory
        ;          at the memory locations specified in the assignment.

        jsr     Config_HEX_Displays ; Use the Hex Displays to display the count
Display ldaa    NumMax
        ldab    #DIGIT1_PP2     ; select 2nd from Right Most HEX Display
        jsr     HEX_Display     ; Display the value
        ldaa    #DVALUE         ; delay for DVALUE milliseconds
        jsr     Delay_ms
        ldaa    NumMin
        ldab    #DIGIT0_PP3     ; select Right Most HEX Display
        jsr     HEX_Display     ; Display the value
        ldaa    #DVALUE         ; delay for DVALUE milliseconds
        jsr     Delay_ms
        bra     Display
        swi
        end
; --- End of Do Not Change Code marker ---




