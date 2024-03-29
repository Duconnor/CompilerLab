#ifndef SEMANTIC_H
#define SEMANTIC_H

#include "tree.h"

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
	char* funcName; /* This field is only valid when Type_ is pointing to a paramter */
};

struct FieldList_ {
    char* name;
	int num; /* This vars' corresponding index (added in Lab3) */
	int isAddress; /* Is this var address or variable */
    Type type;
    FieldList tail;
    FieldList ptail; //Only for parameters!
};

struct Structure_ {
    char* name;
    FieldList member;
    Structure tail;
};

struct Function_ {
    int isDeclared;
    int isDefined;
	int linenum;
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
FieldList VarDec(Type type, Node *root);
FieldList FunDec(Type type, Node *root);
void VarList(FieldList list, Node *root, char *name);
FieldList ParamDec(Node *root, char *name);

/* Statements */
void CompSt(Type type, Node *root);
void StmtList(Type type, Node *root);
void Stmt(Type type, Node *root);

/* Local Definitions */
FieldList DefList(Node *root, int isStructure);
FieldList Def(Node *root, int isStructure);
FieldList DecList(Type type, Node *root, int isStructure);
FieldList Dec(Type type, Node *root, int isStructure);

/* Expressions */
Type Exp(Node *root, int *flag);
int Args(Node *root, FieldList paramList);

#endif
