.data
A: .word 5, 8, -3, 4, -7, 2, 33
B: .word 0:7
LEN: .word 7 # length of the arrays

.text
.globl main
main:
	la $t0, A    # Load address of A into $t0
	la $t1, B    # Load address of B into $t1
	lw $t2, LEN  # Load array length into $t2
	
	li $t3, 0    # Load index into $t3
	
loop:
	# Access element of array A
	lw $t4, 0($t0) # Load word from A into $t4
	
	# Check if number is odd or even
	andi $t5, $t4, 1   # $5 = 1 if $4 is odd
	# if the number is even
	beqz $t5, is_even   # Branch if the number is even

is_odd:	
	# The number is odd
	li $t6, 5   # Load multiplier for odd number
	j multiply  # jump to multiply

is_even:
	# The number is even
	li $t6, 10 # Load multiplier for even number
	j multiply # jump to multiply

multiply:
	# Multiply element of array A by correct factor and store in array B
	mul $t4, $t4, $t6   #$t4 = $t4 x $t6
	sw $t4, 0($t1)   # Store result in array B
	
	# Increment index and array pointer
	addiu $t0, $t0 ,4  # Move to next element in array A
	addiu $t1, $t1, 4  # Move to next element in array B
	addiu $t3, $t3, 1  # Move to next index
	
	# check if end of array is reached
	slt $t5, $t3, $t2  # $t5 = 1 if $t3 < $t2 (end of array not reached)
	bnez $t5, loop # Loop if end of array not yet reached
	
	# Exit
	li $v0, 10    
	syscall
	
	