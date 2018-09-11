;
; file: sieve
; Author: Matthew Sprigg
; Description: Finds all multiples of a given
;	prime within a certain range and mark
;	them as non-prime.
;
;

%include "asm_io.inc"
%define prime [ebp+8]
%define range [ebp+12]
%define array [ebp+16] 


;--------------------------------------------------------
; initialized data is put in the .data segment
;
segment .data


;--------------------------------------------------------
; uninitialized data is put in the .bss segment
;
segment .bss


;--------------------------------------------------------
; code is put in the .text segment
;
segment .text
        global  sieve



;--------------------------------------------------------
; MAIN FUNCTION						;
;--------------------------------------------------------

sieve: 
; void sieve(prime,range, array) {
;	register int j = prime ** 2;
;	do {
;		*(&array+j) = 0;
;		j+=prime
;	} while(j<range);
;}
;--------------------------------------------------------
; PROLOGUE						;
;--------------------------------------------------------
;	Var Table
; ==========================
; Var     | Stack   | Pseudo
; --------------------------
; Local 1 @ [eax]    = j
; Sav EBP @ [ebp]
; RetAddr @ [ebp+4]
; Param 1 @ [ebp+8]  = prime
; Param 2 @ [ebp+12] = range
; Param 3 @ [ebp+16] = array

        enter  0,0               ; setup routine
        pusha
	mov 	edi, array	; point data index to array.
	CLD			; DF = 0, String instr inc.
	mov	eax, prime	; eax = i**2
	mul	eax
;--------------------------------------------------------
; CODE 							;
;--------------------------------------------------------
	
do_while:
	lea edx, [edi+4*ebx]	; edx =  *(&array + j)
	mov dword [edx], 0	; array[j] = 0	
	cmp eax, range		
	jne do_while		; break if j > range
	
	
;--------------------------------------------------------
; EPILOGUE						;
;--------------------------------------------------------
        popa
        ;mov     eax, 0            ; return back to C
        leave
        ret


;--------------------------------------------------------
; FUNCTIONS / SUBPROGRAMS			 	;
;--------------------------------------------------------
