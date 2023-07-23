.data
	promptMessage: .asciiz "Enter a number: "
	resultMessage: .ascii "The result is: "
	theNumber: .word   0
	theAnswer: .word   0
.text
.globl main
main:
	#Read the number from the user
	li $v0, 4
	la $a0, promptMessage
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, theNumber
	
	#Call the factorial functions
	lw $a0, theNumber
	jal mystery
	sw $v0, theAnswer
	
	#Display the results
	li $v0, 4
	la $a0, resultMessage
	syscall
	
	li $v0, 1
	lw $a0, theAnswer
	syscall
	
	#Tell the OS that this is the end of the program
	li $v0, 10
	syscall
.globl mystery
mystery:
	# allocate space for $ra & $s0 in the stack
	addi $sp, $sp, -8
	sw $ra, ($sp)
	sw, $s0, 4($sp)
	li $s1, 2
	
	#Base Case
	li $v0, 0	#return 0 if the base case is reached
	beq $a0, 0, mysteryDone		#if the number is equal to 0
	
	move $s0, $a0	
	sub $a0, $a0, 1		#num = num-1
	jal mystery		# recursive call
	
	mul $t0, $s1, $s0
	subi $t0, $t0, 1
	add $v0, $v0, $t0

	mysteryDone:
			lw $ra, ($sp)	#get the result off the stack
			lw $s0, 4($sp)
			addu $sp, $sp, 8
			jr $ra
	
	
