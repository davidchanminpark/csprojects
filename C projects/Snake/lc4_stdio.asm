;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : lc4_stdio.asm                          ;
;  author      : 
;  description : LC4 Assembly subroutines that call     ;
;                call the TRAPs in os.asm (the wrappers);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; WRAPPER SUBROUTINES FOLLOW ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA 
.ADDR x4000 
store_R5_R6
    
.CODE
.ADDR x0010    ;; this code should be loaded after line 10
               ;; this is done to preserve "USER_START"
               ;; subroutine that calls "main()"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
    STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: TRAP_GETC doesn't require arguments!
		
	TRAP x00        ; Call's TRAP_GETC 
                    ; R0 will contain ascii character from keyboard
                    ; you must copy this back to the stack
	
	;; EPILOGUE ;; 
		; TRAP_GETC has a return value, so make certain to copy it back to stack
    STR R0, R5, #2  ; store return value
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
    
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_putc

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument from stack (starting address of string)
	TRAP x01        ; R0 must be set before TRAP_PUTC is called
	
	;; EPILOGUE ;; 
		; TRAP_PUTC has no return value, so nothing to copy back to stack
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_gets

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument from stack 
	TRAP x02        ; R0 must be set before TRAP_GETS is called
	
	;; EPILOGUE ;; 
    STR R1, R5, #2  ; store output in return value 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_puts

   ;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
    STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
    
    ;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument from stack (starting address of string)
	TRAP x03        ; R0 must be set before TRAP_PUTS is called
	
	;; EPILOGUE ;; 
		; TRAP_PUTC has no return value, so nothing to copy back to stack
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_trap_timer

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument from stack 
	TRAP x04        ; R0 must be set before TRAP_TIMER is called
	
	;; EPILOGUE ;; 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc_timer

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument from stack 
	TRAP x05        ; R0 must be set before TRAP_GETC_TIMER is called
	
	;; EPILOGUE ;; 
    STR R0, R5, #2  ; store output in return value 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_PIXEL Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_pixel

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R2, R5, #5  ; load R2 with argument (color) from stack 
    LDR R1, R5, #4  ; load R1 with argument (x coord) from stack 
    LDR R0, R5, #3  ; load R0 with argument (y coord) from stack 
	TRAP x08        ; R0-R2 must be set before TRAP_DRAW_PIXEL is called
	
	;; EPILOGUE ;; 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_RECT Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_rect

; MAKESURETO SAVE R5 and R6 before TRAP and get it after TRAP for this one and draw_sprite!!

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LEA R3, store_R5_R6  ; load R3 with data memory address
    STR R5, R3, #0  ; store frame pointer into store_R5_R6 in data memory
    STR R6, R3, #1  ; store stack pointer into store_R5_R6 in data memory
    LDR R4, R5, #7  ; load R4 with argument (color) from stack 
    LDR R3, R5, #6  ; load R3 with argument (width) from stack 
    LDR R2, R5, #5  ; load R2 with argument (length) from stack
    LDR R1, R5, #4  ; load R1 with argument (y coord of upper-left corner) from stack 
    LDR R0, R5, #3  ; load R0 with argument (x coord of upper-left corner) from stack
	TRAP x09        ; R0-R4 must be set before TRAP_DRAW_RECT is called
	
	;; EPILOGUE ;; 
    LEA R3, store_R5_R6  ; load R3 with data memory address
    LDR R5, R3, #0  ; load R5 with original frame pointer
    LDR R6, R3, #1  ; load R6 with original stack pointer
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_SPRITE Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_sprite

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LEA R3, store_R5_R6  ; load R3 with data memory address
    STR R5, R3, #0  ; store frame pointer into store_R5_R6 in data memory
    STR R6, R3, #1  ; store stack pointer into store_R5_R6 in data memory
    LDR R3, R5, #6  ; load R3 with argument (starting address of array) from stack 
    LDR R2, R5, #5  ; load R1 with argument (color) from stack 
    LDR R1, R5, #4  ; load R0 with argument (starting row) from stack
    LDR R0, R5, #3  ; load R0 with argument (starting column) from stack
	TRAP x0A        ; R0-R3 must be set before TRAP_DRAW_SPRITE is called
	
	;; EPILOGUE ;; 
    LEA R3, store_R5_R6  ; load R3 with data memory address
    LDR R5, R3, #0  ; load R5 with original frame pointer
    LDR R6, R3, #1  ; load R6 with original stack pointer 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR_SET_SEED Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr_set_seed

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3  ; load R0 with argument (seed for LFSR_TRAP) from stack 
	TRAP x0B        ; R0 must be set before TRAP_LFSR_SET_SEED is called
	
	;; EPILOGUE ;; 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr

	;; PROLOGUE ;;
    STR R7, R6, #-2	; save return address
	STR R5, R6, #-3	; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
		
	;; FUNCTION BODY ;;
		; TODO: write code to get arguments to the trap from the stack
		;  and copy them to the register file for the TRAP call
	TRAP x0C        ; put a random seed into OS memory 
	TRAP x0B
	;; EPILOGUE ;; 
    LDR R0, R5, #2  ; store output in return value 
    ADD R6, R6, #3  ; decrease stack
    LDR R5, R6, #-3 ; restore frame pointer
    LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_RESET_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_reset_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!
  
    ;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	;; no arguments
	TRAP x06
	;; epilogue
	LDR R5, R6, #0
	LDR R7, R6, #1
	ADD R6, R6, #2
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_BLT_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_blt_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!

	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	;; no arguments
	TRAP x07
	;; epilogue
	LDR R5, R6, #0
	LDR R7, R6, #1
	ADD R6, R6, #2
RET
