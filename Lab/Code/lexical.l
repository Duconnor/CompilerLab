%option yylineno
%{
	#include <stdlib.h>
	#include "syntax.tab.h"

	int yycolumn = 1;
	#define YY_USER_ACTION \
	yylloc.first_line = yylloc.last_line = yylineno; \
	yylloc.first_column = yycolumn; \
	yylloc.last_column = yycolumn + yyleng - 1; \
	yycolumn += yyleng;
%}
digit [0-9]
posdigit [1-9]
octdigit [0-7]
posoctdigit [1-7]
hexdigit [0-9A-Fa-f]
poshexdigit [1-9A-Fa-f]
letter [a-zA-Z]
INT 0|{posdigit}{digit}*
OCT 0(0|{posoctdigit}{octdigit}*)
HEX 0x(0|{poshexdigit}{hexdigit}*)
FLOAT {digit}+\.{digit}+
SCIFLOAT ({digit}*\.{digit}+|{digit}+\.{digit}*)[Ee][+-]?{digit}+
ID _|{letter}(_|{letter}|{digit}){0,31}
SEMI ;
COMMA ,
ASSIGNOP =
RELOP >|<|>=|<=|==|\!=
PLUS \+
MINUS -
STAR \*
DIV \/
AND &&
OR \|\|
NOT \!
TYPE int|float
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while
	/* [{letter}] is not acceptable, why? */
%%
\n { yycolumn = 1; }
{STRUCT} { yylval.type_node = initNode("STRUCT", NULL, yylineno); return STRUCT; }
{RETURN} { yylval.type_node = initNode("RETURN", NULL, yylineno); return RETURN; }
{IF} { yylval.type_node = initNode("IF", NULL, yylineno); return IF; }
{ELSE} { yylval.type_node = initNode("ELSE", NULL, yylineno); return ELSE; }
{WHILE} { yylval.type_node = initNode("WHILE", NULL, yylineno); return WHILE; }
{TYPE} { yylval.type_node = initNode("TYPE", yytext, yylineno); return TYPE; }
	/*{SCIFLOAT} { printf("SCI: %s\n", yytext); }*/
{FLOAT} { yylval.type_node = initNode("FLOAT", yytext, yylineno); return FLOAT; }
{INT} { yylval.type_node = initNode("INT", yytext, yylineno); return INT; }
{OCT} {	int val = 0;
		sscanf(yytext, "%o", &val);
		sprintf(yytext, "%d", val);
		yylval.type_node = initNode("INT", yytext, yylineno); return INT; }
{HEX} { int val = 0;
		sscanf(yytext, "%x", &val);
		sprintf(yytext, "%d", val);
		yylval.type_node = initNode("INT", yytext, yylineno); return INT; }
{ID} { yylval.type_node = initNode("ID", yytext, yylineno); return ID; }
{SEMI} { yylval.type_node = initNode("SEMI", NULL, yylineno); return SEMI; }
{COMMA} { yylval.type_node = initNode("COMMA", NULL, yylineno); return COMMA; }
{ASSIGNOP} { yylval.type_node = initNode("ASSIGNOP", NULL, yylineno); return ASSIGNOP; }
{RELOP} { yylval.type_node = initNode("RELOP", NULL, yylineno); return RELOP; }
{PLUS} { yylval.type_node = initNode("PLUS", NULL, yylineno); return PLUS; }
{MINUS} { yylval.type_node = initNode("MINUS", NULL, yylineno); return MINUS; }
{STAR} { yylval.type_node = initNode("STAR", NULL, yylineno); return STAR; }
{DIV} { yylval.type_node = initNode("DIV", NULL, yylineno); return DIV; }
{AND} { yylval.type_node = initNode("AND", NULL, yylineno); return AND; }
{OR} { yylval.type_node = initNode("OR", NULL, yylineno); return OR; }
{NOT} { yylval.type_node = initNode("NOT", NULL, yylineno); return NOT; }
{LP} { yylval.type_node = initNode("LP", NULL, yylineno); return LP; }
{RP} { yylval.type_node = initNode("RP", NULL, yylineno); return RP; }
{LB} { yylval.type_node = initNode("LB", NULL, yylineno); return LB; }
{RB} { yylval.type_node = initNode("RB", NULL, yylineno); return RB; }
{LC} { yylval.type_node = initNode("LC", NULL, yylineno); return LC; }
{RC} { yylval.type_node = initNode("RC", NULL, yylineno); return RC; }
%%

