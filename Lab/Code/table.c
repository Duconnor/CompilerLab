#include "table.h"
#include "semantic.h"
#include <string.h>

FieldList varTable[TABLE_SIZE]; 
FieldList fieldTable[TABLE_SIZE];
Structure structTable[TABLE_SIZE];

unsigned int hash(char* name){
    unsigned int val = 0, i;
    for(; *name; ++name) {
        val = (val << 2) + *name;
        if(i = val & ~0x3fff)
            val = (val ^ (i >> 12)) & 0x3fff;
    }
    return val % TABLE_SIZE;
}

void initTable(){
    memset(varTable, 0, sizeof(varTable));
    memset(structTable, 0, sizeof(structTable));
}

void clearFieldTable() {
	memset(fieldTable, 0, sizeof(fieldTable));
}

int putVar(FieldList var){
    unsigned int hashCode = hash(var->name);
    if(varTable[hashCode] == NULL)
        varTable[hashCode] = var;
    else{
        FieldList tmp = varTable[hashCode];
        for(; tmp->tail != NULL; tmp = tmp->tail)
            /* XXX: Var and Func can have the same name */
            if(strcmp(tmp->name, var->name) == 0 && (tmp->type->kind < 3) == (var->type->kind < 3))
                return -1;
        if(strcmp(tmp->name, var->name) == 0)
            return -1;
        tmp->tail = var;
    }
    return 0;
}

int putStruct(Structure strc){
    unsigned int hashCode = hash(strc->name);
    if(structTable[hashCode] == NULL)
        structTable[hashCode] = strc;
    else{
        Structure tmp = structTable[hashCode];
        for(; tmp->tail != NULL; tmp = tmp->tail){
            if(strcmp(tmp->name, strc->name) == 0)
                return -1;
        }
        if(strcmp(tmp->name, strc->name) == 0)
            return -1;
        tmp->tail = strc;
    }
    return 0;
}

int putField(FieldList fieldVar) {
	unsigned int hashCode = hash(fieldVar->name);
	if (fieldTable[hashCode] == NULL) {
		fieldTable[hashCode] = fieldVar;
	} else {
		FieldList tmp = fieldTable[hashCode];
		for (; tmp->tail != NULL; tmp = tmp->tail) {
			if (strcmp(tmp->name, fieldVar->name) == 0)
				return -1;
		}
		if (strcmp(tmp->name, fieldVar->name) == 0)
			return -1;
		tmp->tail = fieldVar;
	}
	return 0;
}

FieldList getVar(char* name, int kind){
	/* Do a search in vatTable according to name */
	unsigned int hashCode = hash(name);
	FieldList head = varTable[hashCode];
	while (head != NULL) {
		/* Check one by one to see if we get a hit! */
        /* XXX: We should consider the kind of Variable */
		if (strcmp(head->name, name) == 0 && (head->type->kind < 3) == (kind < 3))
			return head;
		else
			head = head->tail;
	}
	return NULL;
}

Structure getStruct(char* name){
	/* Do a search in structTable according to name */
	unsigned int hashCode = hash(name);
	Structure head = structTable[hashCode];
	while (head != NULL) {
		/* Check one by one ~ */
		if (strcmp(head->name, name) == 0)
			return head;
		else
			head = head->tail;
	}
	return NULL;
}

FieldList getFieldVar(char *name) {
	unsigned int hashCode = hash(name);
	FieldList head = fieldTable[hashCode];
	while (head != NULL) {
		if (strcmp(head->name, name) == 0)
			return head;
		else
			head = head->tail;
	}
	return NULL;
}
