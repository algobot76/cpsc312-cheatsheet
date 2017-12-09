% CPSC 312 2017 - Midterm #2 - Variant #A (you can tell which variant
% you did from question 1)

% Question 1

% (a)  A URI is a constant that has a well-defined and standard
% meaning. It is useful because everyone who uses the constant means the
% same thing.  (It does not imply that there is a unique URI for each
% thing (the unique names assumption); there can be multiple URIs for
% the same thing.)

% (b) Sam is a student.
% Sam took the course cs312.

% (c)  The most important part is you need to create a new individual
% for the midterm.
prop(cs3121012017m2,course,cs312).
prop(cs3121012017m2,section,101).
prop(cs3121012017m2,year,2017).
prop(cs3121012017m2,month,october).
prop(cs3121012017m2,day,20).

% Question 2

% yes(R,I,C) :- mp([the,capital,of chile],R,I,C,[]).
% yes(R,I,C) :- reln([the,capital,of,chile],L11,I,O12,C,C12), noun(L11,R,O12,C12,[]).
% yes(R,I,[capital(O12,I)|C12]) :- noun([chile],R,O12,C12,[]).
% yes([],I,[capital(chile,I)]) :- country(chile).
% yes([],I,[capital(chile,I)]) :-.

% Answer is R=[], C=[capital(chile,I)]

% Question 3

% Tree to list (with append)
tr2lst(empty,[]).
tr2lst(btree(LT,Root,RT),L):-
    tr2lst(LT,L0),
    tr2lst(RT,L1),
    append(L0,[Root|L1],L).

% Tree to list (without append using difference lists)
tr2lst_dl(T,L) :-
    tree_to_list(T,L,[]).

tree_to_list(empty, L, L).
tree_to_list(btree(LT,Root,RT),L0,L2):-
    tree_to_list(LT,L0,[Root|L1]),
    tree_to_list(RT,L1,L2).


% Question 4

% (a) { W / h(b, Z), X / b,  Y / f(h(b, Z))}

% (b) does not unify because A would have to be 'fun' and [course, dream]

% (v) {A / [p, r, o, l, o, g], B / [o, g], C / [o, l, o, g]}.

% Question 5

% 3rd clause should combine different list in other order

% Old:

flatr([[A|B]|T],R0,R2) :-
    flatr([A|B],R0,R1),
    flatr(T,R1,R2).

% Should be:
flatr([[A|B]|T],R0,R2) :-
    flatr([A|B],R1,R2),
    flatr(T,R0,R1).

% Note that just changing the order of the clauses in the body does not help!
