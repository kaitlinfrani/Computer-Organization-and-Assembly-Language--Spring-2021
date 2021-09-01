;Kaitlin Frani
;CPSC240-5 Test 1

;===========================Declarations===================================================================
extern printf
extern scanf
global electric_resistance ;will use the function from electricity.cpp file

segment .data
input db "Please enter the resistance numbers of the two subcircuits separated by ws and press enter.",10, 0
input_three db "%lf%lf%lf",0
received db "These resistances were received: %lf Ω %lf Ω %lf Ω", 10, 0
output_resistance db "The resistance of the entire circuit is %lf Ω", 10, 0
return db "The total resistance will be returned to the caller module.", 10, 0

segment .bss

segment .text

electric_resistance: ;name of global function
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

;======Begin section to input resistance numbers======================================================================
;Begin resistance numbers printf block
push qword 99
mov rax, 0
mov rdi, input     ;"Please enter the resistance numbers of the two subcircuits separated by ws and press enter.",10,0
call printf
pop rax
;End of resistance numbers block

push qword 99 ;used to get on the boundary
;Begin enter three numbers scanf block
push qword -1
push qword -2
push qword -3
mov rax, 0
mov rdi, input_three     ;takes in resistance numbers input
mov rsi, rsp
mov rdx, rsp
add rdx, 8
mov rcx, rsp
add rcx, 16
call scanf
movsd xmm10, [rsp]
movsd xmm11, [rsp+8]
movsd xmm12, [rsp+16]
pop rax
pop rax
pop rax
;End of enter numbers scanf block
;======End of section to input resistance numbers=======================================================================

;======Begin section of Displaying Numbers=========================================================================
push qword 0
mov rax, 3
mov rdi, received ;"These resistances were received: "
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf
pop rax
;======End of Displaying Numbers=======================================================================


;======Begin section of electric_resistance Calculation=========================================================================
;Calculate resistance
;1/xmm10 + 1/ xmm11 + 1/xmm12
;put answer into xmm13
;1/xmm13

;first value (1/xmm10)
mov r8, 1 ;putting integer 1 into r8
cvtsi2sd xmm8, r8 ;converting r8 into a float value by storing into xmm8
movsd xmm0, xmm10 ;move first value into xmm0
divsd xmm8, xmm0  ;divide 1 with first value and put into xmm8
movsd xmm13, xmm8 ;move answer in xmm8 to xmm13, will add values in xmm13 later

;second value (1/xmm11)
mov r9, 1; putting integer 1 into r9
cvtsi2sd xmm9, r9 ;converting r9 to float by storing into xmm8
movsd xmm1, xmm11 ;move second value into xmm1
divsd xmm9, xmm1 ;divide 1 with second value and put into xmm9
movsd xmm14, xmm9 ;move answer in xmm9 to xmm14

;third value (1/xmm12) and adding what we got from xmm13, xmm14
mov r10, 1; putting integer 1 into r10
cvtsi2sd xmm7, r10  ;converting r10 to float and storing into xmm6
movsd xmm2, xmm12 ;move second value into xmm2
divsd xmm7, xmm2 ;divide 1 with second value and put into xmm7
movsd xmm15, xmm7 ;move answer in xmm7 to xmm15
addsd xmm13, xmm14  ;adding xmm14 value to xmm13
addsd xmm13, xmm15  ;adding xmm15 value to xmm13

;dividing all (1/xmm13)
mov r11, 1  ;putting integer 1 into r11
cvtsi2sd xmm6, r11  ;converting r11 to float and storing into xmm6
divsd xmm6, xmm13 ;do 1 divided by sum of values that are in 13
movsd xmm13, xmm6 ;put divided answer into xmm13

;Total resistance message
push qword 0
mov rax, 1                    ; outputs one floating number (total resistance)
mov rdi, output_resistance    ; "The resistance of the circuit is: "
movsd xmm0, xmm13
call printf
pop rax
;======End of Resistance Calculation====================================================================================

;======Begin ending messages before exiting program===========================================================================
;display return message
;push qword 0
mov rax, 0
mov rdi, return                  ;"The total resistance will be returned to the caller module."
call printf
pop rax

movsd xmm0, xmm13              ;grabs total resistance in xmm13, returns it to driver file
;======End of ending message before exiting program=================================================================================================================

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
