% shuffle(L1,L2,L3) is true if L3 is an interleaving of the elements of L1 and L2
shuffle(L,[],L).
shuffle([],L,L) :- dif(L,[]).
shuffle([H|T],L,[H|R]) :- shuffle(T,L,R), dif(L,[]).
shuffle(T,[H|L],[H|R]) :- shuffle(T,L,R), dif(T,[]).
