declare
fun {SymCon L1 L2}
   fun {SymConIt L2 Lhs LogL1 LogL2 R}
      case L2
      of nil then
	 LogL1 = L1
	 LogL2 = Lhs
	 R
      %[] L1#nil then nil#2 tal vez no es necesario
      [] H|T
      then AnonL1 AnonL2 in	 
	 {SymConIt T (H|Lhs) (AnonL1|LogL1) (AnonL2|LogL2) (AnonL1#AnonL2 | R)}
      end
   end
in
   {SymConIt L2 nil nil nil nil}
end

local
   L = [1 2 3 4 5 6 7 8]
   La = [9 10 11 12 13 14 15 16]
   R = [1#A 2#B]
   A
   B
in
   %{Browse {SymCon L R}}
   %{Browse R}
   A = 4
   B = 3
   {Browse {SymCon L La}}
end      


declare
fun {Reverse L}
   fun {ReverseIt L Lhs}
      case L of nil then nil
      [] H|T then
	 if T == nil then  H | Lhs
	 else
	    {ReverseIt T (H|Lhs)}
	 end
      end
   end
in
   {ReverseIt L nil}
end

