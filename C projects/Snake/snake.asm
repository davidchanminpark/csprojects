		.DATA
timer 		.FILL #150
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L2_snake
	LEA R7, L4_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L2_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L6_snake
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L7_snake
L6_snake
	LDR R7, R5, #3
	STR R7, R5, #-13
L7_snake
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L8_snake
	LEA R7, L10_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L8_snake
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L12_snake
L11_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L12_snake
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L11_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L14_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L14_snake
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L1_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L17_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L16_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L18_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
zero 		.FILL #255
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.DATA
one 		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.DATA
two 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.DATA
three 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
four 		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.DATA
five 		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
six 		.FILL #128
		.FILL #128
		.FILL #128
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #255
		.DATA
seven 		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.DATA
eight 		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #255
		.DATA
nine 		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-1
	JMP L23_snake
L20_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #1
L21_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L23_snake
	LDR R7, R5, #-1
	CONST R3, #25
	CMPU R7, R3
	BRn L20_snake
	LEA R7, snake_length
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, snake
	CONST R3, #10
	STR R3, R7, #0
	STR R3, R7, #1
	LEA R7, snake_direction
	CONST R3, #3
	STR R3, R7, #0
L19_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L28_snake
L25_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #1
L26_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L28_snake
	LDR R7, R5, #-1
	CONST R3, #5
	CMPU R7, R3
	BRn L25_snake
	LEA R7, bombs_count
	CONST R3, #0
	STR R3, R7, #0
L24_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;turn_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
turn_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	LEA R3, snake_direction
	LDR R3, R3, #0
	SUB R7, R7, R3
	STR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRn L32_snake
	LDR R7, R5, #-1
	CMP R7, R3
	BRnz L30_snake
L32_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
L30_snake
L29_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;grow_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
grow_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, snake
	ADD R2, R3, #-2
	ADD R2, R7, R2
	ADD R3, R3, #-4
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
	LEA R7, snake_length
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, snake
	ADD R2, R3, #-2
	ADD R2, R7, R2
	ADD R3, R3, #-4
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R2, #1
L33_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;move_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
move_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
	LEA R7, snake_length
	LDR R7, R7, #0
	ADD R7, R7, #-1
	STR R7, R5, #-1
	JMP L38_snake
L35_snake
	LDR R7, R5, #-1
	LEA R3, snake
	SLL R2, R7, #1
	ADD R2, R2, R3
	ADD R7, R7, #-1
	SLL R7, R7, #1
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
	LDR R7, R5, #-1
	LEA R3, snake
	SLL R2, R7, #1
	ADD R2, R2, R3
	ADD R7, R7, #-1
	SLL R7, R7, #1
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R2, #1
L36_snake
	LDR R7, R5, #-1
	ADD R7, R7, #-1
	STR R7, R5, #-1
L38_snake
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L35_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L39_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L40_snake
L39_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L41_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L42_snake
L41_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L43_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L44_snake
L43_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L44_snake
L42_snake
L40_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R7, #0
	CONST R2, #16
	CMP R3, R2
	BRp L49_snake
	CONST R7, #0
	STR R7, R5, #-3
	CMP R3, R7
	BRn L49_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	STR R7, R5, #-4
	CONST R3, #15
	CMP R7, R3
	BRp L49_snake
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	CMP R3, R7
	BRzp L45_snake
L49_snake
	CONST R7, #0
	JMP L34_snake
L45_snake
	CONST R7, #1
L34_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-6	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-5
	JMP L52_snake
L51_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #16
	MOD R7, R7, R3
	STR R7, R5, #-2
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #15
	MOD R7, R7, R3
	STR R7, R5, #-3
	CONST R7, #0
	STR R7, R5, #-4
	JMP L55_snake
L54_snake
	CONST R7, #0
	STR R7, R5, #-1
	JMP L60_snake
L57_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	STR R7, R5, #-6
	LDR R3, R5, #-2
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L61_snake
	LDR R7, R5, #-3
	LDR R3, R5, #-6
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L61_snake
	CONST R7, #1
	STR R7, R5, #-4
L61_snake
L58_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L60_snake
	LDR R7, R5, #-1
	CONST R3, #5
	CMPU R7, R3
	BRn L57_snake
	CONST R7, #0
	STR R7, R5, #-5
L55_snake
	LDR R7, R5, #-4
	CONST R3, #0
	CMP R7, R3
	BRz L54_snake
L52_snake
	LDR R7, R5, #-5
	CONST R3, #1
	CMP R7, R3
	BRz L51_snake
	LEA R7, fruit
	LDR R3, R5, #-2
	STR R3, R7, #0
	LDR R3, R5, #-3
	STR R3, R7, #1
L50_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_bomb;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_bomb
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-7	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-5
	JMP L65_snake
L64_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #16
	MOD R7, R7, R3
	STR R7, R5, #-2
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #15
	MOD R7, R7, R3
	STR R7, R5, #-3
	CONST R7, #0
	STR R7, R5, #-4
	JMP L68_snake
L67_snake
	LEA R7, fruit
	STR R7, R5, #-6
	LDR R3, R5, #-2
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L70_snake
	LDR R7, R5, #-3
	LDR R3, R5, #-6
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L70_snake
	CONST R7, #1
	STR R7, R5, #-4
L70_snake
	CONST R7, #0
	STR R7, R5, #-1
	JMP L75_snake
L72_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	STR R7, R5, #-7
	LDR R3, R5, #-2
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L76_snake
	LDR R7, R5, #-3
	LDR R3, R5, #-7
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L76_snake
	CONST R7, #1
	STR R7, R5, #-4
L76_snake
L73_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L75_snake
	LDR R7, R5, #-1
	CONST R3, #5
	CMPU R7, R3
	BRn L72_snake
	CONST R7, #0
	STR R7, R5, #-5
L68_snake
	LDR R7, R5, #-4
	CONST R3, #0
	CMP R7, R3
	BRz L67_snake
L65_snake
	LDR R7, R5, #-5
	CONST R3, #1
	CMP R7, R3
	BRz L64_snake
	LEA R7, bombs_count
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R5, #-2
	STR R3, R7, #0
	LEA R7, bombs_count
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #1
	LEA R7, bombs_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L63_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_bomb_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_bomb_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L82_snake
L79_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L83_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L83_snake
	CONST R7, #2
	JMP L78_snake
L83_snake
L80_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L82_snake
	LDR R7, R5, #-1
	CONST R3, #5
	CMPU R7, R3
	BRn L79_snake
	CONST R7, #0
L78_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_fruit_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_fruit_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, snake
	STR R7, R5, #-1
	LEA R3, fruit
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L86_snake
	LDR R7, R5, #-1
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L86_snake
	CONST R7, #3
	JMP L85_snake
L86_snake
	CONST R7, #0
L85_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_self_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_self_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-1
	JMP L92_snake
L89_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	ADD R3, R3, R7
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L93_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L93_snake
	CONST R7, #4
	JMP L88_snake
L93_snake
L90_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L92_snake
	LDR R7, R5, #-1
	CONST R3, #25
	CMPU R7, R3
	BRn L89_snake
	CONST R7, #0
L88_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collisions;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collisions
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR check_bomb_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #2
	CMP R7, R3
	BRnp L96_snake
	CONST R7, #2
	JMP L95_snake
L96_snake
	JSR check_fruit_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRnp L98_snake
	CONST R7, #3
	JMP L95_snake
L98_snake
	JSR check_self_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #4
	CMP R7, R3
	BRnp L100_snake
	CONST R7, #4
	JMP L95_snake
L100_snake
	CONST R7, #0
L95_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR move_snake
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRnp L103_snake
	CONST R7, #2
	JMP L102_snake
L103_snake
	JSR handle_collisions
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRz L107_snake
	CONST R3, #4
	CMP R7, R3
	BRnp L105_snake
L107_snake
	CONST R7, #2
	JMP L102_snake
L105_snake
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRnp L108_snake
	JSR spawn_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR grow_snake
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #5
	MOD R7, R7, R3
	CONST R3, #0
	CMP R7, R3
	BRnp L110_snake
	JSR spawn_bomb
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, timer
	LDR R7, R7, #0
	CONST R3, #30
	SUB R7, R7, R3
	CONST R3, #35
	CMP R7, R3
	BRnz L112_snake
	LEA R7, timer
	LDR R3, R7, #0
	CONST R2, #30
	SUB R3, R3, R2
	STR R3, R7, #0
L112_snake
	LEA R7, L114_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L110_snake
L108_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #25
	CMP R7, R3
	BRnp L115_snake
	CONST R7, #1
	JMP L102_snake
L115_snake
	CONST R7, #0
L102_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;index_to_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
index_to_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	SLL R7, R7, #3
L117_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L118_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L123_snake
L120_snake
	CONST R7, #0
	HICONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L121_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L123_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMPU R7, R3
	BRn L120_snake
L119_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L128_snake
L125_snake
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L126_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L128_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMPU R7, R3
	BRn L125_snake
L124_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, fruit
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L129_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;display_score;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
display_score
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L131_snake
	LEA R7, zero
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L131_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L133_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L133_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L135_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L135_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRnp L137_snake
	LEA R7, three
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L137_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #4
	CMP R7, R3
	BRnp L139_snake
	LEA R7, four
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L139_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #5
	CMP R7, R3
	BRnp L141_snake
	LEA R7, five
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L141_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #6
	CMP R7, R3
	BRnp L143_snake
	LEA R7, six
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L143_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #7
	CMP R7, R3
	BRnp L145_snake
	LEA R7, seven
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L145_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #8
	CMP R7, R3
	BRnp L147_snake
	LEA R7, eight
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L147_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #9
	CMP R7, R3
	BRnp L149_snake
	LEA R7, nine
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L149_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #10
	CMP R7, R3
	BRnp L151_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, zero
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L151_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #11
	CMP R7, R3
	BRnp L153_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L153_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #12
	CMP R7, R3
	BRnp L155_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L155_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #13
	CMP R7, R3
	BRnp L157_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, three
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L157_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #14
	CMP R7, R3
	BRnp L159_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, four
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L159_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #15
	CMP R7, R3
	BRnp L161_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, five
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L161_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #16
	CMP R7, R3
	BRnp L163_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, six
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L163_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #17
	CMP R7, R3
	BRnp L165_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, seven
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L165_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #18
	CMP R7, R3
	BRnp L167_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, eight
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L167_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #19
	CMP R7, R3
	BRnp L169_snake
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, nine
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L169_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #20
	CMP R7, R3
	BRnp L171_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, zero
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L171_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #21
	CMP R7, R3
	BRnp L173_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L173_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #22
	CMP R7, R3
	BRnp L175_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L175_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #23
	CMP R7, R3
	BRnp L177_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, three
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L177_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #24
	CMP R7, R3
	BRnp L179_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, four
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L179_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #25
	CMP R7, R3
	BRnp L130_snake
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, five
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L130_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_bombs
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR display_score
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L183_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;play_game;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
play_game
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	LEA R7, timer
	CONST R3, #150
	STR R3, R7, #0
	JSR init_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR reset_bombs
	ADD R6, R6, #0	;; free space for arguments
	JMP L186_snake
L185_snake
	LEA R7, timer
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #105
	CMP R7, R3
	BRnp L188_snake
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
L188_snake
	LDR R7, R5, #-1
	CONST R3, #106
	CMP R7, R3
	BRnp L190_snake
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
L190_snake
	LDR R7, R5, #-1
	CONST R3, #107
	CMP R7, R3
	BRnp L192_snake
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
L192_snake
	LDR R7, R5, #-1
	CONST R3, #108
	CMP R7, R3
	BRnp L194_snake
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
L194_snake
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L196_snake
	JMP L184_snake
L196_snake
	JSR update_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-2
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L198_snake
	LEA R7, L200_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L184_snake
L198_snake
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRnp L201_snake
	LEA R7, L203_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L184_snake
L201_snake
L186_snake
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L185_snake
L184_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	LEA R7, L205_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L206_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L208_snake
L207_snake
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L210_snake
	JMP L209_snake
L210_snake
	LDR R7, R5, #-1
	CONST R3, #114
	CMP R7, R3
	BRnp L212_snake
	LEA R7, L214_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L215_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L216_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR play_game
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, L217_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L212_snake
L208_snake
	JMP L207_snake
L209_snake
	CONST R7, #0
L204_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
bombs_count 		.BLKW 1
		.DATA
fruit 		.BLKW 2
		.DATA
bomb 		.BLKW 10
		.DATA
snake_direction 		.BLKW 1
		.DATA
snake_length 		.BLKW 1
		.DATA
snake 		.BLKW 50
		.DATA
L217_snake 		.STRINGZ "Press 'r' to play again, or 'q' to quit...\n"
		.DATA
L216_snake 		.STRINGZ "Eat food (red) to grow, and avoid bombs (white)\n"
		.DATA
L215_snake 		.STRINGZ "Use i, j, k, l to move\n"
		.DATA
L214_snake 		.STRINGZ "\nNew game!\n"
		.DATA
L206_snake 		.STRINGZ "Press 'r' to start\n"
		.DATA
L205_snake 		.STRINGZ "Welcome to Snake!\n"
		.DATA
L203_snake 		.STRINGZ "You won!\n"
		.DATA
L200_snake 		.STRINGZ "You won!\n"
		.DATA
L114_snake 		.STRINGZ "New bomb!\n"
		.DATA
L17_snake 		.STRINGZ "\n"
		.DATA
L10_snake 		.STRINGZ "-32768"
		.DATA
L4_snake 		.STRINGZ "0"
