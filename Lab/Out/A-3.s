.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n"
.globl main
.text
read:
	li $v0, 4
	la $a0, _prompt
	syscall
	li $v0, 5
	syscall
	jr $ra

write:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, _ret
	syscall
	move $v0, $0
	jr $ra

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -12($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -16($fp)
	move $8, $v0
	sw $8, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -24($fp)
	move $8, $v0
	sw $8, -24($fp)
	lw $8, -24($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -20($fp)
	lw $9, -28($fp)
	bgt $8, $9, label1
	sw $8, -20($fp)
	sw $9, -28($fp)
	j label2
label1:
	lw $8, -20($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -32($fp)
	j label3
label2:
	lw $8, -28($fp)
	move $9, $8
	sw $9, -32($fp)
label3:
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -12($fp)
	lw $9, -36($fp)
	beq $8, $9, label5
	sw $8, -12($fp)
	sw $9, -36($fp)
	j label6
label5:
	lw $8, -32($fp)
	lw $9, -20($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -40($fp)
	lw $8, -40($fp)
	lw $9, -20($fp)
	mul $10, $8, $9
	sw $10, -40($fp)
	lw $8, -32($fp)
	lw $9, -40($fp)
	beq $8, $9, label7
	sw $8, -32($fp)
	sw $9, -40($fp)
	j label8
label7:
	lw $8, -32($fp)
	lw $9, -28($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -44($fp)
	lw $8, -44($fp)
	lw $9, -28($fp)
	mul $10, $8, $9
	sw $10, -44($fp)
	lw $8, -32($fp)
	lw $9, -44($fp)
	beq $8, $9, label10
	sw $8, -32($fp)
	sw $9, -44($fp)
	j label11
label10:
	lw $8, -32($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -48($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -52($fp)
	move $9, $8
	sw $9, -12($fp)
	j label12
label11:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -32($fp)
	lw $9, -56($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -60($fp)
	lw $8, -60($fp)
	move $9, $8
	sw $9, -32($fp)
label12:
	j label9
label8:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -64($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	lw $8, -68($fp)
	move $9, $8
	sw $9, -32($fp)
label9:
	j label4
label6:
	lw $8, -48($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $v0, -72($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
