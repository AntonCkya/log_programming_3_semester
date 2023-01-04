% Факты
parent(alexei, tolia).
parent(alexei, volodia).
parent(alexei, vitia).
parent(tolia, tima).

:- op(200, xfy, ':').

% Предикат, возвращающий словарь для всех имен с тремя падежами
% При добавлении нового имени придется заполнить и этот словарь именительным, родительным и творительным падежом
% IM - именительный падеж, ROD - родительный, TV - творительный
cases(Dict) :- Dict = [

    'alexei'  : case('IM')  : ['alexei'],
    'alexei'  : case('ROD') : ['alexeia'],
    'alexei'  : case('TV')  : ['alexeev'],

    'tolia'   : case('IM')  : ['tolia'],
    'tolia'   : case('ROD') : ['toli'],
    'tolia'   : case('TV')  : ['tolin'],

    'volodia' : case('IM')  : ['volodia'],
    'volodia' : case('ROD') : ['volodi'],
    'volodia' : case('TV')  : ['volodin'],

    'vitia'   : case('IM')  : ['vitia'],
    'vitia'   : case('ROD') : ['viti'],
    'vitia'   : case('TV')  : ['vitin'],

    'tima'    : case('IM')  : ['tima'],
    'tima'    : case('ROD') : ['timi'],
    'tima'    : case('TV')  : ['timin']
    
].

% Предикаты для поиска по словарю и проверки на наличие в нем
condition(X, XC, K, XC:K:L) :- member(X, L).

find(X, XC, K, Dict) :- 
    member(Mem, Dict),
    condition(X, XC, K, Mem).

in_base(XC, K, X) :- cases(Dict), find(X, XC, K, Dict).

% Решение
% Программа умеет определять только братьев, поэтому слово 'brat' нигде не прверялось (как и наличие '?')
answer([X,Y,_,_], Res) :- 
    X = 'kto',
    in_base(Y_im, case('TV'), Y),
    parent(P, Y_im), parent(P, Res), Y_im \= Res.

answer([X,_,Y,_], Res) :- 
    X = 'chei',
    in_base(Y_im, case('IM'), Y),
    parent(P, Y_im), parent(P, Res), Y_im \= Res.

answer([X,_,Y,_], _) :- 
    in_base(X_im, case('IM'), X),
    in_base(Y_im, case('ROD'), Y),
    parent(P, X_im), parent(P, Y_im), X_im \= Y_im.
