;
; file: asm_main.asm
; 
; The Sieve of Eratosthenes
;
;

%include "asm_io.inc"
;%include "sieve.asm"
;%include "intsqrt.asm"
%define range 100
; -----------------------------------------------------
; initialized data is put in the .data segment
;
segment .data

	prompt db "This program is the Sieve of Eratosthenes.", 10, \
	"A predefined range of numbers will have each element's", 10, \
	"primeness evaluated as was done by the Ancients.", 10, 10, \
	"The range of this program is: ", 0
	
;	blank 	db " " 		; whitespce char

	prime	dw 2		; prime number	
	
	array	db 01111111b  	; range num Bytes init at FFh.
	TIMES range db 00ffh
; -----------------------------------------------------
; uninitialized data is put in the .bss segment
;
segment .bss

; -----------------------------------------------------
; code is put in the .text segment
;
segment .text
        global  asm_main
	extern intsqrt, sieve
; -----------------------------------------------------
; PROLOGUE
; -----------------------------------------------------
asm_main:
        enter   0,0               ; setup routine
        pusha

; -----------------------------------------------------
; FUNCTION
; -----------------------------------------------------

; Print prompts
;	mov	eax, prompt	; Print prompt.
;	call	print_string
;	mov	eax, range	; Print range.
;	call	print_int

; Core program
	push 	range		; rangert = intsqrt(range);
 	call 	intsqrt		; 
 	mov 	ecx, eax	
break1:

	push	array		; void sieve(prime, range, array);
	push	range		; prime init at prime = 2.
	push	prime
	call 	sieve
	inc dword [prime]	; prime++ | prime = 3
break2:
do_while:	; while (prime <= rangert)
	push	array		; void sieve(prime, range, array);
	push	range
	push	prime
	call 	sieve
	add dword [prime], 2	; prime+=2

	cmp	ecx, dword [prime]
	jle 	do_while

; Print out Array.
	mov	ecx, range
print_loop:
	mov	ebx, array
	add	ebx, ecx
	cmp	dword [edx], 0
	je	continue
; prime
	mov	eax, [edx]
	call	print_int
	;mov	al, blank
	;call	print_char
	call	print_nl
continue:
	loop print_loop	
; -----------------------------------------------------
; EPILOGUE
; -----------------------------------------------------

        popa
        mov     eax, 0          ; return back to C
        leave
        ret

