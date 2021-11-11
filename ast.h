#ifndef _AST_H_
#define _AST_H_

#include <list>
#include <string>

using namespace std;

class Expr{
    public:
        virtual float evaluate()=0;
};

typedef list<Expr *> ExprList;

class CallExpr:public Expr{
    public:
        CallExpr(string name){
            this->name=name;
        }
        string name;
        float evaluate();
};

class CallMethExpr:public Expr{
    public:
        CallMethExpr(string name){
            this->name=name;
        }
        string name;
        float evaluate();
};

class BinaryExpr: public Expr{
    public:
        BinaryExpr(Expr* exp1, Expr* exp2){
            this->exp1= exp1;
            this->exp2= exp2;
        }
        Expr* exp1;
        Expr* exp2;
};
class AssigExpr: public Expr{
    public:
        AssigExpr(string name, Expr* exp){
            this->name=name;
            this->exp=exp;
        }
        string name;
        Expr* exp;
        float evaluate();
};

class AssigMethExpr: public Expr{
    public:
        AssigMethExpr(string name, Expr* exp){
            this->name=name;
            this->exp=exp;
        }
        string name;
        Expr* exp;
        float evaluate();
};

class GreaterExpr: public BinaryExpr{
    public:
        GreaterExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};
class LessExpr: public BinaryExpr{
    public:
        LessExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};
class AddExpr: public BinaryExpr{
    public:
        AddExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};

class SubExpr: public BinaryExpr{
    public:
        SubExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};

class MulExpr: public BinaryExpr{
    public:
        MulExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};

class DivExpr: public BinaryExpr{
    public:
        DivExpr(Expr* exp1, Expr* exp2):BinaryExpr(exp1,exp2){

        }
        float evaluate();
};

class NumExpr: public Expr{
    public:
        NumExpr(float num){
            this-> num = num;
        }
        float num;
        float evaluate();
};

#endif