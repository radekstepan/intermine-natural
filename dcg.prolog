q --> attribute(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}.
q --> reference(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}.
% name of ceo of company
q --> attribute(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}
	,prep, class(Type3), {is_child(Type1, Type3)}.
q --> reference(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}
	,prep, class(Type3), {is_child(Type1, Type3)}.

prep --> [of].

field(Type) --> attribute(Type).
field(Type) --> reference(Type).

class(company) --> [company].
class(ceo) --> [ceo].

attribute(company) --> [name].
attribute(ceo) --> [name].
attribute(ceo) --> [salary].

% reference(company, [ceo|A], A).
reference(company) --> [ceo].
% reference(ceo, [computer|A], A).
reference(ceo) --> [computer].

is_same(Type, Type).
is_child(Type1, Type2) :-
	reference(Type2, [Type1, A], A).