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
% Xs flujo de entrada que contiene caracteres, e.g. a|b|f|b|g
declare
fun {Counter Xs}
   fun {CounterIt Xs L}
      case Xs
      of H|T then
	 NewL
      in
	 NewL = {Add L H nil}
	 NewL | {CounterIt T NewL}
      else nil
      end
   end
in
  thread {CounterIt Xs nil} end
end


% Ejemplo
local InS in
   {Browse {Counter InS}}
   InS = a|b|a|c|_
end


% Modelo cliente-servidor
% Primera Implementación

local
   Xs
   Server = {NewPort Xs}
   C1 = a|b|c|a|b|c|a|b|c|a|_ %10
   C2 = b|c|a|b|c|a|b|c|a|b|c|_ %11
   C3 = c|a|b|c|a|b|c|a|b|c|a|b|c|a|b|_ %15
   C4 = c|a|b|c|a|b|c|a|b|c|a|b|c|_ % 13 -> 49
   proc {Client L} case L of H|T then {Send Server H}{Client T}  end end
in
   {Browse {Counter Xs}}
   thread {Client C1} end
   thread {Client C2} end
   thread {Client C3} end
   thread {Client C4} end
end 		    

% Ejemplo figura
local
   Xs
   Server = {NewPort Xs}
   C1 = a|c|_
   C2 = b|c|_
   C3 = a|_
   proc {Client L} case L of H|T then {Send Server H}{Client T} end end
in
   {Browse {Counter Xs}}
   thread {Client C1} end
   thread {Client C2} end
   thread {Client C3} end
end