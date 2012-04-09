% :::::::: grammar ::::::::

% attribute of class
q(q(L1)) --> a(T,A), {add(A,[],L0)}, [of], c(T,C), {add(C,L0,L1)}.
% reference of class
q(q(L1)) --> r(T,R), {add(R,[],L0)}, [of], c(T,C), {add(C,L0,L1)}.
% attribute of class of class
q(q(L4)) --> a(T1,A), {add(A,[],L0)}, [of], c(T1,C1), {add(C1,L0,L1)}
            , [of], c(T2,C2), {is_child(T1, T2, L2)}, {add(L2,L1,L3)}, {add(C2,L3,L4)}.
% reference of class of class
q(q(L4)) --> r(T1,R), {add(R,[],L0)}, [of], c(T1,C1), {add(C1,L0,L1)}
            , [of], c(T2,C2), {is_child(T1, T2, L2)}, {add(L2,L1,L3)}, {add(C2,L3,L4)}.

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
is_child(T1, T2, _L) :-
    r(T2, _X, [T1, A], A).
% sub child
is_child(T1, T2, L) :-
    % try a type `T`, that is not the root class
    r(T, _X, [T1, A], A), T \= T2,
    % recurse
    is_child(T, T2, L1),
    % add the 'through' reference
    c(T, C, [_A, B], B), prepend(C, L1, L).

% add element to list
add(E, L, [E|L]).
prepend(E, L, [L|E]).

% show tree if Q is valid
show_tree(Q) :- q(Tree, Q, []), write(Tree).
show_tree(_Q).