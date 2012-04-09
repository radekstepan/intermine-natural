% :::::::: grammar ::::::::

% attribute of class
q(q(L1)) --> a(T,A), {add(A,[],L0)}, [of], c(T,C), {add(C,L0,L1)}.
% reference of class
q(q(L1)) --> r(T,R), {add(R,[],L0)}, [of], c(T,C), {add(C,L0,L1)}.
% attribute of class of class
q(q(L2)) --> a(T1,A), {add(A,[],L0)}, [of], c(T1,C1), {add(C1,L0,L1)}
            , [of], c(T2,C2), {is_child(T1, T2)}, {add(C2,L1,L2)}.
% reference of class of class
q(q(L2)) --> r(T1,R), {add(R,[],L0)}, [of], c(T1,C1), {add(C1,L0,L1)}
            , [of], c(T2,C2), {is_child(T1, T2)}, {add(C2,L1,L2)}.

% :::::::: model ::::::::

c(company, 'Class: company') --> [company].
c(department, 'Class: department') --> [department].
c(employee, 'Class: employee') --> [employee].
c(computer, 'Class: computer') --> [computer].

a(company, 'Attribute: name') --> [name].
a(department, 'Attribute: name') --> [name].
a(employee, 'Attribute: name') --> [name].
a(employee, 'Attribute: salary') --> [salary].
a(computer, 'Attribute: CPU') --> [cpu].

r(company, 'Reference: department') --> [department].
r(department, 'Reference: employee') --> [employee].
r(employee, 'Reference: computer') --> [computer].

% :::::::: resolve relations ::::::::

% direct child
is_child(T1, T2) :-
    r(T2, _X, [T1, A], A).
% sub child
is_child(T1, T2) :-
    % try a type `T`, that is not the root class
    r(T, _X, [T1, A], A), T \= T2,
    % add the 'through' reference
    %c(T, C, [_A, B], B), add(C, [], L),
    write(T), write(' '), write(T2), write('\n'),
    % recurse
    is_child(T, T2).

% add element to list
add(E, L, [E|L]).

% show tree if Q is valid
show_tree(Q) :- q(Tree, Q, []), write(Tree).
show_tree(_Q).