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
;    Name:      sum.asm                                                                     *
;    Purpose:   To add up all the floats in the array and return the sum back to control    *
;               as well as allow control return it to main.                                 *
;                                                                                           *
;********************************************************************************************

global sum

section .data

section .bss

section .text

sum:

; Back up all registers to stack and set stack pointer to base pointer
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

push qword -1

;-----------------------INITIALIZE PARAMETERS-----------------------------------------------
mov r15, rdi          ;copies array
mov r14, rsi          ;copies number of elements in the array to r14.
mov r13, 0            ;sum register to add
mov r12, 0            ;counter to iterate through array.

;-----------------------------------START LOOP----------------------------------------------
begin_loop:

;compare counter to number of elements in array
cmp r12, r14
jge outofloop

;--------------------------------COPY INTO ARRAY--------------------------------------------
;add element of array to sum
addsd xmm15, [r15 + 8 * r12]
inc r12

; Restarts loop
jmp begin_loop

;----------------------------------END OF LOOP----------------------------------------------
outofloop:

; Restores all backed up registers to their original state.
pop rax
movsd xmm0, xmm15
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
