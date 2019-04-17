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

}

Structure getStruct(char* name){
    
}