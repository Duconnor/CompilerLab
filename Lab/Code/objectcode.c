#include "objectcode.h"

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

void mAlloc(char *varName, int size) {
	/* varName is not in mVarList */
	offset -= size;
	mVar v = (mVar)malloc(sizeof(struct mVar_));
	v->name = *varName;
	v->offset = offset;
	v->next = NULL;
	putMVar(v);
}

char *getVarName(Operand op) {
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

void mPrintASSIGNP(InterCode ic, FILE *fp) {

}
