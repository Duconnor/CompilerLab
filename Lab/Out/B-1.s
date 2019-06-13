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

hanoi:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, 8($fp)
	lw $9, -4($fp)
	beq $8, $9, label1
	sw $8, 8($fp)
	sw $9, -4($fp)
	j label2
label1:
	li $9, 1000000000
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $9, -8($fp)
	lw $8, 12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -12($fp)
	lw $8, -12($fp)
	lw $9, 20($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -16($fp)
	lw $8, -16($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	j label3
label2:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, 8($fp)
	lw $9, -20($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -24($fp)
	lw $8, 16($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, 20($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, 12($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -24($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -44($fp)
	move $8, $v0
	sw $8, -44($fp)
	li $9, 1000000000
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $9, -48($fp)
	lw $8, 12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, -52($fp)
	lw $9, 20($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -56($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, 8($fp)
	lw $9, -60($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, 20($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, 12($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, 16($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -64($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -84($fp)
	move $8, $v0
	sw $8, -84($fp)
label3:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -88($fp)
	lw $v0, -88($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
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
	lw $8, -4($fp)
	move $8, $v0
	sw $8, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -12($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -16($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, -20($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -16($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -12($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -8($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -40($fp)
	move $8, $v0
	sw $8, -40($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $v0, -44($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
