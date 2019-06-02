#ifndef OBJECTCODE_H
#define OBJECTCODE_H

#include "intercode.h"
#include <stdio.h>

typedef struct mVar_* mVar;

struct mVar_ {
    char* name;
    int offset;
    mVar next;
};

void putMVar(mVar v);
mVar getMVar(char* name);

int mAlloc(char* varName, int size);

char* getVarName(Operand op);

void PrintObjectCode(InterCode ic, FILE* fp);
void mPrintLABEL(InterCode ic, FILE* fp);
void mPrintFUNCTION(InterCode ic, FILE* fp);
void mPrintASSIGN(InterCode ic, FILE* fp);
void mPrintASSIGNP(InterCode ic, FILE* fp);
void mPrintPASSIGN(InterCode ic, FILE* fp);
void mPrintADD(InterCode ic, FILE* fp);
void mPrintSUB(InterCode ic, FILE* fp);
void mPrintMUL(InterCode ic, FILE* fp);
void mPrintDIV(InterCode ic, FILE* fp);
void mPrintGOTO(InterCode ic, FILE* fp);
void mPrintIFGOTO(InterCode ic, FILE* fp);
void mPrintRETURN(InterCode ic, FILE* fp);
void mPrintDEC(InterCode ic, FILE* fp);
void mPrintARGV(InterCode ic, FILE* fp);
void mPrintCALL(InterCode ic, FILE* fp);
void mPrintREAD(InterCode ic, FILE* fp);
void mPrintWRITE(InterCode ic, FILE* fp);

#endif
