;Kaitlin Frani
;kaitlinfrani@csu.fullerton.edu
;Section 5
;harmonic.asm

;===========================Declarations===================================================================
extern printf
extern scanf
global harmonic_sum

section .data
    input_terms db "Enter the number of terms desired: ", 0
    enter_frequency db "Enter the frequency of the processor as positive integer: ", 0
    initial_time db 10, "The time is now %ld tics", 10, 0
    final_time db 10, "The time is now %ld tics", 10, 0
    terms_sum db "k = %10ld     sum = %.9lf", 10, 0
    elapsed_time db 10, "The harmonic algorithm executed for a total time = %ld tics on a %.0lf Hz machine", 10, 0
    stringformat db "%s", 0
    floatformat db "%lf", 0

section .bss
section .text

harmonic_sum:
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

;=============INITIALIZE=========================================================
movq xmm15, r15

mov rax, 0x3ff0000000000000 ;1.0 float for calculation
movq xmm14, rax

movq xmm12, r15 ;keeps it set to 0.0

;=============INPUT PROMPTS=====================================================
;ask for terms
mov rax, 0
mov rdi, stringformat
mov rsi, input_terms
call printf

;push qword 0
mov rax, 1
mov rdi, floatformat
mov rsi, rsp
call scanf

movsd xmm12, xmm0  ;save terms as a float

;=============START TERMS======================================================
mov r8, 0x4024000000000000  ;10.0 in hex to increment 10 terms
movq xmm1, r8
movq xmm11, xmm12     ;copy user input xmm11 for xmm11 / 10.0
divsd xmm11, xmm1     ;divide input by 11.0 for incrementing
roundsd xmm11, xmm11, 1 ;round up for the terms

;=============FREQUENCY PROMPT==================================================
;ask for frequency
mov rax, 0
mov rsi, stringformat
mov rdi, enter_frequency
call printf

mov rax, 1
mov rdi, floatformat
mov rsi, rsp
call scanf

movsd xmm4, xmm0

;==============CALCULATE INITIAL TICK=============================================
mov rax, 0
mov rdx, 0
cpuid
rdtsc
shl rdx, 32
;rax, rdx
add rax, rdx
mov r14, rax

mov rdi, initial_time
mov rsi, r14
call printf

;==============HARMONIC SUM=====================================================
;k and sum format
mov rax, 0
mov rdi, terms_sum

mov rax, 0x3ff0000000000000
movq xmm10, rax

cvtsd2si r13, xmm11
mov r15, r13

mov r12, 0
movsd xmm13, xmm12
addsd xmm13, xmm10

;================START LOOP=====================================================
begin:
ucomisd xmm14, xmm13
je end

cmp r12, r13
je print_terms_sum
inc r12

movsd xmm9, xmm10
divsd xmm9, xmm14
addsd xmm15, xmm9

addsd xmm14, xmm10

jmp begin ;restart loop to keep iterating

;=============PRINT TERMS AND SUM===============================================
print_terms_sum:
mov rax, 1
mov rdi, terms_sum
movsd xmm0, xmm15
mov rsi, r12
call printf

add r13, r15
jmp begin

end:
mov rax, 1
mov rdi, terms_sum
movsd xmm0, xmm15
mov rsi, r12
call printf

;===============FINAL TIME======================================================
mov rax, 0
mov rax, 0
mov rdx, 0

cpuid
rdtsc

shl rdx, 32
add rax, rdx

mov r15, rax

mov rax, 0
mov rdi, final_time
mov rsi, r15
call printf

;============PRINT HARMONIC ALGORITHM===========================================
cvtsi2sd xmm10, r15
cvtsi2sd xmm7, r14
subsd xmm10, xmm7

cvtsd2si r15, xmm10
;cvtsi2sd xmm10, r10
;cvtsd2si r10, xmm4

mov rax, 1
mov rdi, elapsed_time
;prints out total time
mov rsi, r15
;prints out Hz input
movsd xmm0, xmm4
call printf

;===============RETURN ANSWER TO DRIVER==========================================
mov rax, 0
movq xmm0, xmm15

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
