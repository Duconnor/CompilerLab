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

compare:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	lw $8, 8($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, 8($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, 8($fp)
	lw $9, 8($fp)
	bgt $8, $9, label1
	sw $8, 8($fp)
	sw $9, 8($fp)
	j label2
label1:
	lw $v0, 8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label2:
	lw $8, 8($fp)
	lw $9, 8($fp)
	blt $8, $9, label3
	sw $8, 8($fp)
	sw $9, 8($fp)
	j label4
label3:
	lw $v0, 8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $v0, -4($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

myadd:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	lw $8, 8($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -4($fp)
	lw $v0, -4($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	addi $sp, $sp, -12
	lw $8, -12($fp)
	sw $8, -12($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
label5:
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -20($fp)
	lw $9, -24($fp)
	blt $8, $9, label6
	sw $8, -20($fp)
	sw $9, -24($fp)
	j label7
label6:
	li $9, 4
	lw $8, -20($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -28($fp)
	lw $9, -28($fp)
	addi $8, $fp, -12
	add $10, $8, $9
	sw $10, -24($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -32($fp)
	move $8, $v0
	sw $8, -32($fp)
	lw $8, -32($fp)
	lw $9, -24($fp)
	sw, $8, 0($9)
	sw $8, -32($fp)
	sw $9, -24($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -20($fp)
	lw $9, -36($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -40($fp)
	lw $8, -40($fp)
	move $9, $8
	sw $9, -20($fp)
	j label5
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -44($fp)
	move $9, $8
	sw $9, -20($fp)
	li $9, 4
	addi $8, $fp, -12
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	lw $8, -48($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -52($fp)
	li $9, 8
	addi $8, $fp, -12
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -56($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -60($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -52($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal myadd
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -72($fp)
	move $8, $v0
	sw $8, -72($fp)
	lw $8, -72($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -76($fp)
	lw $8, -76($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $8, $fp, -12
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $8, -80($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -84($fp)
	lw $8, -76($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -84($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal compare
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -96($fp)
	move $8, $v0
	sw $8, -96($fp)
	lw $8, -96($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -100($fp)
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
