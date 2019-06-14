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

mod:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	lw $8, 8($fp)
	lw $9, 12($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -4($fp)
	lw $8, -4($fp)
	lw $9, 12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -8($fp)
	lw $8, 8($fp)
	lw $9, -8($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -12($fp)
	lw $8, -12($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $v0, -16($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

power:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	lw $9, 12($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -8($fp)
	lw $8, -8($fp)
	lw $9, 12($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -12($fp)
	lw $8, -12($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -16($fp)
label1:
	lw $8, -16($fp)
	lw $9, -16($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -20($fp)
	li $9, 90
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -20($fp)
	lw $9, -24($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -28($fp)
	li $9, 89
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -28($fp)
	lw $9, -32($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, -36($fp)
	lw $9, -40($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -44($fp)
	lw $9, -48($fp)
	sub $10, $8, $9
	sw $10, -44($fp)
	lw $8, 12($fp)
	lw $9, -44($fp)
	bgt $8, $9, label2
	sw $8, 12($fp)
	sw $9, -44($fp)
	j label3
label2:
	lw $8, -16($fp)
	lw $9, 8($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, -52($fp)
	move $9, $8
	sw $9, -16($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -56($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -56($fp)
	lw $9, -60($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	lw $8, -64($fp)
	lw $9, 12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -68($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -72($fp)
	lw $8, -72($fp)
	lw $9, 12($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -76($fp)
	lw $8, -68($fp)
	lw $9, -76($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -80($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -84($fp)
	lw $8, -80($fp)
	lw $9, -84($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	move $9, $8
	sw $9, 12($fp)
	j label1
label3:
	lw $v0, -16($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

getNumDigits:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -12($fp)
	lw $8, 8($fp)
	lw $9, -12($fp)
	blt $8, $9, label4
	sw $8, 8($fp)
	sw $9, -12($fp)
	j label5
label4:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -16($fp)
	li $8, 0
	lw $9, -16($fp)
	sub $10, $8, $9
	sw $10, -12($fp)
	lw $v0, -12($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label5:
label6:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -16($fp)
	lw $8, 8($fp)
	lw $9, -16($fp)
	bgt $8, $9, label7
	sw $8, 8($fp)
	sw $9, -16($fp)
	j label8
label7:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, 8($fp)
	lw $9, -20($fp)
	div $8, $9
	mflo $10
	sw $10, -16($fp)
	lw $8, -16($fp)
	move $9, $8
	sw $9, 8($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -24($fp)
	lw $8, -8($fp)
	lw $9, -24($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -28($fp)
	lw $8, -28($fp)
	move $9, $8
	sw $9, -8($fp)
	li $9, 2
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -8($fp)
	lw $9, -32($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
	lw $8, -36($fp)
	move $9, $8
	sw $9, -8($fp)
	li $9, 3
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, -8($fp)
	lw $9, -40($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	lw $8, -44($fp)
	move $9, $8
	sw $9, -8($fp)
	j label6
label8:
	lw $v0, -8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra

isNarcissistic:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	lw $9, 8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -8($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -12($fp)
	lw $8, -8($fp)
	lw $9, -12($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -16($fp)
	lw $8, -16($fp)
	addi $sp, $fp, -20
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal getNumDigits
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -24($fp)
	move $8, $v0
	sw $8, -24($fp)
	lw $8, -24($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -28($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -32($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -36($fp)
	lw $8, 8($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -40($fp)
label9:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -44($fp)
	lw $8, -40($fp)
	lw $9, -44($fp)
	bgt $8, $9, label10
	sw $8, -40($fp)
	sw $9, -44($fp)
	j label11
label10:
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -48($fp)
	addi $sp, $fp, -52
	sw $8, 0($sp)
	lw $8, -40($fp)
	addi $sp, $fp, -56
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal mod
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $8, -44($fp)
	move $8, $v0
	sw $8, -44($fp)
	lw $8, -44($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $8, -40($fp)
	lw $9, -60($fp)
	sub $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -64($fp)
	li $9, 10
	addi $sp, $sp, -4
	sw $9, -68($fp)
	lw $8, -64($fp)
	lw $9, -68($fp)
	div $8, $9
	mflo $10
	addi $sp, $sp, -4
	sw $10, -72($fp)
	lw $8, -72($fp)
	move $9, $8
	sw $9, -40($fp)
	lw $8, -28($fp)
	addi $sp, $fp, -76
	sw $8, 0($sp)
	lw $8, -60($fp)
	addi $sp, $fp, -80
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal power
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	lw $8, -84($fp)
	move $8, $v0
	sw $8, -84($fp)
	lw $8, -36($fp)
	lw $9, -84($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -88($fp)
	lw $8, -88($fp)
	move $9, $8
	sw $9, -36($fp)
	j label9
label11:
	lw $8, -36($fp)
	lw $9, 8($fp)
	beq $8, $9, label12
	sw $8, -36($fp)
	sw $9, 8($fp)
	j label13
label12:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $v0, -92($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	j label14
label13:
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -92($fp)
	lw $v0, -92($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
label14:

main:
	addi $sp, $sp, -4
	sw $fp, 0($sp)
	move $fp, $sp
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -4($fp)
	lw $8, -4($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -8($fp)
	li $9, 300
	addi $sp, $sp, -4
	sw $9, -12($fp)
	lw $8, -12($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -16($fp)
label15:
	li $9, 500
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $8, -16($fp)
	lw $9, -20($fp)
	blt $8, $9, label16
	sw $8, -16($fp)
	sw $9, -20($fp)
	j label17
label16:
	lw $8, -16($fp)
	addi $sp, $fp, -24
	sw $8, 0($sp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal isNarcissistic
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $8, -20($fp)
	move $8, $v0
	sw $8, -20($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -28($fp)
	lw $8, -20($fp)
	lw $9, -28($fp)
	beq $8, $9, label18
	sw $8, -20($fp)
	sw $9, -28($fp)
	j label19
label18:
	lw $8, -16($fp)
	move $a0, $8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -32($fp)
	lw $8, -8($fp)
	lw $9, -32($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
	lw $8, -36($fp)
	move $9, $8
	sw $9, -8($fp)
label19:
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -40($fp)
	lw $8, -16($fp)
	lw $9, -40($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	lw $8, -44($fp)
	move $9, $8
	sw $9, -16($fp)
	j label15
label17:
	lw $8, -8($fp)
	move $a0, $8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $v0, -8($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
