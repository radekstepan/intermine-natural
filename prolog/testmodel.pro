% :::::::: grammar ::::::::

% field of class
q(q(L)) --> field_of_class(_T,L).
% field of class of class
q(q(L)) --> field_of_class(T1,L1), [of], c(T2,C2), {is_child(T1, T2, L2)}, {add(L2,L1,L3)}, {add(C2,L3,L)}.

% 'simple' query
field_of_class(T,L1) --> f(T,F), {add(F,[],L0)}, [of], c(T,C), {add(C,L0,L1)}.

% attribute and reference fields
f(T,F) --> a(T,F).
f(T,F) --> r(T,F).

% :::::::: model ::::::::

c(company, 'company (Class)') --> [company].
c(department, 'department (Class)') --> [department].
c(employee, 'employee (Class)') --> [employee].
c(computer, 'computer (Class)') --> [computer].

a(company, 'name (Attribute)') --> [name].
a(department, 'name (Attribute)') --> [name].
a(employee, 'name (Attribute)') --> [name].
a(employee, 'salary (Attribute)') --> [salary].
a(computer, 'CPU (Attribute)') --> [cpu].

r(company, 'department (Reference)') --> [department].
r(department, 'employee (Reference)') --> [employee].
r(employee, 'computer (Reference)') --> [computer].

% :::::::: resolve relations ::::::::

% direct child
is_child(T1, T2, []) :-
    r(T2, _X, [T1, A], A).
% sub child
is_child(T1, T2, L) :-
    % try a type `T`, that is not the root class
    r(T, _X, [T1, A], A), T \= T2,
    % recurse
    is_child(T, T2, L1),
    % add the 'through' reference
    c(T, C, [_A, B], B), prepend(C, L1, L).

% :::::::: executors ::::::::

% add element to list
add(E, L, [E|L]).
prepend(E, L, [L|E]).

% show tree if Q is valid
show_path(Q) :- q(Tree, Q, []), write(Tree), write('\n').
show_path(_Q).

% process list of sentences
process_list([]).
process_list([Head|Tail]) :- findall(_, show_path(Head), _), process_list(Tail).

% suggest paths, for 'incomplete' sentence
show_path(I, X) :- bagof(R, distribute(I, X, R), L), process_list(L).

% distribute vars across a list
distribute(I, [X|Xs], L) :-
    append(A, [_|C], I),
    distribute(C, Xs, R),
    append(A, [X|R], L).
distribute(I, [], I).