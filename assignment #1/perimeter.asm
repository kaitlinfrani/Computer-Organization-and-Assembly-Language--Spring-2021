;================Open Source License============================================================================================
; Program name: "Perimeter and Average Side Length of a Rectangle"
; We want to find out the perimeter and the length of the average side given width and height.
; Copyright (C) 2021 Kaitlin Frani.

;This file is part of the software program "Perimeter and Average Side Length of a Rectangle".
;Perimeter and Average Side Length of a Rectangle is free software: you can redistribute it
;and/or modify it under the terms of the GNU General Public License version 3 as published
;by the Free Software Foundation.
;Area of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;================End of Open Source License=============================================================================================================

;================Author, Prgram, File Identification=======================================================
;Author information
;  Author name: Kaitlin Frani
;  Author email: kaitlinfrani@csu.fullerton.edu

;Program information
;  Program name: Area of Rectangle
;  Programming languages: One module in C++ and one module in X86
;  Date program began: 2021-Feb-4
;  Date of last update: 2021-Feb-13
;  Date of reorganization of comments: 2021-Feb-13
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished. No errors when ran.

;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm
;================End of Identification=====================================================================

;===========================Declarations===================================================================
extern printf
extern scanf
global area_rectangle ;will use the function from rectangle.cpp file

segment .data
welcome db "This program will compute the perimeter and the average side length of a rectangle.",10,0
enter_height db "Enter the height: ",0
enter_width db "Enter the width: ",0
wish db "I hope you enjoyed the calculations.",10,0
good_bye db "The assembly program will send the perimeter to the main function.",10,0
height_input db "%lf",0
width_input db "%lf",0
output_perimeter db "The perimeter is %3.2lf", 10,0 ;3 numbers left, 2 numbers right of decimal
output_length db "The length of the average side is %5.3lf",10,0 ;5 numbers left, 3 numbers right of decimal
side_length_average dq 4.0  ;constant used to divide to find the avg. length

segment .bss

segment .text ;executes instructions

area_rectangle: ;name of global function
;============================================================================================================

;======Backing up all registers + setting stack pointer to base pointer=========================================
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
;======End of backing up registers=================================================================================

;======Begin welcome message=======================================================================================
;displaying what the program will do
push qword 0
mov rax, 0                     ;not going to output any value, so 0
mov rdi, welcome               ;"This program will compute the perimeter and the average side length of a rectangle"
call printf
;======End welcome message==========================================================================================

;======Begin section to input height and width======================================================================
;Begin height printf block
push qword 0
mov rax, 0
mov rdi, enter_height          ;"Enter the height: "
call printf
pop rax
;End of height printf block

;Begin height scanf block
push qword 0
mov rax, 0
mov rdi, height_input          ;takes in height input
mov rsi, rsp
call scanf
movsd xmm10, [rsp]             ;height input into xmm10
pop rax
;End of height scanf block

;Begin width printf block
push qword 0
mov rax, 0
mov rdi, enter_width           ;"Enter the width: "
call printf
pop rax
;End width printf block

;Begin width scanf block
push qword 0
mov rax, 0
mov rdi, width_input           ;takes in width input
mov rsi, rsp
call scanf
movsd xmm11, [rsp]             ;entering width input into xmm11
pop rax                        ;reversing the push into scanf block
;End width scanf block
;======End of section to input height and width=======================================================================

;======Begin section of Perimeter Calculation=========================================================================
;Calculate perimeter
;height + height + width + width = perimeter
movsd xmm12, xmm10  ;put height into xmm12
addsd xmm12, xmm10  ;add height with height in xmm12
addsd xmm12, xmm11  ;add width with the two height values in xmm12
addsd xmm12, xmm11  ;add width again with the two height values and width

;Perimeter message
push qword 0
mov rax, 1                    ; outputs one floating number (the perimeter)
mov rdi, output_perimeter     ; "The perimeter is: "
movsd xmm0, xmm12
call printf
pop rax
;======End of Perimeter Calculation====================================================================================

;======Begin section of Side length Calculation========================================================================
;Calculate average side length: perimeter / 4
mov r8, 4 ; putting integer 4 into r8
cvtsi2sd xmm8, r8   ;converting r8 into a float value by storing into xmm8
movsd xmm0, xmm12   ;putting perimeter into xmm0
divsd xmm0, xmm8    ;getting the value for and dividing it with perimeter
movsd xmm13, xmm0   ;storing average side length into xmm13

;Display average side length
push qword 0
mov rax, 1                ;displaying 1 floating value
mov rdi, output_length    ;"The length of the average side is..."
movsd xmm0, xmm13
call printf
pop rax
;======End of side length calculation===================================================================================

;======Begin ending messages before exiting program===========================================================================
;display wish message
push qword 0
mov rax, 0
mov rdi, wish                  ;"I hope you enjoyed the calculations."
call printf
pop rax

;display good-bye message, sending perimeter to main function
mov rax, 0
mov rdi, good_bye              ;"The assembly program will send the perimeter to the main function"
call printf
pop rax

movsd xmm0, xmm12              ;grabs perimeter in xmm11, returns it to driver file
;=======================================================================================================================

;======Restoring all registers to their original values=================================================================
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

;=======================================================================================================================
