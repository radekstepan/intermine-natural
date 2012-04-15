% ?- replace_at([a,b,c,d], X, 2, L).
% L = [a, X, c, d]

replace_at([_|Tail], X, 1, [X|Tail]).
replace_at([Head|Tail], X, N, [Head|R]) :- M is N - 1, replace_at(Tail, X, M, R).

replace_each([], _, _, [], _).
replace_each([_|Next], Orig, X, [Res|L], N) :-
	replace_at(Orig, X, N, Res),
	M is N + 1,
	replace_each(Next, Orig, X, L, M).

variablize(I, X, L) :- replace_each(I, I, X, L, 1).

% ?- variablize([a,b,c,d], X, L).
% L = [[X, b, c, d], [a, X, c, d], [a, b, X, d], [a, b, c, X]]