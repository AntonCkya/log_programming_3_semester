:-consult('Joestar-tree-2.pl').

married(Man, Woman) :- child(Child, Man), child(Child, Woman), Man \= Woman.

husband(Man, Woman) :- married(Man, Woman), male(Man).
wife(Woman, Man) :- married(Man, Woman), female(Woman).

father(Man, Child) :- child(Child, Man), male(Man).
mother(Woman, Child) :- child(Child, Woman), female(Woman).

son(Man, Human) :- child(Man, Human), male(Man).
daughter(Woman, Human) :- child(Woman, Human), female(Woman).

brother(Man, Human) :- son(Man, Human2), child(Human, Human2), Man \= Human.
sister(Woman, Human) :- daughter(Woman, Human2), child(Human, Human2), Woman \= Human.

grandfather(Man, Human) :- father(Man, Human2), father(Human2, Human).
grandfather(Man, Human) :- father(Man, Human2), mother(Human2, Human).
grandmother(Woman, Human) :- mother(Woman, Human2), father(Human2, Human).
grandmother(Woman, Human) :- mother(Woman, Human2), mother(Human2, Human).

%task1
tesha(Woman, Man) :- wife(Wife, Man), mother(Woman, Wife).

%task2
relative('husband', Man, Woman) :- husband(Man, Woman).
relative('wife', Woman, Men) :- wife(Woman, Man).
relative('father', Man, Child) :- father(Man, Child).
relative('mother', Woman, Child) :- mother(Woman, Child).
relative('son', Man, Human) :- son(Man, Human).
relative('daughter', Woman, Human) :- daughter(Woman, Human).
relative('brother', Man, Human) :- brother(Man, Human).
relative('sister', Woman, Human) :- sister(Woman, Human).
relative('grandfather', Man, Human) :- grandfather(Man, Human).
relative('grandmother', Woman, Human) :- grandmother(Woman, Human).

relative(W, X, Y) :- 
	dfs(X, Y, W).

translator([X, Y], [R]) :-
	relative(R, X, Y).
translator([X, Y|T], [P, Q|R]):-
	relative(P, X, Y),
	translator([Y|T], [Q|R]), !.

move(X, Y) :-
	father(X, Y);
	mother(X, Y);
	brother(X, Y);
	sister(X, Y);
	son(X, Y);
	daughter(X, Y);
	husband(X, Y);
	wife(X, Y),
	grandfather(X, Y),
	grandmother(X, Y).

prolong([X|T], [Y, X|T]) :-
	move(X, Y),
	not(member(Y, [X|T])).

path1([X|T], X, [X|T]).
path1(L, Y, R) :-
	prolong(L, T),
	path1(T, Y, R).

dfs(X, Y, R2) :-
	path1([X], Y, R1),
	translator(R1, R2).

%task3

just_relative('husband', Man, Woman) :- husband(Man, Woman).
just_relative('wife', Woman, Men) :- wife(Woman, Man).
just_relative('father', Man, Child) :- father(Man, Child).
just_relative('mother', Woman, Child) :- mother(Woman, Child).
just_relative('son', Man, Human) :- son(Man, Human).
just_relative('daughter', Woman, Human) :- daughter(Woman, Human).
just_relative('brother', Man, Human) :- brother(Man, Human).
just_relative('sister', Woman, Human) :- sister(Woman, Human).
just_relative('grandfather', Man, Human) :- grandfather(Man, Human).
just_relative('grandmother', Woman, Human) :- grandmother(Woman, Human).

answer([W1, W2, W3, W4, W5], Res) :- %'Who' 'is' 'Joseph Joestar' 'father' '?'
    W1 = 'Who',
    W2 = 'is',
    just_relative(W4, Res, W3).
answer([W1, W2, W3, W4, W5, W6], Res) :- %'Who' 'is' 'Joseph Joestar' 'to' 'Jotaro Kujo' '?'
    W1 = 'Who',
    W2 = 'is',
    W4 = 'to',
    just_relative(Res, W3, W5).
answer([W1, W2, W3, W4, W5, W6]) :- %'Does' 'Jolyne Kujo' 'daughter' 'of' 'Jotaro Kujo' '?'
    W1 = 'Does',
    W4 = 'of',
    just_relative(W3, W2, W5).
answer([W1, W2, W3, W4, W5, W6], Count) :- %'How', 'many', 'son', 'Dio Brando', 'have', '?'
    W1 = 'How',
    W2 = 'many',
    W5 = 'have',
    aggregate_all(count, just_relative(W3, X, W4), Count).
