#include <stdio.h>
#include "bit_ops.h"

/* Returns the Nth bit of X. Assumes 0 <= N <= 31. */
unsigned get_bit(unsigned x, unsigned n) {
    /* YOUR CODE HERE */
    return (x & (1u << n)) >> n; /* UPDATE WITH THE CORRECT RETURN VALUE*/
}

/* Set the nth bit of the value of x to v. Assumes 0 <= N <= 31, and V is 0 or 1 */
void set_bit(unsigned *x, unsigned n, unsigned v) {
    /* YOUR CODE HERE */
    unsigned mask = 1u << n;
    *x = (*x & ~mask) | (v << n);
    /*
        思路：
        取第n位的掩码
        反转掩码，只有第n为为零
        与运算，得到该位被置为零的值
        与v右移n位后进行或运算
        得到结果
    */       
}

/* Flips the Nth bit in X. Assumes 0 <= N <= 31.*/
void flip_bit(unsigned *x, unsigned n) {
    /* YOUR CODE HERE */
    unsigned mask = 1u << n;
    /*
        很好理解了
        mask只有第n位是为1的，其他几位都是0
        那么根据XOR的运算规则，
        相同时会输出0，相反时输出1
        本身为0，那么置0无所谓
        本身为1，那么只有第n位为1，置为零符合要求
        本身为0，且第n位为1，那么置为0符合要求
    */
    *x ^= mask;
}

