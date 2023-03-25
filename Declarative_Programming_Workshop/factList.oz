declare
fun {FactList N}
   fun {Fact N R}
      if N == 1 then R
      else {Fact N-1 N*R}
      end
   end
in    
   {Fact N 1}
end

local L R in
   L = 1
   R = {FactList 5}
   {Browse R}
end


declare
fun {FactList N}
   fun {Fact N L R}
      if N == L then R | nil
      else  R | {Fact N+1 L R*(N+1)}
      end
   end
in    
   {Fact 1 N 1}
end

local N in
   N = 5
   {Browse {FactList N}}
end

