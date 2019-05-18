#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantic.h"
#include "intercode.h"
#include "table.h"


extern FieldList varTable[TABLE_SIZE];

static int curTempNum = 0; /* Initialize to 0 */
static int curVarNum = 0; /* Initialize to 0 */
static int curLabel = 0; /* Initialize to 0 */

static int WIDTH = 4; /* Should be modified to proper value */
static int OFFSET = 0;

static int genNext(int* current) {
	*current++;
	if (*current < 0) {
		/* Overflow */
		printf("Can't generate more!\n");
		exit(-1);
	}
	return *current;
}

static void genBack(int* current) {
	/* Important!!! Why we need this function? 
	 * Because we use different type for temp vars and normal vars 
	 * Their corresponding index should be different too (i.e. curTempNum and curVarNum)
	 * And we will print according to their type (like v1 and t2)
	 * However, when we have one node called 'Exp', we won't be able to know in advance whether it will be variable or tempvar
	 * And we need to pass its index into the function (i.e. the argument 'place')
	 * In order to solve this problem, I think we can always assume it will be a temp var
	 * And when we find out we are wrong (i.e. Exp -> ID)
	 * We use this genBack function to decrement curTempNum and generate a new index for normal variable 
	 * XXX: It is dangerous! 必需在调用函数的上一条语句使用genNext生成新的临时变量的对应index值，否则此处可能会出错！！！！*/
	*current--;
	if (current < 0) {
		/* Should never reach here */
		printf("genBack error!\n");
		exit(-1);
	}
}

static InterCode genSinop(int kind, int val) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op = (Operand)malloc(sizeof(struct Operand_));
	op->kind = kind;
	op->u.value = val;
	newCode->u.sinop.op = op;
	newCode->prev = NULL;
	newCode->next = NULL;
	return newCode;
}

static InterCode genAssign(int leftKind, int rightKind, int leftVar, int rightVar) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand right = (Operand)malloc(sizeof(struct Operand_));
	Operand left = (Operand)malloc(sizeof(struct Operand_));
	right->kind = rightKind;
	/* There is a little trick here
	 * Since u.value and u.varNum share the same memory
	 * We can just assign all values to u.value */
	right->u.value = rightVar;
	left->kind = leftKind;
	left->u.value = leftVar;
	newCode->kind = ASSIGN;
	newCode->u.assign.right = right;
	newCode->u.assign.left = left;
	newCode->prev = NULL;
	newCode->next = NULL;
	return newCode;
}

static InterCode genBinop(int op1Kind, int op2Kind, int resultKind, int op1Var, int op2Var, int resultVar) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op1 = (Operand)malloc(sizeof(struct Operand_));
	Operand op2 = (Operand)malloc(sizeof(struct Operand_));
	Operand result = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.binop.result = result;
	newCode->u.binop.op1 = op1;
	newCode->u.binop.op2 = op2;

	newCode->prev = newCode->next = NULL;

	op1->kind = op1Kind;
	op2->kind = op2Kind;
	result->kind = resultKind;

	op1->u.value = op1Var;
	op2->u.value = op2Var;
	result->u.value = resultVar;

	return newCode;
}

static InterCode genTriop(int op1Kind, int op2Kind, int op3Kind, int op1Var, int op2Var, int op3Var, char *relop) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op1 = (Operand)malloc(sizeof(struct Operand_));
	Operand op2 = (Operand)malloc(sizeof(struct Operand_));
	Operand op3 = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.triop.op1 = op1;
	newCode->u.triop.op2 = op2;
	newCode->u.triop.op3 = op3;
	newCode->u.triop.relop = relop;

	newCode->prev = newCode->next = NULL;
	
	op1->kind = op1Kind;
	op2->kind = op2Kind;
	op3->kind = op3Kind;
	
	op1->u.value = op1Var;
	op2->u.value = op2Var;
	op3->u.value = op3Var;

	return newCode;
}

static InterCode genDec(int kind, int var, int size) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.dec.op1 = op;
	newCode->u.dec.size = size;

	newCode->prev = newCode->next = NULL;

	op->kind = kind;
	op->u.value = var;

	return newCode;
}

static InterCode genFunc(int op1Kind, int op2Kind, int op1Var, int op2Var) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op1 = (Operand)malloc(sizeof(struct Operand_));
	Operand op2 = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.func.op1 = op1;
	newCode->u.func.op2 = op2;

	newCode->prev = newCode->next = NULL;

	op1->kind = op1Kind;
	op2->kind = op2Kind;

	op1->u.value = op1Var;
	op2->u.value = op2Var;

	return newCode;
}

static int cond_Exp(Node *exp, int *place) {
	int label1 = genNext(curLabel);
	int label2 = genNext(curLabel);
	/* Gen place := #0 */
	InterCode newCode1 = genAssign(TEMPVAR, CONSTANT, place, 0);
	newCode1->kind = ASSIGN;
	putCode(newCode1);
	translate_Cond(Exp, label1, label2);
	/* Gen LABEL label1 */
	InterCode newCode2 = genSinop(LB, label1);
	newCode2->kind = LABEL;
	putCode(newCode2);
	/* Gen place := #1 */
	InterCode newCode3 = genAssign(TEMPVAR, CONSTANT, place, 1);
	newCode3->kind = ASSIGN;
	putCode(newCode3);
	/* Gen LABEL label2 */
	InterCode newCode4 = genSinop(LB, label2);
	newCode4->kind = LABEL;
	putCode(newCode4);
	return TEMPVAR;
}

static int getArraySize(Node *exp) {
	Node *node = exp->child;
	if (strcmp(node->lexeme.type, "INT") != 0) {
		/* Should never reach here 
		 * Or it will have grammar error */
		printf("getArraySize error!\n");
		exit(-1);
	}
	return atoi(node->lexeme.value);
}

static int findOffset(char *structureName, char *memberName) {
	/* If memberName = NULL, return the whole size of this structure */
	if (structureName == NULL) {
		/* Should never reach here */
		printf("findOffset error!\n");
		exit(-1);
	}
	Structure struc = getStruct(structureName);
	int offset = 0;
	FieldList member = struc->member;
	while (member != NULL) {
		if (memberName != NULL) {
			if (strcmp(memberName, member->name) == 0) {
				/* TODO: what if we want to access an ARRAY? */
				/* Find what we want */
				return offset;
			}
		}
		if (member->type->kind == BASIC) {
			offset += 4;
		} else if (member->type->kind == ARRAY) {
			/* XXX: It seems that we will also put definition inside the struture into the var list? */
			offset += (member->type->u.array.size * findWidth(member->name));
		} else if (member->type->kind == STRUCTURE) {
			offset += findOffset(member->name, NULL);
		}
		member = member->tail;
	}
	return offset;
}

static int findWidth(char *arrayName) {
	 /* We search the var list to find it's type */
	FieldList var = getVar(arrayName, 0);
	Type elem = var->type->u.array.elem;
	if (elem->kind == BASIC) {
		return 4;
	}
	/* The element type is a structure */
	return findOffset(elem->u.structure->name, NULL);
}

int translate_Exp(Node *exp, int *place) {
	/* Param 'varNum': the index of this variable */
	/* Return: the 'kind' (type) of this intercode */
	/* Current node's type is 'Exp' */
	Node *node = exp->child;
	if (strcmp(node->lexeme.type, "INT") == 0) {
		int value = atoi(node->lexeme.value);
		InterCode newCode = genAssign(TEMPVAR, CONSTANT, place, value);
		newCode->kind = ASSIGN;
		putCode(newCode);
		return TEMPVAR;
	} else if (strcmp(node->lexeme.type, "ID") == 0) {
		/* Important! Usage of genBack here */
		genBack(curTempNum);
		place = genNext(curVarNum);
		/*----------------------------------*/
		FieldList var = getVar(node->lexeme.value, 0);
		if (var->num == -1) {
			var->num = place;
		} else {
			/* This means we have alreay associated one index for this var */
			genBack(curVarNum); /* Put this var index back */
			place = var->num;
		}
		return VARIABLE;
	} else if (strcmp(node->lexeme.type, "MINUS") == 0) {
		int num = genNext(curTempNum);
		/* Now we are at 'MINUS', its child is 'Exp1' */
		int kind = translate_Exp(node->sibling, num);
		InterCode newCode = genBinop(CONSTANT, kind, TEMPVAR, 0, num, place);
		newCode->kind = SUB; /* place := #0 - t_num */
		putCode(newCode);
		return TEMPVAR;
	} else if (strcmp(node->lexeme.type, "Exp") == 0) {
		char *type = node->sibling->lexeme.type;
		if (strcmp(type, "ASSIGNOP") == 0) {
			/* XXX: I made some change here
			 * Despite Exp1 must be ID 
			 * I will pass it to translate_Exp anyway
			 * In order to match this ID with a corresponding num */
			int numLeft = genNext(curTempNum);
			int kindLeft = translate_Exp(node, numLeft);
			int numRight = genNext(curTempNum);
			int kindRight = translate_Exp(node->sibling->sibling, numRight);
			InterCode newCode = genAssign(kindLeft, kindRight, numLeft, numRight);
			newCode->kind = ASSIGN;
			putCode(newCode);
			InterCode newCode2 = genAssign(TEMPVAR, kindLeft, place, numLeft);
			newCode2->kind = ASSIGN;
			putCode(newCode2);
			return TEMPVAR;
		} else if (strcmp(type, "PLUS") == 0 
				|| strcmp(type, "MINUS") == 0
				|| strcmp(type, "STAR") == 0
				|| strcmp(type, "DIV") == 0) {
			/* Case for arithmetic operation */ 
			int num1 = genNext(curTempNum);
			int kind1 = translate_Exp(node, num1);
			int num2 = genNext(curTempNum);
			int kind2 = translate_Exp(node->sibling->sibling, num2);
			InterCode newCode = genBinop(kind1, kind2, TEMPVAR, num1, num2, place);
			putCode(newCode);
			/* Now, we determine the 'kind' of 'newCode' */
			if (strcmp(type, "PLUS") == 0) {
				newCode->kind = ADD;
			} else if (strcmp(type, "MINUS") == 0) {
				newCode->kind = SUB;
			} else if (strcmp(type, "STAR") == 0) {
				newCode->kind = MUL;
			} else if (strcmp(type, "DIV") == 0) {
				newCode->kind = DIV;
			}
			return TEMPVAR;
		} else if (strcmp(type, "RELOP") == 0
				|| strcmp(type, "AND") == 0
				|| strcmp(type, "OR") == 0) {
			return cond_Exp(exp, place);
		} else if (strcmp(type, "LB") == 0) {
			/* For array */
			/* Because we don't support multi-dimensinal array
			 * Exp -> Exp1 LB Exp2 RB 
			 * Exp1 must be of type 'ID' */
			if (strcmp(node->child->lexeme.type, "ID") != 0) {
				/* Case when we encounter a multi dim array */
				printf("Cannot translate: Code contains variables of multi-dimensional array type or parameters of array type.\n");
				exit(-1);
			}
			/* First, find the start address */
			int tempStartAddr = genNext(curTempNum);
			int kindStartAddr = translate_Exp(node, tempStartAddr);

			int bracketNum = getArraySize(node->sibling->sibling);
			/* bracketNum is the index */
			/* Determine the WIDTH here! */
			WIDTH = findWidth(node->child->lexeme.value);
			/* Finally, combine them to get the address of the value we need 
			 * In the intercode: t = v_{start} + index * WIDTH */
			int tempAddr = genNext(curTempNum);
			InterCode newCode1 = genBinop(kindStartAddr, CONSTANT, TEMPVAR, tempStartAddr, bracketNum * WIDTH, tempAddr);
			newCode1->kind = ADD;
			putCode(newCode1);
			/* Associate place with the result */
			InterCode newCode2 = genAssign(TEMPVAR, TEMPVAR, place, tempAddr);
			newCode2->kind = ASSIGNP;
			putCode(newCode2);
			/* Return type is TEMPVAR */
			return TEMPVAR;
		} else if (strcmp(type, "DOT") == 0) {
			/* For structure */
			/* First, find the start address */
			int tempStartAddr = genNext(curTempNum);
			int kindStartAddr = translate_Exp(node, tempStartAddr);
			/* Second, get the offset of the member */
			OFFSET = findOffset(node->child->lexeme.value, node->sibling->sibling->lexeme.value);
			/* Third, get the address of the memeber */
			int tempAddr = genNext(curTempNum);
			InterCode newCode1 = genBinop(kindStartAddr, CONSTANT, TEMPVAR, tempStartAddr, OFFSET, tempAddr);
			newCode1->kind = ADD;
			putCode(newCode1);
			/* Finally, get the member from that address */
			InterCode newCode2 = genAssign(TEMPVAR, TEMPVAR, place, tempAddr);
			newCode2->kind = ASSIGNP;
			putCode(newCode2);
			return TEMPVAR;
		}
	} else if (strcmp(node->lexeme.type, "NOT") == 0) {
		return cond_Exp(exp, place);
	}
}


