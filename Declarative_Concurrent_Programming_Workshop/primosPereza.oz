% a)
declare
fun lazy {Gen I}
   I | {Gen I+1}
end

%b)
declare
fun lazy {LFilter Xs P}
   case Xs
   of nil then
      nil
   [] X|Xr then
      if {P X} then
	 X|{LFilter Xr P}
      else {LFilter Xr P}
      end
   end
end

declare
fun lazy {Criba Xs}
   local X|Xr = Xs in
      X | {Criba {LFilter Xr fun {$ Y} Y mod X \= 0 end }}
   end
end
      


declare
fun lazy {Primes}
   {Criba {Gen 2}}

declare
fun {ShowPrimes N}
   local Xs = {Primes} in
      _ = {List.nth Xs N}
      Xs
   end
end

{Browse {ShowPrimes 10}}



declare L   
L = {Primes}
{Browse L}
{Browse {List.nth L 16}}