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


% Otras pruebas
declare InS
{Browse {Counter InS}}
declare Ys
InS = a|b|c|d|a|c|d|b|Ys
Ys = a|a|a|c|nil


% Modelo cliente-servidor

% Primera Implementación
local
   Xs
   C1 = a|b|c|_%a|b|c|a|b|c|a|_
   C2 = b|c|a|_%b|c|a|b|c|a|b|c|_
   C3 = c|a|b|_%c|a|b|c|a|b|c|a|b|c|a|b|_
   fun lazy {Client L} case L of H|T then H|{Client T} else nil end end
in
   {Browse {Counter Xs}}
   thread Xs = {Client C1} end
   thread Xs = {Client C2} end
   thread Xs = {Client C3} end
end 		    


% Pruebas
% Primera Implementación
local
   Xs
   C1 = a|b|c|a|b|c|a|b|c|a|_
   C2 = b|c|a|b|c|a|b|c|a|b|c|_
   C3 = c|a|b|c|a|b|c|a|b|c|a|b|c|a|b|_
   C4 = c|a|b|c|a|b|c|a|b|c|a|b|c|_
   fun lazy {Client L} case L of H|T then H|{Client T} else nil end end
in
   {Browse {Counter Xs}}
   thread Xs = {Client C1} end
   thread Xs = {Client C2} end
   thread Xs = {Client C3} end
   thread Xs = {Client C4} end
end 		    

