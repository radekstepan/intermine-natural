% q(Q,[]).
q --> field, prep, object.

field --> attribute.
field --> reference.
field --> collection.

attribute --> [name].
reference --> [ceo].
collection --> [departments].

prep --> [of].

object --> [company].