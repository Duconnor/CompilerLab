#ifndef INTERCODE_H
#define INTERCODE_H

typedef struct Operand_* Operand;
typedef struct InterCode_* InterCode;

struct Operand_ {
	enum { TEMPVAR, VARIABLE, CONSTANT, LB, FUNC } kind;
	union {
		int varNum;
		int value;
		char* name;
	} u;
};

struct InterCode_ {
	enum { LABEL, FUNCTION, ASSIGN, ASSIGNP, PASSIGN, ADD, SUB, MUL, DIV, ADDR, GOTO, IFGOTO, RETURN, DEC, ARGV, ARGA, CALL, PARAM, READ, WRITE } kind;
	union {
		struct { Operand op; } sinop;
		struct { Operand left, right; } assign;
		struct { Operand result, op1, op2; } binop;
		//For IFGOTO : if op1 relop op2, then goto op3
		struct { Operand op1, op2, op3; char* relop; } triop;
		struct { Operand op1; int size; } dec;
		struct { Operand op1, op2; } call;
	} u;
	InterCode prev;
	InterCode next;
};

void printInterCodes(char* fileName);

#endif
