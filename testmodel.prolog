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

c(company, class(company)) --> [company].
c(ceo, class(ceo)) --> [ceo].
c(computer, class(computer)) --> [computer].

a(company, attribute(name)) --> [name].
a(ceo, attribute(name)) --> [name].
a(ceo, attribute(salary)) --> [salary].
a(computer, attribute(processor)) --> [processor].

r(company, reference(ceo)) --> [ceo].
r(ceo, reference(computer)) --> [computer].
r(computer, reference(monitor)) --> [monitor].

% :::::::: resolve relations ::::::::

is_child(T1, T2) :- % direct child
    r(T2, _X, [T1, A], A).
is_child(T1, T2) :- % sub child
    r(T, _X, [T1, A], A),
    is_child(T, T2).

% show tree if Q is valid
show_tree(Q) :- q(Tree, Q,[]), write(Tree).
show_tree(_Q).