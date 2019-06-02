#include "objectcode.h"

static mVar mVarList = NULL;

static int offset = 0;

static void loadVar(char *varName, int varSize, int regNum, FILE *fp) {
	/* This function load a var from memory into a register */
	/* 'regNum' is the number of the register you want to store */
	mVar v = getMVar(varName);
	int offset = 0;
	char code[256];
	if (v == NULL) {
		/* Allocate space for this var on the stack */
		offset = mAlloc(varName, varSize);
		/* Decrement the register $sp */
		sprintf(code, "addi $sp, $sp, -%d\n", varSize);
		fputs(code, fp);
	} else {
		offset = v->offset;
	}
	sprintf(code, "lw $%d, -%d($fp)\n", regNum, offset);
	fputs(code, fp);
}

static void saveVar(char *varName, int varSize, int regNum, FILE *fp) {
	/* Save a var from register to memory */
	mVar v = getMVar(varName);
	int offset = 0;
	if (v == NULL) {
		/* Allocate space for this var on the stack */
		offset = mAlloc(varName, varSize);
		sprintf(code, "addi $sp, $sp, -%d\n", varSize);
		fputs(code, fp);
	} else {
		offset = v->offset;
	}
	char code[256];
	sprintf(code, "sw $%d, -%d($fp)\n", regNum, offset);
	fputs(code, fp);
}

void putMVar(mVar v) {
	/* List head 'mVarList' is an empty node */
	if (mVarList == NULL) {
		mVarList = (mVar)malloc(sizeof(struct mVar_));
		mVarList->next = NULL;
	}
	mVar node = mVarList;
	while (node->next != NULL) {
		node = node->next;
	}
	node->next = v;
	v->next = NULL;
}

mVar getMVar(char *name) {
	/* Return NULL if no elements are found */
	if (mVarList == NULL)
		return NULL;
	mVar node = mVarList->next;
	while (node != NULL) {
		if (strcmp(node->name, name) == 0) {
			break;
		} else {
			node = node->next;
		}
	}
	return node;
}

int mAlloc(char *varName, int size) {
	/* varName is not in mVarList */
	offset -= size;
	mVar v = (mVar)malloc(sizeof(struct mVar_));
	v->name = *varName;
	v->offset = offset;
	v->next = NULL;
	putMVar(v);
	return offset;
}

char *getVarName(Operand op) {
	char *varName = (char*)malloc(50 * sizeof(char));
	if (op->kind == TEMPVAR) {
		sprintf(varName, "t%d", op->u.varNum);
	} else if (op->kind == VARIABLE) {
		sprintf(varName, "v%d", op->u.varNum);
	} else if (op->kind == LABEL) {
		sprintf(varName, "label%d", op->u.varNum);
	} else {
		printf("Should not reach here in getVarName\n");
		exit(-1);
	}
	return varName;
}

void mPrintASSIGNP(InterCode ic, FILE *fp) {
	/* For x := *y */
	char *nameRight = getVarName(ic->u.assign.right);
	char *nameLeft = getVarName(ic->u.assign.left);
	loadVar(nameRight, 4, 8, fp);
	char code[256];
	sprintf(code, "lw $9, 0($8)\n");
	fputs(code, fp);
	saveVar(nameLeft, 4, 9, fp);
}

void mPrintPASSIGN(InterCode ic, FILE *fp) {
	/* For *x := y */
	char *nameRight = getVarName(ic->u.assign.right);
	char *nameLeft = getVarName(ic->u.assign.left);
	loadVar(nameRight, 4, 8, fp);
	loadVar(nameLeft, 4, 9, fp);
	char code[256];
	sprintf(code, "sw, $8, 0($9)\n");
	fputs(code, fp);
	saveVar(nameRight, 4, 8, fp);
	saveVar(nameLeft, 4, 9, fp);
}

void mPrintGOTO(InterCode ic, FILE *fp) {
	/* For GOTO x */
	char *label = getVarName(ic->u.sinop.op);
	char code[256];
	sprintf(code, "j %s\n", label);
	fputs(code, fp);
}

void mPrintIFGOTO(InterCode ic, FILE *fp) {
	char *nameOp1 = getVarName(ic->u.triop.op1);
	char *nameOp2 = getVarName(ic->u.triop.op2);
	char *label = getVarName(ic->u.triop.op3);
	loadVar(nameOp1, 4, 8, fp);
	loadVar(nameOp2, 4, 9, fp);
	char *relop = ic->u.triop.relop;
	char code[256];
	if (strcmp(relop, "==") == 0) {
		/* For x == y GOTO z*/
		sprintf(code, "beq $8, $9, %s\n", label);
	} else if (strcmp(relop, "!=") == 0) {
		/* For x != y GOTO z */
		sprintf(code, "bne $8, $9, %s\n", label);
	} else if (strcmp(relop, ">") == 0) {
		/* For x > y GOTO z */
		sprintf(code, "bgt $8, $9, %s\n", label);
	} else if (strcmp(relop, "<") == 0) {
		/* For x < y GOTO z */
		sprintf(code, "blt $8, $9, %s\n", label);
	} else if (strcmp(relop, ">=") == 0) {
		/* For x >= y GOTO z */
		sprintf(code, "bge $8, $9, %s\n", label);
	} else if (strcmp(relop, "<=") == 0) {
		/* For x <= y GOTO z */
		sprintf(code, "ble $8, $9, %s\n", label);
	} else {
		printf("Should not reach here in mPrintIFGOTO!\n");
		exit(-1);
	}
	fputs(code, fp);
	saveVar(nameOp1, 4, 8, fp);
	saveVar(nameOp2, 4, 9, fp);
}
