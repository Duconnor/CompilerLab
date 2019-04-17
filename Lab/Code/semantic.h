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

#endif