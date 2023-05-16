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
fun {Add L C R}
   case L
   of H|T then
      case H
      of Ca#Ocs then
	 if Ca == C then
	    {Append R (Ca#(Ocs+1) | T)}
	 else {Add T C {Append R [H]}}
	 end
      end
   else
      {Append R [C#1]}
   end
end	 


% Counter
% Output flujo de entrada que contiene caracteres, e.g. a|b|f|b|g
declare
fun {Counter Output}
   PAux = {NewPort Output}
   P = {NuevoObjetoPuerto
	fun {$ Msg Estado}
	   NuevoEstado = {Add Estado Msg nil}
	in
	   {Send PAux NuevoEstado}
	   NuevoEstado
	end
	nil}
in
  P
end


% Modelo cliente-servidor  

% Pruebas
% Primera Implementación
local
   Output
   Server = {Counter Output}
   C1 = a|b|c|a|b|c|a|b|c|a|_ %10
   C2 = b|c|a|b|c|a|b|c|a|b|c|_ %11
   C3 = c|a|b|c|a|b|c|a|b|c|a|b|c|a|b|_ %15
   C4 = c|a|b|c|a|b|c|a|b|c|a|b|c|_ % 13 -> 49
   proc {Client L} case L of H|T then {Send Server H}{Client T}  end end
in
   {Browse Output}
   thread {Client C1} end
   thread {Client C2} end
   thread {Client C3} end
   thread {Client C4} end
end 		    
