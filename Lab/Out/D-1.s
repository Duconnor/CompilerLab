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

process:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	li $9, 11
	addi $sp, $sp, -4
	sw $9, -12($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -12($fp)
	lw $9, -16($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -20($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -20($fp)
	lw $9, -24($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -28($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -28($fp)
	lw $9, -32($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
	lw $8, -36($fp)
	move $9, $8
	sw $9, -8($fp)
	li $9, 321
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, 8($fp)
	lw $9, -40($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -44($fp)
	lw $9, -48($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, 8($fp)
	lw $9, -8($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, -52($fp)
	lw $9, -56($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -60($fp)
	lw $8, -60($fp)
	lw $9, 8($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, -8($fp)
	lw $9, 8($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	lw $8, -64($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -72($fp)
	lw $8, -8($fp)
	lw $9, -8($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -76($fp)
	lw $8, -72($fp)
	lw $9, -76($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $8, -80($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -84($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	li $9, 23
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -88($fp)
	lw $9, -92($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -96($fp)
	li $9, 45
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -96($fp)
	lw $9, -100($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	sw $9, -8($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -8($fp)
	lw $9, -108($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -112($fp)
	li $9, 14
	addi $sp, $sp, -4
	sw $9, -116($fp)
	li $9, 24
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -116($fp)
	lw $9, -120($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -124($fp)
	lw $8, -112($fp)
	lw $9, -124($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -132($fp)
	lw $8, 8($fp)
	lw $9, -132($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -136($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $8, -136($fp)
	lw $9, -140($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -128($fp)
	lw $9, -144($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -148($fp)
	li $9, 20
	addi $sp, $sp, -4
	sw $9, -152($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $8, -152($fp)
	lw $9, -156($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -160($fp)
	lw $8, -148($fp)
	lw $9, -160($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -168($fp)
	lw $8, -8($fp)
	lw $9, -168($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -172($fp)
	li $9, 24
	addi $sp, $sp, -4
	sw $9, -176($fp)
	lw $8, -172($fp)
	lw $9, -176($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -180($fp)
	lw $8, -164($fp)
	lw $9, -180($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -188($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -192($fp)
	lw $8, -188($fp)
	lw $9, -192($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -196($fp)
	lw $8, -184($fp)
	lw $9, -196($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -204($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -208($fp)
	lw $8, -204($fp)
	lw $9, -208($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -212($fp)
	lw $8, -200($fp)
	lw $9, -212($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $8, -216($fp)
	move $9, $8
	sw $9, -8($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -220($fp)
	li $9, 6
	addi $sp, $sp, -4
	sw $9, -224($fp)
	lw $8, -220($fp)
	lw $9, -224($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -228($fp)
	lw $8, 8($fp)
	lw $9, -228($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -232($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -236($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -240($fp)
	lw $8, -236($fp)
	lw $9, -240($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -244($fp)
	lw $8, -232($fp)
	lw $9, -244($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -248($fp)
	lw $8, -248($fp)
	move $9, $8
	sw $9, -8($fp)
	lw $v0, -8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -4($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $8, -4($fp)
	lw $9, -8($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -12($fp)
	li $9, 14
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -12($fp)
	lw $9, -16($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -20($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -20($fp)
	lw $9, -24($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -28($fp)
	lw $8, -28($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -32($fp)
	li $9, 7
	addi $sp, $sp, -4
	sw $9, -36($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, -36($fp)
	lw $9, -40($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -44($fp)
	lw $9, -48($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -52($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -52($fp)
	lw $9, -56($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -60($fp)
	lw $8, -60($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -64($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -68($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -68($fp)
	lw $9, -72($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -76($fp)
	li $9, 6
	addi $sp, $sp, -4
	sw $9, -80($fp)
	lw $8, -76($fp)
	lw $9, -80($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -88($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -88($fp)
	lw $9, -92($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -96($fp)
	lw $8, -84($fp)
	lw $9, -96($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -100($fp)
	lw $8, -100($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -108($fp)
	lw $8, -108($fp)
	lw $9, -104($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $8, -112($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -116($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -120($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -124($fp)
	lw $8, -104($fp)
	lw $9, -124($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -128($fp)
	lw $8, -120($fp)
	lw $9, -128($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	lw $8, -132($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -136($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	lw $8, -140($fp)
	lw $9, -104($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -144($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -148($fp)
	li $9, 42
	addi $sp, $sp, -4
	sw $9, -152($fp)
	lw $8, -152($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -156($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -160($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -164($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -168($fp)
	lw $8, -168($fp)
	lw $9, -104($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -172($fp)
	li $9, 1000
	addi $sp, $sp, -4
	sw $9, -176($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -180($fp)
	lw $8, -176($fp)
	lw $9, -180($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $8, -172($fp)
	lw $9, -184($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	lw $8, -188($fp)
	lw $9, -148($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -192($fp)
	lw $8, -192($fp)
	move $9, $8
	sw $9, -148($fp)
label1:
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -196($fp)
	lw $8, -196($fp)
	lw $9, -148($fp)
	blt $8, $9, label2
	sw $8, -196($fp)
	sw $9, -148($fp)
	j label3
label2:
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -200($fp)
	lw $8, -164($fp)
	lw $9, -200($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $8, -156($fp)
	lw $9, -204($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -208($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -212($fp)
	lw $8, -208($fp)
	lw $9, -212($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -220($fp)
	lw $8, -216($fp)
	lw $9, -220($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -224($fp)
	li $9, 7
	addi $sp, $sp, -4
	sw $9, -228($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -232($fp)
	lw $8, -228($fp)
	lw $9, -232($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -236($fp)
	lw $8, -224($fp)
	lw $9, -236($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -240($fp)
	lw $8, -240($fp)
	move $9, $8
	sw $9, -156($fp)
	lw $8, -148($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -248($fp)
	move $8, $v0
	sw $8, -248($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -252($fp)
	lw $8, -252($fp)
	lw $9, -32($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -256($fp)
	lw $8, -248($fp)
	lw $9, -256($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -260($fp)
	lw $8, -260($fp)
	lw $9, -148($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -264($fp)
	lw $8, -104($fp)
	lw $9, -116($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -268($fp)
	lw $8, -264($fp)
	lw $9, -268($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -272($fp)
	lw $8, -272($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -276($fp)
	lw $8, -164($fp)
	lw $9, -164($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -280($fp)
	lw $8, -280($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -164($fp)
	lw $9, -164($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -284($fp)
	lw $8, -284($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -164($fp)
	lw $9, -164($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -288($fp)
	lw $8, -288($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -164($fp)
	lw $9, -164($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -292($fp)
	lw $8, -292($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -164($fp)
	lw $9, -164($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -296($fp)
	lw $8, -296($fp)
	move $9, $8
	sw $9, -164($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -300($fp)
	lw $8, -164($fp)
	lw $9, -300($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -304($fp)
	lw $8, -304($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -308($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -312($fp)
	lw $8, -308($fp)
	lw $9, -312($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -316($fp)
	lw $8, -316($fp)
	move $9, $8
	sw $9, -308($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -320($fp)
	lw $8, -308($fp)
	lw $9, -320($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -324($fp)
	lw $8, -324($fp)
	move $9, $8
	sw $9, -308($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -328($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -332($fp)
	lw $8, -328($fp)
	lw $9, -332($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -336($fp)
	lw $8, -308($fp)
	lw $9, -336($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -340($fp)
	lw $8, -340($fp)
	move $9, $8
	sw $9, -308($fp)
	lw $8, -32($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -348($fp)
	move $8, $v0
	sw $8, -348($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -352($fp)
	lw $8, -32($fp)
	lw $9, -352($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -356($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -360($fp)
	lw $8, -356($fp)
	lw $9, -360($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -364($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -368($fp)
	lw $8, -364($fp)
	lw $9, -368($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -372($fp)
	lw $8, -372($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -380($fp)
	move $8, $v0
	sw $8, -380($fp)
	lw $8, -348($fp)
	lw $9, -380($fp)
	beq $8, $9, label4
	sw $8, -348($fp)
	sw $9, -380($fp)
	j label5
label4:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -384($fp)
	lw $8, -148($fp)
	lw $9, -384($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -388($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -392($fp)
	lw $8, -388($fp)
	lw $9, -392($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -396($fp)
	lw $8, -396($fp)
	move $9, $8
	sw $9, -148($fp)
label5:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -400($fp)
	lw $8, -32($fp)
	lw $9, -400($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -404($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -408($fp)
	lw $8, -404($fp)
	lw $9, -408($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -412($fp)
	lw $8, -412($fp)
	move $9, $8
	sw $9, -32($fp)
	j label1
label3:
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -416($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -420($fp)
	lw $8, -416($fp)
	lw $9, -420($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -424($fp)
	lw $8, -156($fp)
	lw $9, -424($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -428($fp)
	lw $8, -428($fp)
	move $9, $8
	sw $9, -308($fp)
label6:
	lw $8, -308($fp)
	lw $9, -156($fp)
	blt $8, $9, label7
	sw $8, -308($fp)
	sw $9, -156($fp)
	j label8
label7:
	li $9, 15
	addi $sp, $sp, -4
	sw $9, -432($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -436($fp)
	lw $8, -432($fp)
	lw $9, -436($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -440($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -444($fp)
	lw $8, -440($fp)
	lw $9, -444($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -448($fp)
	lw $8, -448($fp)
	lw $9, -32($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -452($fp)
	lw $8, -452($fp)
	move $9, $8
	sw $9, -148($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -456($fp)
	lw $8, -156($fp)
	lw $9, -456($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -460($fp)
	lw $8, -460($fp)
	move $9, $8
	sw $9, -276($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -464($fp)
	lw $8, -308($fp)
	lw $9, -464($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -468($fp)
	lw $8, -468($fp)
	move $9, $8
	sw $9, -308($fp)
	lw $8, -156($fp)
	move $9, $8
	sw $9, -276($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -472($fp)
	lw $8, -472($fp)
	move $9, $8
	sw $9, -164($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -476($fp)
	lw $8, -476($fp)
	move $9, $8
	sw $9, -104($fp)
	j label6
label8:
	lw $8, -148($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -480($fp)
	lw $8, -480($fp)
	move $9, $8
	sw $9, -32($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -484($fp)
	lw $8, -484($fp)
	move $9, $8
	sw $9, -64($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -488($fp)
	lw $8, -488($fp)
	move $9, $8
	sw $9, -104($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -492($fp)
	lw $8, -492($fp)
	move $9, $8
	sw $9, -148($fp)
	lw $8, -32($fp)
	lw $9, -64($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -496($fp)
	lw $8, -496($fp)
	move $9, $8
	sw $9, -276($fp)
	lw $8, -104($fp)
	lw $9, -148($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -500($fp)
	lw $8, -500($fp)
	lw $9, -276($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -504($fp)
	lw $8, -504($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -508($fp)
	lw $v0, -508($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
