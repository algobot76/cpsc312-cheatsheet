% CPSC 312 2017, Binary trees

% Tree to list (with append)
tolist(empty,[]).
tolist(node(LT,Val,RT),L):-
    tolist(LT,L0),
    tolist(RT,L1),
    append(L0,[Val|L1],L).

% Test case:
% tolist(node(node(empty, 2, node(empty, 4, empty)), 5, node(empty, 8, empty)),L).






% Tree to list (without append)
tolist_dl(T,L) :-
    tolist3(T,L,[]).

% tolist3(T, L1, L2) is true if L1-L2 is preorder list of values in tree T
tolist3(empty, L, L).
tolist3(node(LT,Val,RT),L0,L2):-
    tolist3(LT,L0,[Val|L1]),
    tolist3(RT,L1,L2).

% tolist_dl(node(node(empty, 2, node(empty, 4, empty)), 5, node(empty, 8, empty)),L).
