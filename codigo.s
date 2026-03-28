.global _start
_start:
	
	sub r0, r15, r15
	add r1, r0, #0
	add r2, r0, #0x34
	loop1:
	str r1, [r2]
	add r1, r1, #1
	add r2, r2, #4
	subs r3, r1, #5
	bne loop1
	add r2, r0, #0x34
	loop2:
	ldr r4, [r2]
	add r2, r2, #4
	subs r3, r2, #0x48
	bne loop2