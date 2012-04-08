% q(Q,[]).
q --> field(Class), object(Class).

field(company) --> [name].
field(company) --> [size].
object(company) --> [company].

field(ceo) --> [salary].
object(ceo) --> [ceo].