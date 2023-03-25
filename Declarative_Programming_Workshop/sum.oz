% recursive approach
declare
fun {Sum N}
   if N == 0 then 0
   else N + {Sum N-1}
   end
end


% iterative approach
declare
fun {Sum N}
   fun {SumIt N Result}
      if N == Result then N
      else Result + {SumIt N Result+1}
      end
   end
in
  {SumIt N 1}    
end

local L M in
   L = 2
   M = 3
   {Browse {Sum 10}}
end
