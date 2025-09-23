	.text
	.file	"out.ll"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #32
	str	x30, [sp, #16]                  // 8-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -16
	mov	w0, wzr
	bl	putf
	bl	getint
	str	w0, [sp, #12]
	tbnz	w0, #31, .LBB0_5
// %bb.1:
	mov	w8, #1                          // =0x1
	stp	w8, w8, [sp, #24]
.LBB0_2:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #28]
	ldr	w9, [sp, #12]
	cmp	w8, w9
	b.gt	.LBB0_4
// %bb.3:                               //   in Loop: Header=BB0_2 Depth=1
	ldp	w8, w9, [sp, #24]
	mul	w8, w8, w9
	add	w9, w9, #1
	stp	w8, w9, [sp, #24]
	b	.LBB0_2
.LBB0_4:
	ldr	w1, [sp, #12]
	ldr	w2, [sp, #24]
	mov	w0, wzr
	bl	putf
	b	.LBB0_6
.LBB0_5:
	mov	w0, wzr
	bl	putf
.LBB0_6:
	ldr	x30, [sp, #16]                  // 8-byte Folded Reload
	mov	w0, wzr
	add	sp, sp, #32
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
