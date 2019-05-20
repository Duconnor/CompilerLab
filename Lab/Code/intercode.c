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

static void debug(char *str) {
    printf("%s", str);
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
        case FUNCTION_IC:
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
            sprintf(line, "RETURN %s\n", printOperand(ic->u.sinop.op));
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
            sprintf(line, "%s := CALL %s\n", printOperand(ic->u.call.op1), ic->u.call.op2->u.name);
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

static int genNext(int* current) {
	(*current)++;
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
	(*current)--;
	if (*current < 0) {
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

static InterCode genFunDec(int kind, char *name) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op = (Operand)malloc(sizeof(struct Operand_));
	op->kind = kind;
	op->u.name = name;
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

static InterCode genCall(int op1Kind, int op2Kind, int op1Var, char *op2Var) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op1 = (Operand)malloc(sizeof(struct Operand_));
	Operand op2 = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.call.op1 = op1;
	newCode->u.call.op2 = op2;

	newCode->prev = newCode->next = NULL;

	op1->kind = op1Kind;
	op2->kind = op2Kind;

	op1->u.value = op1Var;
	op2->u.name = op2Var;

	return newCode;
}

static int cond_Exp(Node *exp, int *place) {
	int label1 = genNext(&curLabel);
	int label2 = genNext(&curLabel);
	/* Gen place := #0 */
	InterCode newCode1 = genAssign(TEMPVAR, CONSTANT, *place, 0);
	newCode1->kind = ASSIGN;
	putCode(newCode1);
	translate_Cond(exp, label1, label2);
	/* Gen LABEL label1 */
	InterCode newCode2 = genSinop(LB, label1);
	newCode2->kind = LABEL;
	putCode(newCode2);
	/* Gen place := #1 */
	InterCode newCode3 = genAssign(TEMPVAR, CONSTANT, *place, 1);
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
		/* Means we are using variable to index the array */
		return -1;
	}
	return atoi(node->lexeme.value);
}

static int findWidth(char *arrayName);
static int findOffset(char *structureName, char *memberName);

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



/* High-level Definitions */
void translate_Program(Node *program) {
	debug("translate_Program\n");
	translate_ExtDefList(program->child);
}

void translate_ExtDefList(Node *extDefList) {
	debug("translate_ExtDefList\n");
	Node *node = extDefList->child;
	if(node != NULL) {
		translate_ExtDef(node);
		translate_ExtDefList(node->sibling);
	} else {
		/* Do nothing */
	}
}

void translate_ExtDef(Node *extDef) {
	debug("translate_ExtDef\n");
	/* Since there is no global vars, we only need to translate function definitions */
	char *type = extDef->child->sibling->lexeme.type;
	if (strcmp(type, "FunDec") == 0) {
		/* Also, in function definition, we don't need to care about the translation of Specifier */
		translate_FunDec(extDef->child->sibling);
		translate_CompSt(extDef->child->sibling->sibling);
	}
}

/* Declarators */
void translate_FunDec(Node *funDec) {
	debug("translate_FunDec\n");
	/* There are only two possible cases 
	 * 1. FunDec -> ID LP VarList RP 
	 * 2. FunDec -> ID LP RP 
	 * */
	/* Translate ID first, then we translate VarList */
	InterCode newCode = genFunDec(FUNC, funDec->child->lexeme.value);
	newCode->kind = FUNCTION_IC;
	putCode(newCode);
	/* Now translate VarList */
	if (strcmp(funDec->child->sibling->sibling->lexeme.type, "VarList") == 0) {
		FieldList func = getVar(funDec->child->lexeme.value, FUNCTION);
		FieldList params = func->type->u.function->parameters;
		while (params != NULL) {
			int varNum = genNext(&curVarNum);
			params->num = varNum;
			InterCode paramDec = genSinop(VARIABLE, varNum);
			paramDec->kind = PARAM;
			putCode(paramDec);
			params = params->tail;
		}
	}
}

/* Statements */
void translate_CompSt(Node *compst) {
	debug("translate_CompSt\n");
	Node *node = compst->child;
	translate_DefList(node->sibling);
	translate_StmtList(node->sibling->sibling);	
}

void translate_StmtList(Node *stmtlist) {
	debug("translate_StmtList\n");
	Node *node = stmtlist->child;
	if(node != NULL) {
		translate_Stmt(node);
		translate_StmtList(node->sibling);
	} else {
		/* Do nothing */
	}
}

void translate_Stmt(Node *stmt) {
	debug("translate_Stmt\n");
	Node *node = stmt->child;
	if (strcmp(node->lexeme.type, "Exp") == 0) {
		/* Case for production: Stmt -> Exp SEMI */
		translate_Exp(node, NULL);
	}
	else if(strcmp(node->lexeme.type, "CompSt") == 0) {
		/* Case for production: Stmt -> CompSt */
		translate_CompSt(node);
	}
	else if(strcmp(node->lexeme.type, "RETURN") == 0) {
		/* Case for production: Stmt -> RETURN Exp SEMI */
		int newTempNum = genNext(&curTempNum);
		int kind = translate_Exp(node->sibling, &newTempNum);
		InterCode newCode1 = genSinop(kind, newTempNum);
		newCode1->kind = RETURN;
		putCode(newCode1);
	}
	else if(strcmp(node->lexeme.type, "IF") == 0) {
		if(node->sibling->sibling->sibling->sibling->sibling == NULL) {
			/* Case for production: Stmt -> IF LP Exp RP Stmt */
			int label1 = genNext(&curLabel);
			int label2 = genNext(&curLabel);
			Node *exp = node->sibling->sibling;
			translate_Cond(exp, label1, label2);

			InterCode newCode1 = genSinop(LB, label1);
			newCode1->kind = LABEL;
			putCode(newCode1);

			Node *stmt = exp->sibling->sibling;
			translate_Stmt(stmt);

			InterCode newCode2 = genSinop(LB, label2);
			newCode1->kind = LABEL;
			putCode(newCode2);
		}
		else {
			/* Case for production: Stmt -> IF LP Exp RP Stmt ELSE Stmt */
			int label1 = genNext(&curLabel);
			int label2 = genNext(&curLabel);
			int label3 = genNext(&curLabel);
			Node *exp = node->sibling->sibling;
			translate_Cond(exp, label1, label2);

			InterCode newCode1 = genSinop(LB, label1);
			newCode1->kind = LABEL;
			putCode(newCode1);

			Node *stmt1 = exp->sibling->sibling;
			translate_Stmt(stmt1);

			InterCode newCode2 = genSinop(LB, label3);
			newCode2->kind = GOTO;
			putCode(newCode2);

			InterCode newCode3 = genSinop(LB, label2);
			newCode3->kind = LABEL;
			putCode(newCode3);

			Node *stmt2 = stmt1->sibling->sibling;
			translate_Stmt(stmt2);

			InterCode newCode4 = genSinop(LB, label3);
			newCode4->kind = LABEL;
			putCode(newCode4);
		}
	}
	else {
		/* Case for production: Stmt -> WHILE LP Exp RP Stmt */
		int label1 = genNext(&curLabel);
		int label2 = genNext(&curLabel);
		int label3 = genNext(&curLabel);

		InterCode newCode1 = genSinop(LB, label1);
		newCode1->kind = LABEL;
		putCode(newCode1);

		Node *exp = node->sibling->sibling;
		translate_Cond(exp, label2, label3);

		InterCode newCode2 = genSinop(LB, label2);
		newCode2->kind = LABEL;
		putCode(newCode2);

		Node *stmt = exp->sibling->sibling;
		translate_Stmt(stmt);

		InterCode newCode3 = genSinop(LB, label1);
		newCode3->kind = GOTO;
		putCode(newCode3);

		InterCode newCode4 = genSinop(LB, label3);
		newCode4->kind = LABEL;
		putCode(newCode4);

	}
}

/* Local Definitions */
void translate_DefList(Node *deflist) {
	debug("translate_DefList\n");
	Node *node = deflist->child;
	if(node != NULL) {
		translate_Def(node);
		translate_DefList(node->sibling);
	} else {
		/* Do nothing */
	}
}

void translate_Def(Node *def) {
	debug("translate_Def\n");
	Node *node = def->child;
	translate_DecList(node->sibling);
}

void translate_DecList(Node *declist) {
	debug("translate_DecList\n");
	if(declist == NULL)
		debug("NULL HERE 1!\n");
	Node *node = declist->child;
	if(node == NULL)
		debug("NULL HERE 2!\n");
	if(node->sibling == NULL) {
		translate_Dec(node);
	}
	else {
		translate_Dec(node);
		if(node->sibling->sibling == NULL)
			debug("NULL HERE 3!\n");
		translate_DecList(node->sibling->sibling);
	}
}

void translate_Dec(Node *dec) {
	debug("translate_Dec\n");
	Node *node = dec->child;
	Node *vardec = node;
	if(vardec->sibling == NULL) {
		/* Case for production: Dec -> VarDec */
		if(strcmp(vardec->child->lexeme.type, "ID") == 0) {
			/* Case for production VarDec -> ID */
			Node *id = vardec->child;
			FieldList var = getVar(id->lexeme.value, 0);
			if(var->type->kind == STRUCTURE) {
				/* When it's a struct variable, we need to generate [DEC var size] */
				if(var->num == -1)
					var->num = genNext(&curVarNum);
				int newVarNum = var->num;
				int size = findOffset(var->type->u.structure->name, NULL);
				InterCode newCode = genDec(VARIABLE, newVarNum, size);
				newCode->kind = DEC;
				putCode(newCode);
			} else {
				/* No need to generate any code */
			}
		} else {
			/* Case for production VarDec -> VarDec LB INT RB 
			 * and then
			 * VarDec -> ID */
			Node *vardec1 = vardec->child;
			Node *id = vardec1->child;
			FieldList var = getVar(id->lexeme.value, 0);
			if(var->num == -1) 
				var->num = genNext(&curVarNum);
			int newVarNum = var->num;
			/* No Array of Structure */
			int size = atoi(vardec1->sibling->sibling->lexeme.value) * 4;
			InterCode newCode = genDec(VARIABLE, newVarNum, size);
			newCode->kind = DEC;
			putCode(newCode);
		}
	} else {
		/* Case for production: Dec -> VarDec ASSIGNOP Exp*/
		if(strcmp(vardec->child->lexeme.type, "ID") == 0) {
			Node *id = vardec->child;
			Node *exp = vardec->sibling->sibling;
			FieldList var = getVar(id->lexeme.value, 0);
			if(var->num == -1)
				var->num = genNext(&curVarNum);
			int num1 = var->num;
			int num2 = genNext(&curTempNum);
			int kind2 = translate_Exp(exp, &num2);
			InterCode newCode = genAssign(VARIABLE, kind2, num1, num2);
			newCode->kind = ASSIGN;
			putCode(newCode);
		} else {
			/* Can not assign for an array */
			/* Should not reach here! */
		}
	
	}
}	

/* Expressions */
int translate_Exp(Node *exp, int *place) {
	debug("translate_Exp\n");
	/* Param 'varNum': the index of this variable */
	/* Return: the 'kind' (type) of this intercode */
	/* Current node's type is 'Exp' */
	Node *node = exp->child;
	if (strcmp(node->lexeme.type, "INT") == 0) {
		if(place == NULL)
			return -1;
		int value = atoi(node->lexeme.value);
		InterCode newCode = genAssign(TEMPVAR, CONSTANT, *place, value);
		newCode->kind = ASSIGN;
		putCode(newCode);
		return TEMPVAR;
	} else if (strcmp(node->lexeme.type, "ID") == 0) {
		if (node->sibling == NULL) {
			if(place == NULL)
				return -1;
			/* Important! Usage of genBack here */
			genBack(&curTempNum);
			*place = genNext(&curVarNum);
			/*----------------------------------*/
			FieldList var = getVar(node->lexeme.value, 0);
			if (var->num == -1) {
				var->num = *place;
			} else {
				/* This means we have alreay associated one index for this var */
				genBack(&curVarNum); /* Put this var index back */
				*place = var->num;
			}
			return VARIABLE;
		} else if (strcmp(node->sibling->sibling->lexeme.type, "Args") != 0) {
			if (strcmp(node->lexeme.value, "read") == 0) {
				InterCode callRead = genSinop(TEMPVAR, *place);
				callRead->kind = READ;
				putCode(callRead);
			} else {
				InterCode callFunc = genCall(TEMPVAR, FUNC, *place, node->lexeme.value);
				callFunc->kind = CALL;
				putCode(callFunc);
			}
			return TEMPVAR;
		} else {
			/* A little modification 
			 * We generate the 'ARG XX' at the same time we translate Args 
			 * But we use two different functions
			 * 1. translate_Args for normal function 
			 * 2. translate_ArgsWrite for write(x) */
			if (strcmp(node->lexeme.value, "write") == 0) {
				int tempVar = genNext(&curTempNum);
				int kind = translate_ArgsWrite(node->sibling->sibling, &tempVar);
				InterCode callWrite = genSinop(kind, tempVar);
				callWrite->kind = WRITE;
				putCode(callWrite);
			} else {
				translate_Args(node->sibling->sibling);
				/* In the above function, it will generate a bunch of ARG XX*/
				InterCode callFunc = genCall(TEMPVAR, FUNC, *place, node->lexeme.value);
				callFunc->kind = CALL;
				putCode(callFunc);
			}
			return TEMPVAR;
		}
	} else if (strcmp(node->lexeme.type, "MINUS") == 0) {
		if(place == NULL)
			return -1;
		int num = genNext(&curTempNum);
		/* Now we are at 'MINUS', its child is 'Exp1' */
		int kind = translate_Exp(node->sibling, &num);
		InterCode newCode = genBinop(CONSTANT, kind, TEMPVAR, 0, num, *place);
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
			int numLeft = genNext(&curTempNum);
			int kindLeft = translate_Exp(node, &numLeft);
			int numRight = genNext(&curTempNum);
			int kindRight = translate_Exp(node->sibling->sibling, &numRight);
			InterCode newCode = genAssign(kindLeft, kindRight, numLeft, numRight);
			newCode->kind = ASSIGN;
			putCode(newCode);
			if(place != NULL) {
				InterCode newCode2 = genAssign(TEMPVAR, kindLeft, *place, numLeft);
				newCode2->kind = ASSIGN;
				putCode(newCode2);
				return TEMPVAR;
			}
			else
				return -1;
		} else if (strcmp(type, "PLUS") == 0 
				|| strcmp(type, "MINUS") == 0
				|| strcmp(type, "STAR") == 0
				|| strcmp(type, "DIV") == 0) {
			if(place == NULL)
				return -1;
			/* Case for arithmetic operation */ 
			int num1 = genNext(&curTempNum);
			int kind1 = translate_Exp(node, &num1);
			int num2 = genNext(&curTempNum);
			int kind2 = translate_Exp(node->sibling->sibling, &num2);
			InterCode newCode = genBinop(kind1, kind2, TEMPVAR, num1, num2, *place);
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
			if(place == NULL)
				return -1;
			return cond_Exp(exp, place);
		} else if (strcmp(type, "LB") == 0) {
			if(place == NULL)
				return -1;
			/* For array */
			/* Because we don't support multi-dimensinal array
			 * Exp -> Exp1 LB Exp2 RB */
			if (strcmp(node->child->lexeme.type, "Exp") == 0
					&& strcmp(node->child->sibling->lexeme.type, "LB") == 0) {
				/* Case when we encounter a multi dim array */
				printf("Cannot translate: Code contains variables of multi-dimensional array type or parameters of array type.\n");
				exit(-1);
			}
			/* First, find the start address */
			int tempFirstElem = genNext(&curTempNum);
			int kindFirstElem = translate_Exp(node, &tempFirstElem);
			/* If Exp1 -> Exp2 DOT ID 
			 * Then we will get the first element in the array stored at t_{tempStartAddr}
			 * */
			/* XXX: Correct?
			 * If Exp1 -> ID
			 * Then we will still get the first element 
			 * */

			int bracketNum = getArraySize(node->sibling->sibling);
			/* bracketNum is the index */
			/* Determine the WIDTH here! */
			WIDTH = findWidth(node->child->lexeme.value);
			/* Finally, combine them to get the address of the value we need 
			 * In the intercode: t = &v_{start} + index * WIDTH */
			int tempAddr = genNext(&curTempNum);
			InterCode newCode1 = NULL;
			if (bracketNum != -1) {
				newCode1 = genBinop(kindFirstElem, CONSTANT, TEMPVAR, tempFirstElem, bracketNum * WIDTH, tempAddr);
			} else {
				/* Case when we use var to index an array 
				 * We need first generate t = v * WIDTH
				 * And then generate x = &y + t 
				 * */
				int tempIndex = genNext(&curTempNum);
				int kindIndex = translate_Exp(node->sibling->sibling, &tempIndex);
				int tempOffset = genNext(&curTempNum);
				InterCode tempNewCode = genBinop(kindIndex, CONSTANT, TEMPVAR, tempIndex, WIDTH, tempOffset);
				tempNewCode->kind = MUL;
				putCode(tempNewCode);
				newCode1 = genBinop(kindFirstElem, TEMPVAR, TEMPVAR, tempFirstElem, tempOffset, tempAddr);
			}
			newCode1->kind = ADDR; /* ADDR for: x = &y + WIDTH * index */
			putCode(newCode1);
			/* Associate place with the result */
			InterCode newCode2 = genAssign(TEMPVAR, TEMPVAR, *place, tempAddr);
			newCode2->kind = ASSIGNP;
			putCode(newCode2);
			/* Return type is TEMPVAR */
			return TEMPVAR;
		} else if (strcmp(type, "DOT") == 0) {
			if(place == NULL)
				return -1;
			/* For structure */
			/* First, find the start address */
			int tempStartAddr = genNext(&curTempNum);
			int kindStartAddr = translate_Exp(node, &tempStartAddr);
			/* Second, get the offset of the member */
			OFFSET = findOffset(node->child->lexeme.value, node->sibling->sibling->lexeme.value);
			/* Third, get the address of the memeber */
			int tempAddr = genNext(&curTempNum);
			InterCode newCode1 = genBinop(kindStartAddr, CONSTANT, TEMPVAR, tempStartAddr, OFFSET, tempAddr);
			newCode1->kind = ADD;
			putCode(newCode1);
			/* Finally, get the member from that address */
			InterCode newCode2 = genAssign(TEMPVAR, TEMPVAR, *place, tempAddr);
			newCode2->kind = ASSIGNP;
			putCode(newCode2);
			return TEMPVAR;
		}
	} else if (strcmp(node->lexeme.type, "NOT") == 0) {
		if(place == NULL)
			return -1;
		return cond_Exp(exp, place);
	} else if (strcmp(node->lexeme.type, "LP") == 0) {
		return translate_Exp(node->sibling, place);
	}
}

void translate_Cond(Node *exp, int label_true, int label_false) {
	debug("translate_Cond\n");
	Node *node = exp->child;
	if(strcmp(node->lexeme.type, "Exp") == 0) {
		Node *exp1 = node;
		Node *exp2 = node->sibling->sibling;
		if(strcmp(node->sibling->lexeme.type, "RELOP") == 0) {
			/* Case for production: Exp -> Exp RELOP Exp */
			int num1 = genNext(&curTempNum);
			int num2 = genNext(&curTempNum);
			int kind1 = translate_Exp(exp1, &num1);
			int kind2 = translate_Exp(exp2, &num2);
			char *relop = node->sibling->lexeme.value;
			
			InterCode newCode1 = genTriop(kind1, kind2, LB, num1, num2, label_true, relop);
			newCode1->kind = IFGOTO;
			putCode(newCode1);

			InterCode newCode2 = genSinop(LB, label_false);
			newCode2->kind = GOTO;
			putCode(newCode2);
		}
		else if(strcmp(node->sibling->lexeme.type, "AND") == 0) {
			/* Case for production: Exp -> Exp AND Exp */
			int label1 = genNext(&curLabel);
			translate_Cond(exp1, label1, label_false);

			InterCode newCode = genSinop(LB, label1);
			newCode->kind = LABEL;
			putCode(newCode);

			translate_Cond(exp2, label_true, label_false);
		}
		else if(strcmp(node->sibling->lexeme.type, "OR") == 0) {
			/* Case for production: Exp -> Exp OR Exp */
			int label1 = genNext(&curLabel);
			translate_Cond(exp1, label_true, label1);

			InterCode newCode = genSinop(LB, label1);
			newCode->kind = LABEL;
			putCode(newCode);

			translate_Cond(exp2, label_true, label_false);
		}
	}
	else if(strcmp(node->lexeme.type, "NOT") == 0) {
		/* Case for production: Exp -> NOT Exp */
		Node *exp1 = node->sibling;
		translate_Cond(exp1, label_false, label_true);
	}
	else {
		int newTempNum = genNext(&curTempNum);
		int kind = translate_Exp(exp, &newTempNum);

		InterCode newCode1 = genTriop(kind, CONSTANT, LB, newTempNum, 0, label_true, "!=");
		newCode1->kind = IFGOTO; 
		putCode(newCode1);

		InterCode newCode2 = genSinop(LB, label_false);
		newCode2->kind = GOTO;
		putCode(newCode2);
	} 
}

int translate_ArgsWrite(Node *args, int *place) {
	debug("translate_ArgsWrite\n");
	/* Function write(x) takes only one argument */
	return translate_Exp(args->child, place);
}

void translate_Args(Node *args) {
	debug("translate_Args\n");
	int tempVar = genNext(&curTempNum);
	int kind = translate_Exp(args->child, &tempVar);
	/* Deal with case when the argument is a structure */
	if (strcmp(args->child->child->lexeme.type, "ID") == 0) {
		FieldList var = getVar(args->child->child->lexeme.value, 0);
		if (var->type->kind == STRUCTURE) {
			InterCode strucParam = genSinop(kind, tempVar);
			strucParam->kind = ARGA;
			putCode(strucParam);
			if (args->child->sibling != NULL) {
				translate_Args(args->child->sibling->sibling);
				return;
			} else {
				return;
			}
		}
	}
	InterCode param = genSinop(kind, tempVar);
	param->kind = ARGV;
	putCode(param);
	if (args->child->sibling != NULL) {
		translate_Args(args->child->sibling->sibling);
	}
}





