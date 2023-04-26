declare
fun lazy {Generar N}
   N | {Generar N+1}
end

declare
fun lazy {LFilter L F}
   case L
   of nil then nil
   [] X|L2 then
      if {F X} then
	 X|{LFilter L2 F}
      else {LFilter L2 F}
      end
   end
end

declare
fun lazy {Sieve Xs}
   X|Xr = Xs in
   {Browse gen#Xs}
   X|{Sieve
      {LFilter Xr
       fun {$ Y} Y mod X \= 0 end}
     }
end
Primes = {Sieve {Generar 10}}
{Browse Primes}
{Browse {List.nth Primes 16}}