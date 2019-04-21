#include "semantic.h"
extern FieldList symbolTable[TABLE_SIZE];

extern void VarList(Type type, Node *root);
extern Type Specifier(Node *root);
extern void ParamDec(Type type, Node *root);
extern void StmtList(Type type, Node *root);
extern void Stmt(Type type, Node *root);

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
	FieldList newVar = (FieldList)malloc(sizeof(FieldList));
	/* Set the ID first */
	newVar->name = root->child->lexeme.value;
	root = root->child->sibling->sibling;
	if (strcmp(root->lexeme.type, "RP") == 0) {
		/* Case for production: FunDec -> ID LP RP */
		type->u.function->parameters = NULL; /* No parameters */
		newVar->type = type;
		return newVar;
	} else {
		/* Case for production: FunDec -> ID LP VarList RP */
		/* VarList will modify type and fill in the parameters */
		VarList(type, root);
		newVar->type = type;
		return newVar;
	}
}

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
