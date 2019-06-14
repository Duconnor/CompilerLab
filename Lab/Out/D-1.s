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
	sw $9, -8($fp)
	lw $8, -8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -12($fp)
	li $9, 11
	addi $sp, $sp, -4
	sw $9, -16($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, -16($fp)
	lw $9, -20($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -24($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -24($fp)
	lw $9, -28($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -32($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, -32($fp)
	lw $9, -36($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -40($fp)
	lw $8, -40($fp)
	move $9, $8
	sw $9, -12($fp)
	li $9, 321
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, 8($fp)
	lw $9, -44($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -48($fp)
	lw $9, -52($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -56($fp)
	lw $8, 8($fp)
	lw $9, -12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -60($fp)
	lw $8, -56($fp)
	lw $9, -60($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, -64($fp)
	lw $9, 8($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	lw $8, -12($fp)
	lw $9, 8($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -72($fp)
	lw $8, -68($fp)
	lw $9, -72($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -76($fp)
	lw $8, -12($fp)
	lw $9, -12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	lw $8, -76($fp)
	lw $9, -80($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -84($fp)
	lw $8, -84($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -92($fp)
	li $9, 23
	addi $sp, $sp, -4
	sw $9, -96($fp)
	lw $8, -92($fp)
	lw $9, -96($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -100($fp)
	li $9, 45
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -100($fp)
	lw $9, -104($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -108($fp)
	lw $8, -108($fp)
	move $9, $8
	sw $9, -12($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -112($fp)
	lw $8, -12($fp)
	lw $9, -112($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -116($fp)
	li $9, 14
	addi $sp, $sp, -4
	sw $9, -120($fp)
	li $9, 24
	addi $sp, $sp, -4
	sw $9, -124($fp)
	lw $8, -120($fp)
	lw $9, -124($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	lw $8, -116($fp)
	lw $9, -128($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -132($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -136($fp)
	lw $8, 8($fp)
	lw $9, -136($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -140($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -144($fp)
	lw $8, -140($fp)
	lw $9, -144($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -148($fp)
	lw $8, -132($fp)
	lw $9, -148($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -152($fp)
	li $9, 20
	addi $sp, $sp, -4
	sw $9, -156($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -156($fp)
	lw $9, -160($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $8, -152($fp)
	lw $9, -164($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -168($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -172($fp)
	lw $8, -12($fp)
	lw $9, -172($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -176($fp)
	li $9, 24
	addi $sp, $sp, -4
	sw $9, -180($fp)
	lw $8, -176($fp)
	lw $9, -180($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $8, -168($fp)
	lw $9, -184($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -192($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -196($fp)
	lw $8, -192($fp)
	lw $9, -196($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $8, -188($fp)
	lw $9, -200($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -208($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -212($fp)
	lw $8, -208($fp)
	lw $9, -212($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $8, -204($fp)
	lw $9, -216($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	lw $8, -220($fp)
	move $9, $8
	sw $9, -12($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -224($fp)
	li $9, 6
	addi $sp, $sp, -4
	sw $9, -228($fp)
	lw $8, -224($fp)
	lw $9, -228($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -232($fp)
	lw $8, 8($fp)
	lw $9, -232($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -236($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -240($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -244($fp)
	lw $8, -240($fp)
	lw $9, -244($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -248($fp)
	lw $8, -236($fp)
	lw $9, -248($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -252($fp)
	lw $8, -252($fp)
	move $9, $8
	sw $9, -12($fp)
	lw $v0, -12($fp)
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
	sw $9, -8($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -12($fp)
	lw $8, -8($fp)
	lw $9, -12($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -16($fp)
	li $9, 14
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, -16($fp)
	lw $9, -20($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -24($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -24($fp)
	lw $9, -28($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -32($fp)
	lw $8, -32($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -36($fp)
	li $9, 7
	addi $sp, $sp, -4
	sw $9, -40($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -40($fp)
	lw $9, -44($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -48($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -52($fp)
	lw $8, -48($fp)
	lw $9, -52($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -56($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -56($fp)
	lw $9, -60($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, -64($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -68($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -72($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -76($fp)
	lw $8, -72($fp)
	lw $9, -76($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	li $9, 6
	addi $sp, $sp, -4
	sw $9, -84($fp)
	lw $8, -80($fp)
	lw $9, -84($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -92($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -96($fp)
	lw $8, -92($fp)
	lw $9, -96($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -100($fp)
	lw $8, -88($fp)
	lw $9, -100($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $8, -112($fp)
	lw $9, -108($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -116($fp)
	lw $8, -116($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -124($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -128($fp)
	lw $8, -108($fp)
	lw $9, -128($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -132($fp)
	lw $8, -124($fp)
	lw $9, -132($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -136($fp)
	lw $8, -136($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -144($fp)
	lw $8, -144($fp)
	lw $9, -108($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -148($fp)
	lw $8, -148($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -152($fp)
	li $9, 42
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $8, -156($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -160($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -164($fp)
	lw $8, -164($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -168($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -172($fp)
	lw $8, -172($fp)
	lw $9, -108($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -176($fp)
	li $9, 1000
	addi $sp, $sp, -4
	sw $9, -180($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -184($fp)
	lw $8, -180($fp)
	lw $9, -184($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -188($fp)
	lw $8, -176($fp)
	lw $9, -188($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -192($fp)
	lw $8, -192($fp)
	lw $9, -152($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -196($fp)
	lw $8, -196($fp)
	move $9, $8
	sw $9, -152($fp)
label1:
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -200($fp)
	lw $8, -200($fp)
	lw $9, -152($fp)
	blt $8, $9, label2
	sw $8, -200($fp)
	sw $9, -152($fp)
	j label3
label2:
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -204($fp)
	lw $8, -168($fp)
	lw $9, -204($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -208($fp)
	lw $8, -160($fp)
	lw $9, -208($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -212($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -216($fp)
	lw $8, -212($fp)
	lw $9, -216($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	li $9, 5
	addi $sp, $sp, -4
	sw $9, -224($fp)
	lw $8, -220($fp)
	lw $9, -224($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -228($fp)
	li $9, 7
	addi $sp, $sp, -4
	sw $9, -232($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -236($fp)
	lw $8, -232($fp)
	lw $9, -236($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -240($fp)
	lw $8, -228($fp)
	lw $9, -240($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -244($fp)
	lw $8, -244($fp)
	move $9, $8
	sw $9, -160($fp)
	lw $8, -152($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -252($fp)
	move $8, $v0
	sw $8, -252($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -256($fp)
	lw $8, -256($fp)
	lw $9, -36($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -260($fp)
	lw $8, -252($fp)
	lw $9, -260($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -264($fp)
	lw $8, -264($fp)
	lw $9, -152($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -268($fp)
	lw $8, -108($fp)
	lw $9, -120($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -272($fp)
	lw $8, -268($fp)
	lw $9, -272($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -276($fp)
	lw $8, -276($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -280($fp)
	lw $8, -168($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -284($fp)
	lw $8, -284($fp)
	move $9, $8
	sw $9, -168($fp)
	lw $8, -168($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -288($fp)
	lw $8, -288($fp)
	move $9, $8
	sw $9, -168($fp)
	lw $8, -168($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -292($fp)
	lw $8, -292($fp)
	move $9, $8
	sw $9, -168($fp)
	lw $8, -168($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -296($fp)
	lw $8, -296($fp)
	move $9, $8
	sw $9, -168($fp)
	lw $8, -168($fp)
	lw $9, -168($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -300($fp)
	lw $8, -300($fp)
	move $9, $8
	sw $9, -168($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -304($fp)
	lw $8, -168($fp)
	lw $9, -304($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -308($fp)
	lw $8, -308($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -312($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -316($fp)
	lw $8, -312($fp)
	lw $9, -316($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -320($fp)
	lw $8, -320($fp)
	move $9, $8
	sw $9, -312($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -324($fp)
	lw $8, -312($fp)
	lw $9, -324($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -328($fp)
	lw $8, -328($fp)
	move $9, $8
	sw $9, -312($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -332($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -336($fp)
	lw $8, -332($fp)
	lw $9, -336($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -340($fp)
	lw $8, -312($fp)
	lw $9, -340($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -344($fp)
	lw $8, -344($fp)
	move $9, $8
	sw $9, -312($fp)
	lw $8, -36($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -352($fp)
	move $8, $v0
	sw $8, -352($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -356($fp)
	lw $8, -36($fp)
	lw $9, -356($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -360($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -364($fp)
	lw $8, -360($fp)
	lw $9, -364($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -368($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -372($fp)
	lw $8, -368($fp)
	lw $9, -372($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -376($fp)
	lw $8, -376($fp)
	addi $sp, $sp, -4
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -384($fp)
	move $8, $v0
	sw $8, -384($fp)
	lw $8, -352($fp)
	lw $9, -384($fp)
	beq $8, $9, label4
	sw $8, -352($fp)
	sw $9, -384($fp)
	j label5
label4:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -388($fp)
	lw $8, -152($fp)
	lw $9, -388($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -392($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -396($fp)
	lw $8, -392($fp)
	lw $9, -396($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -400($fp)
	lw $8, -400($fp)
	move $9, $8
	sw $9, -152($fp)
label5:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -404($fp)
	lw $8, -36($fp)
	lw $9, -404($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -408($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -412($fp)
	lw $8, -408($fp)
	lw $9, -412($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -416($fp)
	lw $8, -416($fp)
	move $9, $8
	sw $9, -36($fp)
	j label1
label3:
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -420($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -424($fp)
	lw $8, -420($fp)
	lw $9, -424($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -428($fp)
	lw $8, -160($fp)
	lw $9, -428($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -432($fp)
	lw $8, -432($fp)
	move $9, $8
	sw $9, -312($fp)
label6:
	lw $8, -312($fp)
	lw $9, -160($fp)
	blt $8, $9, label7
	sw $8, -312($fp)
	sw $9, -160($fp)
	j label8
label7:
	li $9, 15
	addi $sp, $sp, -4
	sw $9, -436($fp)
	li $9, 4
	addi $sp, $sp, -4
	sw $9, -440($fp)
	lw $8, -436($fp)
	lw $9, -440($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -444($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -448($fp)
	lw $8, -444($fp)
	lw $9, -448($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -452($fp)
	lw $8, -452($fp)
	lw $9, -36($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -456($fp)
	lw $8, -456($fp)
	move $9, $8
	sw $9, -152($fp)
	li $9, 12
	addi $sp, $sp, -4
	sw $9, -460($fp)
	lw $8, -160($fp)
	lw $9, -460($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -464($fp)
	lw $8, -464($fp)
	move $9, $8
	sw $9, -280($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -468($fp)
	lw $8, -312($fp)
	lw $9, -468($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -472($fp)
	lw $8, -472($fp)
	move $9, $8
	sw $9, -312($fp)
	lw $8, -160($fp)
	move $9, $8
	sw $9, -280($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -476($fp)
	lw $8, -476($fp)
	move $9, $8
	sw $9, -168($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -480($fp)
	lw $8, -480($fp)
	move $9, $8
	sw $9, -108($fp)
	j label6
label8:
	lw $8, -152($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -484($fp)
	lw $8, -484($fp)
	move $9, $8
	sw $9, -36($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -488($fp)
	lw $8, -488($fp)
	move $9, $8
	sw $9, -68($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -492($fp)
	lw $8, -492($fp)
	move $9, $8
	sw $9, -108($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -496($fp)
	lw $8, -496($fp)
	move $9, $8
	sw $9, -152($fp)
	lw $8, -36($fp)
	lw $9, -68($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -500($fp)
	lw $8, -500($fp)
	move $9, $8
	sw $9, -280($fp)
	lw $8, -108($fp)
	lw $9, -152($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -504($fp)
	lw $8, -504($fp)
	lw $9, -280($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -508($fp)
	lw $8, -508($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -512($fp)
	lw $v0, -512($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
