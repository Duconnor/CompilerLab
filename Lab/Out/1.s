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
	addi $sp, $sp, -40
	lw $8, -40($fp)
	sw $8, -40($fp)
	li $9, 0
	addi $8, $fp, -40
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -44($fp)
	li $9, 1
	addi $sp, $sp, -4
	sw $9, -48($fp)
	lw $8, -48($fp)
	lw $9, -44($fp)
	sw, $8, 0($9)
	sw $8, -48($fp)
	sw $9, -44($fp)
	li $9, 0
	addi $8, $fp, -40
	add $10, $8, $9
	addi $sp, $sp, -4
	sw $10, -52($fp)
	lw $8, -52($fp)
	lw $9, 0($8)
	addi $sp, $sp, -4
	sw $9, -56($fp)
	lw $8, -56($fp)
	move $a0, $8
	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	li $9, 0
	addi $sp, $sp, -4
	sw $9, -60($fp)
	lw $v0, -60($fp)
	move $sp, $fp
	lw $fp, 0($sp)
	addi $sp, $sp, 4
	jr $ra
