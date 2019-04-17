#include "table.h"
#include <string.h>

FieldList varTable[TABLE_SIZE]; 
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

int putVar(FieldList var){
    unsigned int hashCode = hash(var->name);
    if(varTable[hashCode] == NULL)
        varTable[hashCode] = var;
    else{
        FieldList tmp = varTable[hashCode];
        for(; tmp->tail != NULL; tmp = tmp->tail)
            if(strcmp(tmp->name, var->name) == 0)
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

FieldList getVar(char* name){

}

Structure getStruct(char* name){

}