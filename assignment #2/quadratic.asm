;Kaitlin Frani
;CPSC240-5 Quadratic Formula Calculator Assignment #2

;================Open Source License============================================================================================
; Program name: "Quadratic Formula Calculator"
; We want to find out the roots of a quadratic equation given floating point values.
; Copyright (C) 2021 Kaitlin Frani.

;This program is free software: you can redistribute it and/or modify it under the terms
;of the GNU General Public License version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
;without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;================End of Open Source License=============================================================================================================

;================Author, Program, File Identification============================================================
;Author information
;  Author name: Kaitlin Frani
;  Author email: kaitlinfrani@csu.fullerton.edu

;Program information
;  Program name: Quadratic Formula Calculator
;  Programming languages: Two modules in C++, one module in C, and one module in X86
;  Date program began: 2021-Feb-24
;  Date of last update: 2021-Feb-27
;  Date of reorganization of comments: 2021-Feb-27
;  Files in this program: isfloat.cpp quad_library.cpp second_degree.c
;  Status: Finished. No errors when ran.

;This file
;   File name: quadratic.asm
;   Language: X86 with Intel syntax.
;   Assemble: nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm
;================End of Author, Program, File Identification=====================================================

;===========================Begin Declarations===================================================================
extern printf
extern scanf
extern atof
extern isfloat
extern show_no_root
extern show_one_root
extern show_two_root
global quadratic ;will use the function from driver file

segment .data

intro db "This program will find the roots of any quadratic equation.",10, 10
      db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character: ",0
string_three db "%s",0  ;convert string input to float
valid_equation db 10, "Thank you. The equation is %.8lfx^2 + %.8lfx + %.8lf = 0.0", 10, 10, 0
return db 10, "One of these roots will be returned to the caller function.",10, 0
invalid_message db 10, "Invalid input data detected. You may run this program again.", 10, 0

segment .bss
    array: resq 3   ;for the 3 inputs

segment .text

quadratic:
;===========================End of Declarations==================================================================

;======Backing up all registers + setting stack pointer to base pointer==========================================
push rbp
mov rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf
;======End of backing up registers===============================================================================

;=============Begin setting counter and max # of inputs==========================================================
mov r12, 0  ;counter
mov r13, 3  ;max # of inputs
mov r14, 0  ;flag for square root of negative
;============End of setting counter and max # of inputs==========================================================

;======Begin intro message=======================================================================================
;create 1024 bytes of space for possible long string
sub rsp, 1024

mov rdi, string_three
mov rsi, intro
mov rax, 0
call printf
;======End of intro message======================================================================================

;=======Begin input loop=========================================================================================
beginloop:        ;input loop begins

cmp r12, r13      ;compares counter which is 0(r12) to the limit 3 (r13)
jge valid_inputs  ;jumps to check inputs
;======End of input loop=========================================================================================

;===========Begin setting 3 max inputs===========================================================================
inc r12       ;increments r12 each time user inputs a number
mov rsi, r12  ;passes r12 in input string so that it knows 3 is max
mov rax, 0
;============End of setting 3 max inputs=========================================================================

;===============Begin User Input=================================================================================
;push qword 0
mov rdi, string_three ;pass string three to take user input as a string "%s"
mov rsi, rsp          ;points rsi to top of stack to place input value of scanf
mov rax, 0            ;set rax to 0 to let scanf know incoming float
call scanf
;pop rax
;===========End of User Input====================================================================================

;=============Begin Input Validation Check=======================================================================
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid_input  ;jump to invalid input if not float
;============End of Input Validation Check=======================================================================

;============Begin ASCII to float convert========================================================================
mov rax, 0
call atof
;============End of ASCII to float convert=======================================================================

;=============Begin Move Input to an Array ======================================================================
movq [array + 8 * (r12 - 1)], xmm0
addsd xmm15, [array + 8 * (r12 - 1)]

jmp beginloop
;=============End of Move Input to an Array======================================================================

;============Begin Input Validation==============================================================================
;Invalid input
invalid_input:
mov rax, 0
mov rdi, string_three
mov rsi, invalid_message
call printf
jmp end

;Valid input
valid_inputs:
;check if user inputs 0.0 for a, then invalid.
mov r15, 0
cvtsi2sd xmm8, r15
ucomisd xmm8, [array]
je invalid_input
push qword 0
;=============End of Input Validation============================================================================

;======Begin section of Displaying Numbers=======================================================================
;output three float
push qword 0
movsd xmm0, [array]       ;a
movsd xmm1, [array + 8]   ;b
movsd xmm2, [array + 16]  ;c
mov rdi, valid_equation   ;"The equation is..."
mov rax, 3
call printf
pop rax
pop rax
;======End of Displaying Numbers=================================================================================

;============Begin Root Calculation==============================================================================
;First find discriminant b^2 - 4*a*c
mov r8, 4 ;putting integer 4 in r8
cvtsi2sd xmm8, r8 ;puts 4 into xmm9, converts to float
movsd xmm15, [array]      ;putting a into xmm15
movsd xmm14, [array + 8]  ;putting b into xmm14
movsd xmm13, [array + 16] ;putting c into xmm13

mulsd xmm14, [array + 8]  ;multiplying b*b putting into xmm14
mulsd xmm15, [array + 16] ;multiplying 1st and 3rd, putting value into xmm15 (ac)
mulsd xmm15, xmm8         ;multiplying 4*ac, putting into xmm15
subsd xmm14, xmm15        ;doing b^2(xmm14) - 4ac(xmm15)
movsd xmm12, xmm14        ;copy of discriminant in xmm12
;discriminant is now in xmm12 and xmm14

;comparing if discriminant is >,=,or < 0
mov r9, 0           ;putting 0 into r9 to compare
cvtsi2sd xmm9, r9   ;turning 0 into float, putting it in xmm9
ucomisd xmm14, xmm9 ;comparing discriminant with 0
ja two_roots
je one_root
jb no_root

;will compare if greater than 0, then find two roots
two_roots:
;-b + (sqrt(discriminant)) / 2a
sqrtsd xmm14, xmm14   ;do sqrt of discriminant, put sqrt into xmm14
mov r9, -1  ;for -b
cvtsi2sd xmm10, r9    ;turning -1 to float, putting -1 into xmm10
mulsd xmm10, [array + 8]  ;multiplying -1 with b, putting it into xmm10
movsd xmm11, xmm10 ;make copy of -b, put into xmm11
movsd xmm12, xmm11
addsd xmm11, xmm14    ;-b + sqrt(discriminant) is in xmm11
mov r10, 2  ;for 2a
cvtsi2sd xmm7, r10    ;turning 2 into float, put into xmm7
mulsd xmm7, [array]   ;xmm7 has 2a
divsd xmm11, xmm7     ;doing sqrt of discriminant / 2a

;-b - (sqrt(discriminant(xmm1))) / 2a
subsd xmm10, xmm14  ;-b - sqrt of discriminant
divsd xmm10, xmm7   ;sqrt of discriminant / 2a
movsd xmm12, xmm10  ;making copy putting it into xmm12

mov rax, 2    ;outputting two values
movsd xmm0, xmm11   ;root1
movsd xmm1, xmm10   ;root2
call show_two_root
jmp endfunction

;if equal to 0
one_root:
;-b/2*a
mov r10, 2  ;for 2a
cvtsi2sd xmm7, r10
mulsd xmm7, [array] ;xmm7 has 2a
movsd xmm12, xmm7
divsd xmm12, xmm7   ;xmm12 has -b/2a
mov rax, 1     ;outputting one value
movsd xmm0, xmm12
movsd xmm10, xmm0
call show_one_root
jmp endfunction

;if less than 0
no_root:
mov rax, 0    ;outputting no value
call show_no_root
jmp end
;=================End of Root Calculation========================================================================

;======Begin ending messages before exiting program==============================================================
endfunction:
;display return message
push qword 0
mov rax, 0
mov rdi, return     ;"One of these roots will be returned to the caller function"
call printf
pop rax

movsd xmm0, xmm10   ;grabs a root, returns it to driver file

;no root jumps here to output 0.0
end:
movsd xmm0, xmm10

;since we did sub, we need to add, even the # of pushes and pops
add rsp, 1024
;======End of ending message before exiting program==============================================================

;======Restoring all registers to their original values==========================================================
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret
;================================================================================================================
