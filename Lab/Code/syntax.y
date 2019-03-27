%locations
%define parse.error verbose
%define parse.lac none  
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "tree.h"
    #include "lex.yy.c"
    extern Node* tree;
    extern int yylineno;
    int bErrorFree = 1;
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
Program : ExtDefList {
        $$ = initNode("Program", " ", @$.first_line);
        addChild($$, $1);
        tree = $$;
    }
    ;
ExtDefList : ExtDef ExtDefList {
        $$ = initNode("ExtDefList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | /* empty */ { $$ = NULL; }
    ;
ExtDef : Specifier ExtDecList SEMI {
        $$ = initNode("ExtDef", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Specifier SEMI {
        $$ = initNode("ExtDef", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | Specifier FunDec CompSt {
        $$ = initNode("ExtDef", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;
ExtDecList : VarDec {
        $$ = initNode("ExtDecList", " ", @$.first_line);
        addChild($$, $1);
    }
    | VarDec COMMA ExtDecList {
        $$ = initNode("ExtDecList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;

/* Specifiers */
Specifier : TYPE {
        $$ = initNode("Specifier", " ", @$.first_line);
        addChild($$, $1);
    }
    | StructSpecifier {
        $$ = initNode("Specifier", " ", @$.first_line);
        addChild($$, $1);
    }
    ;
StructSpecifier : STRUCT OptTag LC DefList RC {
        $$ = initNode("StructSpecifier", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
        addChild($$, $5);
    }
    | STRUCT Tag {
        $$ = initNode("StructSpecifier", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    ;
OptTag : ID {
        $$ = initNode("OptTag", " ", @$.first_line);
        addChild($$, $1);
    }
    | /* empty */ { $$ = NULL; }
    ;
Tag : ID {
        $$ = initNode("Tag", " ", @$.first_line);
        addChild($$, $1);
    }
    ;

/* Declarators */
VarDec : ID {
        $$ = initNode("VarDec", " ", @$.first_line);
        addChild($$, $1);
    }
    | VarDec LB INT RB {
        $$ = initNode("VarDec", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
    }
    ;
FunDec : ID LP VarList RP {
        $$ = initNode("FunDec", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
    }
    | ID LP RP {
        $$ = initNode("FunDec", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;
VarList : ParamDec COMMA VarList {
        $$ = initNode("VarList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | ID LP RP {
        $$ = initNode("VarList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;
ParamDec : Specifier VarDec {
        $$ = initNode("ParamDec", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    ;

/* Statements */
CompSt : LC DefList StmtList RC {
        $$ = initNode("CompSt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
		addChild($$, $4);
    }
    | LC error RC {
        bErrorFree = 0;
        //printf("1\n");
    }
    ;
StmtList : Stmt StmtList {
        $$ = initNode("StmtList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | /* empty */ { $$ = NULL; }
    ;
Stmt : Exp SEMI {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | CompSt {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
    }
    | RETURN Exp SEMI {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | IF LP Exp RP Stmt %prec LOWER_THAN_ELSE {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
        addChild($$, $5);
    }
    | IF LP Exp RP Stmt ELSE Stmt {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
        addChild($$, $5);
        addChild($$, $6);
        addChild($$, $7);
    } 
    | WHILE LP Exp RP Stmt {
        $$ = initNode("Stmt", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
        addChild($$, $5);
    }
    | error SEMI {
        bErrorFree = 0;
        //printf("2\n");
    }
    | IF error ELSE {
        bErrorFree = 0;
    }
    ;

/* Local Definitions */
DefList : Def DefList {
        $$ = initNode("DefList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | /* empty */ { $$ = NULL; }
    ;
Def : Specifier DecList SEMI {
        $$ = initNode("Def", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;
DecList : Dec {
        $$ = initNode("DecList", " ", @$.first_line);
        addChild($$, $1);
    }
    | Dec COMMA DecList {
        $$ = initNode("DecList", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;
Dec : VarDec {
        $$ = initNode("Dec", " ", @$.first_line);
        addChild($$, $1);
    }
    | VarDec ASSIGNOP Exp {
        $$ = initNode("Dec", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    ;

/* Expressions */
Exp : Exp ASSIGNOP Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp AND Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp OR Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp RELOP Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp PLUS Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp MINUS Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp STAR Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp DIV Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | LP Exp RP {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | MINUS Exp %prec UMINUS {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | NOT Exp {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
    }
    | ID LP Args RP {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
    }
    | ID LP RP {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp LB Exp RB {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
        addChild($$, $4);
    }
    | Exp DOT ID {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | ID {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
    }
    | INT {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
    }
    | FLOAT {
        $$ = initNode("Exp", " ", @$.first_line);
        addChild($$, $1);
    }
    | LP error RP {
        bErrorFree = 0;
    }
    ;

Args : Exp COMMA Args {
        $$ = initNode("Args", " ", @$.first_line);
        addChild($$, $1);
        addChild($$, $2);
        addChild($$, $3);
    }
    | Exp {
        $$ = initNode("Args", " ", @$.first_line);
        addChild($$, $1);
    }
    ;

%%
void yyerror(char* msg){
    fprintf(stderr, "Error type B at Line %d: %s\n", yylineno, msg + 14);
}