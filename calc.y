%code requires{
    #include "ast.h"
}
%{

    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

    #define YYERROR_VERBOSE 1
%}

%union{
    float float_t;
    char * string_t;
    Expr * expr_t;
    ExprList *expr_list;
}

%token EOL
%token ADD SUB MUL DIV THEN WHILE DO DONE LET
%token<float_t> NUMBER
%token<string_t> STRING

%type<expr_t> exp factor term
%type<expr_list> exprlist
%type<string_t>params
%%
start: exprlist{
        list<Expr*>::iterator it= $1->begin();
        while(it !=$1->end()){
            printf("semantoc result: %f \n",(*it)->evaluate());
            it++;
        }
    }
    | asignation 
    ;

asignation: asignation LET STRING '=' exp EOL {printf("let %s = \n",$3);}
    |LET STRING '=' exp EOL {printf("let %s = \n",$2);}
    |asignation LET STRING '('params')' '=' EOL{printf("let %s () = %d\n",$3,$5);}
    |LET STRING '('params')' '=' EOL{printf("let %s () = %d\n",$2,$4);}
    ;

params:params STRING {$$=$2;}
    |params','STRING {$$=$3;}
    | STRING
    |
    ;

exprlist: exp EOL{$$ = new ExprList; $$->push_back($1);}
    | exprlist exp EOL { $$= $1; $$->push_back($2);}
    ;

exp: exp ADD factor {$$ = new AddExpr($1,$3); }
    | exp SUB factor {$$ = new SubExpr($1,$3);}
    | factor { $$ = $1; }
    ;

factor: factor MUL term { $$ = new MulExpr($1,$3); }
    | factor DIV term { $$ = new DivExpr($1,$3); }
    | term { $$ = $1; }
    ;

term: NUMBER { $$ = new NumExpr($1); }
    ;
%%
