move(A,B) :-
    append(H,['_','b'|T],A),
    append(H,['b','_'|T],B).
    
move(A,B) :-
    append(H,['w','_'|T],A),
    append(H,['_','w'|T],B).

move(A,B) :-
    append(H,['_','w','b'|T],A),
    append(H,['b','w','_'|T],B).

move(A,B) :-
    append(H,['w','b','_'|T],A),
    append(H,['_','b','w'|T],B).


prolong([X|T], [Y,X|T]) :-
    move(X, Y),
    not(member(Y, [X|T])).


print([_]).
print([H|T]) :-
    print(T),
    nl, write(H).


bfs(X, Y) :-
    write('bfs:'), nl,
    write(X),
    get_time(BTime1),
    bdth([[X]], Y, Z),
    print(Z),
    get_time(BTime2),
    TB is BTime2 - BTime1, nl,
    write('time: '), write(TB), nl,
    !.

bdth([[H|T]|_], H, [H|T]).

bdth([H|T], X, Z) :-
    findall(W, prolong(H, W), Y),
    append(T, Y, E), !,
    bdth(E, X, Z).

bdth([_,T], X, Y) :- bdth(T, X, Y).


dfs(X, Y) :-
    write('dfs:'), nl,
    write(X),
    get_time(DTime1),
    ddth([[X]], Y, Z),
    print(Z),
    get_time(DTime2),
    TD is DTime2 - DTime1, nl,
    write('time: '), write(TD), nl,
    !.

ddth([[H|T]|_], H, [H|T]).

ddth([H|T], X, Z) :-
    findall(W, prolong(H, W), Y),
    append(Y, T, E), !,
    ddth(E, X, Z).

ddth([_,T], X, Y) :- ddth(T, X, Y).


int(1).
int(N) :- int(N1), N is N1+1.

search_id(X, Y, W, D) :- depth_id([X], Y, W, D).

search_id(X, Y, W) :-
    int(LEV),
    search_id(X, Y, W, LEV).

search_id(X, Y) :-
    write('dfs:'), nl,
    write(X),
    get_time(ITime1),
    search_id(X, Y, Z),
    print(Z),
    get_time(ITime2),
    TI is ITime2 - ITime1, nl,
    write('time: '), write(TI), nl,
    !.

depth_id([H|T], H, [H|T], 0).

depth_id(W, X, Y, N) :-
    N>0,
    prolong(W, NEW),
    N1 is N-1,
    depth_id(NEW, X, Y, N1).
