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

% resolve both attributes and references
attrRef(AttributeQ, Class, Attribute) :-
	attribute(AttributeQ, Attribute),
	attribute_of(Attribute, Class).
attrRef(ReferenceQ, Class, Reference) :-
	reference(ReferenceQ, Reference),
	reference_of(Reference, Class).

% :::::::: language rules ::::::::

% age of 'Bugs Bunny'
% ceo of 'ACME'
query(AttrRefQ, 'of', ClassQ, Answer) :-
	db(ClassQ, Class), query(AttrRefQ, 'of', Class, Answer).

% age of ceo
% ceo of company
query(AttrRefQ, 'of', Class, Answer) :-
	attrRef(AttrRefQ, Class, AttrRef),
	answer(Answer, Class, AttrRef).

% age of ceo of company
query(AttrRef2Q, 'of', AttrRef1Q, 'of', Class, Answer) :-
	query(AttrRef1Q, 'of', Class, Answer1),
	query(AttrRef2Q, 'of', AttrRef1Q, Answer2),
	answer(Answer, Answer1, Answer2).

% :::::::: database ::::::::

db('ACME', company).
db('Bugs Bunny', ceo).