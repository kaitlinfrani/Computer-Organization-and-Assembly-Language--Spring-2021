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
;    Name:      fill.asm                                                                    *
;    Purpose:   To accept a users input of floats and save it into an array then send       *
;               the total number of elements inputted into the array back to manager so     *
;                that it can output the inputs.                                             *
;                                                                                           *
;********************************************************************************************

extern printf
extern scanf

global fill

section .data
    float_prompt db "Please enter floating numbers separated by ws.",10
                 db "When finished press enter followed by cntl+D.",10, 0
    floatformat db "%lf", 10, 0   ;values

section .bss

section .text

fill:

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

push qword -1

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------
mov r15, rdi
mov r14, rsi
mov r13, 0

;-----------------------------FLOAT PROMPT----------------------------------------------
;enter the floating numbers
push qword 0
mov rax, 0
mov rdi, float_prompt
call printf

;---------------------------------START OF LOOP---------------------------------------------
begin_loop:

;obtain floating number and store
mov rax, 0
mov rdi, floatformat
mov rsi, rsp
call scanf

;tests if Ctrl + D is entered to finish inputting into array.
cdqe
cmp rax, -1
je end_of_loop                          ;end the loop once ctrl + D is entered

;--------------------------------COPY INTO ARRAY--------------------------------------------
;adds copy of float saved in xmm15 into array at index of counter, r13
movsd xmm15, [rsp]
movsd [r15 + 8 * r13], xmm15
inc r13                                 ;increment counter, adding more elements into array

;-----------------------------ARRAY CAPACITY TEST-------------------------------------------
;tests to see if max array capacity has been reached
cmp r13, r14                            ;compares # of elements (r13) to capacity (r14).
je exit                                 ;exit loop once capacity has been reached

;restart loop
jmp begin_loop

;---------------------------------END OF LOOP-----------------------------------------------.
end_of_loop:
pop rax

;------------------------------------EXIT LOOP---------------------------------------------------
exit:
pop rax
mov rax, r13
movsd xmm15, xmm0

;restore all backed up registers to their original state.
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
