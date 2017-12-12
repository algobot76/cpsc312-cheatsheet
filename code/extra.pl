% mid2pr.txt

fib(1,0).
fib(N,F) :- N>1, N1 is N-1, fib2(N1,1,1,F).
fib2(0,_,F,F).
fib2(N,F0,F1,F) :- N>0, FS is F0+F1, N1 is N-1, fib2(N1,F1,FS,F).
