#ifndef INTERCODE_H
#define INTERCODE_H

#include "tree.h"
#include <stdio.h>

typedef struct Operand_* Operand;
typedef struct InterCode_* InterCode;

struct Operand_ {
	/* AORS stands for: array or structure */
	enum { TEMPVAR, VARIABLE, CONSTANT, LB, FUNC, AORS } kind;
	union {
		int varNum;
		int value;
		char* name;
	} u;
};

struct InterCode_ {
	enum { LABEL, FUNCTION_IC, ASSIGN, ASSIGNP, PASSIGN, ADD, SUB, MUL, DIV, ADDR, GOTO, IFGOTO, RETURN, DEC, ARGV, ARGA, CALL, PARAM, READ, WRITE } kind;
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

void putCode(InterCode ic);
void delCode(InterCode ic);
char* printOperand(Operand op);
void printInterCode(InterCode ic, FILE* fp);
void printInterCodes(char* fileName);

/* High-level Definitions */
void translate_Program(Node *program);
void translate_ExtDefList(Node *extDefList);
void translate_ExtDef(Node *extDef);
/* No need for ExtDeclist */

/* No need for Specifiers */

/* Declarators */
void translate_FunDec(Node *funDec);
/* VarDec is implemented in function Dec */
/* No need for VarList and ParamDec */

/* Statements */
void translate_CompSt(Node *compst);
void translate_StmtList(Node *stmtlist);
void translate_Stmt(Node *stmt);

/* Local Definitions */
void translate_DefList(Node *deflist);
void translate_Def(Node *def);
void translate_DecList(Node *declist);
void translate_Dec(Node *dec);

/* Expressions */
int translate_Exp(Node *exp, int *place);
void translate_Args(Node *args);

/* Other Functions */
void translate_Cond(Node *exp, int label_true, int label_false);
int translate_ArgsWrite(Node *args, int *place);


void constantFold();
void constantReplace();
void slidingWindow();
#endif
