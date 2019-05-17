#include <stdio.h>
#include <stdlib.h>
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
    char opStr[10];
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
    }while(currIC != codesHead);  
}