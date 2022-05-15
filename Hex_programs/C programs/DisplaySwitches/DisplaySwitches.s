	.file	"DisplaySwitches.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,200
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
.L2:
	li	a5,4
	lw	a5,0(a5)
	sw	a5,-20(s0)
	li	a5,8
	lw	a4,-20(s0)
	sw	a4,0(a5)
	j	.L2
	.size	main, .-main
	.ident	"GCC: (g5964b5cd727) 11.1.0"
