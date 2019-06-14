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
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -12($fp)
	addi $sp, $sp, -40
	lw $8, -52($fp)
	sw $8, -52($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -56($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -60($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -64($fp)
	lw $8, -64($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -68($fp)
label1:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -60($fp)
	lw $9, -72($fp)
	blt $8, $9, label2
	sw $8, -60($fp)
	sw $9, -72($fp)
	j label3
label2:
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -76($fp)
	lw $9, -76($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	sw $10, -72($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -80($fp)
	move $8, $v0
	sw $8, -80($fp)
	lw $8, -80($fp)
	lw $9, -72($fp)
	sw, $8, 0($9)
	sw $8, -80($fp)
	sw $9, -72($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -84($fp)
	lw $8, -60($fp)
	lw $9, -84($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	move $9, $8
	sw $9, -60($fp)
	j label1
label3:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -12($fp)
	lw $9, -92($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $8, -96($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -100($fp)
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -100($fp)
	lw $9, -104($fp)
	bge $8, $9, label5
	sw $8, -100($fp)
	sw $9, -104($fp)
	j label6
label5:
	li $9, 0
	sw $9, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	sw $9, -68($fp)
	lw $8, -100($fp)
	move $9, $8
	sw $9, -60($fp)
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -68($fp)
	lw $9, -108($fp)
	beq $8, $9, label8
	sw $8, -68($fp)
	sw $9, -108($fp)
	j label9
label8:
	li $9, 1
	sw $9, -108($fp)
	lw $8, -108($fp)
	move $9, $8
	sw $9, -68($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -112($fp)
	lw $8, -60($fp)
	lw $9, -112($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -116($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -116($fp)
	lw $9, -120($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -124($fp)
	lw $8, -124($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -128($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -132($fp)
	lw $8, -60($fp)
	lw $9, -132($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -136($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $8, -136($fp)
	lw $9, -140($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -144($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -148($fp)
	lw $8, -128($fp)
	lw $9, -12($fp)
	blt $8, $9, label10
	sw $8, -128($fp)
	sw $9, -12($fp)
	j label11
label10:
	lw $8, -128($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -152($fp)
	lw $9, -152($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -156($fp)
	lw $8, -156($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -160($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -164($fp)
	lw $8, -148($fp)
	lw $9, -12($fp)
	blt $8, $9, label14
	sw $8, -148($fp)
	sw $9, -12($fp)
	j label13
label14:
	lw $8, -148($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -168($fp)
	lw $9, -168($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -172($fp)
	lw $8, -172($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -176($fp)
	lw $8, -128($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -180($fp)
	lw $9, -180($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $8, -184($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -188($fp)
	lw $8, -176($fp)
	lw $9, -188($fp)
	blt $8, $9, label12
	sw $8, -176($fp)
	sw $9, -188($fp)
	j label13
label12:
	lw $8, -148($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -192($fp)
	lw $9, -192($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -196($fp)
	lw $8, -196($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -200($fp)
	lw $8, -200($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -148($fp)
	move $9, $8
	sw $9, -128($fp)
label13:
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $9, -204($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -208($fp)
	lw $8, -208($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -212($fp)
	lw $8, -212($fp)
	lw $9, -164($fp)
	bgt $8, $9, label15
	sw $8, -212($fp)
	sw $9, -164($fp)
	j label16
label15:
	li $9, 0
	sw $9, -204($fp)
	lw $8, -204($fp)
	move $9, $8
	sw $9, -68($fp)
	lw $8, -128($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $9, -216($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -224($fp)
	lw $9, -224($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -228($fp)
	lw $8, -228($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -232($fp)
	lw $8, -232($fp)
	lw $9, -220($fp)
	sw, $8, 0($9)
	sw $8, -232($fp)
	sw $9, -220($fp)
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -236($fp)
	lw $9, -236($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -240($fp)
	lw $8, -164($fp)
	lw $9, -240($fp)
	sw, $8, 0($9)
	sw $8, -164($fp)
	sw $9, -240($fp)
	lw $8, -128($fp)
	move $9, $8
	sw $9, -60($fp)
label16:
label11:
	j label7
label9:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -244($fp)
	lw $8, -100($fp)
	lw $9, -244($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -248($fp)
	lw $8, -248($fp)
	move $9, $8
	sw $9, -100($fp)
	j label4
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -252($fp)
	lw $8, -252($fp)
	move $9, $8
	sw $9, -60($fp)
label17:
	lw $8, -60($fp)
	lw $9, -12($fp)
	blt $8, $9, label18
	sw $8, -60($fp)
	sw $9, -12($fp)
	j label19
label18:
	lw $8, -60($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -256($fp)
	lw $9, -256($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -260($fp)
	lw $8, -260($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -264($fp)
	lw $8, -264($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -268($fp)
	lw $8, -60($fp)
	lw $9, -268($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -272($fp)
	lw $8, -272($fp)
	move $9, $8
	sw $9, -60($fp)
	j label17
label19:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -276($fp)
	lw $v0, -276($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
