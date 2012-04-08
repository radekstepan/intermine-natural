% root classes
class(ceo).

% model relations
attribute_of(age, ceo).
attribute_of(salary, ceo).

% grammar of relations
attribute('age', age).
attribute('salary', salary).
attribute('money', salary).

% answer format
answer([Class, Attribute], Class, Attribute).

% language rules
% query(Attribute,'of',Object, Answer).
query(AttributeQ, 'of', ClassQ, Answer) :-
	db(ClassQ, Class), attribute(AttributeQ, Attribute), attribute_of(Attribute, Class), answer(Answer, Class, Attribute).

% database
db('Bugs Bunny', ceo).