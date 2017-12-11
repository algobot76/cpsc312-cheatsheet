% For fun and profit, here is a translation of all my answers to q3
% into Prolog. In general, explanations and strategies carry between
% the two versions.

% Translation is a good exercise to get good at two languages fast.

% a)

myremoveduplicates_helper([], _, []).
myremoveduplicates_helper([H|T], Duplicates, RecursiveResult) :-
    member(H, Duplicates),
    myremoveduplicates_helper(T, Duplicates, RecursiveResult).
myremoveduplicates_helper([H|T], Duplicates, [H|RecursiveResult]) :-
    \+ member(H, Duplicates),
    myremoveduplicates_helper(T, [H|Duplicates], RecursiveResult).

myremoveduplicates(Lst, Result) :-
    myremoveduplicates_helper(Lst, [], Result).

% b)

myordered_helper([], _).
myordered_helper([H|T], PreviousElement) :-
    PreviousElement < H,
    myordered_helper(T, H).

myordered([]).
myordered([H|T]) :- myordered_helper(T, H).

% c)

myreplace([ToReplace|T], ToReplace, Replacement, [Replacement|RecursiveResult]) :-
    myreplace(T, ToReplace, Replacement, RecursiveResult).
myreplace([H|T], ToReplace, Replacement, [H|RecursiveResult]) :-
    dif(H, ToReplace),
    myreplace(T, ToReplace, Replacement, RecursiveResult).

% d)

myapply_helper([], _, []).
myapply_helper([H|T], Subs, [SubbedH|RecursiveResult]) :-
    member((H,SubbedH), Subs),
    myapply_helper(T, Subs, RecursiveResult).
myapply_helper([H|T], Subs, [H|RecursiveResult]) :-
    \+ member((H,_), Subs),
    myapply_helper(T, Subs, RecursiveResult).

% e)

deln(0, _, Lst, Lst).
deln(N, _, [], []) :- N > 0.
deln(N, E, [E|T], RecursiveResult) :-
    N > 0,
    RecursiveN is N-1,
    deln(RecursiveN, E, T, RecursiveResult).
deln(N, E, [H|T], [H|RecursiveResult]) :-
    N > 0,
    dif(H,E),
    deln(N, E, T, RecursiveResult).

% f)

% This one had me wanting to use Prolog when writing it in
% Haskell, it's a good example of where multiple execution
% paths helps make some problems easier to reason about.

delna_helper(0, _, Lst, Lst).
delna_helper(N, E, [H|T], [H|RecursiveResult]) :-
    N > 0,
    delna_helper(N, E, T, RecursiveResult).
delna_helper(N, E, [E|T], RecursiveResult) :-
    N > 0,
    RecursiveN is N-1,
    delna_helper(RecursiveN, E, T, RecursiveResult).

delna(N, E, Lst, Results) :-
    findall(Result, delna_helper(N, E, Lst, Result), Results).

% g)

% This one took me a solid 20 minutes due to trying several strategies.
% This is an example of a question that ends up being harder than your
% average exam question; you can use it to help stretch your brain.

% as a point of interest, this is also a linear time version

mynthinit_helper(_, _, [], []).
mynthinit_helper(0, RequiredLength, _, []) :- RequiredLength < 0.
mynthinit_helper(RequiredLength, RequiredLength, [_|_], []).
mynthinit_helper(Length, RequiredLength, [H|T], [H|RecursiveResult]) :-
    Length < RequiredLength,
    NextLength is Length+1,
    mynthinit_helper(NextLength, RequiredLength, T, RecursiveResult).

mynthinit(N, Lst, Result) :-
    length(Lst, ListLength),
    RequiredLength is ListLength-N,
    mynthinit_helper(0, RequiredLength, Lst, Result).

