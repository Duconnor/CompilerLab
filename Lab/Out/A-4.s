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
	lw $8, -24($fp)
	sw $8, -24($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -28($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -32($fp)
label1:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -32($fp)
	lw $9, -36($fp)
	blt $8, $9, label2
	sw $8, -32($fp)
	sw $9, -36($fp)
	j label3
label2:
	lw $8, -32($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -40($fp)
	lw $9, -40($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	sw $10, -36($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -44($fp)
	move $8, $v0
	sw $8, -44($fp)
	lw $8, -44($fp)
	lw $9, -36($fp)
	sw, $8, 0($9)
	sw $8, -44($fp)
	sw $9, -36($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -32($fp)
	lw $9, -48($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, -52($fp)
	move $9, $8
	sw $9, -32($fp)
	j label1
label3:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -56($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -60($fp)
label4:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -64($fp)
	lw $8, -60($fp)
	lw $9, -64($fp)
	beq $8, $9, label5
	sw $8, -60($fp)
	sw $9, -64($fp)
	j label6
label5:
	li $9, 0
	sw $9, -64($fp)
	lw $8, -64($fp)
	move $9, $8
	sw $9, -60($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -68($fp)
	lw $8, -68($fp)
	move $9, $8
	sw $9, -32($fp)
label7:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -32($fp)
	lw $9, -72($fp)
	blt $8, $9, label8
	sw $8, -32($fp)
	sw $9, -72($fp)
	j label9
label8:
	lw $8, -32($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -76($fp)
label10:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -80($fp)
	lw $8, -76($fp)
	lw $9, -80($fp)
	bgt $8, $9, label13
	sw $8, -76($fp)
	sw $9, -80($fp)
	j label12
label13:
	lw $8, -76($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $9, -84($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	lw $9, 0($8)
	sw $9, -80($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -76($fp)
	lw $9, -92($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -100($fp)
	lw $9, -100($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -104($fp)
	lw $8, -104($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -80($fp)
	lw $9, -108($fp)
	blt $8, $9, label11
	sw $8, -80($fp)
	sw $9, -108($fp)
	j label12
label11:
	lw $8, -76($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $9, -112($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -116($fp)
	lw $8, -116($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -120($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -124($fp)
	lw $8, -76($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	lw $9, -128($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -136($fp)
	lw $8, -76($fp)
	lw $9, -136($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	lw $8, -140($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $9, -144($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -148($fp)
	lw $8, -148($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -152($fp)
	lw $8, -152($fp)
	lw $9, -132($fp)
	sw, $8, 0($9)
	sw $8, -152($fp)
	sw $9, -132($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $8, -76($fp)
	lw $9, -156($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -160($fp)
	lw $8, -160($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $9, -164($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -168($fp)
	lw $8, -124($fp)
	lw $9, -168($fp)
	sw, $8, 0($9)
	sw $8, -124($fp)
	sw $9, -168($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -172($fp)
	lw $8, -172($fp)
	move $9, $8
	sw $9, -60($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -176($fp)
	lw $8, -76($fp)
	lw $9, -176($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -180($fp)
	lw $8, -180($fp)
	move $9, $8
	sw $9, -76($fp)
	j label10
label12:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -184($fp)
	lw $8, -32($fp)
	lw $9, -184($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	lw $8, -188($fp)
	move $9, $8
	sw $9, -32($fp)
	j label7
label9:
	j label4
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -192($fp)
	lw $8, -192($fp)
	move $9, $8
	sw $9, -32($fp)
label14:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -196($fp)
	lw $8, -32($fp)
	lw $9, -196($fp)
	blt $8, $9, label15
	sw $8, -32($fp)
	sw $9, -196($fp)
	j label16
label15:
	lw $8, -32($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $9, -200($fp)
	addi $8, $fp, -24
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $8, -204($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -208($fp)
	lw $8, -208($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -212($fp)
	lw $8, -32($fp)
	lw $9, -212($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $8, -216($fp)
	move $9, $8
	sw $9, -32($fp)
	j label14
label16:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -220($fp)
	lw $v0, -220($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
