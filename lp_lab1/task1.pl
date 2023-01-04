% Sinyukov A.S. № 20

lenght([], 0) .
lenght([_|Y], N) :- length(Y, N1), N is N1 + 1 .

member(A, [A|_]) .
member(A, [_|Z]) :- member(A, Z) .

append([], X, X) .
append([A|X], Y, [A|Z]) :- append(X, Y, Z) .

remove(X, [X|T], T) .
remove(X, [Y|T], [Y|T1]) :- remove(X, T, T1) .

permute([], []).
permute(L, [X|T]) :- remove(X, L, R), permute(R, T) .

sublist(S, L) :- append(_, L1, L), append(S, _ , L1) .


remove_last([_], []).
remove_last([A|T], [A|R]) :- remove_last(T, R) .

remove_last2(L, R) :- append(R, [_], L) . 


count_chet([], 0) .
count_chet([A|Y], N) :- count_chet(Y, N1), N is N1 + (A+1) mod 2 .

% Содержательный пример "удалить три"
remove_three(X, XNEW) :- lenght(X, LEN), LEN >= 3, remove_last(X, X1), remove_last(X1, X2), remove_last(X2, XNEW).
remove_three(X, _) :- lenght(X, LEN), LEN < 3, fail.
