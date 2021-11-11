#include "ast.h"
#include <map>
#include <list>
#include <iostream>


map<string,Expr*> globalVariables;
map<string,Expr*> methods;

float NumExpr::evaluate(){
    return this->num;
}
float AddExpr::evaluate(){
    return this->exp1->evaluate() + this->exp2->evaluate();
}
float SubExpr::evaluate(){
    return this->exp1->evaluate() - this->exp2->evaluate();
}
float MulExpr::evaluate(){
    return this->exp1->evaluate() * this->exp2->evaluate();
}
float DivExpr::evaluate(){
    return this->exp1->evaluate() / this->exp2->evaluate();
}