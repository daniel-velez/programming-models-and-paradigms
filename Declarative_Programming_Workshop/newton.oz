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
fun {Limpiar F}
   if F == 0 then 0
   else
      case F
      of s(LHS RHS) then
	 if LHS == 0 then {Limpiar RHS}
	 elseif RHS == 0 then {Limpiar LHS}
	 else
	    LHSR = {Limpiar LHS}
	    RHSR = {Limpiar RHS}
	    Result = nil
	 in
	    if LHSR == 0 then
	       if RHSR \= 0 then RHSR % {Limpiar RHSR}
	       else RHSR%{Browse RHSR} 0
	       end
	    elseif RHSR == 0 then LHSR%{Limpiar LHSR}
	    else s(LHSR RHSR)
	    end
	 end
      [] r(LHS RHS) then
	 if LHS == 0 then {Limpiar RHS}
	 elseif RHS == 0 then {Limpiar LHS}
	 else
	    LHSR = {Limpiar LHS}
	    RHSR = {Limpiar RHS}
	    Result = nil
	 in
	    if LHSR == 0 then
	       if RHSR \= 0 then RHSR % {Limpiar RHSR}
	       else RHSR%{Browse RHSR} 0
	       end
	    elseif RHSR == 0 then LHSR%{Limpiar LHSR}
	    else s(LHSR RHSR)
	    end
	 end
      [] m(LHS RHS) then
	 if LHS == 0 then 0
	 elseif RHS == 0 then 0
	 else
	    LHSR = {Limpiar LHS}
	    RHSR = {Limpiar RHS}
	 in
	    if LHSR == 0 then 0
	    elseif RHSR == 0 then 0
	    else m({Limpiar LHSR} {Limpiar RHSR})
	    end
	 end
      else F
      end
   end 
end


local
   S = s(2 3)
   L = s
in
   case L of _ then
      {Browse {Label S}}
   else { Browse 'nothing' }
   end
end

% S = s( 3 s(s(2 ~1) 3))
% S = s( s(0 3) s(s(s(2 s(0 ~1)) 0) s(0 3)))
local
   S = s(s(0 3) s(s(s(s(0 s(s(x 0) s(4 ~1))) s(0 ~1)) 0) s(0 3))) in
   {Browse {Limpiar S}}
end

local S = s(m(k s(m(0 1) s(k x))) m(x m(1 s(0 k)))) in
   {Browse {Limpiar S}}
end


