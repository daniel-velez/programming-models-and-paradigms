declare
fun {Derivar F A}
   if F == A then 1
   else
      case F
      of s(LHS RHS) then
	 s({Derivar LHS A} {Derivar RHS A})
      [] r(LHS RHS) then
	 r({Derivar LHS A} {Derivar RHS A})
      [] m(LHS RHS) then
	 s( m({Derivar LHS A} RHS) m(LHS {Derivar RHS A}) )
      [] d(LHS RHS) then
	 d( r( m({Derivar LHS A} RHS) m(LHS {Derivar RHS A}) ) e(RHS 2) )
      [] l(E) then
	 d( {Derivar E A} E)
      [] e(B EXP) then
	 m( e(B EXP) s( d( m({Derivar B A} EXP) B ) m( {Derivar EXP A} l(B) ) ) )
      else 0 %constant case
      end
   end
end

local L = s(k m(3 x)) in
   {Browse {Derivar L x}}
end

local L = s  A = 2 in
   {Browse L==A}
end


declare
fun {Evaluar F A V}
   if F == A then V
   else
      case F
      of s(LHS RHS) then
	 {Evaluar LHS A V} + {Evaluar RHS A V}
      [] r(LHS RHS) then
	 {Evaluar LHS A V} - {Evaluar RHS A V}
      [] m(LHS RHS) then
	 {Evaluar LHS A V} * {Evaluar RHS A V}
      [] d(LHS RHS) then
	 {Evaluar LHS A V} / {Evaluar RHS A V}
      [] l(E) then
	 ln({Evaluar E A V})
      [] e(B EXP) then
	 {Power {Evaluar B A V} {Evaluar EXP A V}}
      else F
      end
   end
end

declare
fun {Power N P}
   fun {PowerIt N P R}
      if P == 0 then 1
      elseif P == 1 then R
      elseif (P-1) == 0 then N*R
      else {PowerIt N (P-1) (R*N)}
      end
   end
in
   {PowerIt N P N}
end

local A in
   {Browse {Evaluar d(2.0 x) x 4.0}}
end

local A in
   {Browse {Evaluar s(0.0 s(m(0.0 x) m(3.0 1.0))) x x}}
end
