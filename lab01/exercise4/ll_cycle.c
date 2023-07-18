#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *fast_pointer = head;
    node *slow_pointer = head;
    
    while (fast_pointer != NULL && fast_pointer->next != NULL && fast_pointer->next->next != NULL)
    {
        slow_pointer = slow_pointer->next;
        fast_pointer = fast_pointer->next->next;

        if (slow_pointer == fast_pointer) {
            return 1;
        }
    }
    return 0;
}
