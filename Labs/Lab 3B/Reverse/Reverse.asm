; Reverse.asm
;
; Author:               D. Haley, Professor, for CST8216
; Modified by:          <Shahram Ahmad  &&  Wahid Abdul Rahim>
; Student Number(s):    <  040971488    &&      040985017    >
; Lab Section(s):       <    301        &&         302       >
; Course:               CST8216 Fall 2021
; Date:                 <November 26th, 2021>

; Purpose       To copy and reverse an array using the supplied
;               Flowchart while performing the following:
;               additional operations to decrypt the Secret Message.
;               After reading in an 8-bit value from the Source Array,
;               we decrypt the value by
;               a. dividing the value by 2
;               b. then adding 32 to the value
;               c. then storing the value in the Destination Array
;
; Decryption Constants
DIVISOR         equ     2        ; Values in supplied array will be divided by
                                ; this value
ADDED_VALUE     equ     32      ; Dividend value will have 32 added to it


                org     $1000
Source_Array
#include A3B_Array.txt
End_Source_Array


                org    $1020    ; Secret Message will appear
                                ; starting here
Destination_Array
                ds      End_Source_Array-Source_Array   ; auto calculate Array Size
End_Destination_Array




                org     $2000
                lds     #$2000                        ; Initialize Stack


                ldx     #End_Source_Array-1           ;start X at beginning of source array
                                                    ; or i can just say End_Source_Array-1
                                                  ;decrement x once before to break the gap.
                ldy     #Destination_Array        ;start Y at end of dest array


B               ldab    1,x-                    ;load contents of source[X] into A and dec x

                pshx
                
                ldx     #DIVISOR
                idiv

                
                addb     #ADDED_VALUE
                leax      d,x
                ;ABX
                exg       d,x


                 stab     1,y+


                pulx

                cpx     #Source_Array       ;check if y has reached beginning of source_array
                lbge     B                ;keep going, if not true
                ;beq       DONE
                 ;bra       B

DONE
                end







































