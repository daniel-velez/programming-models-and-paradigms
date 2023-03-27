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



local L = s(1.0 ss as) in
   {Browse L}
   {Browse L.1}
   {Browse L.2}
   {Browse L.3}
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



declare
fun {Limpiar F A V}
   if F == A then V
   else
      case F
      of s(LHS RHS) then
	 if LHS == 0 then RHS
	 elseif RHS == 0 then LHS
	 else
	    V1 = {Limpiar LHS A V}
	    V2 = {Limpiar RHS A V}
	 in
	    if V1 == 0 then V2
	    elseif V2 == 0 then V1
	    else
	       s(V1 V2)
	    end
	 end	 
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

local F = s(s(0 2) s(x 0)) in
   {Browse {Limpiar F x x}}
end
