declare
fun {Fib N}
   if N<2 then 1
   else
      {Fib N-1} + {Fib N-2}
   end
end

local N in
   N = 43%37
   {Browse {Fib N}}
end

declare
fun {Fib N}
   fun {FibIt N C Lhs Rhs}
      if N < 2 then 1
      elseif C == N then
	 Lhs + Rhs
      elseif C == 1 then
	 {FibIt N (C+1) 1 1}
      else
	 {FibIt N (C+1) Rhs (Lhs+Rhs)}
      end
   end
in
   {FibIt N 1 1 1}
end

local N in
   N = 4200
   {Browse {Fib N}}
end
