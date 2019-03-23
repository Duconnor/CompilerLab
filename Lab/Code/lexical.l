%option yylineno
%{
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
{STRUCT} { return STRUCT; }
{RETURN} { return RETURN; }
{IF} { return IF; }
{ELSE} { return ELSE; }
{WHILE} { return WHILE; }
{TYPE} { return TYPE; }
	/*{SCIFLOAT} { printf("SCI: %s\n", yytext); }*/
{FLOAT} { return FLOAT; }
{INT} { return INT; }
{OCT} { return FLOAT; }
{HEX} { return FLOAT; }
{ID} { return ID; }
{SEMI} { return SEMI; }
{COMMA} { return COMMA; }
{ASSIGNOP} { return ASSIGNOP; }
{RELOP} { return RELOP; }
{PLUS} { return PLUS; }
{MINUS} { return MINUS; }
{STAR} { return STAR; }
{DIV} { return DIV; }
{AND} { return AND; }
{OR} { return OR; }
{NOT} { return NOT; }
{LP} { return LP; }
{RP} { return RP; }
{LB} { return LB; }
{RB} { return RB; }
{LC} { return LC; }
{RC} { return RC; }
%%

