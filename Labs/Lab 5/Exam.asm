; Exam.asm
; COMPLETED
; Name:                 < Wahid Abdul Rahim >
; Student Number:       < 040 985 017 >
;
; NOTE:                 No credit will be given if the above information is missing
;
; Final Exam Quiz instructions and this starter code
; provides instructions on what this program must do

; Program Constants

OFFSET          equ     $20             ; <== Calculate Constant Offset Addressing Mode
                                        ;     offset value from the Array to Index_Number_Array
                                        ;     using the appropriate adddresses.
                                        ;      You may HARD CODE this value.

DIVISOR         equ     18                ; <== Determine the divisor used with the
                                        ;     idiv instruction from Final Exam Quiz instructions
ARRAY_LEN       equ     End_Array-Array ; dynamic array size calculation
Index           equ     $00             ; Starting Array index
ORIG_ZERO       equ     $CC             ; if original Array value = 0, store this value
NON_ZERO        equ     $FF             ; if idiv results not equal to zero, store this value


        org     $1000
Array   db      0,18,35,55,72,0,0,126,144,0,0,198,215,235,252,0  ; cut and paste the array provided to you
                                        ; in the Final Exam Quiz instructions here
End_Array

        org    $1020                    ; <== Final Exam Quiz instructions contains
                                        ;     this value. Use this address to
                                        ;     calculate your offset for
                                        ;     CONSTANT OFFSET ADDRESSING mode
Index_Number_Array
                ds      End_Array-Array
End_Index_Number_Array
count   db      0

                org     $2000
                lds     #$2000
; your code goes here
                ldaa    $00
                staa    Index
                staa    count
                ldy     #Array
Loop            cpy     #End_Array
                beq     End
                ldab    0,y
                cmpb    $00
                beq     Zero
                ldx     #DIVISOR
                idiv
                cmpb    $00
                bne     BAD_R
                ldab    count
                stab    OFFSET,y
                bra     Inc
Zero            ldab    #ORIG_ZERO
                stab    $20,y
                bra     Inc
Bad_r           ldab    #NON_ZERO
                stab    OFFSET,y
                bra     Inc
Inc             ldab    #Index
                incb
                inc     count
                stab    Index
                iny
                bra     Loop
End             swi
                end

;============================================================
;       org     $1000
;Array db  0    14      0       28      34      35      70
;
;Index_Number_Array contents (example storage origin)
;
;       $1010   $1011   $1012   $1013   $1014   $1015   $1016
;       $CC     $01     $CC     $03     $FF     $05     $06
;
; $CC is stored when value read from Array equals $00
; $FF is stored when the value read from the Array is not $00,
;     has been divided by DIVISOR, but the Remainder indicates that
;      this value is not evenly divisible by DIVISOR,
;      which is 7 in this example

; $nn ? an integer number representing index of the Array where
;      the value read from the Array is not $00, has been
;      divided by DIVISOR, and the Remainder indicates that
;      this value is evenly divisible by DIVISOR,
;      which is 7 in this example

    ;START
    ;Initialize Constants and Variables (see 21F_Final_Exam.asm)
    ;Set index = 0
    ;Point to start of Array
    ;
    ;A Get the value at Array [index]
    ;IF (value is not equal to 0)
    ;            Divide value by 18
    ;            IF (remainder is equal to 0)
    ;                  Store the index of the Array at Array [index + OFFSET]
    ;            ELSE
    ;                  Store NON_ZERO value at Array [index + OFFSET]
    ;ELSE Store ORIG_ZERO at Array [index + OFFSET]
    ;      Increment pointer to Array
    ;      Increment index
    ;      IF index less than ARRAY_LEN branch back to A
    ;            ELSE end program
    ;END