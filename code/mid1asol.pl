% CPSC 312 - Midterm #1 2017 Solution A
%  This is the version where question 1 is about 'r'.

% Question 1
% (a)
%         r _________________________________
%           |     _______       ______       |
%         __|_____|      |_____|      |______|____
%           |     |   s  |     |   t  |  |   |
%           |   __|      |_____|      |__|_  |
%           |  |  |______|     |______|  | | |
%           |  |  _______                | | |
%           |  |__|      |_______________| | |
%           |     |  u   |                 | |
%        ___|_____|      |_________________|_|_____
%           |     |______|                   |
%           |________________________________|


% (b) s exists
% (c) call u

% Question 2
% (a) r :- q,z
% (b) q.
% (c) yes :- u,p,t.
% (d) there are no clauses for n

% Question 3
%  emu, on_plane, abfly, bird, \+ plane_broken,
%  \+ flies_autonomously, flies, \+ injured, \+penguin

% Question 4
next_day(ce(Y,M,D),ce(Y,M,D1)) :-
    number_days(M,ND),
    D < ND,
    D1 is D+1.
next_day(ce(Y,M,D),ce(Y,M1,1)) :-
    number_days(M,D),
    M < 12,
    M1 is M+1.
next_day(ce(Y,12,31),ce(Y1,1,1)) :-
    Y1 is Y+1.
 

number_days(M,31) :- member(M,[1,3,5,7,8,10,12]).
number_days(2,28).
number_days(M,30) :- member(M,[4,6,9,11]).

%?- next_day(ce(2017,12,30),D1).
%?- next_day(ce(2017,12,30),D1), next_day(D1,D2).

% Question 5

replace(_, _, [], []).
replace(Old, New, [Old | L], [New | R]) :-
    replace(Old, New, L, R).
replace(Old, New, [Head | L], [Head | R]) :-
    dif(Old,Head),
    replace(Old, New, L, R).

%?- replace(prolog,fun,L,[fun,is,fun]).
% L = [prolog, is, prolog] ;
% L = [prolog, is, fun] ;
% L = [fun, is, prolog] ;
% L = [fun, is, fun] ;
% false.
