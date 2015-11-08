/******************************************************************************
* @FILE p1_1000911250.s
* @BRIEF simple calculator
*
* @AUTHOR Victor Garcia
******************************************************************************/
 
    .global main
    .func main
   
main:
    
    BL  _scanf
    MOV R8, R0	
    BL  _getchar            @ branch to scanf procedure with return
    MOV R10, R0
    BL  _scanf
    MOV R9, R0
    BL  _compare
    BL  _print
    BL   main              @ branch to exit procedure with no return*/
   
_getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return

_scanf:
    MOV R4, LR              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    MOV PC, R4              @ return

_print:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    MOV R1, R1
    BL printf           @ call printf
    MOV PC, R4          @ return

_compare:
    CMP R10, #'+'           @ compare against the constant char '@'
    BEQ _add                @ branch to equal handler
    CMP R10, #'-'           @ branch to not equal handler
    BEQ _sub
    CMP R10, #'*'
    BEQ _mult
    CMP R10, #'M'
    BEQ _greater
    MOV PC, R4

_add:
    ADD R1, R8, R9
    MOV PC, LR

_sub:
    SUB R1, R8, R9
    MOV PC, LR

_mult:
    MUL R1, R8, R9
    MOV PC, LR

_greater:
    CMP R8, R9
    BGE  _great 
    BLE  _less

_great:
    MOV R1, R8
    MOV PC, LR
  
_less:
    MOV R1, R9
    MOV PC, LR   

.data
format_str:     .asciz      "%d"
read_char:      .ascii      " "
print_str:     .ascii      "%d\n\n"

