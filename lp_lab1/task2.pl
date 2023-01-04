%Предикаты обработки списков
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

sum([], 0).
sum([X|Y], S) :- sum(Y, S1), S is S1 + X.

%Начальные данные
student(102,'Петров').
student(101,'Петровский').
student(104,'Иванов').
student(102,'Ивановский').
student(104,'Запорожцев').
student(101,'Сидоров').
student(103,'Сидоркин').
student(102,'Биткоинов').
student(103,'Эфиркина').
student(103,'Сиплюсплюсов').
student(103,'Программиро').
student(104,'Джаво').
student(103,'Клавиатурникова').
student(101,'Мышин').
student(104,'Фулл').
student(101,'Безумников').
student(102,'Шарпин').
student(104,'Круглосчиталкин').
student(103,'Решетников').
student(102,'Эксель').
student(102,'Текстописов').
student(103,'Текстописова').
student(101,'Густобуквенникова').
student(102,'Криптовалютников').
student(104,'Блокчейнис').
student(102,'Азурин').
student(103,'Вебсервисов').
student(102,'Круглотличников').

subject('LP','Логическое программирование').
subject('MTH','Математический анализ').
subject('FP','Функциональное программирование').
subject('INF','Информатика').
subject('ENG','Английский язык').
subject('PSY','Психология').

grade('Петров','LP',4).
grade('Петров','MTH',3).
grade('Петров','FP',5).
grade('Петров','INF',4).
grade('Петров','ENG',4).
grade('Петров','PSY',3).
grade('Петровский','LP',5).
grade('Петровский','MTH',5).
grade('Петровский','FP',5).
grade('Петровский','INF',4).
grade('Петровский','ENG',5).
grade('Петровский','PSY',3).
grade('Иванов','LP',5).
grade('Иванов','MTH',3).
grade('Иванов','FP',4).
grade('Иванов','INF',5).
grade('Иванов','ENG',5).
grade('Иванов','PSY',5).
grade('Ивановский','LP',3).
grade('Ивановский','MTH',5).
grade('Ивановский','FP',4).
grade('Ивановский','INF',3).
grade('Ивановский','ENG',5).
grade('Ивановский','PSY',5).
grade('Запорожцев','LP',2).
grade('Запорожцев','MTH',2).
grade('Запорожцев','FP',4).
grade('Запорожцев','INF',3).
grade('Запорожцев','ENG',4).
grade('Запорожцев','PSY',4).
grade('Сидоров','LP',4).
grade('Сидоров','MTH',4).
grade('Сидоров','FP',4).
grade('Сидоров','INF',4).
grade('Сидоров','ENG',3).
grade('Сидоров','PSY',4).
grade('Сидоркин','LP',4).
grade('Сидоркин','MTH',5).
grade('Сидоркин','FP',4).
grade('Сидоркин','INF',3).
grade('Сидоркин','ENG',4).
grade('Сидоркин','PSY',4).
grade('Биткоинов','LP',5).
grade('Биткоинов','MTH',4).
grade('Биткоинов','FP',3).
grade('Биткоинов','INF',4).
grade('Биткоинов','ENG',3).
grade('Биткоинов','PSY',2).
grade('Эфиркина','LP',2).
grade('Эфиркина','MTH',4).
grade('Эфиркина','FP',3).
grade('Эфиркина','INF',2).
grade('Эфиркина','ENG',2).
grade('Эфиркина','PSY',4).
grade('Сиплюсплюсов','LP',4).
grade('Сиплюсплюсов','MTH',4).
grade('Сиплюсплюсов','FP',4).
grade('Сиплюсплюсов','INF',5).
grade('Сиплюсплюсов','ENG',4).
grade('Сиплюсплюсов','PSY',4).
grade('Программиро','LP',5).
grade('Программиро','MTH',4).
grade('Программиро','FP',3).
grade('Программиро','INF',3).
grade('Программиро','ENG',5).
grade('Программиро','PSY',4).
grade('Джаво','LP',4).
grade('Джаво','MTH',4).
grade('Джаво','FP',3).
grade('Джаво','INF',2).
grade('Джаво','ENG',3).
grade('Джаво','PSY',5).
grade('Клавиатурникова','LP',4).
grade('Клавиатурникова','MTH',5).
grade('Клавиатурникова','FP',3).
grade('Клавиатурникова','INF',5).
grade('Клавиатурникова','ENG',4).
grade('Клавиатурникова','PSY',4).
grade('Мышин','LP',5).
grade('Мышин','MTH',4).
grade('Мышин','FP',5).
grade('Мышин','INF',4).
grade('Мышин','ENG',3).
grade('Мышин','PSY',3).
grade('Фулл','LP',4).
grade('Фулл','MTH',4).
grade('Фулл','FP',4).
grade('Фулл','INF',5).
grade('Фулл','ENG',5).
grade('Фулл','PSY',5).
grade('Безумников','LP',3).
grade('Безумников','MTH',5).
grade('Безумников','FP',3).
grade('Безумников','INF',2).
grade('Безумников','ENG',4).
grade('Безумников','PSY',3).
grade('Шарпин','LP',3).
grade('Шарпин','MTH',4).
grade('Шарпин','FP',4).
grade('Шарпин','INF',5).
grade('Шарпин','ENG',5).
grade('Шарпин','PSY',5).
grade('Круглосчиталкин','LP',5).
grade('Круглосчиталкин','MTH',2).
grade('Круглосчиталкин','FP',4).
grade('Круглосчиталкин','INF',3).
grade('Круглосчиталкин','ENG',4).
grade('Круглосчиталкин','PSY',3).
grade('Решетников','LP',4).
grade('Решетников','MTH',4).
grade('Решетников','FP',5).
grade('Решетников','INF',3).
grade('Решетников','ENG',5).
grade('Решетников','PSY',3).
grade('Эксель','LP',4).
grade('Эксель','MTH',4).
grade('Эксель','FP',4).
grade('Эксель','INF',3).
grade('Эксель','ENG',5).
grade('Эксель','PSY',4).
grade('Текстописов','LP',2).
grade('Текстописов','MTH',5).
grade('Текстописов','FP',4).
grade('Текстописов','INF',3).
grade('Текстописов','ENG',5).
grade('Текстописов','PSY',3).
grade('Текстописова','LP',4).
grade('Текстописова','MTH',4).
grade('Текстописова','FP',4).
grade('Текстописова','INF',3).
grade('Текстописова','ENG',5).
grade('Текстописова','PSY',2).
grade('Густобуквенникова','LP',5).
grade('Густобуквенникова','MTH',2).
grade('Густобуквенникова','FP',4).
grade('Густобуквенникова','INF',5).
grade('Густобуквенникова','ENG',4).
grade('Густобуквенникова','PSY',3).
grade('Криптовалютников','LP',5).
grade('Криптовалютников','MTH',2).
grade('Криптовалютников','FP',2).
grade('Криптовалютников','INF',3).
grade('Криптовалютников','ENG',4).
grade('Криптовалютников','PSY',2).
grade('Блокчейнис','LP',5).
grade('Блокчейнис','MTH',2).
grade('Блокчейнис','FP',5).
grade('Блокчейнис','INF',3).
grade('Блокчейнис','ENG',4).
grade('Блокчейнис','PSY',5).
grade('Азурин','LP',4).
grade('Азурин','MTH',2).
grade('Азурин','FP',4).
grade('Азурин','INF',3).
grade('Азурин','ENG',5).
grade('Азурин','PSY',2).
grade('Вебсервисов','LP',3).
grade('Вебсервисов','MTH',4).
grade('Вебсервисов','FP',3).
grade('Вебсервисов','INF',3).
grade('Вебсервисов','ENG',5).
grade('Вебсервисов','PSY',2).
grade('Круглотличников','LP',4).
grade('Круглотличников','MTH',3).
grade('Круглотличников','FP',5).
grade('Круглотличников','INF',5).
grade('Круглотличников','ENG',3).
grade('Круглотличников','PSY',5).

%Предикаты обработки данных
%1
% avg - вычисляет средний балл (применяется и в 3 подзадании)
% all_passed - проверка на сдачу всех экзаменов (вернет 1 или 0 для удобства)
% avg_passed - возвращает результат avg и all_passed
% any_stud - выводит результат для 1 подзадания

avg(X, AVG) :- findall(N, grade(X,_,N), ARR), sum(ARR, SUM), length(ARR, LEN), AVG is SUM / LEN.

all_passed(X, RES) :- findall(N, grade(X,_,N), ARR), (not(member(2, ARR)) -> RES is 1 ; RES is 0).

avg_passed(X, AVG, RES) :- avg(X, AVG), all_passed(X, RES).

any_stud() :- findall(X, student(_,X), ARR), any_stud(ARR).
any_stud([]).
any_stud([X|Y]) :- any_stud(Y), avg_passed(X, AVG, RES), writeln(X), writeln(AVG), (RES = 1 -> writeln('Всё сдал(а)') ; writeln('Есть задолженности')), writeln('--------------------------------------------------').


%2
% count_fail - счётчик двоек
% full_subj - находит полное название предмета (тупо обёртка над subject, наверное он сам бы сработал)
% any_subj - выводит результат для 2 подзадания

count_fail(NAME, X) :- findall(N, grade(N, NAME, 2), ARR), length(ARR, X).

full_subj(X, Y) :- subject(X, Y).

any_subj() :- findall(X, subject(X, _), ARR), any_subj(ARR).
any_subj([]).
any_subj([X|Y]) :- any_subj(Y), count_fail(X, N), full_subj(X, XFULL), writeln(XFULL), writeln(N), writeln('---------------------------------------').


%3
% minus_one - минус один (я не понимаю почему не работало L is L1 - 1 нормально но это сработало)
% maxlist - максимум в листе
% all_avg - выводит список средних баллов по группе
% max_group_avg - находит максимумальный средний балл в группе
% stud_by_group_avg - находит студентов с максимальным средним и выводит (так удобнее)
% best_stud - выводит результат для 3 подзадания

minus_one(X,Y) :- Y is X - 1.

maxlist([],0).
maxlist([A|B],MAX) :-
    maxlist(B,C),
    A > C,
    MAX is A.
maxlist([A|B],MAX) :-
    maxlist(B,C),
    A =< C,
    MAX is C.


all_avg(X, GR) :-
	findall(N, student(GR,N), ARR),
	length(ARR, LEN),
	all_avg(X, ARR, GR, LEN).
all_avg(X, ARR, _, 0) :- append([], ARR, X).
all_avg(X, [A|B], GR, L) :-
	minus_one(L, L1),
	avg(A, AVG),
	append(B, [AVG], X1),
	all_avg(X, X1, GR, L1).
	
max_group_avg(X, GR) :- all_avg(ARR, GR), maxlist(ARR, X).

% stud_by_group_avg(X, GR, AVG) :- student(GR, X), avg(X, AVG).

stud_by_group_avg(GR, AVG) :- findall(N, student(GR,N), ARR), stud_by_group_avg(GR, AVG, ARR).
stud_by_group_avg(_, _, []).
stud_by_group_avg(GR, AVG, [A|B]) :-
	avg(A, AVG),
	writeln(A),
	stud_by_group_avg(GR, AVG, B).
stud_by_group_avg(GR, AVG, [A|B]) :-
	stud_by_group_avg(GR, AVG, B),
	not(avg(A, AVG)).

best_stud() :- best_stud([101, 102, 103, 104]).
best_stud([]).
best_stud([A|B]) :-
	best_stud(B),
	writeln(A),
	max_group_avg(AVG, A),
	stud_by_group_avg(A, AVG),
	writeln('---------------------------------------').
