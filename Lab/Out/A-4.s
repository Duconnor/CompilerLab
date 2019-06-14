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
	addi $sp, $sp, -20
	lw $8, -20($fp)
	sw $8, -20($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -24($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -28($fp)
label1:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -28($fp)
	lw $9, -32($fp)
	blt $8, $9, label2
	sw $8, -28($fp)
	sw $9, -32($fp)
	j label3
label2:
	lw $8, -28($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
	lw $9, -36($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	sw $10, -32($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -40($fp)
	move $8, $v0
	sw $8, -40($fp)
	lw $8, -40($fp)
	lw $9, -32($fp)
	sw $8, 0($9)
	sw $8, -40($fp)
	sw $9, -32($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -28($fp)
	lw $9, -44($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	lw $8, -48($fp)
	move $9, $8
	sw $9, -28($fp)
	j label1
label3:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -52($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -56($fp)
label4:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -56($fp)
	lw $9, -60($fp)
	beq $8, $9, label5
	sw $8, -56($fp)
	sw $9, -60($fp)
	j label6
label5:
	li $9, 0
	sw $9, -60($fp)
	lw $8, -60($fp)
	move $9, $8
	sw $9, -56($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -64($fp)
	lw $8, -64($fp)
	move $9, $8
	sw $9, -28($fp)
label7:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -68($fp)
	lw $8, -28($fp)
	lw $9, -68($fp)
	blt $8, $9, label8
	sw $8, -28($fp)
	sw $9, -68($fp)
	j label9
label8:
	lw $8, -28($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -72($fp)
label10:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -76($fp)
	lw $8, -72($fp)
	lw $9, -76($fp)
	bgt $8, $9, label13
	sw $8, -72($fp)
	sw $9, -76($fp)
	j label12
label13:
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $9, -80($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -84($fp)
	lw $9, 0($8)
	sw $9, -76($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -88($fp)
	lw $8, -72($fp)
	lw $9, -88($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -92($fp)
	lw $8, -92($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $9, -96($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -100($fp)
	lw $8, -100($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -76($fp)
	lw $9, -104($fp)
	blt $8, $9, label11
	sw $8, -76($fp)
	sw $9, -104($fp)
	j label12
label11:
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -108($fp)
	lw $9, -108($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $8, -112($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -116($fp)
	lw $8, -116($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -124($fp)
	lw $9, -124($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -132($fp)
	lw $8, -72($fp)
	lw $9, -132($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -136($fp)
	lw $8, -136($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	lw $9, -140($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -144($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -148($fp)
	lw $8, -148($fp)
	lw $9, -128($fp)
	sw $8, 0($9)
	sw $8, -148($fp)
	sw $9, -128($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -152($fp)
	lw $8, -72($fp)
	lw $9, -152($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -156($fp)
	lw $8, -156($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -160($fp)
	lw $9, -160($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $8, -120($fp)
	lw $9, -164($fp)
	sw $8, 0($9)
	sw $8, -120($fp)
	sw $9, -164($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -168($fp)
	lw $8, -168($fp)
	move $9, $8
	sw $9, -56($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -172($fp)
	lw $8, -72($fp)
	lw $9, -172($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -176($fp)
	lw $8, -176($fp)
	move $9, $8
	sw $9, -72($fp)
	j label10
label12:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -180($fp)
	lw $8, -28($fp)
	lw $9, -180($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $8, -184($fp)
	move $9, $8
	sw $9, -28($fp)
	j label7
label9:
	j label4
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -188($fp)
	lw $8, -188($fp)
	move $9, $8
	sw $9, -28($fp)
label14:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -192($fp)
	lw $8, -28($fp)
	lw $9, -192($fp)
	blt $8, $9, label15
	sw $8, -28($fp)
	sw $9, -192($fp)
	j label16
label15:
	lw $8, -28($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -196($fp)
	lw $9, -196($fp)
	addi $8, $fp, -20
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $8, -200($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -204($fp)
	lw $8, -204($fp)
	move $a0, $8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -208($fp)
	lw $8, -28($fp)
	lw $9, -208($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -212($fp)
	lw $8, -212($fp)
	move $9, $8
	sw $9, -28($fp)
	j label14
label16:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -216($fp)
	lw $v0, -216($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
