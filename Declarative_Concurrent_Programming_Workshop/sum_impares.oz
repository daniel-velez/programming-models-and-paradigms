declare
fun {Gen N End}
   if N < End then
      N | {Gen (N+1) End}
   else nil
   end
end

declare
fun {Sum Xs R}
   case Xs
   of H|T then
      {Sum T (R+H)}
   else R
   end
end

local Xs Ys Result in
   thread Xs = {Gen 0 10000} end %Productor
   thread Ys = {Filter Xs fun {$ A} A mod 2 \= 0 end} end  %Transductor
   thread {Delay 1000} Result = {Sum Ys 0} end %Consumidor
   {Browse Result}
   {Browse Ys}
end
      

local L = [1 2 3 4] in
   {Browse {Filter L fun {$ A} A>1 end}}
end