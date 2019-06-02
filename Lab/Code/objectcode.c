#include "objectcode.h"

static void debug(char* str) {
    printf("DEBUG: %s", str);
}

static mVar mVarList = NULL;

static int offset = 0;

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
    if(left->kind == VARIABLE || left->kind == TEMPVAR) {
        
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