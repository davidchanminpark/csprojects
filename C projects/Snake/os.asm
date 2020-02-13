;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : os.asm                                 ;
;  author      : 
;  description : LC4 Assembly program to serve as an OS ;
;                TRAPS will be implemented in this file ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;   OS - TRAP VECTOR TABLE   ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.OS
.CODE
.ADDR x8000
  ; TRAP vector table
  JMP TRAP_GETC           ; x00
  JMP TRAP_PUTC           ; x01
  JMP TRAP_GETS           ; x02
  JMP TRAP_PUTS           ; x03
  JMP TRAP_TIMER          ; x04
  JMP TRAP_GETC_TIMER     ; x05
  JMP TRAP_RESET_VMEM	  ; x06
  JMP TRAP_BLT_VMEM	      ; x07
  JMP TRAP_DRAW_PIXEL     ; x08
  JMP TRAP_DRAW_RECT      ; x09
  JMP TRAP_DRAW_SPRITE    ; x0A
  JMP TRAP_LFSR_SET_SEED  ; x0B
  JMP TRAP_LFSR           ; x0C
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;   OS - MEMORY ADDRESSES & CONSTANTS   ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; these handy alias' will be used in the TRAPs that follow
  USER_CODE_ADDR .UCONST x0000	; start of USER code
  OS_CODE_ADDR 	 .UCONST x8000	; start of OS code

  OS_GLOBALS_ADDR .UCONST xA000	; start of OS global mem
  OS_STACK_ADDR   .UCONST xBFFF	; start of OS stack mem

  OS_KBSR_ADDR .UCONST xFE00  	; alias for keyboard status reg
  OS_KBDR_ADDR .UCONST xFE02  	; alias for keyboard data reg

  OS_ADSR_ADDR .UCONST xFE04  	; alias for display status register
  OS_ADDR_ADDR .UCONST xFE06  	; alias for display data register

  OS_TSR_ADDR .UCONST xFE08 	; alias for timer status register
  OS_TIR_ADDR .UCONST xFE0A 	; alias for timer interval register

  OS_VDCR_ADDR	.UCONST xFE0C	; video display control register
  OS_MCR_ADDR	.UCONST xFFEE	; machine control register
  OS_VIDEO_NUM_COLS .UCONST #128
  OS_VIDEO_NUM_ROWS .UCONST #124
  
  DATA_MEMORY_START .UCONST x2000  ; start address of user data memory
  DATA_MEMORY_END .UCONST x7FFF    ; end address of user data memory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY RESERVATIONS ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
OS_GLOBALS_MEM	.BLKW x1000
;;;  LFSR value used by lfsr code
LFSR .FILL 0x0001

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY RESERVATION ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000
OS_VIDEO_MEM .BLKW x3E00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;   OS & TRAP IMPLEMENTATIONS BEGIN HERE   ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x8200
.FALIGN
  ;; first job of OS is to return PennSim to x0000 & downgrade privledge
  CONST R7, #0   ; R7 = 0
  RTI            ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - none
;;; Outputs          - R0 = ASCII character from ASCII keyboard

.CODE
TRAP_GETC
    LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp TRAP_GETC       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a single character out to ASCII display
;;; Inputs           - R0 = ASCII character to write to ASCII display
;;; Outputs          - none

.CODE
TRAP_PUTC
  LC R1, OS_ADSR_ADDR 	; R1 = address of display status reg
  LDR R1, R1, #0    	; R1 = value of display status reg
  BRzp TRAP_PUTC    	; if R1[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R1, OS_ADDR_ADDR 	; R1 = address of display data reg
  STR R0, R1, #0    	; R1 = value of keyboard data reg (R0)
  RTI			; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a string of characters from the ASCII keyboard
;;; Inputs           - R0 = Address to place characters from keyboard
;;; Outputs          - R1 = Lenght of the string without the NULL

.CODE
TRAP_GETS
  CONST R1, #0                     ; load 0 into length of string 
  LC R2, DATA_MEMORY_START         ; load start address into R2
  LC R3, DATA_MEMORY_END           ; load end address into R3
  CONST R4, x0A                   ; load ASCII for enter key into R4
  
  CMP R0, R2                       ; set up NZP
  BRn END_TRAP_GETS                ; if R0 is less than R2, input is not valid, end call, otherwise continue
  CMP R0, R3                       ; set up NZP
  BRp END_TRAP_GETS                ; if R0 is greater than R3, input is not valid, end call, otherwise continue
  
 LOOP
  LC R5, OS_KBSR_ADDR  ; R5 = address of keyboard status reg
  LDR R5, R5, #0       ; R5 = value of keyboard status reg
  BRzp LOOP       ; if R5[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

  LC R5, OS_KBDR_ADDR  ; R5 = address of keyboard data reg
  LDR R5, R5, #0       ; R5 = value of keyboard data reg
  
  CMP R4, R5    ; set up NZP
  BRz END_TRAP_GETS  ; if value of keyboard data is enter key, then end trap call, otherwise continue
  STR R5, R0, #0   ; write content value of keyboard data into address R0
  ADD R1, R1, #1   ; increment length of string
  ADD R0, R0, #1   ; increment address in R0
  JMP LOOP      ; loop back to listening for new input 
 END_TRAP_GETS
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a string of characters out to ASCII display
;;; Inputs           - R0 = Address for first character
;;; Outputs          - none

.CODE
TRAP_PUTS

  LC R1, DATA_MEMORY_START         ; load start address into R1
  LC R2, DATA_MEMORY_END           ; load end address into R2
  
  CMP R0, R1                       ; set up NZP
  BRn END_CALL                     ; if R0 is less than R1, input is not valid, end call, otherwise continue
  CMP R0, R2                       ; set up NZP
  BRp END_CALL                     ; if R0 is greater than R2, input is not valid, end call, otherwise continue
  
 LOAD
  ADD R4, R0, #0        ; copy address into R4
  LDR R0, R0, #0        ; load content of R0 (address) into R0 (now ASCII)
  BRz END_CALL          ; if R0 is null then end call, otherwise continue
  
 CHECK_STATUS
  LC R3, OS_ADSR_ADDR 	; R3 = address of display status reg
  LDR R3, R3, #0    	; R3 = value of display status reg
  BRzp TRAP_PUTC    	; if R3[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R3, OS_ADDR_ADDR 	; R3 = address of display data reg
  STR R0, R3, #0    	; R3 = value of keyboard data reg (R0)
  ADD R0, R4, #1        ; increment address that has been saved
  JMP LOAD              ; loop back to load next address
 END_CALL
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function:
;;; Inputs           - R0 = time to wait in milliseconds
;;; Outputs          - none

.CODE
TRAP_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0

  RTI       		; PC = R7 ; PSR[15]=0



;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - R0 = time to wait
;;; Outputs          - R0 = ASCII character from keyboard (or NULL)

.CODE
TRAP_GETC_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

 COUNT_GETC
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRn END_TIMER    	; If R1[15]=1, timer has gone off!
  
  LC R0, OS_KBSR_ADDR   ; R0 = address of keyboard status reg
  LDR R0, R0, #0       ; R0 = value of keyboard status reg
  BRzp COUNT_GETC      ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

  LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
  LDR R0, R0, #0       ; R0 = value of keyboard data reg
  JMP VALUE_FOUND      ; if keyboard value is found, then end the trap
 END_TIMER
  CONST R0, #0       ; if timer expires, R0 is set to NULL
 VALUE_FOUND
  RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_RESET_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; In double-buffered video mode, resets the video display
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE	
TRAP_RESET_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #1
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_BLT_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_BLT_VMEM - In double-buffered video mode, copies the contents
;;; of video memory to the video display.
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE
TRAP_BLT_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #2
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_PIXEL   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw point on video display
;;; Inputs           - R0 = row to draw on (y)
;;;                  - R1 = column to draw on (x)
;;;                  - R2 = color to draw with
;;; Outputs          - none

.CODE
TRAP_DRAW_PIXEL
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC  R4, OS_VIDEO_NUM_COLS  ; R4=number of columns

  CMPIU R1, #0    	         ; Checks if x coord from input is > 0
  BRn END_PIXEL
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_PIXEL
  CMPIU R0, #0    	         ; Checks if y coord from input is > 0
  BRn END_PIXEL
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_PIXEL

  MUL R4, R0, R4      	     ; R4= (row * NUM_COLS)
  ADD R4, R4, R1      	     ; R4= (row * NUM_COLS) + col
  ADD R4, R4, R3      	     ; Add the offset to the start of video memory
  STR R2, R4, #0      	     ; Fill in the pixel with color from user (R2)

END_PIXEL
  RTI       		         ; PC = R7 ; PSR[15]=0
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_RECT   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw rectangle on video display
;;; Inputs    R0 - x coordinate of upper-left corner of the rectangle
;;;           R1 - y coordinate of upper-left corner of the rectangle
;;;           R2 - length of rectangle 
;;;           R3 - width of rectangle
;;;           R4 - color of rectangle 
;;; Outputs   none

.CODE
TRAP_DRAW_RECT

  LC R5, DATA_MEMORY_START   ; Load x2000 into R5
  STR R2, R5, #0             ; Write in length into data memory
  
  CMPIU R1, #0    	         ; Checks if x coord from input is > 0
  BRn END_RECT
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_RECT
  CMPIU R0, #0    	         ; Checks if y coord from input is > 0
  BRn END_RECT
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_RECT
  
  CMPIU R2, #0               ; Checks if length is positive
  BRnz END_RECT
  CMPIU R3, #0               ; Checks if width is positive
  BRnz END_RECT
  
  ADD R5, R0, R2             ; Checks if length is valid from starting x coord
  CMPIU R5, #127
  BRp END_RECT
  ADD R6, R1, R3             ; Checks if width is valid from starting y coord
  CMPIU R6, #123
  BRp END_RECT
  
 FILL_RECT
  CMPI R3, #0   ; set up NZP
  BRnz END_RECT  ; if total width (# of total rows) are all filled up, finish, otherwise continue
  
 FILL_ROW
  CMPI R2, #0      ; sets up NZP
  BRz END_ROW     ; if row is filled up until total length then end row, if not continue
  LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
  LC R6, OS_VIDEO_NUM_COLS   ; R6=number of columns
  MUL R6, R1, R6      	     ; R6= (row * NUM_COLS)
  ADD R6, R6, R0      	     ; R6= (row * NUM_COLS) + col
  ADD R6, R6, R5      	     ; Add the offset to the start of video memory
  STR R4, R6, #0      	     ; Fill in the pixel with color from user R4
  ADD R2, R2, #-1     ; decrement length
  ADD R0, R0, #1      ; increment x coordinate
  JMP FILL_ROW
 END_ROW
  LC R5, DATA_MEMORY_START   ; load x2000 into R5
  LDR R2, R5, #0             ; load length into R2 
  ADD R3, R3, #-1     ; decrement width
  ADD R1, R1, #1      ; increment y coordinate
  SUB R0, R0, R2      ; return x coordinate to original position by subtracting it by width
  JMP FILL_RECT
 END_RECT
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_SPRITE   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw sprite on display
;;; Inputs    R0 - starting column in the video memory 
;;;           R1 - starting row in video memory
;;;           R2 - color of sprite
;;;           R3 - starting address of an array of 8 LC-4 words for bit pattern of the sprite
;;; Outputs   none

.CODE
TRAP_DRAW_SPRITE
  LEA R6, OS_GLOBALS_MEM  ; R6 contains starting address for memory in OS_GLOBALS_MEM
  STR R3, R6, #0    ; store original address for current sprite word in xA000
  CONST R5, #8      ; R6 contains counter of 8 for sprite words
  STR R5, R6, #1    ; store counter of sprite words into address xA001

 
 DRAW_DOWN
  CMPI R5, #0       ; set up NZP for sprite word counter
  BRz END_SPRITE    ; if 8 words have been drawn, end, otherwise continue
  LDR R4, R3, #0    ; load R4 with LC-4 word, R4 represents current sprite word that is used
  SLL R4, R4, #8    ; shift bits to the left 8 spaces
  CONST R5, #8      ; load new counter of 8 for drawing across - # of bits in word into R5
  
 DRAW_ACROSS
  CMPI R5, #0       ; set up NZP for counter
  BRz END_ACROSS    ; if counter has reached zero, end drawing across, otherwise continue
  CMPI R4, #0       ; set up NZP for MSB of R4
  BRzp DONT_DRAW    ; if word is positive or zero (leading 0), then do not draw, otherwise draw
  
  CMPIU R0, #127     ; set up NZP for x coordinate
  BRp DONT_DRAW     ; if x coordinate is outside the column, skip the drawing, otherwise continue
  CMPIU R0, #0       ; set up NZP for x coordinate
  BRn DONT_DRAW     ; if x coordinate is outside the column, skip the drawing, otherwise continue
  CMPIU R1, #123     ; set up NZP for y coordinate
  BRp DONT_DRAW     ; if y coordinate is outside the column, skip the drawing, otherwise continue
  CMPIU R1, #0       ; set up NZP for y coordinate
  BRn DONT_DRAW     ; if y coordinate is outside the column, skip the drawing, otherwise continue
  
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC R6, OS_VIDEO_NUM_COLS   ; R6=number of columns
  
  MUL R6, R1, R6   ; R6= (row * NUM_COLS)
  ADD R6, R6, R0   ; R6= (row * NUM_COLS) + col
  ADD R6, R3, R6   ; add offset xC000
  STR R2, R6, #0   ; fill in pixel with color 
  
 DONT_DRAW
  ADD R5, R5, #-1  ; decrement counter
  ADD R0, R0, #1   ; increment x coordinate
  SLL R4, R4, #1   ; shift one space to the left - introduces new MSB
  JMP DRAW_ACROSS  ; loop back to across with new bit 
 
 END_ACROSS
  LEA R6, OS_GLOBALS_MEM  ; R6 contains starting address for memory in OS_GLOBALS_MEM
  LDR R3, R6, #0   ; load current address of word into R3
  ADD R3, R3, #1   ; increment address to access new word
  LDR R5, R6, #1   ; load counter for words into R5
  ADD R5, R5, #-1  ; decrement counter 
  ADD R0, R0, #-8  ; subtract starting x coordinate by 8 to return to original position
  ADD R1, R1, #1   ; increment y coordinate to start new row 
  
  STR R3, R6, #0   ; store new address of word into xA000
  STR R5, R6, #1   ; store updated counter of words into xA001
  JMP DRAW_DOWN    ; loop back to DRAW_DOWN
  
 END_SPRITE
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_LFSR_SET_SEED   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Store seed in xA000
;;; Inputs    R0 - seed for LFSR_TRAP
;;; Outputs   none

.CODE
TRAP_LFSR_SET_SEED
LEA R1, OS_GLOBALS_MEM   ; load xA000 into R1
STR R0, R1, #0           ; write seed into xA000 address
RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_LFSR   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Implement LFSR algorithm and return pseudo-random number generated by algorithm in R0
;;; Inputs    none
;;; Outputs   R0 - pseudo-random number generated

.CODE
TRAP_LFSR
 LEA R1, OS_GLOBALS_MEM ; load R1 with address xA000 
 LDR R0, R1, #0         ; load data value from seed into R0
 LC R6, DATA_MEMORY_START ; load R6 with address x2000
 STR R7, R6, #0         ; write R7 into x2000
 JSR LFSR_SUB
 LC R6, DATA_MEMORY_START ; load R6 with address x2000
 LDR R7, R6, #0         ; load content in x2000 into R7 - the original R7 - PC+1 to return to from trap
RTI

.FALIGN
LFSR_SUB
 CONST R1, #2   ; set R1 as iteration counter for how many times a counter method should be run, one for R0[15] 
                ; and R0[13] and another for R0[12] and R0[10], init = 2
 CONST R2, #0   ; constant value of 0 to be used in XOR
 ADD R3, R0, #0 ; store R0 (seed) in a temp register R3
 CONST R4, #1   ; constant value of 1 to be used in XOR
 CONST R5, #0   ; R5 holds updated XOR value, init = 0
COUNTER
 CMPI R3, #0    ; set NZP (R3 - 0)
 BRzp POS ; if NZP is pos or zero, goto POS and XOR with 0, otherwise XOR with 1
 XOR R5, R5, R4 ; XOR with 1 and store in R5
 JMP NEXT
POS
 XOR R5, R5, R2 ; XOR with 0 and store in R5
NEXT
 SLL R3, R3, #2 
 CMPI R3, #0     ; set NZP (R3 - 0)
 BRzp POS_2; if NZP is pos or zero, goto POS2 and XOR with 0, otherwise XOR with 1
 XOR R5, R5, R4 ; XOR with 1 and store in R5
POS_2
 XOR R5, R5, R2 ; XOR with 0 and store in R5 
 SLL R3, R3, #1 ; shift seed one more to the left
 ADD R1, R1, #-1 ; decrement counter
 CMPI R1, #0    ; set NZP (R1 - 0)
 BRp COUNTER    ; if iteration counter has only run once (R1 = 1), then run counter one more time and loop it, 
                ; if not (R1 = 0) continue

 SLL R0, R0, #1 ; shift R0, the seed, one spot to the left
 ADD R0, R0, R5 ; add one to LSB if R5 was one, add zero if it was zero
 LEA R6, OS_GLOBALS_MEM ; load R1 with address xA000
 STR R0, R6, #0 ; write new stream into OS data memory stored in R6 (xA000)
RET


