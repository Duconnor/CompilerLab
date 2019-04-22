#ifndef SEMANTIC_H
#define SEMANTIC_H

#include "table.h"

typedef struct Type_* Type;
typedef struct FieldList_* FieldList;
typedef struct Structure_* Structure;
typedef struct Function_* Function;

struct Type_ {
    enum { BASIC, ARRAY, STRUCTURE, FUNCTION } kind;
    union {
        int basic;
        struct { Type elem; int size; } array;
        Structure structure;
        Function function;
    } u;
};

struct FieldList_ {
    char* name;
    Type type;
    FieldList tail;
};

struct Structure_ {
    char* name;
    FieldList member;
    Structure tail;
};

struct Function_ {
    int isDeclared;
    int isDefined;
    Type retVal;
    FieldList parameters;
};

/* High-level Definitions */
void Program(Node *root);
void ExtDefList(Node *root);
void ExtDef(Node *root);
void ExtDecList(Type type, Node *root);

/* Specifier */
Type Specifier(Node *root);
Type StructSpecifer(Node *root);

/* Declarators */
FieldList VarList(FieldList type, Node *root);
FieldList FunDec(Type type, Node *root);
void ParamDec(Type type, Node *root);

/* Statements */
void CompSt(Type type, Node *root);
void StmtList(Type type, Node *root);
void Stmt(Type type, Node *root);


/* Expressions */
Type Exp(Node *root, int *flag);
int Args(Node *root, FieldList paramList);

#endif