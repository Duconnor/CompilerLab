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
	lw $9, 12($fp)
	bgt $8, $9, label1
	sw $8, 8($fp)
	sw $9, 12($fp)
	j label2
label1:
	lw $v0, 8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label2:
	lw $8, 8($fp)
	lw $9, 12($fp)
	blt $8, $9, label3
	sw $8, 8($fp)
	sw $9, 12($fp)
	j label4
label3:
	lw $v0, 12($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, 0($fp)
	lw $v0, 0($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

myadd:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	lw $8, 8($fp)
	lw $9, 12($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -8($fp)
	lw $v0, -8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	addi $sp, $sp, -40
	lw $8, -44($fp)
	sw $8, -44($fp)
	addi $sp, $sp, -20
	lw $8, -64($fp)
	sw $8, -64($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -68($fp)
	lw $8, -68($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -72($fp)
label5:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -76($fp)
	lw $8, -72($fp)
	lw $9, -76($fp)
	blt $8, $9, label6
	sw $8, -72($fp)
	sw $9, -76($fp)
	j label7
label6:
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $9, -80($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	sw $10, -76($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -84($fp)
	move $8, $v0
	sw $8, -84($fp)
	lw $8, -84($fp)
	lw $9, -76($fp)
	sw, $8, 0($9)
	sw $8, -84($fp)
	sw $9, -76($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -88($fp)
	lw $8, -72($fp)
	lw $9, -88($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -92($fp)
	lw $8, -92($fp)
	move $9, $8
	sw $9, -72($fp)
	j label5
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -96($fp)
	lw $8, -96($fp)
	move $9, $8
	sw $9, -72($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -100($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -104($fp)
label8:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -72($fp)
	lw $9, -108($fp)
	blt $8, $9, label9
	sw $8, -72($fp)
	sw $9, -108($fp)
	j label10
label9:
	lw $8, -104($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $9, -112($fp)
	addi $8, $fp, -64
	add $10, $8, $9
	sw $10, -108($fp)
	lw $8, -72($fp)
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
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -128($fp)
	lw $8, -72($fp)
	lw $9, -128($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	lw $8, -132($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -136($fp)
	lw $9, -136($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	lw $8, -140($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -144($fp)
	lw $8, -144($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -124($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal compare
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -156($fp)
	move $8, $v0
	sw $8, -156($fp)
	lw $8, -156($fp)
	lw $9, -108($fp)
	sw, $8, 0($9)
	sw $8, -156($fp)
	sw $9, -108($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -72($fp)
	lw $9, -160($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $8, -164($fp)
	move $9, $8
	sw $9, -72($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -168($fp)
	lw $8, -104($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -172($fp)
	lw $8, -172($fp)
	move $9, $8
	sw $9, -104($fp)
	j label8
label10:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -176($fp)
	lw $8, -176($fp)
	move $9, $8
	sw $9, -72($fp)
label11:
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -180($fp)
	lw $8, -72($fp)
	lw $9, -180($fp)
	blt $8, $9, label12
	sw $8, -72($fp)
	sw $9, -180($fp)
	j label13
label12:
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $9, -184($fp)
	addi $8, $fp, -64
	add $10, $8, $9
	sw $10, -180($fp)
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	lw $9, -188($fp)
	addi $8, $fp, -64
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -192($fp)
	lw $8, -192($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -196($fp)
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $9, -200($fp)
	addi $8, $fp, -44
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $8, -204($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -208($fp)
	lw $8, -208($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	lw $8, -196($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal myadd
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -220($fp)
	move $8, $v0
	sw $8, -220($fp)
	lw $8, -220($fp)
	lw $9, -180($fp)
	sw, $8, 0($9)
	sw $8, -220($fp)
	sw $9, -180($fp)
	lw $8, -72($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -224($fp)
	lw $9, -224($fp)
	addi $8, $fp, -64
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -228($fp)
	lw $8, -228($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -232($fp)
	lw $8, -232($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -236($fp)
	lw $8, -72($fp)
	lw $9, -236($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -240($fp)
	lw $8, -240($fp)
	move $9, $8
	sw $9, -72($fp)
	j label11
label13:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -244($fp)
	lw $v0, -244($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
