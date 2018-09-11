; INTEGER SQUARE ROOT
;
; file: intsqrt.asm
;
; Author: Matthew Sprigg
;
; Description: Calculates the integer square root
; 	of a number rounded down. This is useful for
;	certain algorithms where an integer does not
;	exceed the square root of a certain number
;	because it takes far fewer bytes than other
;	square root algorithms such as the babylonian
;	method.
;
; Example: 16 - 1 - 3 - 5 - 7 = 0
;
;	There are four odd subtractors, thus the root is zero.
;
;Ex 2:	4 - 1 - 3 = 0;
;
;	Root = 2.
;
;Ex 3: 12 - 1 - 3 - 5 - 7 = -4
;	
;	Less than zero, therefore 12 is not an even square.
;	The square root is between 3 and 4.
;	The integer square root is 3.



%include "asm_io.inc"


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
        global intsqrt 		; make accessable to other modules.


;--------------------------------------------------------
; FUNCTIONS / SUBPROGRAMS			 	;
;--------------------------------------------------------


intsqrt:
;
; int intsqrt(int n) {
; 
;	 int counter = 0;
;	 int subtractor = 1;
;
;	 while (n > 0)	{
;		n -= subtractor;
;		subtractor+=2
;		counter++
;	}
;
;	return counter;
;}

;--------------------------------------------------------
; PROLOGUE						;
;--------------------------------------------------------

;     	   VAR TABLE
; ==============================
;   Data  | Pointer | Pseudocode
; ------------------------------
; local 1 @ [ebp-4] <-- counter
; local 2 @ [ebx] <-- subtractor
; sav EBP @ [ebp]
; retaddr @ [ebp+4]
; param 1 @ [ebp+8] <-- n
	
	push 	ebp		; save original ebp val on stack.

	mov	ebp, esp	; new EBP = ESP
	sub	esp, 4		; Local vars need 2 dwords.

	push	ebx		; Preserve ebx.

	mov dword [ebp-4], 0	; counter = 0; 
	;mov dword [ebp-8], 1	; subtractor = 1;
	
	mov	ebx, 1		; subtractor = 1;
	; arithmatic instructions such as sub cannot
	; operate on two memory locations.
;--------------------------------------------------------
; CODE							;
;--------------------------------------------------------
	
do_while: ; (n > 0)
	sub	[ebp+8], ebx	; n -= subtractor;
	add	ebx, 2		; subtractor += 2;
	inc dword [ebp-4]	; counter++;

	cmp dword [ebp+8], 0	; if (n <= 0) break;
	jg	do_while
	
	setne	bl
	movzx	ebx, bl
	mov	eax, [ebp-4]
	sub	eax, ebx
	; Because the integer square root is one less than the result
	; 	in counter UNLESS the result is zero, it is necessary
	;	to have two possible results from the single var counter.
	;	SETNE removes the need for branches and takes fewer bytes.

;--------------------------------------------------------
; EPILOGUE						;
;--------------------------------------------------------
	
	pop	ebx	; restore ebx
	add	esp, 4	; clean up local vars.
	pop	ebp	; restore ebp.
	ret		; return.

