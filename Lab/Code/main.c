#include <stdlib.h>
#include <stdio.h>

extern FILE *yyin;
extern int yylex(void);

int main(int argc, char **argv) {
	if (argc > 1) {
		if (!(yyin = fopen(argv[1], "r"))) {
			perror("Error: ");
			return -1;
		}
	}
	while(yylex() != 0);
	return 0;
}
