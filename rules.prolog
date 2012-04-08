% :::::::: model ::::::::

% root classes
class(company).
class(department).
class(employee).
class(ceo).

% model relations
reference_of(ceo, company).
collection_of(department, company).
collection_of(employee, department).
attribute_of(name, department).
attribute_of(name, employee).
attribute_of(age, ceo).
attribute_of(salary, ceo).

% answer format, the `path`
answer([C, A, X], C, A, X).

% resolve attributes, references & collections
has(Attr, C, _X) :- attribute_of(Attr, C).
has(Ref, C, _X) :- reference_of(Ref, C).
has(Coll, C, _X) :- collection_of(Coll, C).
% resolve through (X) the tree for references & collections
has(Ref, C, X) :- reference_of(X, C), reference_of(Ref, X).
has(Ref, C, X) :- reference_of(X, C), collection_of(Ref, X).
has(Coll, C, X) :- collection_of(X, C), reference_of(Coll, X).
has(Coll, C, X) :- collection_of(X, C), collection_of(Coll, X).

% :::::::: language rules ::::::::

% age of 'Bugs Bunny'
query([A, 'of', Db], Answer) :-
	db(Db, C), query([A, 'of', C], Answer).

% age of ceo
query([A, 'of', C], Answer) :-
	has(A, C, X), answer(Answer, C, A, X).

% name of department of company
query([A, 'of', C1, 'of', C2], Answer) :-
	query([A, 'of', C1], Answer1),
	query([C1, 'of', C2], Answer2),
	answer(Answer, Answer2, Answer1, _X).

% name of employee of company (through department)

% :::::::: database ::::::::

db('ACME', company).
db('Bugs Bunny', ceo).
db('Mickey Mouse', employee).