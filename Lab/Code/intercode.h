#ifndef INTERCODE_H
#define INTERCODE_H

typedef struct Operand_* Operand;
typedef struct InterCode_* InterCode;

struct Operand_ {
	enum { VARIABLE, CONSTANT, ADDRESS } kind;
	union {
		int varNum;
		int value;
	} u;
};

struct InterCode_ {
	enum { ASSIGN, ADD, SUB, MUL } kind;
	union {
		struct { Operand right, left} assign;
		struct { Operand result, op1, op2 } binop;
	} u;
	InterCode prev;
	InterCode next;
};

#endif
