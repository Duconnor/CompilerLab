#include "semantic.h"
#include <stdio.h>

extern FieldList symbolTable[TABLE_SIZE];

extern int putVar(FieldList var);
extern putStruct(Structure strc);
extern FieldList getVar(char* name, int kind);
extern Structure getStruct(char* name);

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
                    /* TODO: Check if there are inconsistent declarations */
                }
            }
        }
        else {
            /* Case for ExtDef -> Specifier FunDec SEMI */
            /* TODO: Check if there are inconsistent declarations */
        }
    }    
}

void ExtDecList(Type type, Node *root) {
    Field newVar = VarDec(type, root->child);
    /* TODO: Check and insert(or not) */
    root = root->child->sibling;
    if(root == NULL)
        /* Case for ExtDecList -> VarDec */
    else {
        root = root->sibling;
        ExtDecList(type, root);
    }

}

/* Declarators */
FieldList VarDec(Type type, Node *root) {
	if (strcmp(root->child->lexeme.type, "ID")) {
		/* Case for production: VarDec -> ID */

		/* Get ID and insert into symbol table */
		FieldList newVar = (FieldList)malloc(sizeof(FieldList));
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
	FieldList newVar = (FieldList)malloc(sizeof(FieldList_));
	/* Set the ID first */
	newVar->name = root->child->lexeme.value;
    newVar->type = (Type)malloc(sizeof(Type_));
    newVar->type->kind = FUNCTION;
    Function newFunc = (Function)malloc(sizeof(Function_));
    newVar->type->u.function = newFunc;
    newFunc->isDeclare = 1;
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
		newFunc->parameters = VarList(root);
		return newVar;
	}
}

/* XXX: VarList() and ParamDec() needs to rewrite */
void VarList(Type type, Node *root) {
	ParamDec(type, root->child);
	root = root->child->sibling;
	if (root == NULL) {
		/* Case for production: VarList -> ParamDec */
		return;
	} else {
		/* Case for production: VarList -> ParamDec COMMA VarList*/
		return VarList(type, root->sibling);
	}
}

void ParamDec(Type type, Node *root) {
	Type paramType = Specifier(root->child);
	root = root->child->sibling;
	FieldList newParam = VarDec(paramType, root);
	/* Add this into the parameter list */
	FieldList list = type->u.function->parameters;
	if (list == NULL) {
		/* First parameter */
		list = newParam;
	} else {
		while (list->tail != NULL) {
			list = list->tail;
		}
		list->tail = newParam;
	}
}

/* Stataments */
void CompSt(Type type, Node *root) {
	/* XXX: might need some change here */
	DefList(root->child->sibling);

	StmtList(root->child->sibling->sibling);
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
	if (strcmp(root->lexeme.type, "Exp")) {
		/* Case for production: Stmt -> Exp SEMI */
		Exp(root);
	} else if (strcmp(root->lexeme.type, "CompSt")) {
		/* Case for production: Stmt -> CompSt*/
		Type emptyType = NULL;
		CompSt(emptyType, root);
	} else if (strcmp(root->lexeme.type, "RETURN")) {
		/* Case for production: Stmt -> RETURN Exp SEMI */
		Type expType = Exp(root);
		assert(isEquivalent(expType, type));
	} else if (strcmp(root->lexeme.type, "IF")) {
		/* Case for production: Stmt -> IF LP Exp RP XX */
		root = root->sibling->sibling;
		Type expType = Exp(root);
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
		Type expType = Exp(root);
		/* expType can only be int */
		/* XXX: Assume basic = 0 means 'int' here*/
		assert(expType->kind == BASIC && expType->u.basic == 0);
		root = root->sibling->sibling;
		Stmt(type, root);
	}
}
