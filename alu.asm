
INCLUDE EMU8086.INC     ;Including Library

org 100h

.data       ;Data Segment

msg_intro db ' 1. Addition', 0dh,0ah, ' 2. Subtration', 0dh,0ah, ' 3. Multiplication', 0dh,0ah, ' 4. Division', 0dh,0ah, ' 5. Negation', 0dh,0ah, ' 6. OR', 0dh,0ah, ' 7. AND ', 0dh,0ah, ' 8. XOR', 0dh,0ah, ' 9. NOT',0dh,0ah, ' 10. Modulus',0dh,0ah, ' 0. EXIT', '$'

msg_A db 'The SUM of two Numbers = $', 0dh,0ah       ;Printing Strings
msg_S db 'The SUBTRACTION of two Numbers = $', 0dh,0ah
msg_M db 'The MULTIPLICATION of two Numbers = $', 0dh,0ah
msg_D db 'The DIVISION of two Numbers = $', 0dh,0ah 
msg_N db 'The NEG numue of Number = $', 0dh,0ah 
msg_OR db 'The OR operation of two Number = $', 0dh,0ah
msg_AND db 'The AND operation of two  Number = $', 0dh,0ah 
msg_XOR db 'The XOR operation of two Number = $', 0dh,0ah 
msg_NOT db 'The NOT of Number = $', 0dh,0ah
msg_MD db 'The MODULUS of Two Numbers = $', 0dh,0ah

cont db 10,13,'Do you want to continue? $'
bye db '           *Exit* $'
      
num1 dw ?       ;Uninitialize
num2 dw ?       ;Uninitialize  
res dw ?
agn dw ?

.code       ;Code Segment
MAIN PROC
    
MOV AX, @data
MOV DS, AX

Start:                  ;Start Lable

print '             Arithmatic and Logical Operations    '  
printn      ;New Line

printn
MOV AH,9
MOV DX, OFFSET msg_intro
INT 21h                                          

printn
printn
print 'Choose the Operation: '
CALL scan_num
printn
printn

CMP CX, 0
JE _Bye         ;Jumps to Exit Func if input is equal to 0             


CMP CX, 1
JE Addition     ;Jumps to Addition Func if input is equal to 1


CMP CX, 2
JE Subtraction     ;Jumps to Substraction Func if input is equal to 2
   
   
CMP CX, 3
JE Multiplication     ;Jumps to Multiplication Func if input is equal to 3


CMP CX, 4
JE Division     ;Jumps to Division Func if input is equal to 4


CMP CX, 5
JE Negation     ;Jumps to Absolute Func if input is equal to 5


CMP CX, 6
JE _OR       ;Jumps to _OR Func if input is equal to 6


CMP CX, 7
JE _AND       ;Jumps to _AND Func if input is equal to 7


CMP CX, 8
JE _XOR       ;Jumps to _NOT Func if input is equal to 8


CMP CX, 9
JE _NOT       ;Jumps to _NOT Func if input is equal to 9


CMP CX, 10
JE Modulus    ;Jumps to Modulus Func if input is equal to 10

                       ;FUNCTIONS

Addition:       ;Addition Func

print '     ***--Addition--*'
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1        ;Moving num1 to AX reg
ADD AX, num2        ;Adding AX to num2
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_A    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg
                        
JMP Con                 ;Goes to Con Func               


Subtraction:        ;Subtraction Func

print '     ***--Subtraction--*'
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1        ;Moving num1 to AX reg
SUB AX, num2        ;Subtracting AX with num2
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_S    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg

JMP Con                 ;Goes to Con Func             


Multiplication:        ;Multiplication Func

print '     ***--Multiplication--*'
printn  
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1        ;`Moving num1 to AX reg
MUL num2            ;Multiplying AX with num2
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_M    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg

JMP Con                 ;Goes to Con Func


Division:        ;Division Func

print '     ***--Division--*' 
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1 
MOV AX, num1        ;Moving num1 to AX reg  

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2    
MOV BX, num2
printn

CMP BX, 0      ;if divisor = 2 
JE Error        ;overflow

MOV DX, 0           ;Moving 0 in DX to avoid overflow

DIV BX            ;Dividing AX with num2
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_D    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg

JMP Con                 ;Goes to Con Func


Negation:        ;Negation Func

print '     ***--Negation--*' 
printn
printn
print 'Enter Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

MOV AX, num1        ;Moving num1 to AX reg
NOT AX              ;Taking Neg of AX
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_N    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg

JMP Con                 ;Goes to Con Func


        
        
Modulus:

print '     ***--Modulus--*' 
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1 
MOV AX, num1        ;Moving num1 to AX reg  

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2    
MOV BX, num2
printn

MOV DX, 0           ;Moving 0 in DX to avoid overflow

DIV BX            ;Dividing AX with num2
MOV res, DX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_MD    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg

JMP Con                 ;Goes to Con Func



_OR:            ;OR Func

print '     ***--Binary OR--*'
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1
OR AX, num2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_OR    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints on screen

JMP Con


_AND:               ;AND Func

print '     ***--Binary AND--*'
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1
AND AX, num2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_AND    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints on screen

JMP Con
 
 
_XOR:               ;XOR Func

print '     ***--Binary XOR--*'
printn
printn
print 'Enter First Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

print 'Enter Second Number: '
CALL scan_num       ;Second no. input
MOV num2, CX        ;Moving second no. to num2
printn

MOV AX, num1
XOR AX, num2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_XOR    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints on screen

JMP Con
 

_NOT:             ;NOT Func               

print '     ***--Binary NOT--*'
printn  
printn
print 'Enter Number: '
CALL scan_num       ;First no. input
MOV num1, CX        ;Moving first no. to num1   

printn      ;New Line 

MOV AX, num1
NOT AX
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_NOT    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num

JMP Con


Error:    

printn
print 'Cannot be divided by 0. ' 
printn
print 'Undefined Math Error'
printn    
printn

JMP Division


Con:            ;Continue Func
 
printn
MOV AH,9
MOV DX, OFFSET cont    ;Displaying Message
INT 21h                 ;Calling Interrupt
print '(Yes = 1 / No = 0) : '
CALL scan_num           ;Enter 1 for Yes and 0 for No
MOV agn, CX
printn
printn

CMP agn, 1
JE Start            ;Jumps to Start Func if input is equal to 1                    

CMP agn, 0
JE _Bye             ;Jumps to Bye Func if input is equal to 0
printn


_Bye:       ;EXIT Func

printn
printn
MOV AH,9
MOV DX, OFFSET bye    ;Displaying Message
INT 21h                        


MAIN ENDP        


DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


END main

HLT         ;Halting                                            
ret         ;Return

ret




