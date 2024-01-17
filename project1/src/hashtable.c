#include "hashtable.h"
#include <stdlib.h>
#include <stdio.h>

/*
 * This creates a new hash table of the specified size and with
 * the given hash function and comparison function.
 */
HashTable *createHashTable(int size, unsigned int (*hashFunction)(void *),
                           int (*equalFunction)(void *, void *)) {
  int i = 0;
  HashTable *newTable = malloc(sizeof(HashTable));
  if (NULL == newTable) {
    fprintf(stderr, "malloc failed \n");
    exit(1);
  }
  newTable->size = size;
  newTable->data = malloc(sizeof(HashBucket *) * size);
  if (NULL == newTable->data) {
    fprintf(stderr, "malloc failed \n");
    exit(1);
  }
  for (i = 0; i < size; i++) {
    newTable->data[i] = NULL;
  }
  newTable->hashFunction = hashFunction;
  newTable->equalFunction = equalFunction;
  return newTable;
}

/*
 * This inserts a key/data pair into a hash table.  To use this
 * to store strings, simply cast the char * to a void * (e.g., to store
 * the string referred to by the declaration char *string, you would
 * call insertData(someHashTable, (void *) string, (void *) string).
 */
void insertData(HashTable *table, void *key, void *data) {
  // -- TODO --
  // HINT:
  // 1. Find the right hash bucket location with table->hashFunction.
  unsigned int hash = table->hashFunction(key) % table->size;
  
  // 2. Allocate a new hash bucket struct.
  HashBucket *newBucket = malloc(sizeof(HashBucket));
  if (newBucket == NULL) {
    exit(1);
  }

  newBucket->data = data;
  newBucket->key = key;
  newBucket->next = NULL;
  
  // 3. Append to the linked list or create it if it does not yet exist. 
  if (table->data[hash] == NULL) {
    table->data[hash] = newBucket;
  } else {
    HashBucket *temp = table->data[hash];
    while (temp->next != NULL) {
      temp = temp->next;
    }
    temp->next = newBucket;
  }
}

/*
 * This returns the corresponding data for a given key.
 * It returns NULL if the key is not found. 
 */
void *findData(HashTable *table, void *key) {
  // -- TODO --
  // HINT:
  // 1. Find the right hash bucket with table->hashFunction.
  unsigned int hash = table->hashFunction(key) % table->size;

  // 2. Walk the linked list and check for equality with table->equalFunction.
  HashBucket *current = table->data[hash];

  while (current != NULL)
  {
    if (table->equalFunction(current->key, key) == 1) {
      return current->data;
    }

    current = current->next;
  }
  
  return NULL;
}