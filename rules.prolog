% :::::::: model ::::::::

% root classes
class(company).
class(ceo).

% model relations
reference_of(ceo, company).
attribute_of(age, ceo).
attribute_of(salary, ceo).

% grammar of relations
reference('ceo', ceo).
attribute('age', age).
attribute('salary', salary).
attribute('money', salary).

% answer format, the `path`
answer([Class, What], Class, What).

% :::::::: language rules ::::::::

% age of 'Bugs Bunny'
query(AttributeQ, 'of', ClassQ, Answer) :-
	db(ClassQ, Class),
	attribute(AttributeQ, Attribute),
	attribute_of(Attribute, Class),
	answer(Answer, Class, Attribute).
% age of ceo
query(AttributeQ, 'of', Class, Answer) :-
	attribute(AttributeQ, Attribute),
	attribute_of(Attribute, Class),
	answer(Answer, Class, Attribute).
% ceo of 'ACME'
query(ReferenceQ, 'of', ClassQ, Answer) :-
	db(ClassQ, Class),
	reference(ReferenceQ, Reference),
	reference_of(Reference, Class),
	answer(Answer, Class, Reference).
% ceo of company
query(ReferenceQ, 'of', Class, Answer) :-
	reference(ReferenceQ, Reference),
	reference_of(Reference, Class),
	answer(Answer, Class, Reference).
% age of ceo of 'ACME'
query(Attribute2Q, 'of', Attribute1Q, 'of', ClassQ, Answer) :-
	query(Attribute1Q, 'of', ClassQ, Answer1),
	query(Attribute2Q, 'of', Attribute1Q, Answer2),
	answer(Answer, Answer1, Answer2).

% :::::::: database ::::::::

db('ACME', company).
db('Bugs Bunny', ceo).