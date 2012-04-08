q --> attribute(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}.
q --> reference(Type1), prep, class(Type2)
	,{is_same(Type1, Type2)}.
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
class(computer) --> [computer].

attribute(company) --> [name].
attribute(ceo) --> [name].
attribute(ceo) --> [salary].
attribute(computer) --> [processor].

reference(company) --> [ceo].
reference(ceo) --> [computer].

is_same(Type, Type). % same type
is_child(Type1, Type2) :- % direct child
	reference(Type2, [Type1, A], A).
is_child(Type1, Type2) :- % sub child
	reference(T, [Type1, A], A),
	is_child(T, Type2).