.globl map

.text
main:
    jal ra, create_default_list
    add s0, a0, x0 # a0 (and now s0) is the head of node list

    # Print the list
    add a0, s0, x0
    jal ra, print_list
    # Print a newline
    jal ra, print_newline

    # === Calling `map(head, &square)` ===
    # Load function arguments
    add a0, s0, x0 # Loads the address of the first node into a0

    # Load the address of the "square" function into a1 (hint: check out "la" on the green sheet)
    ### YOUR CODE HERE ###


    # Issue the call to map
    jal ra, map

    # Print the squared list
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    # === Calling `map(head, &decrement)` ===
    # Because our `map` function modifies the list in-place, the decrement takes place after
    # the square does

    # Load function arguments
    add a0, s0, x0 # Loads the address of the first node into a0
    
    # Load the address of the "decrement" function into a1 (should be very similar to before)
    ### YOUR CODE HERE ###


    # Issue the call to map
    jal ra, map

    # Print decremented list
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    addi a0, x0, 10
    ecall # Terminate the program

map:
    # Prologue: Make space on the stack and back-up registers
    ### YOUR CODE HERE ###

    beq a0, x0, done # If we were given a null pointer (address 0), we're done.

    add s0, a0, x0 # Save address of this node in s0
    add s1, a1, x0 # Save address of function in s1

    # Remember that each node is 8 bytes long: 4 for the value followed by 4 for the pointer to next.
    # What does this tell you about how you access the value and how you access the pointer to next?

    # Load the value of the current node into a0
    # THINK: Why a0?
    ### YOUR CODE HERE ###

    # Call the function in question on that value. DO NOT use a label (be prepared to answer why).
    # Hint: Where do we keep track of the function to call? Recall the parameters of "map".
    ### YOUR CODE HERE ###

    # Store the returned value back into the node
    # Where can you assume the returned value is?
    ### YOUR CODE HERE ###

    # Load the address of the next node into a0
    # The address of the next node is an attribute of the current node.
    # Think about how structs are organized in memory.
    ### YOUR CODE HERE ###

    # Put the address of the function back into a1 to prepare for the recursion
    # THINK: why a1? What about a0?
    ### YOUR CODE HERE ###

    # Recurse
    ### YOUR CODE HERE ###

done:
    # Epilogue: Restore register values and free space from the stack
    ### YOUR CODE HERE ###

    jr ra # Return to caller

# === Definition of the "square" function ===
square:
    mul a0, a0, a0
    jr ra

# === Definition of the "decrement" function ===
decrement:
    addi a0, a0, -1
    jr ra

# === Helper functions ===
# You don't need to understand these, but reading them may be useful

create_default_list:
    # sp: stack pointer
    # sp-12, 12 bytes space (3 words)
    addi sp, sp, -12

    # ra 0 sp
    sw ra, 0(sp)
    # s0 4 sp
    sw s0, 4(sp)
    # s1 8 sp
    sw s1, 8(sp)

    # load immediate
    li s0, 0            # Pointer to the last node we handled
    li s1, 0            # Number of nodes handled
loop:                   # do...
    # a0 = 8
    li a0, 8
    # revoke the malloc function
    # the parameter is a0
    jal ra, malloc      #     Allocate memory for the next node
    # a0 is a node

    # s1 = a0.slice(0, 4)
    sw s1, 0(a0)        #     node->value = i
    # s2 = a0.skuce(4, 8)
    sw s0, 4(a0)        #     node->next = last

    # s0 = a0
    add s0, a0, x0      #     last = node
    # number of nodes handled + 1
    addi s1, s1, 1      #     i++
    # t0 = 10
    addi t0, x0, 10
    bne s1, t0, loop    # ... while i!= 10
    # ra = sp[0]
    lw ra, 0(sp)
    # s0 = sp[4]
    lw s0, 4(sp)
    # s1 = sp[8]
    lw s1, 8(sp)

    # recover the stack pointer
    addi sp, sp, 12
    jr ra

print_list:
    bne a0, x0, print_me_and_recurse
    jr ra               # Nothing to print
print_me_and_recurse:
    # t0 = a0
    add t0, a0, x0      # t0 gets current node address
    lw a1, 0(t0)        # a1 gets value in current node
    addi a0, x0, 1      # Prepare for print integer ecall
    ecall
    addi a1, x0, ' '    # a0 gets address of string containing space
    addi a0, x0, 11     # Prepare for print char syscall
    ecall
    lw a0, 4(t0)        # a0 gets address of next node
    jal x0, print_list  # Recurse. The value of ra hasn't been changed.

print_newline:
    addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall
    jr ra

malloc:
    # a1 = a0 + 0   
    addi a1, a0, 0
    # a0 = 9
    addi a0, x0, 9
    ecall
    jr ra
