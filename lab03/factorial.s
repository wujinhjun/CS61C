# global function
.globl factorial

# pseudo instruction
# data segment
.data
# variable n
# store a word (32 bit) in memory
n: .word 8

.text
main:
    # load address of n to t0
    # t0 address = n address
    la t0, n

    # load word of t0 to a0
    # a0 = 8
    lw a0, 0(t0)

    # jump and link to factorial
    # register ra is the x1
    jal ra, factorial

    # a1 = a0 + 0
    # a1 is the return value after executing the factorial function
    addi a1, a0, 0
    # a0 = 0 + 1
    addi a0, x0, 1

    # environment call
    ecall # Print Result

    addi a1, x0, '\n'
    # a0 = 11
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    # t3 = 1
    addi t3, x0, 1
    # t4 = a0 + x0
    # t4 = 8;
    add t4, a0, x0 # t4 = a0 + x0 
    loop:
        beq t4, x0, exit # if t4 == x0 then exit loop
        mul t3, t3, t4
        mv  a0, t3 # a0 = t3
        addi t4, t4, -1 # t4 = t4 + -1        
        j loop
    exit:
        # jump register  
        jr ra