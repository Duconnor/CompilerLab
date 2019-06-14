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
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -4($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -8($fp)
	lw $8, -4($fp)
	lw $9, -8($fp)
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -12($fp)
	lw $8, -12($fp)
	move $9, $8
	addi $sp, $sp, -4
	sw $9, -16($fp)
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -20($fp)
	lw $v0, -20($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
