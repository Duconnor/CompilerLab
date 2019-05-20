#include <stdlib.h>
#include <stdio.h>
#include "tree.h"
#include "semantic.h"
#include "table.h"
#include "intercode.h"

extern FILE *yyin;
extern int yylineno;
extern void yyrestart(FILE*);
extern void yyparse(void);
extern int aErrorFree, bErrorFree;

Node* tree;

int main(int argc, char **argv) {
	if (argc > 1) {
		FILE *file = fopen(argv[1], "r");
		if (!file) {
			perror(argv[1]);
			return -1;
		}

		tree = NULL;

		yylineno = 1;
		yyrestart(file);
		yyparse();

		initTable();
		
		if(aErrorFree && bErrorFree) {
			printTree(tree);
			printf("\n");
			Program(tree);
			translate_Program(tree);
			printInterCodes(argv[2]);
		}

		destroyTree(tree);

		return 0;
	}
	return -1;
}
