% root classes
class(company).
class(ceo).
class(employee).

% names of attrs, cols, refs
attribute(name).
reference(ceo).
collection(employees).

% for collections, link to class; allows us to say 'employee|employees' of Class
type(employees,employee).

% the model relations
relation(name,company).
relation(name,ceo).
relation(name,employee).
relation(ceo,company).
relation(employee,company).

% model rules
attribute(Attribute,Class) :-
	attribute(Attribute),relation(Attribute,Class). % company -> name
reference(ReferenceClass,Class) :-
	reference(ReferenceClass),relation(ReferenceClass,Class). % company -> ceo
collection(Collection,Class) :-
	type(Collection,CollectionClass),collection(Collection),relation(CollectionClass,Class). % company -> employees
collection(CollectionClass,Class) :-
	type(Collection,CollectionClass),collection(Collection),relation(CollectionClass,Class). % company -> employee

% language rules
query(Attribute, 'of', Class) :- attribute(Attribute,Class).
query(Reference, 'of', Class) :- reference(Reference,Class).
query(Collection, 'of', Class) :- collection(Collection,Class).