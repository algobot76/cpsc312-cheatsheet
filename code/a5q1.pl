
harmonic(1, 1).
harmonic(N, Result) :-
    N > 1,
    NN is N-1,
    harmonic(NN, RecursiveResult),
    Result is 1/N + RecursiveResult.

