#include "objectcode.h"

static void debug(char* str) {
    printf("DEBUG: %s", str);
}

static mVar mVarList = NULL;

static int offset = 0;

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

mVar mAlloc(char *varName, int size) {
	/* varName is not in mVarList */
	offset -= size;
	mVar v = (mVar)malloc(sizeof(struct mVar_));
	v->name = *varName;
	v->offset = offset;
	v->next = NULL;
	putMVar(v);
    return v;
}

char* getVarName(Operand op) {
	char *varName = (char*)malloc(50 * sizeof(char));
	if (op->kind == TEMPVAR) {
		sprintf(varName, "t%d", op->u.varNum);
	} else if (op->kind == VARIABLE) {
		sprintf(varName, "v%d", op->u.varNum);
	} else {
		printf("Should not reach here in getVarName\n");
		exit(-1);
	}
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
    if(right->kind == CONSTANT) {
        /* x := #k */
        char* name = getVarName(left);
        mVar MVarChecker = getMVar(name);
        if(MVarChecker == NULL) 
            MVarChecker = mAlloc(name, 4);
        sprintf(line, "\tli $t0, %d\n", right->u.value);
        fputs(line, fp);
        memset(line, 0, sizeof(line));
        sprintf(line, "\tsw $t0, %d($fp)\n", MVarChecker->offset);
        fputs(line, fp);
    } else {
        /* x := y */
        char* lname = getVarName(left);
        char* rname = getVarName(right);
        mVar lMVarChecker = getMVar(lname);
        if(lMVarChecker == NULL)
            lMVarChecker = mAlloc(lname, 4);
        mVar rMVarChecker = getMVar(rname);
        if(rMVarChecker == NULL) {
            //rMVar SHOULD be in the list
            printf("Should not reach here in mPrintASSIGN\n");
            exit(-1);
        }
        sprintf(line, "\tlw $t1, %d($fp)\n", rMVarChecker->offset);
        fputs(line,fp);
        memset(line, 0, sizeof(line));
        sprintf(line, "\tmove $t0, $t1\n");
        fputs(line, fp);
        memset(line, 0, sizeof(line));
        sprintf(line, "\tsw $t0, %d($fp)\n", lMVarChecker->offset);
        fputs(line, fp);
    }
}

void mPrintADD(InterCode ic, FILE* fp) {

}

void mPrintSUB(InterCode ic, FILE* fp) {

}

void mPrintMUL(InterCode ic, FILE* fp) {

}

void mPrintDIV(InterCode ic, FILE* fp) {

}


void mPrintASSIGNP(InterCode ic, FILE *fp) {

}
