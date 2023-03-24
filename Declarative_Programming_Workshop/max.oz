declare
fun {Max L}
   fun {MaxLoop L M}
      case L of nil then M
      [] H|T then
	 if M > H then {MaxLoop T M}
	 else {MaxLoop T H} end
      end
   end
in
   if L == nil then error
   else {MaxLoop L.2 L.1} end
end

local L in
   L = [2 4 ~5 1]
   { Browse {Max L} }
end


local
   Max = proc {$ L R}
	    local 
	       MaxLoop = proc {$ L M}
			    case L of nil then R = M
			    [] H|T then
			       if M > H then {MaxLoop T M}
			       else {MaxLoop T H}
			       end
			    end
			 end
	    in
	       if L == nil then R = error
	       else {MaxLoop L.2 L.1}
	       end
	    end
	 end
   R
in
   {Max [1 2 3 ~51 23] R}{Browse R}
end
		       


declare
fun {SumList List}
   case List of nil then 0
   [] H|T then
      case H of H2|T2 then {SumList H}+{SumList T}
      else H+{SumList T} % pattern matching on lists
      end
   end
end

local LS A in
   LS = [[1 2] [3 4]]
   A = {SumList LS}
   {Browse A}
end
