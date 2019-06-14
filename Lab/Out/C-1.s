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
	addi $sp, $sp, -40
	lw $8, -88($fp)
	sw $8, -88($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $8, -92($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -96($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -100($fp)
	lw $8, -100($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -104($fp)
label1:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -108($fp)
	lw $8, -96($fp)
	lw $9, -108($fp)
	blt $8, $9, label2
	sw $8, -96($fp)
	sw $9, -108($fp)
	j label3
label2:
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -112($fp)
	lw $9, -112($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	sw $10, -108($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -116($fp)
	move $8, $v0
	sw $8, -116($fp)
	lw $8, -116($fp)
	lw $9, -108($fp)
	sw $8, 0($9)
	sw $8, -116($fp)
	sw $9, -108($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -120($fp)
	lw $8, -96($fp)
	lw $9, -120($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -124($fp)
	lw $8, -124($fp)
	move $9, $8
	sw $9, -96($fp)
	j label1
label3:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -128($fp)
	lw $8, -8($fp)
	lw $9, -128($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -132($fp)
	lw $8, -132($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -136($fp)
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -140($fp)
	lw $8, -136($fp)
	lw $9, -140($fp)
	bge $8, $9, label5
	sw $8, -136($fp)
	sw $9, -140($fp)
	j label6
label5:
	li $9, 0
	sw $9, -140($fp)
	lw $8, -140($fp)
	move $9, $8
	sw $9, -104($fp)
	lw $8, -136($fp)
	move $9, $8
	sw $9, -96($fp)
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -144($fp)
	lw $8, -104($fp)
	lw $9, -144($fp)
	beq $8, $9, label8
	sw $8, -104($fp)
	sw $9, -144($fp)
	j label9
label8:
	li $9, 1
	sw $9, -144($fp)
	lw $8, -144($fp)
	move $9, $8
	sw $9, -104($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -148($fp)
	lw $8, -96($fp)
	lw $9, -148($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -152($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -156($fp)
	lw $8, -152($fp)
	lw $9, -156($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -160($fp)
	lw $8, -160($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -164($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -168($fp)
	lw $8, -96($fp)
	lw $9, -168($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -172($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -176($fp)
	lw $8, -172($fp)
	lw $9, -176($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -180($fp)
	lw $8, -180($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -184($fp)
	lw $8, -164($fp)
	lw $9, -8($fp)
	blt $8, $9, label10
	sw $8, -164($fp)
	sw $9, -8($fp)
	j label11
label10:
	lw $8, -164($fp)
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
	addi $sp, $sp, -4
	sw $9, -200($fp)
	lw $8, -184($fp)
	lw $9, -8($fp)
	blt $8, $9, label14
	sw $8, -184($fp)
	sw $9, -8($fp)
	j label13
label14:
	lw $8, -184($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -204($fp)
	lw $9, -204($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -208($fp)
	lw $8, -208($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -212($fp)
	lw $8, -164($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -216($fp)
	lw $9, -216($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	lw $8, -220($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -224($fp)
	lw $8, -212($fp)
	lw $9, -224($fp)
	blt $8, $9, label12
	sw $8, -212($fp)
	sw $9, -224($fp)
	j label13
label12:
	lw $8, -184($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -228($fp)
	lw $9, -228($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -232($fp)
	lw $8, -232($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -236($fp)
	lw $8, -236($fp)
	move $9, $8
	sw $9, -200($fp)
	lw $8, -184($fp)
	move $9, $8
	sw $9, -164($fp)
label13:
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -240($fp)
	lw $9, -240($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -244($fp)
	lw $8, -244($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -248($fp)
	lw $8, -248($fp)
	lw $9, -200($fp)
	bgt $8, $9, label15
	sw $8, -248($fp)
	sw $9, -200($fp)
	j label16
label15:
	li $9, 0
	sw $9, -240($fp)
	lw $8, -240($fp)
	move $9, $8
	sw $9, -104($fp)
	lw $8, -164($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -252($fp)
	lw $9, -252($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -256($fp)
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -260($fp)
	lw $9, -260($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -264($fp)
	lw $8, -264($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -268($fp)
	lw $8, -268($fp)
	lw $9, -256($fp)
	sw $8, 0($9)
	sw $8, -268($fp)
	sw $9, -256($fp)
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -272($fp)
	lw $9, -272($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -276($fp)
	lw $8, -200($fp)
	lw $9, -276($fp)
	sw $8, 0($9)
	sw $8, -200($fp)
	sw $9, -276($fp)
	lw $8, -164($fp)
	move $9, $8
	sw $9, -96($fp)
label16:
label11:
	j label7
label9:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -280($fp)
	lw $8, -136($fp)
	lw $9, -280($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -284($fp)
	lw $8, -284($fp)
	move $9, $8
	sw $9, -136($fp)
	j label4
label6:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -288($fp)
	lw $8, -288($fp)
	move $9, $8
	sw $9, -136($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -292($fp)
	lw $8, -292($fp)
	move $9, $8
	sw $9, -96($fp)
label17:
	lw $8, -96($fp)
	lw $9, -8($fp)
	blt $8, $9, label18
	sw $8, -96($fp)
	sw $9, -8($fp)
	j label19
label18:
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -296($fp)
	lw $9, -296($fp)
	addi $8, $fp, -88
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -300($fp)
	li $9, 0
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -304($fp)
	lw $8, -304($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -308($fp)
	lw $8, -308($fp)
	lw $9, -300($fp)
	sw $8, 0($9)
	sw $8, -308($fp)
	sw $9, -300($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -312($fp)
	lw $8, -96($fp)
	lw $9, -312($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -316($fp)
	lw $8, -316($fp)
	move $9, $8
	sw $9, -96($fp)
	li $9, 0
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -320($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -324($fp)
	lw $8, -136($fp)
	lw $9, -324($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -328($fp)
	lw $8, -328($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -332($fp)
	lw $9, -332($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -336($fp)
	lw $8, -336($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -340($fp)
	lw $8, -340($fp)
	lw $9, -320($fp)
	sw $8, 0($9)
	sw $8, -340($fp)
	sw $9, -320($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -344($fp)
	lw $8, -344($fp)
	move $9, $8
	sw $9, -104($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -348($fp)
	lw $8, -136($fp)
	lw $9, -348($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -352($fp)
	lw $8, -352($fp)
	move $9, $8
	sw $9, -136($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -356($fp)
	lw $8, -356($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -360($fp)
label20:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -364($fp)
	lw $8, -104($fp)
	lw $9, -364($fp)
	beq $8, $9, label21
	sw $8, -104($fp)
	sw $9, -364($fp)
	j label22
label21:
	li $9, 1
	sw $9, -364($fp)
	lw $8, -364($fp)
	move $9, $8
	sw $9, -104($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -368($fp)
	lw $8, -360($fp)
	lw $9, -368($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -372($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -376($fp)
	lw $8, -372($fp)
	lw $9, -376($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -380($fp)
	lw $8, -380($fp)
	move $9, $8
	sw $9, -164($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -384($fp)
	lw $8, -360($fp)
	lw $9, -384($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -388($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -392($fp)
	lw $8, -388($fp)
	lw $9, -392($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -396($fp)
	lw $8, -396($fp)
	move $9, $8
	sw $9, -184($fp)
	lw $8, -164($fp)
	lw $9, -136($fp)
	blt $8, $9, label23
	sw $8, -164($fp)
	sw $9, -136($fp)
	j label24
label23:
	lw $8, -164($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -400($fp)
	lw $9, -400($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -404($fp)
	lw $8, -404($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -408($fp)
	lw $8, -408($fp)
	move $9, $8
	sw $9, -200($fp)
	lw $8, -184($fp)
	lw $9, -136($fp)
	blt $8, $9, label27
	sw $8, -184($fp)
	sw $9, -136($fp)
	j label26
label27:
	lw $8, -184($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -412($fp)
	lw $9, -412($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -416($fp)
	lw $8, -416($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -420($fp)
	lw $8, -164($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -424($fp)
	lw $9, -424($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -428($fp)
	lw $8, -428($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -432($fp)
	lw $8, -420($fp)
	lw $9, -432($fp)
	blt $8, $9, label25
	sw $8, -420($fp)
	sw $9, -432($fp)
	j label26
label25:
	lw $8, -184($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -436($fp)
	lw $9, -436($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -440($fp)
	lw $8, -440($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -444($fp)
	lw $8, -444($fp)
	move $9, $8
	sw $9, -200($fp)
	lw $8, -184($fp)
	move $9, $8
	sw $9, -164($fp)
label26:
	lw $8, -360($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -448($fp)
	lw $9, -448($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -452($fp)
	lw $8, -452($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -456($fp)
	lw $8, -456($fp)
	lw $9, -200($fp)
	bgt $8, $9, label28
	sw $8, -456($fp)
	sw $9, -200($fp)
	j label29
label28:
	li $9, 0
	sw $9, -448($fp)
	lw $8, -448($fp)
	move $9, $8
	sw $9, -104($fp)
	lw $8, -164($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -460($fp)
	lw $9, -460($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -464($fp)
	lw $8, -360($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -468($fp)
	lw $9, -468($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -472($fp)
	lw $8, -472($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -476($fp)
	lw $8, -476($fp)
	lw $9, -464($fp)
	sw $8, 0($9)
	sw $8, -476($fp)
	sw $9, -464($fp)
	lw $8, -360($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -480($fp)
	lw $9, -480($fp)
	addi $8, $fp, -48
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -484($fp)
	lw $8, -200($fp)
	lw $9, -484($fp)
	sw $8, 0($9)
	sw $8, -200($fp)
	sw $9, -484($fp)
	lw $8, -164($fp)
	move $9, $8
	sw $9, -360($fp)
label29:
label24:
	j label20
label22:
	j label17
label19:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -488($fp)
	lw $8, -488($fp)
	move $9, $8
	sw $9, -96($fp)
label30:
	lw $8, -96($fp)
	lw $9, -8($fp)
	blt $8, $9, label31
	sw $8, -96($fp)
	sw $9, -8($fp)
	j label32
label31:
	lw $8, -96($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -492($fp)
	lw $9, -492($fp)
	addi $8, $fp, -88
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -496($fp)
	lw $8, -496($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -500($fp)
	lw $8, -500($fp)
	move $a0, $8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -504($fp)
	lw $8, -96($fp)
	lw $9, -504($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -508($fp)
	lw $8, -508($fp)
	move $9, $8
	sw $9, -96($fp)
	j label30
label32:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -512($fp)
	lw $v0, -512($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
