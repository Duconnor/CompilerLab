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
	li $9, 4
	lw $8, -28($fp)
	mul $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -36($fp)
