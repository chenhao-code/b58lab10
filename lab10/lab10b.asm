.data
buffer: .space 100
message1: .asciiz "\nEnter a value: "
message2: .asciiz "\nBefore function"
message3: .asciiz "\nA + B + C = "
message4: .asciiz "\n Num solutions for Ax^2 + Bx + C is = "
newline: .asciiz "\n"

.text
.globl main
main:
	# Read A
	la $a0, message1
	li $v0, 4
	syscall
	li $v0, 5 # read an integer
	syscall
	move $t0, $v0 # save A to $a0
	
	# Read B
	la $a0, message1
	li $v0, 4 
	syscall
	li $v0, 5 # read an integer
	syscall
	move $t1, $v0  # save B to $a1
	
	# Read C
	la $a0, message1
	li $v0, 4 
	syscall
	li $v0, 5 # read an integer
	syscall
	move $t2, $v0  # save B to $a2
	
	# Print "Before function"
	la $a0, message2
	li $v0, 4
	syscall
	
	# Call do_addition
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	jal do_addition
	move $s0, $v0
	
	# Print "A + B + C = "
	la $a0, message3
	li $v0, 4
	syscall
	
	# Print result
	move $a0, $s0
	li $v0, 1
	syscall
	
	# Prepare parameters for n_solutions on stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	
	
	
	# Call n_solutions
	jal n_solutions
	lw $t5, 0($sp)
        addi $sp, $sp, 4
	move $s0, $t5
	
	# Print "Num solutions for Ax^2 + Bx + C is = "
	la $a0, message4
	li $v0, 4
	syscall
	
	# Print n_solutions result
	move $a0, $s0
	li $v0, 1
	syscall
	
	# Restore the stack

	
	# Exit
	li $v0, 10
	syscall
	
do_addition:
	add $v0, $a0, $a1	# A + B
	add $v0, $v0, $a2	# + C
	jr $ra
	
n_solutions:
	lw $s2, 0($sp) # C
	lw $s1, 4($sp) # B
	lw $s0, 8($sp) # A
	addi $sp, $sp, 12 # reclaim space
	
	mul $t3, $s1, $s1  # B * B
	
	# 4 * A * C
	li $t4, 4
	mul $t4, $t4, $s0
	mul $t4, $t4, $s2
	# B * B - 4 * A * C
	sub $t3, $t3, $t4
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	bgt $t3, $zero, L1   # delta > 0
	beq $t3, $zero, L2   # delta == 0
	ble $t3, $zero, L3            # return 0
	jr $ra

L1:
	li $v0, 2	# return 2
	j end
	
L2:
	li $v0, 1      # return 1 
	j end

L3: 	li $v0, 0      # return 0
	j end

end: 
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	jr $ra
	
		  
	
	
	