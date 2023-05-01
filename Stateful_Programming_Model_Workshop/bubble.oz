declare
proc {BubbleSort A}
   Len = {Array.high A} - {Array.low A} + 1
   Aux = {NewCell 0}
in
   for I in 1..(Len - 1) do
      for J in 1..(Len-I) do
	 if A.J > A.(J+1) then
	    Aux := A.J
	    A.J := A.(J+1)
	    A.(J+1) := @Aux
	 end
      end
   end
end

declare
proc {ShowArray A}
   {Browse {Array.toRecord array A}}
end

local L = {NewArray 1 10 1} in
   L.1 := 10
   L.2 := 9
   L.3 := 8
   L.4 := 7
   L.5 := 6
   L.6 := 5
   L.7 := 4
   L.8 := 3
   L.9 := 2
   L.10 := 1
   {ShowArray L}
   {BubbleSort L}
   {ShowArray L}
end