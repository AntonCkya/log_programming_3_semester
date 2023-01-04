# Отчет по курсовому проекту
## по курсу "Логическое программирование"

### студент: Синюков А.С.

## Результат проверки

Вариант задания:

 - [ ] стандартный, без NLP (на 3)
 - [x] стандартный, с NLP (на 3-4)
 - [ ] продвинутый (на 3-5)
 
| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*

## Введение

В результате работы над курсовым проектом были получены навыки работы с родословными деревьями формата GEDCOM, а также работа с родословными деревьями в виде предикатов в языке программирования Prolog

## Задание

1) Создание дерева в формате GEDCOM
2) Преобразовать дерево формата GEDCOM в набор утверждений на языке Prolog вида: `child(ребенок, родитель)`, `male(человек)`, `female(человек)` 
3) Реализовать предикат проверки/поиска тещи
4) Реализовать программу на языке Prolog, которая позволит определять степень родства двух произвольных индивидуумов в дереве
5) Реализовать естественно-языковый интерфейс к системе, позволяющий задавать вопросы относительно степеней родства.

## Получение родословного дерева

Родословное дерево содержится в файле `Joestar-tree-2.ged`

Родословное дерево было сделано в программе "Древо жизни", она бесплатная до 40 индивидов. Мне это подходило, я реализовал дерево с 23 индивидами. В качестве родословной послужила родословная Джостаров из "Невероятных Приключений ДжоДжо"

## Конвертация родословного дерева

Парсер на питоне находится в файле `main.py`, генерирует файл `Joestar-tree-2.pl`

Для парсера GEDCOM в предикаты использовался язык Python.
При считывании разбиралось 2 случая:
1) Найден `'0 @I'`

В таком случае после данной строки находилась строка, содержащая `'1 NAME'`, из нее извлекалось имя. Далее находилась строка, содержащая `'1 SEX'` и из нее извлекался пол. В зависимости от пола строились предикаты `male(человек)`, `female(человек)`

```python
if '0 @I' in line:
    pred = '('
    p_id = line[2:-6]
elif '1 NAME' in line and pred == '(':
    pred += '\''
    pred += line[7:-1].replace('/', '').strip()
    pred += '\''
    pred += ')'
    id_dict[p_id] = pred[1:-1]
elif '1 SEX' in line and len(pred) > 0 and pred[0] == '(':
    if '1 SEX M' in line:
        pred = 'male' + pred
    elif '1 SEX F' in line:
        pred = 'female' + pred
    predicates.append(pred)
    pred = ''
    p_id = ''
```
2) Найден `'0 @F'`

В таком случае из строк с началом `'1 HUSB'`, `'1 WIFE'`, `'1 CHIL'` после даннной строился предикат `child(ребенок, родитель)`.
```python
elif '1 HUSB' in line and pred == ', ':
    pred += id_dict[line[7:-1]]
    pred += ')'
elif '1 WIFE' in line and pred_2 == ', ':
    pred_2 += id_dict[line[7:-1]]
    pred_2 += ')'
elif '1 CHIL' in line:
    child_name = id_dict[line[7:-1]]
    if len(pred) > 0 and pred != ', ':
        predicates.append('child(' + child_name + pred)
    if len(pred_2) > 0 and pred_2 != ', ':
        predicates.append('child(' + child_name + pred_2)
```
Все эти предикаты записывались в список, на основе списка строился файл с правилами `Joestar-tree-2.pl`

## Предикат поиска родственника

Все предикаты расположены в файле `main.pl`

Теща это мать жены. То есть нужно проверить является ли теща матерью человека N, и этот человек N является мужем данного человека:
```prolog
%Проверка на женатость пары людей
married(Man, Woman) :- child(Child, Man), child(Child, Woman), Man \= Woman.

%Проверка степени замужества (на муж/жена)
husband(Man, Woman) :- married(Man, Woman), male(Man).
wife(Woman, Man) :- married(Man, Woman), female(Woman).

%Проверка отцовства/материнства
father(Man, Child) :- child(Child, Man), male(Man).
mother(Woman, Child) :- child(Child, Woman), female(Woman).

... %Опущены не нужные в данный момент предикаты
%Проверка тещи
tesha(Woman, Man) :- wife(Wife, Man), mother(Woman, Wife).
```
Результат:
```prolog
?- tesha(X, 'Joseph Joestar').
X = 'Mommy Q'

?- tesha('Mommy Lisa', X).
X = 'George II Joestar'

?- tesha(X, 'Dio Brando').
false.
```

## Определение степени родства

Для простых случаев расписываем предикат relative:
(простые случаи это муж/жена, отец/мать, сын/дочь, брат/сестра, дедушка/бабушка)
```prolog
relative('husband', Man, Woman) :- husband(Man, Woman).
relative('wife', Woman, Men) :- wife(Woman, Man).
relative('father', Man, Child) :- father(Man, Child).
relative('mother', Woman, Child) :- mother(Woman, Child).
...
```
Если случай не простой, то идем по дереву поиском в глубину, формируя список отношения:
```prolog
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
```
Результат:
```prolog
?- relative(X, 'Dio Brando', 'Ungalo').
X = father ;
X = [brother, brother, brother, son] ;
X = [brother, brother, son] ;
X = [brother, brother, brother, son] ;
X = [brother, brother, son] ;
X = [brother, son] ;

?- relative('brother', 'Rikiel', X).
X = 'Giorno Giovanna' ;
X = 'Donatello Versus' ;
X = 'Ungalo' ;
false.
```


## Естественно-языковый интерфейс

Простой естественно языковой интерфейс был реализован на основе мно ранее сделанной 4 лабораторной работе, только расширен. Вопросы могут быть следующих видов:
1) ['Who','is', NAME, RELATION, '?']:
```prolog
answer([W1, W2, W3, W4, W5], Res) :-
    W1 = 'Who',
    W2 = 'is',
    just_relative(W4, Res, W3).
```
Результат:
```prolog
?- answer(['Who', 'is', 'Joseph Joestar', 'father', '?'], X).
X = 'George II Joestar'

?- answer(['Who', 'is', 'Jotaro Kujo', 'grandfather', '?'], X).
X = 'Joseph Joestar'
```
2) ['Who','is', NAME, 'to', NAME, '?']:
```prolog
answer([W1, W2, W3, W4, W5, W6], Res) :-
    W1 = 'Who',
    W2 = 'is',
    W4 = 'to',
    just_relative(Res, W3, W5).
```
Результат:
```prolog
?- answer(['Who', 'is', 'Jotaro Kujo', 'to', 'Jolyne Kujo', '?'], X).
X = father

?- answer(['Who', 'is', 'Suzi Q Joestar', 'to', 'Joseph Joestar', '?'], X).
X = wife
```
3) ['Does', NAME, RELATION, 'of', NAME, '?']:
```prolog
answer([W1, W2, W3, W4, W5, W6]) :- 
    W1 = 'Does',
    W4 = 'of',
    just_relative(W3, W2, W5).
```
Результат:
```prolog
?- answer(['Does', 'Dio Brando', 'son', 'of', 'Joseph Joestar', '?']).
false.

?- answer(['Does', 'Dio Brando', 'father', 'of', 'Giorno Giovanna', '?']).
true.
```
4) ['How', 'many', RELATION, NAME, 'have', '?']:

(вводить родство в единственном числе)
```prolog
answer([W1, W2, W3, W4, W5, W6], Count) :- 
    W1 = 'How',
    W2 = 'many',
    W5 = 'have',
    aggregate_all(count, just_relative(W3, X, W4), Count).
```
Результат:
```prolog
?- answer(['How', 'many', 'son', 'Dio Brando', 'have', '?'], X).
X = 4.

?- answer(['How', 'many', 'father', 'Josuke Higashikata', 'have', '?'], X).
X = 1.
```

## Выводы

Данный курсовой проект научил очень многому: работе с деревьями GEDCOM и из парсинг в формат пролога (и не только), работе с родословными деревьями в прологе и небольшим основам рпаботы с естественным языком. При этом в данной работе пришлось работать со всем тем, чем мы занимались в семестре: работать со списками, деревьями, естественным языком. Появилось ощущение того, что лабораторные работы готовили нас к написанию курсовой (хоть и некоторые лабы ощущались сложнее в свое время, если не учитывать эссе).

Во время написания реферата я познакомился глубже с устройством языка программирования Prolog и логическим программированием в целом, роазобрался в вопросе искусственного интеллекта и нейронных сетей, на примерах увидел чего достиг прогрес к концу 2022 года в этой области. Такой курсовой проект является идеальным завершением изучения логического программирования в вузе, а дальнейшее погружение в эту область будет зависеть лишь от меня.
