% :::::::: grammar ::::::::

% attribute of class
q(q(A,C)) --> a(T,A), [of], c(T,C).
% reference of class
q(q(R,C)) --> r(T,R), [of], c(T,C).
% attribute of class of class
q(q(A,C1,C2)) --> a(T1,A), [of], c(T1,C1)
    ,[of], c(T2,C2), {is_child(T1, T2)}.
% reference of class of class
q(q(R,C1,C2)) --> r(T1,R), [of], c(T1,C1)
    ,[of], c(T2,C2), {is_child(T1, T2)}.

% :::::::: model ::::::::

c(company, 'Class: company') --> [company].
c(department, 'Class: department') --> [department].
c(employee, 'Class: employee') --> [employee].

a(company, 'Attribute: name') --> [name].
a(department, 'Attribute: name') --> [name].
a(employee, 'Attribute: name') --> [name].
a(employee, 'Attribute: salary') --> [salary].

r(company, 'Reference: department') --> [department].
r(department, 'Reference: employee') --> [employee].

% :::::::: resolve relations ::::::::

is_child(T1, T2) :- % direct child
    r(T2, _X, [T1, A], A).
is_child(T1, T2) :- % sub child
    r(T, _X, [T1, A], A),
    is_child(T, T2).

% show tree if Q is valid
show_tree(Q) :- q(Tree, Q, []), write(Tree).
show_tree(_Q).