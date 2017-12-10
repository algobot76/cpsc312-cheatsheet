% CPSC 312 - 2017 - Assignment 4
% Copyright D. Poole, 2017. Do not distribute.

% Question 1

% deriv(E,X,DE) is true if DE is the derivatibe of E with respect to X
deriv(X,X,1).
deriv(C,X,0) :- atomic(C), dif(C,X).
deriv(A+B,X,DA+DB) :-
    deriv(A,X,DA),
    deriv(B,X,DB).
deriv(A*B,X,A*DB+B*DA) :-
    deriv(A,X,DA),
    deriv(B,X,DB).

% Some optional extras
deriv(sin(E),X,cos(E)*DE) :-
    deriv(E,X,DE).
deriv(cos(E),X,-sin(E)*DE) :-
    deriv(E,X,DE).
deriv(exp(E),X,exp(E)*DE) :-
    deriv(E,X,DE).

%?- deriv(7+3*x, x, D).
%?- deriv(x+3*x+6*xy, x, D).
%?- deriv(7+3*x+6*x*y, x, D).
%?- deriv(x+3*x+6*x*y+ 11*x*x, x, D).
%?- deriv(x+3*x+6*x*y+ 11*x*x*y*y, x, D).
% And even multi-variate analysis:
%?- deriv(x+3*x+6*x*y+ 11*x*x + 18*y*y, x, Dx), deriv(Dx,y,Dxy).
%?- deriv(x+3*x+6*x*y+ 11*x*x*y*y, x, Dx), deriv(Dx,y,Dxy).



%simplify(Exp, Exp2) is true if expression Exp simplifies to Exp2
simplify(X,X) :-
    atomic(X).
simplify((A+B),V) :-
    simplify(A, VA),
    simplify(B, VB),
    simp_vals(VA+VB, V).
simplify((A*B),V) :-
    simplify(A, VA),
    simplify(B, VB),
    simp_vals(VA*VB, V).

%simplify_vals(Exp, Exp2) is true if expression Exp simplifies to Exp2,
% where the arguments to Exp have already been simplified
simp_vals(0+V,V).
simp_vals(V+0,V).
simp_vals(A+B,AB) :-
    number(A),number(B),
    AB is A+B.
simp_vals(A+B,A+B).
simp_vals(0*_,0).
simp_vals(_*0,0).
simp_vals(V*1,V).
simp_vals(1*V,V).
simp_vals(A*B,AB) :-
    number(A),number(B),
    AB is A*B.
simp_vals(A*B,A*B).


% try:
%?- simplify(y*1+(0*x + x*0),E).
%?- simplify(y*(2*10+3),E).
%?- simplify(1+ (3*1+x*0)+ (6*x*0+y* (6*1+x*0))+ (11*x*1+x* (11*1+x*0)), E).
%?- deriv(x+3*x+6*x*y+ 11*x*x + 18*y*y, x, Dx), deriv(Dx,y,Dxy), simplify(Dxy,Sol).
%?- deriv(x+3*x+6*x*y+ 11*x*x*y*y, x, Dx), deriv(Dx,y,Dxy), simplify(Dxy,Sol).


% Question 2

% for testing, here is a definition of the colour of numbers
red(E) :- E < 10.
white(10).
blue(E) :- E>10.

% dutch_flag(L,D) is true if D conatins the elements of L where,
% the red elements are before the white elements, which are before the blue elements.

% dutch flag with difference lists
dutch_flag_dl(L,R):-
    partn_dl(L,R,W,W,B,B,[]).

%partn_dl(L,R1,R2,W1,W2,B1,B2) is true when
%  R1-R2 contains elements of L that are red
%  W1-W2 contains elements of L that are white
%  B1-B2 contains elements of L that are blue
partn_dl([],R,R,W,W,B,B).
partn_dl([H|T],[H|R1],R2,W1,W2,B1,B2) :-
    red(H),
    partn_dl(T,R1,R2,W1,W2,B1,B2).
partn_dl([H|T],R1,R2,[H|W1],W2,B1,B2) :-
    white(H),
    partn_dl(T,R1,R2,W1,W2,B1,B2).
partn_dl([H|T],R1,R2,W1,W2,[H|B1],B2) :-
    blue(H),
    partn_dl(T,R1,R2,W1,W2,B1,B2).

% Try:
%:- dutch_flag_dl([4,9,17,3,88,10,33,0],D).

% Note: this could be made simpler by noticing that B2 is always [] and so can be removed.
% This simplication is equivalent to treating B as a regular (not difference) list.
% But it makes the predicate less flexible.


% reversing dutch flag with difference lists

% rev_dutch_flag(L,D) is true if D conatins the elements of L where,
% the red elements are before the white elements, which are before the blue elements.
% the elements in each colour group are in reverse order than they are in L
rev_dutch_flag_dl(L,R):-
    rev_partn_dl(L,R,W,W,B,B,[]).

%rev_partn_dl(L,R1,R2,W1,W2,B1,B2) is true when
%  R1-R2 contains elements of L that are red in reverse order
%  W1-W2 contains elements of L that are white in reverse order
%  B1-B2 contains elements of L that are blue in reverse order
rev_partn_dl([],R,R,W,W,B,B).
rev_partn_dl([H|T],R1,R2,W1,W2,B1,B2) :-
    red(H),
    rev_partn_dl(T,R1,[H|R2],W1,W2,B1,B2).
rev_partn_dl([H|T],R1,R2,W1,W2,B1,B2) :-
    white(H),
    rev_partn_dl(T,R1,R2,W1,[H|W2],B1,B2).
rev_partn_dl([H|T],R1,R2,W1,W2,B1,B2) :-
    blue(H),
    rev_partn_dl(T,R1,R2,W1,W2,B1,[H|B2]).

% Try:
%:- rev_dutch_flag_dl([4,9,17,3,88,10,33,0],D).
