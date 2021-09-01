;********************************************************************************************
; Program name:          Sum of Float Numbers in an Array                                   *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input floats into an array and         *
;                        returns the floats entered and sum of floats in the array.         *
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Kaitlin Frani                                                               *
; Email:        kaitlinfrani@csu.fullerton.edu                                              *
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2021 Kaitlin Frani                                                          *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Sum of Float Numbers in an Array                                          *
;   Programming languages: One module in C, One module in C++, Three modules in X86         *
;   Files in this program: control.asm, fill.asm, sum.asm, main.c, display.cpp              *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      control.asm                                                                 *
;    Purpose:   To manage all the files in the program and call to functions fill,          *
;               sum and display as needed. It also gets the value of sum and returns it.    *
;                                                                                           *
;********************************************************************************************

extern printf
extern scanf
extern fill
extern display
extern sum

array_size equ 100                 ;capacity for number of elements allowed in array.

global control

section .data
    intro db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Kaitlin F.", 10, 0
    numbers_entered db 10, "The numbers you entered are these: ", 10, 0
    sum_values db "The sum of these values is %.8lf.", 10, 0
    sumprompt db "The control module will now return the sum to the caller module.", 10, 0
    floatformat db "%lf", 10, 0

section .bss
    floatArray: resq 100           ;array with 100 reserved qwords

section .text

control:

; Back up all registers and set stack pointer to base pointer
push rbp
mov rbp, rsp
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

push qword -1                          ;extra push to create even number of pushes

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------
mov r14, 0                        ;number of elements in array.
mov r13, 0                        ;sum of floats in array

;-------------------------------INTRO PROMPT------------------------------------------
mov rax, 0
mov rdi, intro                    ;intro message
call printf

;---------------------------CALL FUNCTION FILL---------------------------------------
mov rdi, floatArray               ;passes array into rdi register.
mov rsi, array_size
mov rax, 0
call fill
mov r14, rax                      ;saves copy of fill output into r14

;-------------------------CONFIRMS OUTPUT OF INPUTTED VALUES--------------------------------
push qword 0
mov rdi, numbers_entered          ;"The numbers you entered are:"
mov rax, 0
call printf

;----------------------------DISPLAY ELEMENTS OF ARRAY--------------------------------------
;will output each float entered
mov rdi, floatArray               ;passes the array as first parameter.
mov rsi, r14                      ;passes # of elements in the array stored in r14.
mov rax, 0
call display

;-----------------------------------CALL FUNCTION SUM-----------------------------------------------
;will return the sum of floats in the array
mov rdi, floatArray                 ;passes the array as first parameter.
mov rsi, r14                        ;passes # of elements in the array stored in r14.
mov rax, 0
call sum
movsd xmm15, xmm0                   ;saves a copy of the sum functions output to xmm15

;--------------------------PRINTS OUT TOTAL SUM-----------------------------------------------
movsd xmm15, xmm0                   ;obtains the sum we put in xmm15
mov rdi, sum_values
mov rsi, r14
mov rax, 1
call printf

;---------------------------------PRINTS OUT SUMPROMPT--------------------------------------
push qword 0
mov rdi, sumprompt                  ;"The control module will now return the sum to the caller.."
mov rax, 0
call printf

;---------------------------------END OF FILE-----------------------------------------------
; Restores all registers to their original state.
pop rax
pop rax
pop rax
movsd xmm0, xmm15     ;value returned from control.asm to main.c will be in xmm0
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
