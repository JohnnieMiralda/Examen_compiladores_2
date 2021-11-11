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

%type<expr_t> exp expp factor term asignation params
%type<expr_list> exprlist
%%
start: exprlist{
        list<Expr*>::iterator it= $1->begin();
        while(it !=$1->end()){
            printf("semantoc result: %f \n",(*it)->evaluate());
            it++;
        }
    }
    ;

asignation:LET STRING '=' expp {
        Expr* asig=new AssigExpr($2,$4);
        if(asig->evaluate()==1){
            printf("Variable %s declarada\n",$2);
        }else{
            printf("Variable %s ya existe\n",$2);
        }
        $$= asig;
        }
    |LET STRING '('params')' '=' expp {
        Expr* asig=new AssigMethExpr($2,$7);
        if(asig->evaluate()==1){
            printf("Method %s declarada\n",$2);
        }else{
            printf("Method %s ya existe\n",$2);
        }
        $$= asig;
        }
    ;

params:params STRING {
        Expr* asig=new AssigExpr($2,NULL);
        if(asig->evaluate()==1){
            printf("Variable %s declarada\n",$2);
        }else{
            printf("Variable %s ya existe\n",$2);
        }
        $$= asig;
        }
    |params','STRING {{
        Expr* asig=new AssigExpr($3,NULL);
        if(asig->evaluate()==1){
            printf("Variable %s declarada\n",$3);
        }else{
            printf("Variable %s ya existe\n",$3);
        }
        $$= asig;
        }}
    | STRING{
        Expr* asig=new AssigExpr($1,NULL);
        if(asig->evaluate()==1){
            printf("Variable %s declarada\n",$1);
        }else{
            printf("Variable %s ya existe\n",$1);
        }
        $$= asig;
        }
    |
    ;

exprlist: expp EOL{$$ = new ExprList; $$->push_back($1);}
    | exprlist expp EOL { $$= $1; $$->push_back($2);}
    | exprlist asignation EOL { $$= $1; $$->push_back($2);}
    | asignation EOL{$$ = new ExprList; $$->push_back($1);}
    ;

expp: expp '<' exp {$$ = new LessExpr($1,$3); }
    | expp '>' exp {$$ = new GreaterExpr($1,$3); }
    | exp {$$=$1;}

exp: exp ADD factor {$$ = new AddExpr($1,$3); }
    | exp SUB factor {$$ = new SubExpr($1,$3);}
    | factor { $$ = $1; }
    ;

factor: factor MUL term { $$ = new MulExpr($1,$3); }
    | factor DIV term { $$ = new DivExpr($1,$3); }
    | term { $$ = $1; }
    ;

term: NUMBER { $$ = new NumExpr($1); }
    | STRING '('params ')' { $$ = new CallMethExpr($1);}
    | STRING { $$ = new CallExpr($1);}
    ;
%%
