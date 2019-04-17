/*
    Data structure of symbol table
    Use PJW's hash function and open hashing method
*/  
#ifndef TABLE_H
#define TABLE_H

#include "tree.h"
#include "semantic.h"

#define TABLE_SIZE 1024

unsigned int hash(char* name);


#endif