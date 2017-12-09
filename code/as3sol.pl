% CPSC 312 2017 - Assignment 3 Solution

% Question One

% am(H,M) where H is an integer in [1,12] and M is integer in range [0,59]
% denotes the function H:M am.
% For example am(5,33) denotes 5:33am. am(12,30) denotes half-past midnight.
% am(11,59) denotes the time one minute before noon.

% pm(H,M) denotes the time H:M after noon.

% Note that midnight is am(12,00) and noon is pm(12,00).

% before(T1,T2) is true if time T1 is before time T2 in the same day.
before(am(_,_), pm(_,_)).
before(am(12,_),am(H2,_)) :-
   H2<12.
before(am(H1,_),am(H2,_)) :-
   H1<H2,
   H2<12.
before(am(H,M1),am(H,M2)) :-
   M1<M2.
before(pm(12,_),pm(H2,_)) :-
   H2<12.
before(pm(H1,_),pm(H2,_)) :-
   H1<H2,
   H2<12.
before(pm(H,M1),pm(H,M2)) :-
    M1<M2.

% test cases:
%?- before(am(8,30),am(9,10)).
%?- before(am(9,10),am(8,30)).
%?- before(am(12,10),am(8,30)).
%?- before(am(12,10),am(12,05)).
%?- before(am(9,10),pm(8,30)).


% Question 2

% del1(E, L, R) is true when R is a list with the same elements as
% list L (in the same order) but with one instance of E removed
del1(E,[E|T],T).
del1(E,[H|T],[H|R]) :-
    del1(E,T,R).


%?- del1(a,[a,v,a,t,a,r],R).
%?- del1(2,L,[a,b,c,a]).


% Question 3

% lookup(X,Env,V)  is true when X has value V in Env.
lookup(X,Env,V) :-
    member(val(X,V), Env).

% try:
%?- lookup(b,[val(aa,3), val(b,7), val(dd,23)],V).

%eval(Exp, Env, V) is true if expression Exp evaluates to V given environment Env
eval(X,Env,V) :-
    lookup(X,Env,V).
eval(N,_,N) :-
    number(N).
eval((A+B),Env,V) :-
    eval(A,Env,VA),
    eval(B,Env,VB),
    V is VA+VB.
eval((A*B),Env,V) :-
    eval(A,Env,VA),
    eval(B,Env,VB),
    V is VA*VB.

% try:
% eval(aa*aa+b*11, [val(aa,3), val(b,7), val(dd,23)], V).

% Question 4
% Once you worked out what was going on, this should have been easier than the previous assignments. 
