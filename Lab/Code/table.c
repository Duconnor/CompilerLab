#include "table.h"
#include <string.h>

FieldList varTable[TABLE_SIZE]; 
FieldList structTable[TABLE_SIZE];

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

}

int putVar(FieldList var){

}

int putStruct(Structure strc){

}

FieldList getVar(char* name){
	/* Do a search in vatTable according to name */
	int hashCode = hash(name);
	FieldList head = varTable[hashCode];
	while (head != NULL) {
		/* Check one by one to see if we get a hit! */
		if (strcmp(head->name, name) == 0)
			return head;
		else
			head = head->tail;
	}
	return NULL;
}

Structure getStruct(char* name){
	/* Do a search in structTable according to name */
    int hashCode = hash(name);
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
