section .bss
	res:	resb 4
	x:		resb 4

section .text
	global do_math


;; float do_math(float x, float y, float z)
;  returns x * sqrt(2) + y * sin(z * PI * 1/e)

do_math:

	push 	ebp
	mov		ebp, esp
	
	mov		eax, 0x40000000
	mov		[x], eax
	
    mov 	ebx, x
    here:
    
    fld		dword [ebp - 4]
    
    fld 	dword [ebx]   	;load float
    
    fsqrt
    
    fmul
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
	fld		dword [ebp - 8]				; y
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
	fld		dword [ebp - 12]			; z
	
	fldpi
    
    fld1
    
    fld1
    fld1
    fld1
    fadd
    fdiv
    fldl2e					; push log2 e on the stack
    fmul
    f2xm1					; 2 ^ log2e
    fld1
    fadd					;	sqrt(e)
    
    fld1
    fld1
    fld1
    fadd
    fdiv
    fldl2e					; push log2 e on the stack
    fmul
    f2xm1					; 2 ^ log2e
    fld1
    fadd					;	sqrt(e)
    
    fmul					; e
    
    fdiv					; 1/e
    
    fmul					; 1/e * pi
    fmul					; 1/e * pi * z
    
    fsin 					; sin(1/e * pi * z)
    
    fmul 					; y*sin(1/e * pi * z)
    fadd
    
    ;fstp 	qword [esp]  	;store double (8087 does the conversion internally)
    ;push 	format_output
    ;call printf
    ;add esp, 12

	pop 	ebp
	ret
