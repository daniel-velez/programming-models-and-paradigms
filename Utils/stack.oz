declare
fun {PilaNueva}
   C = {NewCell nil}
   proc {Colocar E} C := E|@C end
   fun {Sacar} case @C of X|S1 then C := S1 X end end
   fun {EsVacia} @C == nil end
in
   proc {$ Msj}
      case Msj
      of colocar(X) then {Colocar X}
      [] sacar(?E) then E = {Sacar}
      [] esVacia(?B) then B = {EsVacia}
      end
   end
end

declare L
P = {PilaNueva}
{Browse P}
{P sacar(L)}
{Browse L}


{Browse S}
declare P in
local S in
   thread {NewPort S P} end
   thread {ForAll S Browse} end
end
{Send P hola}
{Send P hol2}
{Browse s#S}