#include "semantic.h"
#include <stdio.h>
#include <string.h>

extern FieldList symbolTable[TABLE_SIZE];

extern int putVar(FieldList var);
extern int putStruct(Structure strc);
extern FieldList getVar(char* name, int kind);
extern Structure getStruct(char* name);

static char strcName[3] = "00";

static int isEquivalent(Type this, Type that) {
	/* return whether this == that */
	if (this->kind != that->kind) {
		return 0;
	} else {
		if (this->kind == BASIC) {
			return this->u.basic == that->u.basic;
		} else if (this->kind == ARRAY) {
			return isEquivalent(this->u.array.elem, that->u.array.elem) && this->u.array.size == that->u.array.size;
		} else if (this->kind == STRUCTURE) {
			/* We only consider name equivalence here */
			return !strcmp(this->u.structure->name, that->u.structure->name);
		} else {
			/* For function, we need to consider return type and its parameters */
			int isRetTypeEquivalent = isEquivalent(this->u.function->retVal, that->u.function->retVal);
			int isParametersEquivalent = 1;
			FieldList thisList = this->u.function->parameters;
			FieldList thatList = that->u.function->parameters;
			while (thisList != NULL && thatList != NULL) {
				if (strcmp(thisList->name, thatList->name) != 0 ||
				!isEquivalent(thisList->type, thatList->type)) {
					isParametersEquivalent = 0;
					break;
				}
				thisList = thisList->tail;
				thatList = thatList->tail;
			}
			if ((thisList == NULL && thatList != NULL) || (thisList != NULL && thatList == NULL)) {
				isParametersEquivalent = 0;
			}
			return isRetTypeEquivalent && isParametersEquivalent;
		}
	}
}

/* High-level Definitions */
void Program(Node *root) {
    ExtDefList(root->child);
}

void ExtDefList(Node *root) {
    if(root->child != NULL){
        /* Case for production: ExtDefList -> ExtDef ExtDefList */
        ExtDef(root->child);
        ExtDefList(root->child->sibling);
    }
    else
        /* Case for production: ExtDefList -> epsilon */    
        return;
}

void ExtDef(Node *root) {
    Node *SpcNode = root->child;
    Type type = Specifier(SpcNode);
    Node *root = SpcNode->sibling;
    if(strcmp(root->lexeme.type, "SEMI"))
        /* Case for ExtDef -> Specifier SEMI */
        return;
    else if(strcmp(root->lexeme.type, "ExtDecList") == 0) 
        /* Case for ExtDef -> Specifier ExtDecList SEMI */
        ExtDecList(type, root);
    else if(strcmp(root->lexeme.type, "FunDec") == 0) {
        FieldList funcVar = FunDec(type, root);
        Function func = funcVar->type->u.function;
        if(strcmp(root->sibling->lexeme.type, "Compst") == 0) {
            /* Case for ExtDef -> Specifier FunDec CompSt */
            func->isDefined = 1;
            /* Check if there is a function with the same name*/
            FieldList funcVarChecker = getVar(funcVar->name, funcVar->type->kind);
            if(funcVarChecker == NULL)
                /* A new function, insert it into table */
                putVar(funcVar);
            else {
                Function funcChecker = funcVarChecker->type->u.function;
                if(funcChecker->isDefined == 1)
                    printf("Error type 4 at Line %d: Redefined function \"%s\"\n", root->lexeme.linenum, funcVar->name);
                else {
                    /* Check if there are inconsistent declarations */
					if(isEquivalent(funcVar->type, funcVarChecker->type)) {
						funcChecker->isDefined = 1;
						return;
					}
					else 
						printf("Error type 19 at Line %d: Inconsistent declaration of function \"%s\"\n", root->lexeme.linenum, funcVar->name);
                }
            }
        }
        else {
            /* Case for ExtDef -> Specifier FunDec SEMI */
			FieldList funcVarChecker = getVar(funcVar->name, funcVar->type->kind);
			if(funcVarChecker == NULL)
				putVar(funcVar);
			else {
				if(isEquivalent(funcVar->type, funcVarChecker->type))
					return;
				else
					printf("Error type 19 at Line %d: Inconsistent declaration of function \"%s\"\n", root->lexeme.linenum, funcVar->name);
			}
        }
    }    
}

void ExtDecList(Type type, Node *root) {
    FieldList newVar = VarDec(type, root->child);
	FieldList varChecker = getVar(newVar->name, newVar->type->kind);
	Structure strcChecker = getStruct(newVar->name);
	if(varChecker == NULL && strcChecker == NULL)
		putVar(newVar);
	else 
		printf("Error type 3 at Line %d: Redefined variable \"%s\"\n", root->lexeme.linenum, newVar->name);
    root = root->child->sibling;
    if(root == NULL)
        /* Case for ExtDecList -> VarDec */
		return;
    else {
        root = root->sibling;
        ExtDecList(type, root);
    }

}

Type Specifier(Node *root) {
	Type type;
	if(strcmp(root->child->lexeme.type, "TYPE") == 0) {
		/* Case for production: Specifier -> TYPE */
		type = (Type)malloc(sizeof(struct Type_));
		type->kind = BASIC;
		if(strcmp(root->child->lexeme.value, "int") == 0)
			type->u.basic = 0;
		else
			type->u.basic = 1;
	}
	else {
		/* Case for production: Specifier -> StructSpecifier */
		type = StructSpecifer(root->child);
	}
	return type;
}

Type StructSpecifer(Node *root) {
	root = root->child->sibling;
	if(strcmp(root->lexeme.type, "OptTag") == 0) {
		/* Case for production: StructSpecifier -> STRUCT OptTag LC DefList RC */
		Type type = (Type)malloc(sizeof(struct Type_));
		Structure newStrc = (Structure)malloc(sizeof(struct Structure_));
		type->kind = STRUCTURE;
		type->u.structure = newStrc;
		if(root->child == NULL) {
			/* Case for production: OptTag -> epsilon */
			/* Anonymous structure */
			newStrc->name = (char*)malloc(sizeof(char) * 3);
			strcpy(newStrc->name, strcName);
			strcName[1]++;
		}
		else {
			/* Case for production: OptTag -> ID */
			newStrc->name = root->child->lexeme.value;
		}
		root = root->sibling->sibling;
		newStrc->member = DefList(root, 1);
		FieldList varChecker = getVar(newStrc->name, 0);
		Structure strcChecker = getStruct(newStrc->name);
		if(varChecker == NULL && strcChecker == NULL) {
			putStruct(newStrc);
			return type;
		} else {
			printf("Error type 16 at Line %d: Duplicated name \"%s\".\n", root->lexeme.linenum, newStrc->name);
			return NULL;
		}			
	}
	else if(strcmp(root->lexeme.type, "Tag") == 0){
		Structure strcChecker = getStruct(root->child->lexeme.value);
		if(strcChecker == NULL) {
			printf("Error type 17 at Line %d: Undefined structure \"%s\".\n",root->lexeme.linenum, root->child->lexeme.value);
			return NULL;
		}
		else {
			Type type = (Type)malloc(sizeof(struct Type_));
			type->kind = STRUCTURE;
			type->u.structure = strcChecker;
			return type;
		}
	}
}

/* Declarators */
FieldList VarDec(Type type, Node *root) {
	if (strcmp(root->child->lexeme.type, "ID")) {
		/* Case for production: VarDec -> ID */

		/* Get ID and insert into symbol table */
		FieldList newVar = (FieldList)malloc(sizeof(struct FieldList_));
		newVar->name = root->child->lexeme.value;
		/* XXX: make sure variable 'type' here will not be freed */
		newVar->type = type;

		/* Return immediately since there is no more child */
		return newVar;
	} else if (strcmp(root->child->lexeme.type, "VarDec") == 0) {
		/* Case for production: VarDec -> VarDec LB INT RB */

		/* Call VarDec() first */
		FieldList newVar = VarDec(type, root->child);

		/* We now know it must be an array */
		/* Get the dimension first */
		int dimension = atoi(root->child->sibling->sibling->lexeme.value);
		if (newVar->type->kind == BASIC) {
			/* This means we just came back from an ID node */
			/* Construct a new type for 'array' */
			int basic = newVar->type->u.basic;
			Type elem = malloc(sizeof(Type));
			elem->kind = BASIC;
			elem->u.basic = basic;

			newVar->type->kind = ARRAY;
			newVar->type->u.array.size = dimension;
			newVar->type->u.array.elem = elem;
		} else {
			/* This means we came back from an VarDec node*/
			/* Field 'elem' and 'kind' must be set already, so we just need to update 'size' */
			newVar->type->u.array.size *= dimension;
		}

		/* Return now */
		return newVar;
	}
}

FieldList FunDec(Type type, Node *root) {
    /* XXX: Here "type" should be the type of retVal */
    /* XXX: It should be "sizeof(FieldList_)" */
	FieldList newVar = (FieldList)malloc(sizeof(struct FieldList_));
	/* Set the ID first */
	newVar->name = root->child->lexeme.value;
    newVar->type = (Type)malloc(sizeof(struct Type_));
    newVar->type->kind = FUNCTION;
    Function newFunc = (Function)malloc(sizeof(struct Function_));
    newVar->type->u.function = newFunc;
    newFunc->isDeclared = 1;
    newFunc->isDefined = 0;
    newFunc->retVal = type;
	root = root->child->sibling->sibling;
	if (strcmp(root->lexeme.type, "RP") == 0) {
		/* Case for production: FunDec -> ID LP RP */
		newFunc->parameters = NULL; /* No parameters */
		return newVar;
	} else {
		/* Case for production: FunDec -> ID LP VarList RP */
		/* VarList() should return a FieldList */
		FieldList listHead = (FieldList)malloc(sizeof(struct FieldList_));
		listHead->tail = NULL;
		VarList(listHead, root);
		newFunc->parameters = listHead->tail;
		free(listHead);
		return newVar;
	}
}

void VarList(FieldList list, Node *root) {
	FieldList newParam = ParamDec(root->child);
	root = root->child->sibling;
	FieldList tmp = list;
	while(tmp->tail != NULL)
		tmp = tmp->tail;
	tmp->tail = newParam;
	if (root == NULL) {
		/* Case for production: VarList -> ParamDec */
		return ;
	} else {
		/* Case for production: VarList -> ParamDec COMMA VarList*/
		VarList(list, root->sibling);
	}
}

FieldList ParamDec(Node *root) {
	Type paramType = Specifier(root->child);
	root = root->child->sibling;
	FieldList newParam = VarDec(paramType, root);
	return newParam;
}

/* Stataments */
void CompSt(Type type, Node *root) {
	/* XXX: might need some change here */
	DefList(root->child->sibling, 0);

	StmtList(type, root->child->sibling->sibling);
}

void StmtList(Type type, Node *root) {
	if (root->child != NULL) {
		/* Case for production: StmtList -> Stmt StmtList */
		Stmt(type, root->child);
		StmtList(type, root->child->sibling);
	} else {
		/* Case for production: StmtList -> epsilon */
		/* Do nothing */
	}
}

void Stmt(Type type, Node *root) {
	root = root->child;
	int flag = 0;
	if (strcmp(root->lexeme.type, "Exp")) {
		/* Case for production: Stmt -> Exp SEMI */
		Exp(root, &flag);
	} else if (strcmp(root->lexeme.type, "CompSt")) {
		/* Case for production: Stmt -> CompSt*/
		Type emptyType = NULL;
		CompSt(emptyType, root);
	} else if (strcmp(root->lexeme.type, "RETURN")) {
		/* Case for production: Stmt -> RETURN Exp SEMI */
		Type expType = Exp(root, &flag);
		//assert(isEquivalent(expType, type));
		printf("Error type 8 at Line %d: Type mismatched for return.\n", root->lexeme.linenum);
		/* XXX: Need return here? */
	} else if (strcmp(root->lexeme.type, "IF")) {
		/* Case for production: Stmt -> IF LP Exp RP XX */
		root = root->sibling->sibling;
		Type expType = Exp(root, &flag);
		/* expType can only be int */
		/* XXX: Assume basic = 0 means 'int' here*/
		assert(expType->kind == BASIC && expType->u.basic == 0);
		root = root->sibling->sibling;
		Stmt(type, root);
		if (root->sibling == NULL) {
			/* Case for production: Stmt -> IF LP Exp RP Stmt */
			/* Do nothing */
			return;
		} else {
			/* Case for production: Stmt -> IF LP Exp RP Stmt ELSE Stmt */
			root = root->sibling->sibling;
			Stmt(type, root);
		}
	} else {
		/* Case for production: Stmt -> WHILE LP Exp RP Stmt */
		root = root->sibling->sibling;
		Type expType = Exp(root, &flag);
		/* expType can only be int */
		/* XXX: Assume basic = 0 means 'int' here*/
		assert(expType->kind == BASIC && expType->u.basic == 0);
		root = root->sibling->sibling;
		Stmt(type, root);
	}
}

FieldList DefList(Node *root, int isStructure) {
	if (root->child != NULL) {
		/* Case for production: DefList -> Def DefList */
		FieldList definitions = Def(root->child, isStructure);
		/* Find the end of list 'definitions' */
		FieldList ptr = definitions;
		while (ptr != NULL && ptr->tail != NULL) {
			ptr = ptr->tail;
		}
		ptr->tail = DefList(root->child->sibling, isStructure);
		return definitions;
	} else {
		/* Case for production: DefList -> epsilon */
		return NULL;
	}
}

FieldList Def(Node *root, int isStructure) {
	Type type = Specifier(root->child);
	return DecList(type, root->child->sibling, isStructure);
}

FieldList DecList(Type type, Node *root, int isStructure) {
	FieldList definition = Dec(type, root->child, isStructure);
	/* Check here */
	FieldList varChecker = getVar(definition->name, 0);
	Structure strcChecker = getStruct(definition->name);
	if (varChecker == NULL && strcChecker == NULL) {
		putVar(definition);
	} else {
		printf("Error type 16 at Line %d: Duplicated name \"%s\".\n", root->lexeme.linenum, definition->name);
		return NULL;
	}
	if (root->child->sibling == NULL) {
		/* Case for production DecList -> Dec */
		return definition;
	} else {
		/* Case for production DecList -> Dec COMMA DecList */
		FieldList restVars = DecList(type, root->child->sibling->sibling, isStructure);
		definition->tail = restVars;
		return definition;
	}
}

FieldList Dec(Type type, Node *root, int isStructure) {
	FieldList newVar = VarDec(type, root->child);
	if (root->child->sibling == NULL) {
		/* Case for production Dec -> VarDec */
		return newVar;
	} else {
		/* Case for production Dec -> VarDec ASSIGNOP Exp */
		if (isStructure) {
			printf("Error type 15 at Line %d: Multiple definition or initializing a field when defining a structure.\n", root->child->sibling->lexeme.linenum);
			return NULL;
		} else {
			int flag = 0;
			Type expType = Exp(root->child->sibling->sibling, &flag);
			if (!isEquivalent(type, expType)) {
				printf("Error type 5 at Line %d: Type mismatched for assignment.\n", root->child->sibling->lexeme.linenum);
				return NULL;
			}
		}
		return newVar;
	}
}

/* Expressions */
Type Exp(Node *root, int *flag) {
	if(strcmp(root->child->lexeme.type, "Exp") == 0) {
		if(strcmp(root->child->sibling->lexeme.type, "ASSIGNOP") == 0){
			/* Case for production: Exp -> Exp ASSIGNOP Exp */
			*flag = 1;
			int leftFlag = 0, rightFlag = 0;
			Type leftExp = Exp(root->child, &leftFlag);
			Type rightExp = Exp(root->child->sibling->sibling, &rightFlag);
			if(leftFlag == 1) {
				printf("Error type 6 at Line %d: The left-hand side of an assignment must be a variable.\n", root->lexeme.linenum);
				return NULL;
			}
			if(isEquivalent(leftExp, rightExp))
				return leftExp;
			else {
				printf("Error type 5 at Line %d: Type mismatched for assignment.\n", root->lexeme.linenum);
				return NULL;
			}
		}
		else if(strcmp(root->child->sibling->lexeme.type, "AND") == 0
				|| strcmp(root->child->sibling->lexeme.type, "OR") == 0
				|| strcmp(root->child->sibling->lexeme.type, "RELOP") == 0
				|| strcmp(root->child->sibling->lexeme.type, "PLUS") == 0
				|| strcmp(root->child->sibling->lexeme.type, "MINUS") == 0
				|| strcmp(root->child->sibling->lexeme.type, "STAR") == 0
				|| strcmp(root->child->sibling->lexeme.type, "DIV") == 0) {
			/* Case for production: Exp -> Exp AND/OR/RELOP/PLUS/MINUS/STAR/DIV Exp */
			int leftFlag = 0, rightFlag = 0;
			Type leftExp = Exp(root->child, leftFlag);
			Type rightExp = Exp(root->child->sibling->sibling, rightFlag);
			if(isEquivalent(leftExp, rightExp) && leftExp->kind == BASIC) {
				/* This is a RIGHT-VALUE */
				*flag = 1;
				/* Return either type */
				return leftExp; 
			} else {
				printf("Error type 7 at Line %d: Type mismatched for operands.\n", root->lexeme.linenum);
				return NULL;
			}
		}
		else if(strcmp(root->child->sibling->lexeme.type, "LB") == 0) {
			/* Case for production: Exp -> Exp LB Exp RB */
			int tmpFlag = 0;
			Type arrayType = Exp(root->child, &tmpFlag);
			if(arrayType == NULL)
				return NULL;
			if(arrayType->kind != ARRAY) {
				printf("Error type 10 at Line %d: \"%s\" is not an array.\n", root->child->lexeme.linenum, root->child->lexeme.value);
				return NULL;
			}
			root = root->child->sibling->sibling;
			Type indexType = Exp(root, &tmpFlag);
			if(indexType == NULL)
				return NULL;
			if(indexType->kind != BASIC || indexType->u.basic != 0) {
				printf("Error type 12 at Line %d: \"%s\" is not an integer.\n", root->lexeme.linenum, root->lexeme.value);
				return NULL;
			}
			return arrayType->u.array.elem;
		}
		else if(strcmp(root->child->sibling->lexeme.type, "DOT") == 0) {
			/* Case for production: Exp -> Exp DOT ID */
			int tmpFlag = 0;
			Type strcType = Exp(root->child, &tmpFlag);
			if(strcType == NULL)
				return NULL;
			if(strcType->kind != STRUCTURE) {
				printf("Error type 13 at Line %d: Illegal use of \".\".\n", root->child->lexeme.linenum);
				return NULL;
			} 
			FieldList memberList = strcType->u.structure->member;
			root = root->child->sibling->sibling;
			char *memberName = root->lexeme.value;
			while(memberList != NULL) {
				if(strcmp(memberName, memberList->name) == 0) 
					return memberList->type;
				memberList = memberList->tail;
			}
			printf("Error type 14 at Line %d: Non-existent field \"%s\".\n", root->lexeme.linenum, root->lexeme.value);
			return NULL;
		}
	}
	else if(strcmp(root->child->lexeme.type, "LP") == 0) {
		/* Case for production: Exp -> LP Exp RP */
		*flag = 1;
		return Exp(root->child->child, flag);
	}
	else if(strcmp(root->child->lexeme.type, "MINUS") == 0) {
		/* Case for production: Exp -> MINUS Exp */
		*flag = 1;
		Type type = Exp(root->child->sibling, flag);
		if(type == NULL) 
			return NULL;
		if(type->kind != BASIC || type->u.basic != 0) {
			printf("Error type 7 at Line %d: Type mismatched for operands.\n", root->lexeme.linenum);
			return NULL;
		}
		return type;
	}
	else if(strcmp(root->child->lexeme.type, "NOT") == 0) {
		/* Case for production: Exp -> NOT Exp */
		*flag = 1;
		Type type = Exp(root->child->sibling, flag);
		if(type == NULL) 
			return NULL;
		if(type->kind != BASIC || type->u.basic != 0) {
			printf("Error type 7 at Line %d: Type mismatched for operands.\n", root->lexeme.linenum);
			return NULL;
		}
		return type;
	}
	else if(strcmp(root->child->lexeme.type, "ID") == 0) {
		if(root->child->sibling == NULL) {
			/* Case for production: Exp -> ID */
			FieldList varChecker = getVar(root->child->lexeme.value, 0);
			if(varChecker == NULL) {
				printf("Error type 1 at Line %d: Undefined variable \"%s\".\n", root->child->lexeme.linenum, root->child->lexeme.value);
				return NULL; 
			}
			return varChecker->type;
		}
		else {
			FieldList varChecker = getVar(root->child->lexeme.value, 0);
			FieldList funcVarChecker = getVar(root->child->lexeme.value, 3);
			if(varChecker != NULL && funcVarChecker == NULL) {
				printf("Error type 11 at Line %d: \"%s\" is not a function.\n", root->child->lexeme.linenum, root->child->lexeme.value);
				return NULL;
			}
			if(funcVarChecker == NULL || funcVarChecker->type->u.function->isDefined == 0) {
				printf("Error type 2 at Line %d: Undefined function \"%s\".\n", root->child->lexeme.linenum, root->child->lexeme.value);
				return NULL;
			}
			FieldList paramList = funcVarChecker->type->u.function->parameters;
			root = root->child->sibling->sibling;
			if(strcmp(root->lexeme.type, "RP") == 0) {
				/* Case for production: Exp -> ID LP RP */
				if(paramList != NULL) {
					printf("Error type 9 at Line %d: Function \"%s\" is not applicable for arguments.\n", root->lexeme.linenum, funcVarChecker->name);
					return NULL;
				}
			}
			else {
				/* Case for production: Exp -> ID LP Args RP */
				if(Args(root, paramList) != 0) {
					printf("Error type 9 at Line %d: Function \"%s\" is not applicable for arguments.\n", root->lexeme.linenum, funcVarChecker->name);
					return NULL;
				}
			}
			*flag = 1;
			return funcVarChecker->type->u.function->retVal;
		}
	}
	else if(strcmp(root->child->lexeme.type, "INT") == 0) {
		/* Case for production: Exp -> INT */
		Type type = (Type)malloc(sizeof(struct Type_));
		type->kind = BASIC;
		type->u.basic = 0;
		*flag = 1;
		return type;
	}
	else if(strcmp(root->child->lexeme.type, "FLOAT") == 0) {
		/* Case for production: Exp -> FLOAT */
		Type type = (Type)malloc(sizeof(struct Type_));
		type->kind = BASIC;
		type->u.basic = 1;
		*flag = 1;
		return type;
	}
}

int Args(Node *root, FieldList paramList) {
	if(paramList == NULL)
		return 1;
	int flag = 0;
	root = root->child;
	Type thisParam = Exp(root, &flag);
	if(isEquivalent(thisParam, paramList->type)) {
		if(root->sibling == NULL)
			return 0;
		else {
			root = root->sibling;
			return Args(root, paramList->tail);
		}
	}
}
