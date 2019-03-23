#include <stdlib.h>
#include <stdio.h>

extern FILE *yyin;
extern int yylineno;
extern void yyrestart(FILE*);
extern void yyparse(void);

int main(int argc, char **argv) {
	if (argc > 1) {
		FILE *file = open(argv[1], "r");
		if (!file) {
			perror(argv[1]);
			return -1;
		}
		yylineno = 1;
		yyrestart(f);
		yyparse();
		return 0;
	}
	return -1;
}
