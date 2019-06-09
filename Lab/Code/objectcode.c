#include "objectcode.h"
#include <stdlib.h>
#include <string.h>

static void debug(char* str) {
    printf("DEBUG: %s", str);
}

static mVar mVarList = NULL;

static int offset = 0;

static int pCount = 0;

static void loadVar(char *varName, int varSize, int regNum, FILE *fp) {
	/* This function load a var from memory into a register */
	/* 'regNum' is the number of the register you want to store */
	mVar v = getMVar(varName);
	int offset = 0;
	char code[256];
    memset(code, 0, sizeof(code));
	if (v == NULL) {
		/* Allocate space for this var on the stack */
		offset = mAlloc(varName, varSize);
		/* Decrement the register $sp */
		sprintf(code, "\taddi $sp, $sp, -%d\n", varSize);
		fputs(code, fp);
	} else {
		offset = v->offset;
	}
	sprintf(code, "\tlw $%d, %d($fp)\n", regNum, offset);
	fputs(code, fp);
}

static void saveVar(char *varName, int varSize, int regNum, FILE *fp) {
	/* Save a var from register to memory */
    char code[256];
    memset(code, 0, sizeof(code));
	mVar v = getMVar(varName);
	int offset = 0;
	if (v == NULL) {
		/* Allocate space for this var on the stack */
		offset = mAlloc(varName, varSize);
		sprintf(code, "\taddi $sp, $sp, -%d\n", varSize);
		fputs(code, fp);
	} else {
		offset = v->offset;
	}
	sprintf(code, "\tsw $%d, %d($fp)\n", regNum, offset);
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
	v->name = varName;
	v->offset = offset;
	v->next = NULL;
	putMVar(v);
	return offset;
}

char* getVarName(Operand op) {
	char *varName = (char*)malloc(50 * sizeof(char));
	if (op->kind == TEMPVAR) {
		sprintf(varName, "t%d", op->u.varNum);
	} else if (op->kind == VARIABLE) {
		sprintf(varName, "v%d", op->u.varNum);
	} else if (op->kind == LB) {
		sprintf(varName, "label%d", op->u.varNum);
	} else {
		printf("Should not reach here in getVarName\n");
		exit(-1);
	}
	return varName;
}

void PrintObjectCode(InterCode ic, FILE* fp) {
    switch(ic->kind) {
        case LABEL:
            mPrintLABEL(ic, fp);
            break;
        case FUNCTION_IC:
            mPrintFUNCTION(ic, fp);
            break;
        case ASSIGN:
            mPrintASSIGN(ic, fp);
            break;
        case ASSIGNP:
            mPrintASSIGNP(ic, fp);
            break;
        case PASSIGN:
            mPrintPASSIGN(ic, fp);
            break;
        case ADD:
            mPrintADD(ic, fp);
            break;
        case SUB:
            mPrintSUB(ic, fp);
            break;
        case MUL:
            mPrintMUL(ic, fp);
            break;
        case DIV:
            mPrintDIV(ic, fp);
            break;
        case GOTO:
            mPrintGOTO(ic, fp);
            break;
        case IFGOTO:
            mPrintIFGOTO(ic, fp);
            break;
        case RETURN:
            mPrintRETURN(ic, fp);
            break;
        case DEC:
            mPrintDEC(ic, fp);
            break;
        case ARGV:
            mPrintARGV(ic, fp);
            break;
        case CALL:
            mPrintCALL(ic, fp);
            break;
        case READ:
            mPrintREAD(ic, fp);
            break;
        case WRITE:
            mPrintWRITE(ic, fp);
            break;
        default:
            exit(-1);
            debug("bad code type!\n");
    }
}

void mPrintLABEL(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    sprintf(line, "label%d\n", ic->u.sinop.op->u.varNum);
    fputs(line, fp);
}

void mPrintASSIGN(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    Operand left = ic->u.assign.left;
    Operand right = ic->u.assign.right;
    char* lname = getVarName(left);
    char* rname = getVarName(right);
    if(right->kind == CONSTANT) {
        /* x := #k */
        sprintf(line, "\tli $9, %d\n", right->u.value);
        fputs(line, fp);
    } else {
        /* x := y */
        loadVar(rname, 4, 8, fp);
        sprintf(line, "\tmove $9, $8\n");
        fputs(line, fp);
    }
    saveVar(lname, 4, 9, fp);
}

void mPrintADD(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    Operand res = ic->u.binop.result;
    Operand op1 = ic->u.binop.op1;
    Operand op2 = ic->u.binop.op2;
    char* resName = getVarName(res);
    char* op1Name = getVarName(op1);
    char* op2Name = getVarName(op2);
    if(op2->kind == CONSTANT) {
        loadVar(op1Name, 4, 8, fp);
        sprintf(line, "\taddi $9, $8, %d\n", op2->u.value);
        fputs(line, fp);
        saveVar(resName, 4, 9, fp);
    } else {
        loadVar(op1Name, 4, 8, fp);
        loadVar(op2Name, 4, 9, fp);
        sprintf(line, "\tadd $10, $8, $9\n");
        fputs(line, fp);
        saveVar(resName, 4, 10, fp);
    }
}

void mPrintSUB(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    Operand res = ic->u.binop.result;
    Operand op1 = ic->u.binop.op1;
    Operand op2 = ic->u.binop.op2;
    char* resName = getVarName(res);
    char* op1Name = getVarName(op1);
    char* op2Name = getVarName(op2);
    if(op2->kind == CONSTANT) {
        loadVar(op1Name, 4, 8, fp);
        sprintf(line, "\taddi $9, $8, %d\n", -op2->u.value);
        fputs(line, fp);
        saveVar(resName, 4, 9, fp);
    } else {
        loadVar(op1Name, 4, 8, fp);
        loadVar(op2Name, 4, 9, fp);
        sprintf(line, "\tsub $10, $8, $9\n");
        fputs(line, fp);
        saveVar(resName, 4, 10, fp);
    }
}

void mPrintMUL(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    Operand res = ic->u.binop.result;
    Operand op1 = ic->u.binop.op1;
    Operand op2 = ic->u.binop.op2;
    char* resName = getVarName(res);
    char* op1Name = getVarName(op1);
    char* op2Name = getVarName(op2);
    loadVar(op1Name, 4, 8, fp);
    loadVar(op2Name, 4, 9, fp);
    sprintf(line, "\tmul $10, $8, $9\n");
    fputs(line, fp);
    saveVar(resName, 4, 10, fp);
}

void mPrintDIV(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    Operand res = ic->u.binop.result;
    Operand op1 = ic->u.binop.op1;
    Operand op2 = ic->u.binop.op2;
    char* resName = getVarName(res);
    char* op1Name = getVarName(op1);
    char* op2Name = getVarName(op2);
    loadVar(op1Name, 4, 8, fp);
    loadVar(op2Name, 4, 9, fp);
    sprintf(line, "\tdiv $8, $9\n");
    fputs(line, fp);
    sprintf(line, "\tmflo $10\n");
    fputs(line, fp);
    saveVar(resName, 4, 10, fp);
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
		sprintf(code, "\tbeq $8, $9, %s\n", label);
	} else if (strcmp(relop, "!=") == 0) {
		/* For x != y GOTO z */
		sprintf(code, "\tbne $8, $9, %s\n", label);
	} else if (strcmp(relop, ">") == 0) {
		/* For x > y GOTO z */
		sprintf(code, "\tbgt $8, $9, %s\n", label);
	} else if (strcmp(relop, "<") == 0) {
		/* For x < y GOTO z */
		sprintf(code, "\tblt $8, $9, %s\n", label);
	} else if (strcmp(relop, ">=") == 0) {
		/* For x >= y GOTO z */
		sprintf(code, "\tbge $8, $9, %s\n", label);
	} else if (strcmp(relop, "<=") == 0) {
		/* For x <= y GOTO z */
		sprintf(code, "\tble $8, $9, %s\n", label);
	} else {
		printf("Should not reach here in mPrintIFGOTO!\n");
		exit(-1);
	}
	fputs(code, fp);
	saveVar(nameOp1, 4, 8, fp);
	saveVar(nameOp2, 4, 9, fp);
}

void mPrintFUNCTION(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    sprintf(line, "%s:\n", ic->u.sinop.op->u.name);
    fputs(line, fp);
    sprintf(line, "\taddi $sp, $sp, -4\n");
    fputs(line, fp);
    sprintf(line, "\tsw $fp, 0($sp)\n");
    fputs(line, fp);
    sprintf(line, "\tmove $fp, $sp\n");
    fputs(line, fp);
}

void mPrintPARAM(InterCode ic, FILE* fp) {
    mVar v = (mVar)malloc(sizeof(struct mVar_));
    v->name = getVarName(ic->u.sinop.op);
    v->offset = 8 + 4 * pCount;
    v->next = NULL;
    putMVar(v);
    if(ic->next->kind != PARAM)
        pCount = 0;    
}


void mPrintRETURN(InterCode ic, FILE* fp) {
    char* retVarName = getVarName(ic->u.sinop.op);
    mVar v = getMVar(retVarName);
    char line[100];
    memset(line, 0, sizeof(line));
    sprintf(line, "\tlw $v0, %d($fp)\n", v->offset);
    fputs(line, fp);
    sprintf(line, "\tmove $sp, $fp\n");
    fputs(line, fp);
    sprinft(line, "\tlw $fp, 0($sp)\n");
    fputs(line, fp);
    sprintf(line, "\taddi $sp, $sp, 4\n");
    fputs(line, fp);
    sprintf(line, "\tjr $ra\n");
    fputs(line, fp);
}

void mPrintDEC(InterCode ic, FILE* fp) {

}

void mPrintARGV(InterCode ic, FILE* fp) {

}


void mPrintCALL(InterCode ic, FILE* fp) {

}

void mPrintREAD(InterCode ic, FILE* fp) {

}

void mPrintWRITE(InterCode ic, FILE* fp) {

}

