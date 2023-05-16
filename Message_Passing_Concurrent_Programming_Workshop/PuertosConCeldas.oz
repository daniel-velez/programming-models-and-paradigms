declare
proc {NuevoPuerto S P}
   AuxCell = {NewCell S}
   proc {EnviarIn V}
      Foo
      NewVal = @AuxCell
   in
      NewVal = V|Foo
      AuxCell := Foo
   end
   
in
   P = proc {$ Op}
	  case Op
	  of enviar(X) then {EnviarIn X}
	  end
       end
end

declare
proc {Enviar P X}
   {P enviar(X)}
end

% Ejemplo 1
declare S P
{NuevoPuerto S P}
{Browse S}
{Enviar P a}
{Enviar P b}

% Ejemplo 2
declare P 
local S in
   {NuevoPuerto S P}
   thread {ForAll S Browse} end
   {Browse S}
end
{Enviar P hola}
{Enviar P hola2}
{Enviar P nil}
