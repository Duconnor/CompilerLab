/*
    Data structure of symbol table
    Use PJW's hash function and open hashing method
*/  
#ifndef TABLE_H
#define TABLE_H


struct Type_;
struct FieldList_;
struct Structure_;
struct Function_;

typedef struct Type_* Type;
typedef struct FieldList_* FieldList;
typedef struct Structure_* Structure;
typedef struct Function_* Function;

#define TABLE_SIZE 1024

unsigned int hash(char* name);

void initTable();

int putVar(FieldList var);
int putStruct(Structure strc);

FieldList getVar(char* name, int kind);
Structure getStruct(char* name);

#endif