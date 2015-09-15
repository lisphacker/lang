	.file	"omp_vecadd.c"
	.text
	.p2align 4,,15
	.globl	vecadd_1
	.type	vecadd_1, @function
vecadd_1:
.LFB39:
	.cfi_startproc
	testl	%ecx, %ecx
	jle	.L1
	leaq	16(%rdx), %rax
	leaq	16(%rdi), %r9
	cmpq	%rax, %rdi
	setae	%r8b
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %r8d
	leaq	16(%rsi), %r9
	cmpq	%rax, %rsi
	setae	%al
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %eax
	testb	%al, %r8b
	je	.L3
	cmpl	$6, %ecx
	jbe	.L3
	movl	%ecx, %r10d
	xorps	%xmm2, %xmm2
	shrl	$2, %r10d
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	leal	0(,%r10,4), %r9d
.L9:
	movaps	%xmm2, %xmm0
	addl	$1, %r8d
	movaps	%xmm2, %xmm1
	movlps	(%rdi,%rax), %xmm0
	movlps	(%rsi,%rax), %xmm1
	movhps	8(%rdi,%rax), %xmm0
	movhps	8(%rsi,%rax), %xmm1
	addps	%xmm1, %xmm0
	movlps	%xmm0, (%rdx,%rax)
	movhps	%xmm0, 8(%rdx,%rax)
	addq	$16, %rax
	cmpl	%r10d, %r8d
	jb	.L9
	cmpl	%r9d, %ecx
	je	.L1
	movslq	%r9d, %rax
	movss	(%rdi,%rax,4), %xmm0
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	leal	1(%r9), %eax
	cmpl	%eax, %ecx
	jle	.L1
	cltq
	addl	$2, %r9d
	movss	(%rdi,%rax,4), %xmm0
	cmpl	%r9d, %ecx
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	jle	.L20
	movslq	%r9d, %r9
	movss	(%rdi,%r9,4), %xmm0
	addss	(%rsi,%r9,4), %xmm0
	movss	%xmm0, (%rdx,%r9,4)
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	movss	(%rdi,%rax,4), %xmm0
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L11
.L1:
	rep ret
	.p2align 4,,10
	.p2align 3
.L20:
	rep ret
	.cfi_endproc
.LFE39:
	.size	vecadd_1, .-vecadd_1
	.p2align 4,,15
	.globl	vecadd_2
	.type	vecadd_2, @function
vecadd_2:
.LFB40:
	.cfi_startproc
	testl	%ecx, %ecx
	jle	.L21
	leaq	16(%rdx), %rax
	leaq	16(%rdi), %r9
	cmpq	%rax, %rdi
	setae	%r8b
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %r8d
	leaq	16(%rsi), %r9
	cmpq	%rax, %rsi
	setae	%al
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %eax
	testb	%al, %r8b
	je	.L23
	cmpl	$6, %ecx
	jbe	.L23
	movl	%ecx, %r10d
	xorps	%xmm2, %xmm2
	shrl	$2, %r10d
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	leal	0(,%r10,4), %r9d
.L29:
	movaps	%xmm2, %xmm0
	addl	$1, %r8d
	movaps	%xmm2, %xmm1
	movlps	(%rdi,%rax), %xmm0
	movlps	(%rsi,%rax), %xmm1
	movhps	8(%rdi,%rax), %xmm0
	movhps	8(%rsi,%rax), %xmm1
	addps	%xmm1, %xmm0
	movlps	%xmm0, (%rdx,%rax)
	movhps	%xmm0, 8(%rdx,%rax)
	addq	$16, %rax
	cmpl	%r10d, %r8d
	jb	.L29
	cmpl	%r9d, %ecx
	je	.L21
	movslq	%r9d, %rax
	movss	(%rdi,%rax,4), %xmm0
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	leal	1(%r9), %eax
	cmpl	%eax, %ecx
	jle	.L21
	cltq
	addl	$2, %r9d
	movss	(%rdi,%rax,4), %xmm0
	cmpl	%r9d, %ecx
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	jle	.L39
	movslq	%r9d, %r9
	movss	(%rdi,%r9,4), %xmm0
	addss	(%rsi,%r9,4), %xmm0
	movss	%xmm0, (%rdx,%r9,4)
	ret
	.p2align 4,,10
	.p2align 3
.L23:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L31:
	movss	(%rdi,%rax,4), %xmm0
	addss	(%rsi,%rax,4), %xmm0
	movss	%xmm0, (%rdx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L31
.L21:
	rep ret
	.p2align 4,,10
	.p2align 3
.L39:
	rep ret
	.cfi_endproc
.LFE40:
	.size	vecadd_2, .-vecadd_2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%.3f\n"
	.text
	.p2align 4,,15
	.globl	bench
	.type	bench, @function
bench:
.LFB41:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdi, %r14
	xorl	%edi, %edi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%r8, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	$10000, %ebx
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	movq	%rsp, %rsi
	call	clock_gettime
	.p2align 4,,10
	.p2align 3
.L42:
	movl	$1000000, %ecx
	movq	%r12, %rdx
	movq	%r13, %rsi
	movq	%r14, %rdi
	call	*%rbp
	subl	$1, %ebx
	jne	.L42
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	cvtsi2sdq	24(%rsp), %xmm1
	cvtsi2sdq	8(%rsp), %xmm2
	movsd	.LC0(%rip), %xmm3
	cvtsi2sdq	16(%rsp), %xmm0
	movl	$.LC1, %esi
	movl	$1, %edi
	movl	$1, %eax
	mulsd	%xmm3, %xmm1
	mulsd	%xmm3, %xmm2
	addsd	%xmm1, %xmm0
	cvtsi2sdq	(%rsp), %xmm1
	addsd	%xmm2, %xmm1
	subsd	%xmm1, %xmm0
	call	__printf_chk
	addq	$32, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE41:
	.size	bench, .-bench
	.section	.rodata.str1.1
.LC2:
	.string	"malloc() error"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB42:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$4000000, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	call	malloc
	movl	$4000000, %edi
	movq	%rax, %rbp
	call	malloc
	movl	$4000000, %edi
	movq	%rax, %rbx
	call	malloc
	testq	%rbp, %rbp
	je	.L45
	testq	%rbx, %rbx
	je	.L45
	testq	%rax, %rax
	movq	%rax, %r12
	je	.L45
	movq	%rbx, %rcx
	andl	$15, %ecx
	shrq	$2, %rcx
	negq	%rcx
	andl	$3, %ecx
	je	.L54
	cmpl	$1, %ecx
	movl	$0x00000000, (%rbx)
	movl	$0x00000000, 0(%rbp)
	jbe	.L55
	cmpl	$2, %ecx
	movl	$0x3f800000, 4(%rbx)
	movl	$0x3f800000, 4(%rbp)
	jbe	.L56
	movl	$0x40000000, 8(%rbx)
	movl	$0x40000000, 8(%rbp)
	movl	$999997, %edi
	movl	$3, %eax
.L47:
	leal	1(%rax), %r11d
	movl	$1000000, %edx
	xorl	%r8d, %r8d
	subl	%ecx, %edx
	movl	%ecx, %ecx
	movl	%r11d, 4(%rsp)
	leal	2(%rax), %r11d
	leaq	0(,%rcx,4), %r9
	movd	4(%rsp), %xmm4
	movl	%edx, %r10d
	xorl	%ecx, %ecx
	movl	%r11d, 8(%rsp)
	leal	3(%rax), %r11d
	shrl	$2, %r10d
	movd	8(%rsp), %xmm1
	movl	%eax, 8(%rsp)
	leal	0(,%r10,4), %esi
	movl	%r11d, 12(%rsp)
	movd	8(%rsp), %xmm0
	leaq	(%rbx,%r9), %r11
	movd	12(%rsp), %xmm3
	addq	%rbp, %r9
	punpckldq	%xmm4, %xmm0
	movdqa	.LC6(%rip), %xmm2
	punpckldq	%xmm3, %xmm1
	punpcklqdq	%xmm1, %xmm0
	jmp	.L53
	.p2align 4,,10
	.p2align 3
.L49:
	movdqa	%xmm1, %xmm0
.L53:
	movdqa	%xmm0, %xmm1
	addl	$1, %r8d
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, (%r11,%rcx)
	paddd	%xmm2, %xmm1
	movlps	%xmm0, (%r9,%rcx)
	movhps	%xmm0, 8(%r9,%rcx)
	addq	$16, %rcx
	cmpl	%r8d, %r10d
	ja	.L49
	addl	%esi, %eax
	subl	%esi, %edi
	cmpl	%esi, %edx
	je	.L51
	cvtsi2ss	%eax, %xmm0
	movslq	%eax, %rdx
	cmpl	$1, %edi
	leal	1(%rax), %ecx
	movss	%xmm0, (%rbx,%rdx,4)
	movss	%xmm0, 0(%rbp,%rdx,4)
	je	.L51
	cvtsi2ss	%ecx, %xmm0
	movslq	%ecx, %rdx
	addl	$2, %eax
	cmpl	$2, %edi
	movss	%xmm0, (%rbx,%rdx,4)
	movss	%xmm0, 0(%rbp,%rdx,4)
	je	.L51
	cvtsi2ss	%eax, %xmm0
	movslq	%eax, %rdx
	movss	%xmm0, (%rbx,%rdx,4)
	movss	%xmm0, 0(%rbp,%rdx,4)
.L51:
	movl	$vecadd_1, %r8d
	movl	$1000000, %ecx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	bench
	movl	$vecadd_2, %r8d
	movl	$1000000, %ecx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	bench
	movq	%r12, %rdi
	call	free
	movq	%rbx, %rdi
	call	free
	movq	%rbp, %rdi
	call	free
.L44:
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L54:
	.cfi_restore_state
	movl	$1000000, %edi
	xorl	%eax, %eax
	jmp	.L47
.L45:
	movq	stderr(%rip), %rcx
	movl	$14, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	orl	$-1, %eax
	jmp	.L44
.L55:
	movl	$999999, %edi
	movl	$1, %eax
	jmp	.L47
.L56:
	movl	$999998, %edi
	movl	$2, %eax
	jmp	.L47
	.cfi_endproc
.LFE42:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	3894859413
	.long	1041313291
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC6:
	.long	4
	.long	4
	.long	4
	.long	4
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
