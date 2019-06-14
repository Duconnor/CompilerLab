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
	sw $9, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	addi $sp, $sp, -40
	lw $8, -48($fp)
	sw $8, -48($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -52($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -56($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -60($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -64($fp)
label1:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -68($fp)
	lw $8, -56($fp)
	lw $9, -68($fp)
	blt $8, $9, label2
	sw $8, -56($fp)
	sw $9, -68($fp)
	j label3
label2:
	lw $8, -56($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -72($fp)
	lw $9, -72($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	sw $10, -68($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -76($fp)
	move $8, $v0
	sw $8, -76($fp)
	lw $8, -76($fp)
	lw $9, -68($fp)
	sw, $8, 0($9)
	sw $8, -76($fp)
	sw $9, -68($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -80($fp)
	lw $8, -56($fp)
	lw $9, -80($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -84($fp)
	move $9, $8
	sw $9, -56($fp)
	j label1
label3:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -88($fp)
	lw $8, -8($fp)
	lw $9, -88($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -92($fp)
	lw $8, -92($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -96($fp)
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -96($fp)
	lw $9, -100($fp)
	bge $8, $9, label5
	sw $8, -96($fp)
	sw $9, -100($fp)
	j label6
label5:
	li $9, 0
	sw $9, -100($fp)
	lw $8, -100($fp)
	move $9, $8
	sw $9, -64($fp)
	lw $8, -96($fp)
	move $9, $8
	sw $9, -56($fp)
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -64($fp)
	lw $9, -104($fp)
	beq $8, $9, label8
	sw $8, -64($fp)
	sw $9, -104($fp)
	j label9
label8:
	li $9, 1
	sw $9, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	sw $9, -64($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -56($fp)
	lw $9, -108($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -116($fp)
	lw $8, -112($fp)
	lw $9, -116($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -120($fp)
	lw $8, -120($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -124($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -128($fp)
	lw $8, -56($fp)
	lw $9, -128($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -136($fp)
	lw $8, -132($fp)
	lw $9, -136($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	lw $8, -140($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -144($fp)
	lw $8, -124($fp)
	lw $9, -8($fp)
	blt $8, $9, label10
	sw $8, -124($fp)
	sw $9, -8($fp)
	j label11
label10:
	lw $8, -124($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -148($fp)
	lw $9, -148($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -152($fp)
	lw $8, -152($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $8, -156($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -144($fp)
	lw $9, -8($fp)
	blt $8, $9, label14
	sw $8, -144($fp)
	sw $9, -8($fp)
	j label13
label14:
	lw $8, -144($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $9, -164($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -168($fp)
	lw $8, -168($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -172($fp)
	lw $8, -124($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -176($fp)
	lw $9, -176($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -180($fp)
	lw $8, -180($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -184($fp)
	lw $8, -172($fp)
	lw $9, -184($fp)
	blt $8, $9, label12
	sw $8, -172($fp)
	sw $9, -184($fp)
	j label13
label12:
	lw $8, -144($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	lw $9, -188($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -192($fp)
	lw $8, -192($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -196($fp)
	lw $8, -196($fp)
	move $9, $8
	sw $9, -160($fp)
	lw $8, -144($fp)
	move $9, $8
	sw $9, -124($fp)
label13:
	lw $8, -56($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $9, -200($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $8, -204($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -208($fp)
	lw $8, -208($fp)
	lw $9, -160($fp)
	bgt $8, $9, label15
	sw $8, -208($fp)
	sw $9, -160($fp)
	j label16
label15:
	li $9, 0
	sw $9, -200($fp)
	lw $8, -200($fp)
	move $9, $8
	sw $9, -64($fp)
	lw $8, -124($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -212($fp)
	lw $9, -212($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $8, -56($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	lw $9, -220($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -224($fp)
	lw $8, -224($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -228($fp)
	lw $8, -228($fp)
	lw $9, -216($fp)
	sw, $8, 0($9)
	sw $8, -228($fp)
	sw $9, -216($fp)
	lw $8, -56($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -232($fp)
	lw $9, -232($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -236($fp)
	lw $8, -160($fp)
	lw $9, -236($fp)
	sw, $8, 0($9)
	sw $8, -160($fp)
	sw $9, -236($fp)
	lw $8, -124($fp)
	move $9, $8
	sw $9, -56($fp)
label16:
label11:
	j label7
label9:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -240($fp)
	lw $8, -96($fp)
	lw $9, -240($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -244($fp)
	lw $8, -244($fp)
	move $9, $8
	sw $9, -96($fp)
	j label4
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -248($fp)
	lw $8, -248($fp)
	move $9, $8
	sw $9, -56($fp)
label17:
	lw $8, -56($fp)
	lw $9, -8($fp)
	blt $8, $9, label18
	sw $8, -56($fp)
	sw $9, -8($fp)
	j label19
label18:
	lw $8, -56($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -252($fp)
	lw $9, -252($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -256($fp)
	lw $8, -256($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -260($fp)
	lw $8, -260($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -264($fp)
	lw $8, -56($fp)
	lw $9, -264($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -268($fp)
	lw $8, -268($fp)
	move $9, $8
	sw $9, -56($fp)
	j label17
label19:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -272($fp)
	lw $v0, -272($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
