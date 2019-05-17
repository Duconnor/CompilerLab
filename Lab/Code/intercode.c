extern FieldList varTable[TABLE_SIZE];

static int curTempNum = 0; /* Initialize to 0 */
static int curVarNum = 0; /* Initialize to 0 */
static int curLabel = 0; /* Initialize to 0 */

static int genNext(int &current) {
	current++;
	if (current < 0) {
		/* Overflow */
		printf("Can't generate more!\n");
		exit(-1);
	}
	return current;
}

static InterCode genSinop(int kind, int val) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op = (Operand)malloc(sizeof(struct Operand_));
	op->kind = kind;
	op->val = val;
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

static InterCode genFunc(int op1Kind, int op2Kind, int op1Var, int op2Var) {
	InterCode newCode = (InterCode)malloc(sizeof(struct InterCode_));
	Operand op1 = (Operand)malloc(sizeof(struct Operand_));
	Operand op2 = (Operand)malloc(sizeof(struct Operand_));

	newCode->u.func.op1 = op1;
	newCode->u.func.op2 = op2;

	newCode->prev = newCode->next = NULL;

	op1->kind = op1Kind;
	op2->kind = op2Kind;

	op1->u.value = op1Var;
	op2->u.value = op2Var;

	return newCode;
}

int translate_Exp(Node *exp, int place) {
	/* Param 'varNum': the index of this variable */
	/* Return: the 'kind' (type) of this intercode */
	/* Current node's type is 'Exp' */
	Node *node = exp->child;
	if (strcmp(node->lexeme.type, "INT") == 0) {
		int value = atoi(node->lexeme.value);
		InterCode newCode = genAssign(TEMPVAL, CONSTANT, place, value);
		newCode->kind = ASSIGN;
		putCode(newCode);
		return TEMPVAL;
	} else if (strcmp(node->lexeme.type, "ID") == 0) {
		FieldList var = getVar(node->lexeme.value, 0);
		if (var.num == -1) {
			var.num = place;
		} else {
			/* XXX: I don't think we should do anything here */
		}
		return VARIABLE;
	} else if (strcmp(node->lexeme.type, "MINUS") == 0) {
		int num = genNext(curTempNum);
		/* Now we are at 'MINUS', its child is 'Exp1' */
		int kind = translate_Exp(node->sibling, num);
		InterCode newCode = genBinop(CONSTANT, kind, TEMPVAL, 0, num, place);
		newCode->kind = SUB; /* place := #0 - t_num */
		putCode(newCode);
		return TEMPVAL;
	} else if (strcmp(node->lexeme.type, "Exp") == 0) {
		char *type = node->sibling->lexeme.type;
		if (strcmp(type, "ASSIGNOP") == 0) {
			/* XXX: I made some change here
			 * Despite Exp1 must be ID 
			 * I will pass it to translate_Exp anyway
			 * In order to match this ID with a corresponding num */
			int numLeft = genNext(curVarNum); /* Left is ID (variable) */
			int kindLeft = translate_Exp(node, numLeft);
			int numRight = genNext(curTempNum);
			int kindRight = translate_Exp(node->sibling->sibling, numRight);
			InterCode newCode = genAssign(kindLeft, kindRight, numLeft, numRight);
			newCode->kind = ASSIGN;
			putCode(newCode);
			InterCode newCode2 = genAssign(TEMPVAL, kindLeft, place, numLeft);
			newCode2->kind = ASSIGN;
			putCode(newCode2);
			return TEMPVAL;
		} else if (strcmp(type, "PLUS") == 0 
				|| strcmp(type, "MINUS") == 0
				|| strcmp(type, "STAR") == 0
				|| strcmp(type, "DIV") == 0) {
			/* Case for arithmetic operation */ 
			int num1 = genNext(curTempNum);
			int kind1 = translate_Exp(node, num1);
			int num2 = genNext(curTempNum);
			int kind2 = translate_Exp(node->sibling->sibling, num2);
			InterCode newCode = genBinop(kind1, kind2, TEMPVAL, num1, num2, place);
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
			return TEMPVAL;
		} else if (strcmp(type, ""))
	} else if (strcmp(node->lexeme.type, "NOT") == 0) {
		/* TODO: */
	}
}
