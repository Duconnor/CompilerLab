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
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -8($fp)
	move $8, $v0
	sw $8, -8($fp)
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
	lw $8, -12($fp)
	lw $9, -20($fp)
	bgt $8, $9, label1
	sw $8, -12($fp)
	sw $9, -20($fp)
	j label2
label1:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -20($fp)
	lw $9, -24($fp)
	mul $10, $8, $9
	sw $10, -24($fp)
	lw $8, -12($fp)
	lw $9, -24($fp)
	bgt $8, $9, label4
	sw $8, -12($fp)
	sw $9, -24($fp)
	j label5
label4:
	lw $8, -12($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	j label6
label5:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -20($fp)
	lw $9, -28($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -32($fp)
	lw $8, -32($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
label6:
	j label3
label2:
	lw $8, -12($fp)
	lw $9, -20($fp)
	beq $8, $9, label7
	sw $8, -12($fp)
	sw $9, -20($fp)
	j label8
label7:
	li $9, 100
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -20($fp)
	lw $9, -36($fp)
	bgt $8, $9, label10
	sw $8, -20($fp)
	sw $9, -36($fp)
	j label11
label10:
	li $9, 100
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, -40($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	j label12
label11:
	lw $8, -20($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
label12:
	j label9
label8:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -12($fp)
	lw $9, -44($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	lw $8, -48($fp)
	lw $9, -20($fp)
	blt $8, $9, label13
	sw $8, -48($fp)
	sw $9, -20($fp)
	j label14
label13:
	lw $8, -20($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	j label15
label14:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -12($fp)
	lw $9, -52($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -56($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
label15:
label9:
label3:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $v0, -60($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
