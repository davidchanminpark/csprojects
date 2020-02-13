;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial.asm                          ;
;  author      : 
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;; pseudo-code of factorial algorithm
;
; A = 5 ;  // example to do 5!
; B = A ;  // B=A! when while loop completes
;
; while (A > 1) {
; 	A = A - 1 ;
; 	B = B * A ;
; }
;

;;; TO-DO: Implement the factorial algorithm above using LC4 Assembly instructions

; register allocation: R0=A, R1=B

.FALIGN
SUB_FACTORIAL
;; prologue
STR R7, R6, #-2    ; save caller's return address
STR R5, R6, #-3    ; save caller's frame pointer 
ADD R6, R6, #-3    ; updates stack pointer
ADD R5, R6, #0     ; creates/updates frame pointer

LDR R0, R5, #3     ; copy argument from caller into R0

SETUP
  ADD R1, R0, #0 ; B=A
CHECK
  CMPI R0, #7      ; sets NZP (A - 7)
  BRp FAIL_INPUT   ; tests NZP, checks if input is less than or equal to 7 - the largest number possible to do a factorial in this program (was A - 7 pos? if yes, go to FAIL_INPUT)
  CMPI R0, #1      ; sets NZP (A - 1)
  BRnz FAIL_INPUT  ; tests NZP - checks if input is greater than 0 (was A - 1 neg or zero?, if yes, go to FAIL_INPUT)
START
  CMPI R0, #1      ; sets NZP (A - 1)
  BRnz END_FACTORIAL ; tests NZP (was A - 1 neg or zero?, if yes, go to END_FACTORIAL)
  ADD R0, R0, #-1  ; A = A - 1
  MUL R1, R1, R0   ; B = B * A
  BRnzp START  ; always goto START
FAIL_INPUT
  CONST R1, #-1    ; sets R1 to 0 if input is invalid
END_FACTORIAL

;; epilogue

ADD R6, R6, #3     ; decrease stack
STR R1, R6, #-1    ; update R1 (output) - return value
LDR R5, R6, #-3    ; restore base/frame pointer 
LDR R7, R6, #-2    ; restore R7, R6, #-2
RET

