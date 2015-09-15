	.file	"vecadd.c"
	.text
	.p2align 4,,15
	.globl	vecadd
	.type	vecadd, @function
vecadd:
.LFB0:
	.cfi_startproc
	testl	%ecx, %ecx
	jle	.L25
	leaq	32(%rdx), %rax
	leaq	32(%rdi), %r9
	cmpq	%rax, %rdi
	setae	%r8b
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %r8d
	leaq	32(%rsi), %r9
	cmpq	%rax, %rsi
	setae	%al
	cmpq	%r9, %rdx
	setae	%r9b
	orl	%r9d, %eax
	testb	%al, %r8b
	je	.L3
	cmpl	$7, %ecx
	jbe	.L3
	movl	%ecx, %r10d
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	shrl	$3, %r10d
	leal	0(,%r10,8), %r8d
.L9:
	vmovups	(%rdi,%rax), %xmm1
	addl	$1, %r9d
	vmovups	(%rsi,%rax), %xmm0
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm1, %ymm1
	vinsertf128	$0x1, 16(%rsi,%rax), %ymm0, %ymm0
	vmulps	%ymm0, %ymm1, %ymm0
	vmovups	%xmm0, (%rdx,%rax)
	vextractf128	$0x1, %ymm0, 16(%rdx,%rax)
	addq	$32, %rax
	cmpl	%r10d, %r9d
	jb	.L9
	cmpl	%r8d, %ecx
	je	.L24
	movslq	%r8d, %rax
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	leal	1(%r8), %eax
	cmpl	%eax, %ecx
	jle	.L24
	cltq
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	leal	2(%r8), %eax
	cmpl	%eax, %ecx
	jle	.L24
	cltq
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	leal	3(%r8), %eax
	cmpl	%eax, %ecx
	jle	.L24
	cltq
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	leal	4(%r8), %eax
	cmpl	%eax, %ecx
	jle	.L24
	cltq
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	leal	5(%r8), %eax
	cmpl	%eax, %ecx
	jle	.L24
	cltq
	addl	$6, %r8d
	vmovss	(%rdi,%rax,4), %xmm0
	cmpl	%r8d, %ecx
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	jle	.L24
	movslq	%r8d, %r8
	vmovss	(%rdi,%r8,4), %xmm0
	vmulss	(%rsi,%r8,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%r8,4)
	vzeroupper
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	vzeroupper
.L25:
	rep ret
	.p2align 4,,10
	.p2align 3
.L3:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	vmovss	(%rdi,%rax,4), %xmm0
	vmulss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L11
	rep ret
	.cfi_endproc
.LFE0:
	.size	vecadd, .-vecadd
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
