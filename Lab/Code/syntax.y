%locations
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "tree.h"
    #include "lex.yy.c"
    extern Node* GrammarTree;
%}

/* declared types */
%union{
    Node* type_node;
}

/* declared tokens */
%token <type_node> INT FLOAT ID SEMI COMMA ASSIGNOP RELOP PLUS MINUS STAR DIV AND OR DOT NOT TYPE LP RP LB RB LC RC STRUCT RETURN IF ELSE WHILE

/* declared non-terminals */
%type <type_node> Program ExtDefList ExtDef ExtDecList Specifier StructSpecifier OptTag Tag VarDec FunDec VarList ParamDec CompSt StmtList Stmt DefList Def DecList Dec Exp Args

/* priority & associativity */
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT UMINUS
%left DOT LB RB LP RP
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

// Pay attention to MINUS and UMINUS!
// Reference: Section-5.4 in http://www.gnu.org/software/bison/manual/html_node/Contextual-Precedence.html

%%
/* High-level Definitions */
Program : ExtDefList {}
    ;
ExtDefList : ExtDef ExtDefList {}
    | /* empty */ {}
    ;
ExtDef : Specifier ExtDecList SEMI {}
    | Specifier SEMI {}
    | Specifier FunDec CompSt {}
    ;
ExtDecList : VarDec {}
    | VarDec COMMA ExtDecList {}
    ;

/* Specifiers */
Specifier : TYPE {}
    | StructSpecifier {}
    ;
StructSpecifier : STRUCT OptTag LC DefList RC {}
    | STRUCT Tag {}
    ;
OptTag : ID {}
    | /* empty */ {}
    ;
Tag : ID {}
    ;

/* Declarators */
VarDec : ID {}
    | VarDec LB INT RB {}
    ;
FunDec : ID LP VarList RP {}
    | ID LP RP {}
    ;
VarList : ParamDec COMMA VarList {}
    | ID LP RP {}
    ;
ParamDec : Specifier VarDec {}
    ;

/* Statements */
CompSt : LC DefList StmtList RC {}
    ;
StmtList : Stmt StmtList {}
    | /* empty */ {}
    ;
Stmt : Exp Stmt {}
    | CompSt {}
    | RETURN Exp SEMI {}
    | IF LP Exp RP Stmt %prec LOWER_THAN_ELSE {}
    | IF LP Exp RP Stmt ELSE Stmt {} 
    | WHILE LP Exp RP Stmt {}
    ;

/* Local Definitions */
DefList : Def DefList {}
    | /* empty */ {}
    ;
Def : Specifier DecList SEMI {}
    ;
DecList : Dec {}
    | Dec COMMA DecList {}
    ;
Dec : VarDec {}
    | VarDec ASSIGNOP Exp {}
    ;

/* Expressions */
Exp : Exp ASSIGNOP Exp {}
    | Exp AND Exp {}
    | Exp OR Exp {}
    | Exp RELOP Exp {}
    | Exp PLUS Exp {}
    | Exp MINUS Exp {}
    | Exp STAR Exp {}
    | Exp DIV Exp {}
    | LP Exp RP {}
    | MINUS Exp %prec UMINUS {}
    | NOT Exp {}
    | ID LP Args RP {}
    | ID LP RP {}
    | Exp LB Exp RB {}
    | Exp DOT ID {}
    | ID {}
    | INT {}
    | FLOAT {}
    ;

Args : Exp COMMA Args {}
    | Exp {}
    ;

%%
