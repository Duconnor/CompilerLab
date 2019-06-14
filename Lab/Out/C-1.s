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
	addi $sp, $sp, -40
	lw $8, -92($fp)
	sw $8, -92($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -96($fp)
	lw $8, -96($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -100($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -104($fp)
	lw $8, -104($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -108($fp)
label1:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -112($fp)
	lw $8, -100($fp)
	lw $9, -112($fp)
	blt $8, $9, label2
	sw $8, -100($fp)
	sw $9, -112($fp)
	j label3
label2:
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -116($fp)
	lw $9, -116($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	sw $10, -112($fp)
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -120($fp)
	move $8, $v0
	sw $8, -120($fp)
	lw $8, -120($fp)
	lw $9, -112($fp)
	sw, $8, 0($9)
	sw $8, -120($fp)
	sw $9, -112($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -124($fp)
	lw $8, -100($fp)
	lw $9, -124($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -128($fp)
	lw $8, -128($fp)
	move $9, $8
	sw $9, -100($fp)
	j label1
label3:
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -132($fp)
	lw $8, -12($fp)
	lw $9, -132($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -136($fp)
	lw $8, -136($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -140($fp)
label4:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -144($fp)
	lw $8, -140($fp)
	lw $9, -144($fp)
	bge $8, $9, label5
	sw $8, -140($fp)
	sw $9, -144($fp)
	j label6
label5:
	li $9, 0
	sw $9, -144($fp)
	lw $8, -144($fp)
	move $9, $8
	sw $9, -108($fp)
	lw $8, -140($fp)
	move $9, $8
	sw $9, -100($fp)
label7:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -148($fp)
	lw $8, -108($fp)
	lw $9, -148($fp)
	beq $8, $9, label8
	sw $8, -108($fp)
	sw $9, -148($fp)
	j label9
label8:
	li $9, 1
	sw $9, -148($fp)
	lw $8, -148($fp)
	move $9, $8
	sw $9, -108($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -152($fp)
	lw $8, -100($fp)
	lw $9, -152($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -156($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -160($fp)
	lw $8, -156($fp)
	lw $9, -160($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -164($fp)
	lw $8, -164($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -168($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -172($fp)
	lw $8, -100($fp)
	lw $9, -172($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -176($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -180($fp)
	lw $8, -176($fp)
	lw $9, -180($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -184($fp)
	lw $8, -184($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -188($fp)
	lw $8, -168($fp)
	lw $9, -12($fp)
	blt $8, $9, label10
	sw $8, -168($fp)
	sw $9, -12($fp)
	j label11
label10:
	lw $8, -168($fp)
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
	addi $sp, $sp, -4
	sw $9, -204($fp)
	lw $8, -188($fp)
	lw $9, -12($fp)
	blt $8, $9, label14
	sw $8, -188($fp)
	sw $9, -12($fp)
	j label13
label14:
	lw $8, -188($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -208($fp)
	lw $9, -208($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -212($fp)
	lw $8, -212($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -216($fp)
	lw $8, -168($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -220($fp)
	lw $9, -220($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -224($fp)
	lw $8, -224($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -228($fp)
	lw $8, -216($fp)
	lw $9, -228($fp)
	blt $8, $9, label12
	sw $8, -216($fp)
	sw $9, -228($fp)
	j label13
label12:
	lw $8, -188($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -232($fp)
	lw $9, -232($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -236($fp)
	lw $8, -236($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -240($fp)
	lw $8, -240($fp)
	move $9, $8
	sw $9, -204($fp)
	lw $8, -188($fp)
	move $9, $8
	sw $9, -168($fp)
label13:
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -244($fp)
	lw $9, -244($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -248($fp)
	lw $8, -248($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -252($fp)
	lw $8, -252($fp)
	lw $9, -204($fp)
	bgt $8, $9, label15
	sw $8, -252($fp)
	sw $9, -204($fp)
	j label16
label15:
	li $9, 0
	sw $9, -244($fp)
	lw $8, -244($fp)
	move $9, $8
	sw $9, -108($fp)
	lw $8, -168($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -256($fp)
	lw $9, -256($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -260($fp)
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -264($fp)
	lw $9, -264($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -268($fp)
	lw $8, -268($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -272($fp)
	lw $8, -272($fp)
	lw $9, -260($fp)
	sw, $8, 0($9)
	sw $8, -272($fp)
	sw $9, -260($fp)
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -276($fp)
	lw $9, -276($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -280($fp)
	lw $8, -204($fp)
	lw $9, -280($fp)
	sw, $8, 0($9)
	sw $8, -204($fp)
	sw $9, -280($fp)
	lw $8, -168($fp)
	move $9, $8
	sw $9, -100($fp)
label16:
label11:
	j label7
label9:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -284($fp)
	lw $8, -140($fp)
	lw $9, -284($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -288($fp)
	lw $8, -288($fp)
	move $9, $8
	sw $9, -140($fp)
	j label4
label6:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -292($fp)
	lw $8, -292($fp)
	move $9, $8
	sw $9, -140($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -296($fp)
	lw $8, -296($fp)
	move $9, $8
	sw $9, -100($fp)
label17:
	lw $8, -100($fp)
	lw $9, -12($fp)
	blt $8, $9, label18
	sw $8, -100($fp)
	sw $9, -12($fp)
	j label19
label18:
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -300($fp)
	lw $9, -300($fp)
	addi $8, $fp, -92
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -304($fp)
	li $9, 0
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -308($fp)
	lw $8, -308($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -312($fp)
	lw $8, -312($fp)
	lw $9, -304($fp)
	sw, $8, 0($9)
	sw $8, -312($fp)
	sw $9, -304($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -316($fp)
	lw $8, -100($fp)
	lw $9, -316($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -320($fp)
	lw $8, -320($fp)
	move $9, $8
	sw $9, -100($fp)
	li $9, 0
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -324($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -328($fp)
	lw $8, -140($fp)
	lw $9, -328($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -332($fp)
	lw $8, -332($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -336($fp)
	lw $9, -336($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -340($fp)
	lw $8, -340($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -344($fp)
	lw $8, -344($fp)
	lw $9, -324($fp)
	sw, $8, 0($9)
	sw $8, -344($fp)
	sw $9, -324($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -348($fp)
	lw $8, -348($fp)
	move $9, $8
	sw $9, -108($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -352($fp)
	lw $8, -140($fp)
	lw $9, -352($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -356($fp)
	lw $8, -356($fp)
	move $9, $8
	sw $9, -140($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -360($fp)
	lw $8, -360($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -364($fp)
label20:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -368($fp)
	lw $8, -108($fp)
	lw $9, -368($fp)
	beq $8, $9, label21
	sw $8, -108($fp)
	sw $9, -368($fp)
	j label22
label21:
	li $9, 1
	sw $9, -368($fp)
	lw $8, -368($fp)
	move $9, $8
	sw $9, -108($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -372($fp)
	lw $8, -364($fp)
	lw $9, -372($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -376($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -380($fp)
	lw $8, -376($fp)
	lw $9, -380($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -384($fp)
	lw $8, -384($fp)
	move $9, $8
	sw $9, -168($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -388($fp)
	lw $8, -364($fp)
	lw $9, -388($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -392($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -396($fp)
	lw $8, -392($fp)
	lw $9, -396($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -400($fp)
	lw $8, -400($fp)
	move $9, $8
	sw $9, -188($fp)
	lw $8, -168($fp)
	lw $9, -140($fp)
	blt $8, $9, label23
	sw $8, -168($fp)
	sw $9, -140($fp)
	j label24
label23:
	lw $8, -168($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -404($fp)
	lw $9, -404($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -408($fp)
	lw $8, -408($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -412($fp)
	lw $8, -412($fp)
	move $9, $8
	sw $9, -204($fp)
	lw $8, -188($fp)
	lw $9, -140($fp)
	blt $8, $9, label27
	sw $8, -188($fp)
	sw $9, -140($fp)
	j label26
label27:
	lw $8, -188($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -416($fp)
	lw $9, -416($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -420($fp)
	lw $8, -420($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -424($fp)
	lw $8, -168($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -428($fp)
	lw $9, -428($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -432($fp)
	lw $8, -432($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -436($fp)
	lw $8, -424($fp)
	lw $9, -436($fp)
	blt $8, $9, label25
	sw $8, -424($fp)
	sw $9, -436($fp)
	j label26
label25:
	lw $8, -188($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -440($fp)
	lw $9, -440($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -444($fp)
	lw $8, -444($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -448($fp)
	lw $8, -448($fp)
	move $9, $8
	sw $9, -204($fp)
	lw $8, -188($fp)
	move $9, $8
	sw $9, -168($fp)
label26:
	lw $8, -364($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -452($fp)
	lw $9, -452($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -456($fp)
	lw $8, -456($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -460($fp)
	lw $8, -460($fp)
	lw $9, -204($fp)
	bgt $8, $9, label28
	sw $8, -460($fp)
	sw $9, -204($fp)
	j label29
label28:
	li $9, 0
	sw $9, -452($fp)
	lw $8, -452($fp)
	move $9, $8
	sw $9, -108($fp)
	lw $8, -168($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -464($fp)
	lw $9, -464($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -468($fp)
	lw $8, -364($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -472($fp)
	lw $9, -472($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -476($fp)
	lw $8, -476($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -480($fp)
	lw $8, -480($fp)
	lw $9, -468($fp)
	sw, $8, 0($9)
	sw $8, -480($fp)
	sw $9, -468($fp)
	lw $8, -364($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -484($fp)
	lw $9, -484($fp)
	addi $8, $fp, -52
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -488($fp)
	lw $8, -204($fp)
	lw $9, -488($fp)
	sw, $8, 0($9)
	sw $8, -204($fp)
	sw $9, -488($fp)
	lw $8, -168($fp)
	move $9, $8
	sw $9, -364($fp)
label29:
label24:
	j label20
label22:
	j label17
label19:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -492($fp)
	lw $8, -492($fp)
	move $9, $8
	sw $9, -100($fp)
label30:
	lw $8, -100($fp)
	lw $9, -12($fp)
	blt $8, $9, label31
	sw $8, -100($fp)
	sw $9, -12($fp)
	j label32
label31:
	lw $8, -100($fp)
	li $9, 4
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -496($fp)
	lw $9, -496($fp)
	addi $8, $fp, -92
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -500($fp)
	lw $8, -500($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -504($fp)
	lw $8, -504($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -508($fp)
	lw $8, -100($fp)
	lw $9, -508($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -512($fp)
	lw $8, -512($fp)
	move $9, $8
	sw $9, -100($fp)
	j label30
label32:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -516($fp)
	lw $v0, -516($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
