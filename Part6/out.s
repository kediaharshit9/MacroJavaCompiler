	.text
	.globl    main
main:
move $fp, $sp
subu $sp, $sp, 44
sw $ra, -4($fp)
li $v1, 4
move $s0, $v1
move $a0, $s0
jal _halloc
move $s0, $v0
move $s0, $s0
li $v1, 4
move $s1, $v1
move $a0, $s1
jal _halloc
move $s1, $v0
move $s1, $s1
la $s2, Fac_ComputeFac
sw $s2, 0($s0)
sw $s0, 0($s1)
move $s1, $s1
lw $s0, 0($s1)
lw $s0, 0($s0)
li $v1, 10
move $s2, $v1
sw $t0, 36($sp)
sw $t1, 32($sp)
sw $t2, 28($sp)
sw $t3, 24($sp)
sw $t4, 20($sp)
sw $t5, 16($sp)
sw $t6, 12($sp)
sw $t7, 8($sp)
sw $t8, 4($sp)
sw $t9, 0($sp)
move $a0, $s1
move $a1, $s2
jalr $s0
lw $t0, 36($sp)
lw $t1, 32($sp)
lw $t2, 28($sp)
lw $t3, 24($sp)
lw $t4, 20($sp)
lw $t5, 16($sp)
lw $t6, 12($sp)
lw $t7, 8($sp)
lw $t8, 4($sp)
lw $t9, 0($sp)
move $s2, $v0
move $a0, $s2
jal _print
lw  $ra, -4($fp)
addu $sp, $sp, 44
j $ra

	.text
	.globl    Fac_ComputeFac
Fac_ComputeFac:
sw $fp, -8($sp)
move $fp, $sp
subu $sp, $sp, 80
sw $ra, -4($fp)
sw $s0, 68($sp)
sw $s1, 64($sp)
sw $s2, 60($sp)
sw $s3, 56($sp)
sw $s4, 52($sp)
sw $s5, 48($sp)
sw $s6, 44($sp)
sw $s7, 40($sp)
move $s0, $a0
move $s1, $a1
li $v1, 0
move $s2, $v1
sle $v1, $s1, $s2
move $s2, $v1
beqz $s2 L2
li $v1, 1
move $s0, $v1
move $s0, $s0
b L3
L2:	 nop
move $s2, $s0
lw $s3, 0($s2)
lw $s3, 0($s3)
li $v1, 1
move $s4, $v1
sub $v1, $s1, $s4
move $s4, $v1
sw $t0, 36($sp)
sw $t1, 32($sp)
sw $t2, 28($sp)
sw $t3, 24($sp)
sw $t4, 20($sp)
sw $t5, 16($sp)
sw $t6, 12($sp)
sw $t7, 8($sp)
sw $t8, 4($sp)
sw $t9, 0($sp)
move $a0, $s2
move $a1, $s4
jalr $s3
lw $t0, 36($sp)
lw $t1, 32($sp)
lw $t2, 28($sp)
lw $t3, 24($sp)
lw $t4, 20($sp)
lw $t5, 16($sp)
lw $t6, 12($sp)
lw $t7, 8($sp)
lw $t8, 4($sp)
lw $t9, 0($sp)
move $s4, $v0
mul $v1, $s1, $s4
move $s4, $v1
move $s0, $s4
L3:	 nop
nop
move $v0, $s0
lw $s0, 68($sp)
lw $s1, 64($sp)
lw $s2, 60($sp)
lw $s3, 56($sp)
lw $s4, 52($sp)
lw $s5, 48($sp)
lw $s6, 44($sp)
lw $s7, 40($sp)
lw $ra, -4($fp)
lw $fp, -8($fp)
addu $sp, $sp, 80
j $ra

         .text
         .globl    _halloc
_halloc:
         li $v0, 9
         syscall
         j $ra

         .text
         .globl    _print
_print:
         li $v0, 1
         syscall
         la $a0, newl
         li $v0, 4
         syscall
         j $ra
         .data
         .align   0
newl:    .asciiz "\n"
