% Факты
name("Дина").
name("Соня").
name("Коля").
name("Рома").
name("Миша").

gender("Дина", female).
gender("Соня", female).
gender("Коля", male).
gender("Рома", male).
gender("Миша", male).

% Предикаты
same_gender(X, Y) :- gender(X, A), gender(Y, A).
diff_gender(X, Y) :- not(same_gender(X, Y)).

no_mother("Рома"). % Мать Ромы умерла
has_mom(X) :- not(no_mother(X)).

not_name("Коля", "Карпенко"). % "Отец Коли уже договорился с родителями Карпенко" - значит Коля не Карпенко
name_exception(X, Y) :- not(not_name(X, Y)).

parents_not_knows("Коля", "Дина"). % Родители Дины никогда не встречались с родителями Коли
parents_knows(X, Y) :- not(parents_not_knows(X, Y)), not(parents_not_knows(Y, X)).

unique([]) :- !.
unique([A|B]) :- member(A, B), !, fail; unique(B).

% Решение
solve(Solve) :-
	Solve = [
		person(A, "Бойченко"),
		person(B, "Карпенко"),
		person(C, "Лысенко"),
		person(D, "Савченко"),
		person(E, "Шевченко")
	],
	name(A), name(B), name(C), name(D), name(E),
	unique([A, B, C, D, E]), % Разные имена
	
	gender(B, male), % у Карпенко сын
	
	name_exception(B, "Карпенко"),

	same_gender(E, A), % Предположим, что в одной баскетбольной команде играют люди одного пола

	diff_gender(C, A), % Они собираются пожениться

	has_mom(E), % мать Шевченко 
	has_mom(B), % пришла к матери Карпенко
	has_mom(C), % "Все четверо очень довольны" - видимо тоже живы матери
	has_mom(A),

	parents_knows(E, B), % "мать Шевченко пришла к матери Карпенко" - видимо знакомы

	parents_knows(B, "Коля"), % Карпенко знают родителей Коли

	parents_knows(A, C). % Отец и мать Лысенко хорошие друзья родителей Бойченко

