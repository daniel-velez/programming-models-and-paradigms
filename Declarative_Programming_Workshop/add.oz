declare
fun {Add B1 B2}
   local
      I1 = {ToInt B1}
      I2 = {ToInt B2}
   in
      {ToBin I1+I2}
   end
end


local
   L1 = [1 1 0 1 1 0]
   L2 = [0 1 0 1 1 1]
in
   {Browse {Add L1 L2}}
end


declare
fun {Length L}
   fun {LengthIt L R}
      case L of nil then R
      [] H|T then
	 {LengthIt T R+1}
      end
   end
in
   {LengthIt L 0}
end

local
   L = 2
in
   {Browse L**3}
end

declare
fun {Power N P}
   if P == 0 then 1
   else
      N * {Power N (P-1)}
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


local
   N = 0
in
   {Browse {Power 3 5}}
end



declare
fun {ToInt B}
   local
      Len = {Length B} - 1
      fun {ToIntIt Rhs Mult R}
	 case Rhs of H|T then
	    {ToIntIt T (Mult-1) R+(H*{Power 2 Mult})}
	 else R
	 end
      end
   in
      {ToIntIt B Len 0}
   end
end

local
   B = [1 0 1]
in
   {Browse {ToInt B}}
end

local A=5 B=2 in
   {Browse 11 div 2}
end



declare
fun {ToBin D}
   fun {ToBinIt D B}
      if D >= 1 then
	 {ToBinIt (D div 2)  ((D mod 2) | B)}
      elseif D == 0 andthen B == nil then [0]
      else
	 B
      end
   end
in
   {ToBinIt D nil}
end


local D = 5 in
   {Browse {ToBin D}}
end