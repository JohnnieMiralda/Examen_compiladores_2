%option noyywrap
%option yylineno

%{
    #include "tokens.h"
%}

%%
"+" { return ADD; }
"=" { return '='; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }
";" { return ';'; }
">" { return '>'; }
"<" { return '<'; }
"let" { return LET; }
"while" { return WHILE; }
"do" { return DO; }
"done" { return DONE; }
[0-9]+"."[0-9]+ { yylval.float_t = atof(yytext); return NUMBER; }
[0-9]+ { yylval.float_t = atof(yytext); return NUMBER; }
[a-zA-Z]+[a-zA-Z0-9]* { yylval.string_t = strdup(yytext); return STRING; }
[\n] { return EOL; }
[ \t] { /* ignorar */ }
. { printf("invalido %c\n", yytext[0]); }
%%