;*****************************************************************************************************************************
;Program name: "Interview". This program will conduct an interview and give you a job offer                                  *
;Copyright (C) 2021 Luke Eltiste                                                                                             *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                     *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
;*****************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Luke Eltiste
;  Author email: lukeeltiste@csu.fullerton.edu
;
;Program information
;  Program name: Sum of an Array
;  Programming languages:  One file in C++, and One file in X68 Assembly
;  Date program began:     2021-Apr-16
;  Date program completed: 2021-Apr-25
;  Date comments upgraded: 2021-Apr-25
;  Files in this program:  main.cpp and interview.asm
;  Status: Complete.  No errors found after extensive testing.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
; To show how to take Char's as input and use them in the program structure
;
;This file
;   File name: interview.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l interview.lis -o interview.o interview.asm
;   Link:     g++ -m64 -no-pie -o interview.out -std=c++17 main.o interview.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

extern printf
extern scanf

global interview

segment .data
stringFormat db "%s", 0                                                                                       ; Format for strings
floatFormat db "%lf", 0 ; Format for floats                                                                   ; Format for floats
intro db "Hello %s. I am Ms Fenster. The interview will begin now.", 10, 0                           ; Welcome Message
amount db "Wow! $%1.2lf That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?", 10, 0 ; Salary Message
electricity_intro db "Alright. Now we will work on your electricity.", 10, 0                                     ; Circuit Test Message
enter_resistance1 db "Please enter the resistance of circuit #1 in ohms: ", 0                                  ; Circuit Question 1
enter_resistance2 db "What is the resistance of circuit #2 in ohms: ", 0                                       ; Circuit Question 2
total_resistance db "The total resistance is %1.3lf Ohms.", 10, 0                                                  ; Resistance message
cs_prompt db "Were you a computer science major (y or n)? ", 0                                          ; Comp Sci Major Question
goodbye db "Thank you.  Please follow the exit signs to the front desk.", 10, 0                            ; Bye Message

section .bss

segment .text
interview:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword -1                                               ;extra push to create even number of pushes

;-----------------------INITIALIZE PARAMETERS------------------------------------
mov r15, rax        ;name
movsd xmm15, xmm0   ;salary

;------------------------INTRO PROMPT--------------------------------------------
push qword 0
mov rax, 0
mov rdi, intro
mov rsi, r15
call printf
pop rax

;-------------------------SALARY PROMPT------------------------------------------
push qword 0
mov rax, 1
mov rdi, amount
movsd xmm0, xmm15
call printf
pop rax

;-----------------------Y/N INPUT------------------------------------------------
push qword 0
mov rax, 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
;jump to electricity_test if not equal to yes
jne electricity_test

;return 1 million to driver, if yes go to end
mov rax, 0x412E848000000000
movq xmm14, rax
jmp end

;-------------------ELECTRICITY TEST---------------------------------------------
electricity_test:
;"We will work on your electricity"
push qword 0
mov rax, 0
mov rdi, electricity_intro
call printf
pop rax

;first resistance
push qword 0
mov rax, 0
mov rdi, enter_resistance1
call printf
pop rax

;resistance 1 input in xmm10
mov rax, 1
mov rdi, floatFormat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, xmm0
pop rax

;second resistance
push qword 0
mov rax, 0
mov rdi, enter_resistance2
call printf
pop rax

;resistance 2 input in xmm11
mov rax, 1
mov rdi, floatFormat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, xmm0
pop rax

;------------------------ELECTRICITY CALCULATION---------------------------------
;Set 1 to 1.0 floating for 1/resistance
mov rax, 0x3FF000000000000
;Put into xmm registers for floating calculation
movq xmm13, rax
movsd xmm14, xmm13
movsd xmm9, xmm13

;1/resistance then add the resistances
divsd xmm13, xmm10
divsd xmm14, xmm11
addsd xmm13, xmm14
divsd xmm9, xmm13

;-----------------------TOTAL RESISTANCE PROMPT----------------------------------
push qword 0
mov rax, 1
mov rdi, total_resistance
movsd xmm0, xmm9
call printf
pop rax

;-----------------------CS MAJOR PROMPT------------------------------------------
push qword 0
mov rax, 0
mov rdi, cs_prompt
call printf
pop rax

push qword 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
;if yes go to cs major
je cs_major

;for the social major, salary is 1200.12
;if no, go to end
mov rax, 0x4092C07AE147AE14
movq xmm14, rax
jmp end

;if yes, salary is 88000.88
cs_major:
mov rax, 0x40F57C0E147AE148
movq xmm14, rax

end:
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

movsd xmm0, xmm14
ret
