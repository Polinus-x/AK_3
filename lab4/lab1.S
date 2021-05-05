.global lab4
.syntax unified

#define X1 #-9
#define X2 #10
#define X3 #31
#define X4 #-21
#define NZK_TOP #0x802C0000
#define NZK #0b10000000001011

lab4:
	push {lr}
	bl task1
	bl task2
	pop {pc}

task1:
	push {lr}
	mov r0, X1
	mov r1, #0xFFFFFFFF

	mov r2, X2
	mov r3, #0

	mov r4, X3
	mov r5, #0

	mov r6, X4
	mov r7, #0xFFFFFFFF

	// Calculation: 8 * 
	
	// ~X2
	mvn r2, r2
	mvn r3, r3
	
	// X1 + ~X2
	add r0, r2
	adc r1, r3
	
	// X1 + ~X2 + X3
	add r0, r4
	adc r1, r5
	
	// 2*(X1 + ~X2 + X3)
	lsl r0, #1
	lsl r1, #1
	
	// X4 + 1
	add r6, #1
	
	// 16 * (X4 + 1)
	lsl r6, #4
	lsl r7, #4
	
	// F = ...
	sub r0, r6
	sbc r1, r7
	
	bl result_correction
	pop {pc}
	
// Result correction
result_correction:
	push {lr}
	bvc step2
	lsr r0, #1
	lsr r1, #1
step2:
	orr r0, #0
	bne step4
	orr r1, #0
	bne step4
	ldr r7, =NZK_TOP
    	mov r0, r7
step4:
	ldr r7, =NZK
	add r1, r7
	and r5, r1, #0xc0000000
	beq step7
	eor r5, #0xc0000000
	beq step7
	lsr r0, #1
	lsr r1, #1
step7:
	bvs end_correction
	push {r0}
	push {r1}
	pop {r1}
	pop {r0}

end_correction:
	pop {pc}

task2:
	push {lr}

	mov r1, #25
	mov r2, #5

program_a:
	// 1: r0 = r1 * r2
	mul r0, r1, r2
	
	// 2: r0 = r1 + r2
	add r0, r1, r2
	
jump3:
	// 3: r0 = r1 + r2
	adds r0, r1, r2
	
	// 4: jump1
	bvc jump1
	
	// 6: r1 = r1 * 2
	lsl r1, #1
	
	b jump2
jump1:
	// 5: r0 = r0 + r3
	add r0, r3
	
	// VI - go to program b
	bl program_b
	
	// 7: r1 = r4 + 4
	sub r1, r4, #4
jump2:
	// 8: jump3
	bcs jump3
	
	// 9: r0 = r0 + r1
	add r0, r1
	pop {pc}

program_b:
	push {lr}
jump5:
	// 10: r1 = r1 * 4
	lsl r1, #2
	
	// 11: jump4
	bmi jump4
	
	
	
	// 12: r1 = r1 & r2 
	and r1, r2
jump4:
	// 13: jump5
	beq jump5
	
	// XII - go to program c
	bl program_c
	
	// 14: r0 = r1 + r2
	add r0, r1, r2
	
	// 15: r2 = r2 * 8
	lsl r2, #3
	
	pop {pc}

program_c:
	push {lr}
	
	// 17: r1 = r0 + 10
	add r1, r0, #10
	
	// 18: r0 = r2 * r1
	mul r0, r2, r1
	
	pop {pc}
