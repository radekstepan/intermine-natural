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

% grammar of relations
reference('ceo', ceo).
collection('departments', department).
collection('employees', employee).
attribute('name', name).
attribute('age', age).
attribute('salary', salary).

% answer format, the `path`
answer([C, A], C, A).

% resolve attributes, references & collections
has(Attr, C) :- attribute_of(Attr, C).
has(Ref, C) :- reference_of(Ref, C).
has(Coll, C) :- collection_of(Coll, C).

% :::::::: language rules ::::::::

% age of 'Bugs Bunny'
query([A, 'of', Db], Answer) :-
	db(Db, C), query([A, 'of', C], Answer).

% age of ceo
query([A, 'of', C], Answer) :-
	has(A, C), answer(Answer, C, A).

% name of department of company
query([A2, 'of', A1, 'of', C], Answer) :-
	query([A1, 'of', C], Answer1),
	query([A2, 'of', A1], Answer2),
	answer(Answer, Answer1, Answer2).

% :::::::: database ::::::::

db('ACME', company).
db('Bugs Bunny', ceo).
db('Mickey Mouse', employee).