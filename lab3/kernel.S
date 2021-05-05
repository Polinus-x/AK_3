.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb


// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector

vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata

	data: .asciz "kernel started!\n"
	final: .asciz "Result value in register #3: "
    
.section .text

__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

// calculate
	mov r0, #8
	mov r1, #4
	mov r2, #2
	sub r3, r0, r1
	cmp r3, #0
	it ge
	addge r3, r0, r1
	sdiv r3, r2

	STRH r3, [r4], #0
	LDRH r0, [r4], #0
    
	mov r0, r3
	bl dbgput_num
end:
	b end

