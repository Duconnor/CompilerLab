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

isPrime:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, 8($fp)
	lw $9, -4($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -8($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -12($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
label1:
	lw $8, -20($fp)
	lw $9, -12($fp)
	blt $8, $9, label2
	sw $8, -20($fp)
	sw $9, -12($fp)
	j label3
label2:
	lw $8, 8($fp)
	lw $9, -20($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -24($fp)
	lw $8, -24($fp)
	lw $9, -20($fp)
	mul $10, $8, $9
	sw $10, -24($fp)
	lw $8, 8($fp)
	lw $9, -24($fp)
	beq $8, $9, label4
	sw $8, 8($fp)
	sw $9, -24($fp)
	j label5
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $v0, -28($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label5:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -20($fp)
	lw $9, -28($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -32($fp)
	lw $8, -32($fp)
	move $9, $8
	sw $9, -20($fp)
	j label1
label3:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $v0, -36($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

isRever:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	lw $8, 8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -4($fp)
	addi $sp, $sp, -40
	lw $8, -44($fp)
	sw $8, -44($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -48($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -52($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -56($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -60($fp)
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -64($fp)
	lw $8, -4($fp)
	lw $9, -64($fp)
	bne $8, $9, label7
	sw $8, -4($fp)
	sw $9, -64($fp)
	j label8
label7:
	lw $8, -52($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	lw $9, -68($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	sw $10, -64($fp)
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -4($fp)
	lw $9, -72($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -76($fp)
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -80($fp)
	lw $8, -76($fp)
	lw $9, -80($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -4($fp)
	lw $9, -84($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	lw $9, -64($fp)
	sw, $8, 0($9)
	sw $8, -88($fp)
	sw $9, -64($fp)
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -4($fp)
	lw $9, -92($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $8, -96($fp)
	move $9, $8
	sw $9, -4($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -52($fp)
	lw $9, -100($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	sw $9, -52($fp)
	j label6
label8:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -52($fp)
	lw $9, -108($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $8, -112($fp)
	move $9, $8
	sw $9, -52($fp)
label9:
	lw $8, -60($fp)
	lw $9, -52($fp)
	bne $8, $9, label10
	sw $8, -60($fp)
	sw $9, -52($fp)
	j label11
label10:
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -116($fp)
	lw $9, -116($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -120($fp)
	lw $8, -120($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -124($fp)
	lw $8, -52($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	lw $9, -128($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	lw $8, -132($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -136($fp)
	lw $8, -124($fp)
	lw $9, -136($fp)
	bne $8, $9, label12
	sw $8, -124($fp)
	sw $9, -136($fp)
	j label13
label12:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $v0, -140($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label13:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $8, -60($fp)
	lw $9, -140($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -144($fp)
	move $9, $8
	sw $9, -60($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -148($fp)
	lw $8, -52($fp)
	lw $9, -148($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -152($fp)
	lw $8, -152($fp)
	move $9, $8
	sw $9, -52($fp)
	j label9
label11:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $v0, -156($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 100
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	li $9, 110
	addi $sp, $sp, -4
	sw $9, -12($fp)
	lw $8, -12($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
label14:
	lw $8, -20($fp)
	lw $9, -16($fp)
	blt $8, $9, label15
	sw $8, -20($fp)
	sw $9, -16($fp)
	j label16
label15:
	lw $8, -20($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal isPrime
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -28($fp)
	move $8, $v0
	sw $8, -28($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -28($fp)
	lw $9, -32($fp)
	beq $8, $9, label17
	sw $8, -28($fp)
	sw $9, -32($fp)
	j label18
label17:
	lw $8, -20($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
label18:
	lw $8, -20($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal isRever
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -40($fp)
	move $8, $v0
	sw $8, -40($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -40($fp)
	lw $9, -44($fp)
	beq $8, $9, label19
	sw $8, -40($fp)
	sw $9, -44($fp)
	j label20
label19:
	li $8, 0
	lw $9, -20($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	lw $8, -48($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
label20:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -20($fp)
	lw $9, -52($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -56($fp)
	move $9, $8
	sw $9, -20($fp)
	j label14
label16:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $v0, -60($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
