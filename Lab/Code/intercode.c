#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "intercode.h"

static void debug(char *str) {
    printf("%s\n", str);
}

InterCode codesHead = NULL;
InterCode codesTail = NULL;

void putCode(InterCode ic) {
    if(ic == NULL) {
        debug("putCode error: ic is NULL !");
        return;
    }
    if(codesHead == NULL) {
        codesHead = ic;
        codesTail = ic;
        ic->prev = ic;
        ic->next = ic;
    }
    else {
        codesHead->prev = ic;
        codesTail->next = ic;
        ic->prev = codesTail;
        ic->next = codesHead;
        codesTail = ic;
    }
}

void delCode(InterCode ic) {
    if(ic == NULL) {
        debug("delCode error: ic is NULL!\n");
        return;
    }
    ic->prev->next = ic->next;
    ic->next->prev = ic->prev;
    if(codesHead == ic && codesTail == ic) {
        codesHead = NULL;
        codesTail = NULL;
    }
    else if(codesHead == ic)
        codesHead = ic->next;
    else
        codesTail = ic->prev;
    free(ic);
}

char* printOperand(Operand op) {
    char* opStr = (char*)malloc(sizeof(char) * 10);
    memset(opStr, 0, sizeof(opStr));
    switch(op->kind) {
        case TEMPVAR:
            sprintf(opStr, "t%d", op->u.varNum);
            break;
        case VARIABLE:
            sprintf(opStr, "v%d", op->u.varNum);
            break;
        case CONSTANT:
            sprintf(opStr, "#%d", op->u.value);
            break;
    }
    return opStr;
}

void printInterCode(InterCode ic, FILE* fp) {
    char line[100];
    memset(line, 0, sizeof(line));
    switch(ic->kind){
        case LABEL:
            sprintf(line, "LABEL label%d :\n", ic->u.sinop.op->u.varNum);
            break;
        case FUNCTION:
            sprintf(line, "FUNCTION %s :\n", ic->u.sinop.op->u.name);
            break;
        case ASSIGN:
            sprintf(line, "%s := %s\n", printOperand(ic->u.assign.left), printOperand(ic->u.assign.right));
            break;
        case ASSIGNP:
            sprintf(line, "%s := *%s\n", printOperand(ic->u.assign.left), printOperand(ic->u.assign.right));
            break;
        case PASSIGN:
            sprintf(line, "*%s := %s\n", printOperand(ic->u.assign.left), printOperand(ic->u.assign.right));
            break;
        case ADD:
            sprintf(line, "%s := %s + %s\n", printOperand(ic->u.binop.result), printOperand(ic->u.binop.op1), printOperand(ic->u.binop.op2));
            break;
        case SUB:
            sprintf(line, "%s := %s - %s\n", printOperand(ic->u.binop.result), printOperand(ic->u.binop.op1), printOperand(ic->u.binop.op2));
            break;
        case MUL:
            sprintf(line, "%s := %s * %s\n", printOperand(ic->u.binop.result), printOperand(ic->u.binop.op1), printOperand(ic->u.binop.op2));
            break;
        case DIV:
            sprintf(line, "%s := %s / %s\n", printOperand(ic->u.binop.result), printOperand(ic->u.binop.op1), printOperand(ic->u.binop.op2));
            break;
        case ADDR:
            sprintf(line, "%s := &%s + %s\n", printOperand(ic->u.binop.result), printOperand(ic->u.binop.op1), printOperand(ic->u.binop.op2));
            break;
        case GOTO:
            sprintf(line, "GOTO label%d\n", ic->u.sinop.op->u.varNum);
            break;
        case IFGOTO:
            sprintf(line, "IF %s %s %s GOTO label%d\n", printOperand(ic->u.triop.op1), ic->u.triop.relop, printOperand(ic->u.triop.op2), ic->u.triop.op3->u.varNum);
            break;
        case RETURN:
            sprintf(line, "RETURN #%d\n", ic->u.sinop.op->u.value);
            break;
        case DEC:
            sprintf(line, "DEC %s %d\n", printOperand(ic->u.dec.op1), ic->u.dec.size);
            break;
        case ARGV:
            sprintf(line, "ARG %s\n", printOperand(ic->u.sinop.op));
            break;
        case ARGA:
            sprintf(line, "ARG &%s\n", printOperand(ic->u.sinop.op));
            break;
        case CALL:
            sprintf(line, "%s := CALL %s\n", printOperand(ic->u.func.op1), ic->u.func.op2->u.name);
            break;
        case PARAM:
            sprintf(line, "PARAM %s\n", printOperand(ic->u.sinop.op));
            break;
        case READ:
            sprintf(line, "READ %s\n", printOperand(ic->u.sinop.op));
            break;
        case WRITE:
            sprintf(line, "WRITE %s\n", printOperand(ic->u.sinop.op));
            break;
        default:
            debug("printInterCode error: bad code type!\n");
    }
    fputs(line, fp);
}

void printInterCodes(char* fileName) {
    FILE *fp = fopen(fileName, "w");
    if(fp == NULL) {
        printf("Error: Cannot open file %s\n!", fileName);
        exit(-1);
    }
    InterCode currIC = codesHead;
    do{
        printInterCode(currIC, fp);
        currIC = currIC->next;
    }while(currIC != codesHead);  
}

/*
int main() {
    InterCode ic1 = (InterCode)malloc(sizeof(struct InterCode_));
    Operand op11 = (Operand)malloc(sizeof(struct Operand_));
    ic1->kind = FUNCTION;
    ic1->u.sinop.op = op11;
    op11->kind = FUNCTION;
    op11->u.name = "add";
    putCode(ic1);

    InterCode ic2 = (InterCode)malloc(sizeof(struct InterCode_));
    Operand op21 = (Operand)malloc(sizeof(struct Operand_));
    ic2->kind = PARAM;
    ic2->u.sinop.op = op21;
    op21->kind = VARIABLE;
    op21->u.varNum = 1;
    putCode(ic2);

    InterCode ic3 = (InterCode)malloc(sizeof(struct InterCode_));
    Operand op31 = (Operand)malloc(sizeof(struct Operand_));
    Operand op32 = (Operand)malloc(sizeof(struct Operand_));
    ic3->kind = ASSIGNP;
    ic3->u.assign.left = op31;
    ic3->u.assign.right = op32;
    op31->kind = TEMPVAR;
    op31->u.varNum = 2;
    op32->kind = VARIABLE;
    op32->u.varNum = 1;
    putCode(ic3);

    InterCode ic4 = (InterCode)malloc(sizeof(struct InterCode_));
    Operand op41 = (Operand)malloc(sizeof(struct Operand_));
    Operand op42 = (Operand)malloc(sizeof(struct Operand_));
    Operand op4r = (Operand)malloc(sizeof(struct Operand_));
    ic4->kind = ADD;
    ic4->u.binop.op1 = op41; 
    ic4->u.binop.op2 = op42;
    ic4->u.binop.result = op4r;
    op41->kind = VARIABLE;
    op41->u.varNum = 1;
    op42->kind = CONSTANT;
    op42->u.value = 4;
    op4r->kind = VARIABLE;
    op4r->u.varNum = 7;
    putCode(ic4);

    printInterCodes("test.ir");

    return 0;
}
*/