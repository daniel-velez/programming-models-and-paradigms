declare
fun {NuevoObjetoPuerto Comp Inic}
   proc {MsgLoop S1 Estado}
      case S1 of Msg|S2 then
	 {MsgLoop S2 {Comp Msg Estado}}
      [] nil then skip
      end
   end
   Sin
in
   thread {MsgLoop Sin Inic} end
   {NewPort Sin}
end


declare
proc {NuevaCelda X C}
   C = {NuevoObjetoPuerto
	fun {$ Msg Estado}
	   case Msg
	   of acceder(X) then X = Estado Estado
	   [] asignar(X) then X
	   end
	end
	_}
   {Send C asignar(X)}
end


declare
proc {Acceder X C}
   {Send C acceder(X)}
end

declare
proc {Asignar X C}
   {Send C asignar(X)}
end



% Ejemplo
declare X1 X2 X3 C
{NuevaCelda 1 C}
{Acceder X1 C}
{Browse x1#X1}

{Asignar ping C}
{Acceder X2 C}
{Browse X2}

{Asignar pong C}
{Acceder X3 C}
{Browse X3}
