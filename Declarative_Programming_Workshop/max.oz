
% functional notation
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


% procedural notation
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