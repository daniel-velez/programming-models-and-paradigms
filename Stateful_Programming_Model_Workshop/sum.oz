declare
fun {Q A B}
   R = {NewCell 0}
in
   for X in A..B do
      R := @R + X
   end
   @R
end

{Browse {Q 1 10}}