.global lab1
.syntax unified
#define a #1
#define b #1
#define c #2
lab1:
	push {lr}
	mov r0, a
	mov r1, b
	mov r2, c
	sub r3, r0, r1
	cmp r3, #0
	it ge 
	addge r3, r0, r1
	sdiv r3, r2
	pop {pc}
