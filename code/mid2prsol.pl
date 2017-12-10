%%% CPSC 312 - 2017 - Practice Midterm #2 - Prolog Solution
%%% Copyright, David Poole, 2017. All rights reserved. Do not redistribute.

%zip(L1,L2,R) that is true if R consists of a list of pairs, such that
% zip([e1,e2,...,ek],[f1,f2,..fn],[(e1,f1),(e2,f2),...,(er,fr)]) where r = min(k,n).

zip([],_,[]).
zip(L,[],[]) :- dif(L,[]).
zip([H1|T1],[H2|T2],[(H1,H2)|R]) :- zip(T1,T2,R).

%?- zip([1,2,3],[a,b,c,d],Z).


% notin(E,L) is true if E is not in list L
notin(_,[]).
notin(E,[H|R]) :-
    dif(E,H),
    notin(E,R).

% apply(L,S,R) is true if list L becomes R according to substitution S
% where a substitution is a list of sub(from,to) terms
apply([],_,[]).
apply([H|L],S,[HR|R]):-
    rep(H,S,HR),
    apply(L,S,R).

% rep(E,S,R) is true if E gets replaced by R according to substitution S
rep(H,[],H).
rep(H,[sub(H,R)|_],R).
rep(H,[sub(H1,_)|S],R) :-
    dif(H,H1),
    rep(H,S,R).

%?- apply([a,b,c,d,e],[sub(a,4), sub(c,3), sub(f,7)],R).
%R=[4,b,3,d,e]
%?- apply([a,b,c,d,e],[sub(a,b), sub(b,a), sub(e,a)],R).
%R=[b,a,c,d,a]

% appla(A,S,R) is true if arithmetic expression A becomes R according to substitution S
appla(A,S,R) :-
    atomic(A),
    rep(A,S,R).
appla((A+B),S,(AR+BR)) :-
    appla(A,S,AR),
    appla(B,S,BR).
appla((A*B),S,(AR*BR)) :-
    appla(A,S,AR),
    appla(B,S,BR).

%?- appla(a+b*c*d+e*c,[sub(a,f), sub(c,3), sub(f,7)],R).
%  Note: appla can be called apply, but then you need to put the clauses together, and it will work for lists mixed with arithmetic expressions.


%  deln(N,E,L,R)  is true when R is the result of removing N instances of E from L.
deln(0,_,[],[]).
deln(N,E,[E|L],R) :-
    N>0,
    N1 is N-1,
    deln(N1,E,L,R).
deln(N,E,[H|L],[H|R]) :-
    deln(N,E,L,R).
% ?- deln(2,a,[a,v,a,t,a,r],R).

% Here is another solution
%  deln_alt(N,E,L,R)  is true when R is the result of removing N instances of E from L.
deln_alt(0,_,R,R).
deln_alt(N,E,[E|L],R) :-
    N>0,
    N1 is N-1,
    deln_alt(N1,E,L,R).
deln_alt(N,E,[H|L],[H|R]) :-
    N>0,
    deln_alt(N,E,L,R).
% ?- deln_alt(2,a,[a,v,a,t,a,r],R).

enrl_cs_not_math(S) :- enrolled(S,C), dept(C,comp_sci), \+ enrol_3rd_year_math(S).
enrol_3rd_year_math(S) :- enrolled(S,C2), dept(C2,math), level(C2,3).

% can_enrol(S,C) is true if student S can enrol in course C
can_enrol(S,cpsc304) :- passed(S,cpsc221).
can_enrol(S,cpsc304) :- passed(S,cpsc260), passed(S,eece320), passed_one(S,[cspsc210,eece210,eece309]).
%  passed_one(S,L) is true if student S has passed one course in list L.
passed_one(S,[C|_]) :- passed(S,C).
passed_one(S,[_|L]) :- passed_one(S,L).

%  Triples, Semantic Web (there are lots of possible solutions).
prop(cpsc312, 'rdf:type', course).
prop(student_of_grade, 'rdfs:range', student).
prop(student_of_grade, 'rdfs:domain', grade).
prop(course_of_grade, 'rdfs:range', course).
prop(course_of_grade, 'rdfs:domain', grade).
prop(g123, 'rdf:type', grade).
prop(g123, student_of_grade, s12345).
prop(g123, course_of_grade, cpsc312).
prop(g123, year_of_grade, 2017).
prop(g123, item_of_grade, mid1).
prop(h123, mark_of_grade, 41).
prop(s12345, 'rdf:type', student).
prop(s12345, first_name, "Sam").
prop(s12345, last_name, "Family").
prop(s12345, year_of_birth, 1995).
prop(s12345, month_of_birth, 10).
prop(s12345, day_in_month_of_birth, 21).


