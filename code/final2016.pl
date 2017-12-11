% CPSC 312 -- Prolog Code from the 2016 Final
% Copyright 2017 - not for redistribution

% Question 1

foo([],Y,Y).
foo([A|B],C,[A|D]) :- foo(C,B,D).
% foo([1,3], [9,7,4], A).

% Powerset
% Straight Recusion
powerset([],[[]]).
powerset([H|T], R) :-
    powerset(T,PT),
    applytoeach(H,PT,R).
applytoeach(_,[],[]).
applytoeach(H,[E|R],[[H|E],E|PR]) :-
    applytoeach(H,R,PR).

% With an accumulator
powset([],[[]]).
powset([H|T],R) :-
    powset(T,TP),
    add_to_each(H,TP,TP,R).
add_to_each(_,[],TP,TP).
add_to_each(H,[L|R],TP,[[H|L]|A]) :-
    add_to_each(H,R,TP,A).

% With an accumulator, alternative answer
powset2([],[[]]).
powset2([H|T],R) :-
    powset2(T,TP),
    add_to_each2(H,TP,TP,R).
add_to_each2(_,[],TP,TP).
add_to_each2(H,[L|R],TP,A) :-
    add_to_each2(H,R,[[H|L]|TP],A).

% powerset([1,2,3],R).
% powset([1,2,3],R).
% powset2([1,2,3],R).


%  Question 2

split([],[],[]).
split([X],[X],[]).
split([X,Y|R],[X|R1],[Y|R2]) :- split(R,R1,R2).

merge([],L,L).
merge(L,[],L) :- dif(L,[]).
merge([A|L1],[B|L2],[A|R]) :-
    A =< B,
    merge(L1,[B|L2],R).
merge([A|L1],[B|L2],[B|R]) :-
    A > B,
    merge([A|L1],L2,R).

msort([],[]).
msort([A],[A]).
msort([A,B|L],S) :-
    split([A,B|L],L1,L2),
    msort(L1,S1),
    msort(L2,S2),
    merge(S1,S2,S).

% msort([1,6,4,3,5,8,3,5,7,9,11,0],S).

% Question 3
translate([],[],_).
translate([X|Xs],[Y|Ys],Dict) :-
    member((X,Y),Dict),
    translate(Xs,Ys,Dict).

% Latin = [wir, betreten, feuer, trunken, himmlische, dein,heiligtum], English = [we, enter, 'drunk with', fire, 'heavenly being', your, sanctuary], translate(Latin, English, Dictionary), translate([wir, trunken, feuer], T1, Dictionary), translate(T2, [your, heavenly, being],Dictionary).
ans(T1,T2,Dictionary) :-
German = [wir, betreten, feuer, trunken, himmlische, dein,
heiligtum], English = [we, enter, 'drunk with', fire, 'heavenly
being', your, sanctuary], translate(German, English, Dictionary),
translate([wir, trunken, feuer], T1, Dictionary),
translate(T2, [your, heavenly, being],Dictionary).

% ans(T1,T2,Dictionary)

% It would probably be better to parse the sentence, create a representation of the meaning of a sentence and use a dictionary to translate to the other language.

% Question 4

martix(transpose(M),I,J,V) :-
    matrix(M,J,I,V).

