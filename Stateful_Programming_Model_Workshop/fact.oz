declare
fun {Fact N}
   R = {NewCell 1}
in
   for X in 0..N do
      if X \= 0 then R := @R * X
      else skip end
   end
   @R
end

{Browse {Fact 1}}