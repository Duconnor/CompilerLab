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
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -12($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -24($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -12($fp)
	lw $9, -20($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -32($fp)
	lw $8, -32($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -36($fp)
	lw $9, -28($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -40($fp)
	lw $8, -40($fp)
	lw $9, -20($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	lw $8, -44($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -48($fp)
	lw $9, -20($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, -36($fp)
	lw $9, -52($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -56($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -60($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, -36($fp)
	lw $9, -48($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, -60($fp)
	lw $9, -64($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	li $9, 25
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -68($fp)
	lw $9, -72($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -76($fp)
	lw $8, -76($fp)
	move $9, $8
	sw $9, -60($fp)
	lw $8, -48($fp)
	lw $9, -60($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $8, -36($fp)
	lw $9, -60($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -80($fp)
	lw $9, -84($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -20($fp)
	lw $9, -92($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $8, -88($fp)
	lw $9, -96($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -100($fp)
	lw $8, -100($fp)
	move $9, $8
	sw $9, -48($fp)
	lw $8, -60($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, -48($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $v0, -104($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
