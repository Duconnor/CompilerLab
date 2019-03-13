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
\n {}
{STRUCT} { printf("STRUCT: %s\n", yytext); }
{RETURN} { printf("RETURN: %s\n", yytext); }
{IF} { printf("IF: %s\n", yytext); }
{ELSE} { printf("ELSE: %s\n", yytext); }
{WHILE} { printf("WHILE: %s\n", yytext); }
{TYPE} { printf("TYPE: %s\n", yytext); }
{SCIFLOAT} { printf("SCI: %s\n", yytext); }
{FLOAT} { printf("FLOAT: %s\n", yytext); }
{INT} { printf("INT: %s\n", yytext); }
{OCT} { printf("OCT: %s\n", yytext);}
{HEX} { printf("HEX: %s\n", yytext); }
{ID} { printf("ID: %s\n", yytext); }
{SEMI} { printf("SEMI: %s\n", yytext); }
{COMMA} { printf("COMMA: %s\n", yytext); }
{ASSIGNOP} { printf("ASSIGNOP: %s\n", yytext); }
{RELOP} { printf("RELOP: %s\n", yytext); }
{PLUS} { printf("PLUS: %s\n", yytext); }
{MINUS} { printf("MINUS: %s\n", yytext); }
{STAR} { printf("STAR: %s\n", yytext); }
{DIV} { printf("DIV: %s\n", yytext); }
{AND} { printf("AND: %s\n", yytext); }
{OR} { printf("OR: %s\n", yytext); }
{NOT} { printf("NOT: %s\n", yytext); }
{LP} { printf("LP: %s\n", yytext); }
{RP} { printf("RP: %s\n", yytext); }
{LB} { printf("LB: %s\n", yytext); }
{RB} { printf("RB: %s\n", yytext); }
{LC} { printf("LC: %s\n", yytext); }
{RC} { printf("RC: %s\n", yytext); }
%%

