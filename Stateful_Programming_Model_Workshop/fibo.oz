declare
fun {Fib N}
   F0 = {NewCell 1}
   F1 = {NewCell 1}
   Aux = {NewCell 0}
in
   if N < 2 then @F1
   else
      for X in 2..N do
	 Aux := @F1
	 F1 := @F0 + @F1
	 F0 := @Aux
      end
      @F1
   end
end

{Browse {Fib 0}}