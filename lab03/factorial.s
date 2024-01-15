.globl factorial

.data
n: .word 8

.text
main:
    # t0 address = n address
    la t0, n
    # a0 = 8
    lw a0, 0(t0)
    jal ra, factorial

    # a1 = a0
    addi a1, a0, 0
    # a0 = 1
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    # a0 = 11
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi t3, x0, 1
    add t4, a0, x0 # t4 = a0 + x0 
    loop:
        beq t4, x0, exit # if t3 == x0 then exit loop
        mul t3, t3, t4
        mv  a0, t3 # a0 = t3
        addi t4, t4, -1 # t4 = t4 + -1        
        j loop
    exit:
        jr ra