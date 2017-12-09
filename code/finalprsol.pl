% CPSC 312 2017 - Practice Questions for the final
%%%%%%%%%%%%------ Fun in Prolog

% def(F,A,FA) function F on argument A returns FA
def(sq,X,X2) :- X2 is X*X.
def(plus,X,plus(X)).
def(plus(X),Y,Z) :- Z is X+Y.
def(gt,X,gt(X)).     % gt(X) is \Y -> X>Y
def(gt(X),Y,true) :- X>Y.
def(gt(X),Y,false) :- X =< Y.

% eval(E,V) is true if expression E evaluates to V
% this uses square brackets as parentheses, values separated by commas
eval(N,N) :- number(N).
eval([V],V).
eval([P,A|R],V) :-
    eval(A,AV),
    def(P,AV,R1),
    eval([R1|R],V).

% eval([sq,[plus,3,7]],V).


% mapWhile(F,P,[X1,X2,...,Xn]) = [f X1,f X2,...,f Xk]
% where k is the largest index such that P Xi is true for all i=<k
mapWhile(_,_,[],[]).
mapWhile(_,P,[H|_],[]) :- eval([P,H],false).
mapWhile(F,P,[H|T],[FH|R]) :-
    eval([P,H],true),
    eval([F,H],FH),
    mapWhile(F,P,T,R).

% mapWhile(plus(20),gt(10),[9,8,4,1,55,7,8,1,33],R).
% R = [29, 28, 24, 21] 

%%%%%%%%%%%% Question 4

wff(A,B) :- terminal(A,Z), binop(Z,Y), wff(Y,B).
wff(A,B) :- unop(A,Z), wff(Z,B).
wff(A,B) :- terminal(A,B).

binop([&|T],T).
binop([or|T],T).
unop([not|T],T).

terminal([Term|T],T) :- term(Term).

term(p).
term(q).
term(r).

% wff([p,&,not,q,or,r],V).
/*
yes(V) :- wff([p,&,not,q,or,r],V).
yes(V) :- terminal([p,&,not,q,or,r],Z1), binop(Z1,Y1), wff(Y1,V).
yes(V) :- term(p), binop([&,not,q,or,r],Y1), wff(Y1,V).
yes(V) :- binop([&,not,q,or,r],Y1), wff(Y1,V).
yes(V) :- wff([not,q,or,r],V).
yes(V) :- unop([not,q,or,r],Z2),wff(Z2,V).
yes(V) :- wff([q,or,r],V).
yes(V) :- terminal([q,or,r],Z3), binop(Z3,Y3), wff(Y3,V).
yes(V) :- term(q), binop([or,r],Y3), wff(Y3,V).
yes(V) :- binop([or,r],Y3), wff(Y3,V).
yes(V) :- wff([r],V).
yes(V) :- terminal([r],V).
yes([]) :- term(r).
yes([]).

Other answers:
V = [or, r] ;
V = [&, not, q, or, r].

*/

wff_r(A,B,R) :- terminal_r(A,Z,T), binop_r(Z,Y,T,BR,R), wff_r(Y,B,BR).
wff_r(A,B,R) :- unop_r(A,Z,BV,R), wff_r(Z,B,BV).
wff_r(A,B,R) :- terminal_r(A,B,R).

binop_r([&|T],T,X,Y,and(X,Y)).
binop_r([or|T],T,X,Y,or(X,Y)).
unop_r([not|T],T,TV,not(TV)).

terminal_r([Term|T],T,Term) :- term(Term).

%wff_r([p,&,q,or,r],E,T).
