declare
fun {Not V}
   1-V
end

declare
fun {CompuertaNot Xs}
   case Xs
   of X|Xr then
      {Not X} | {CompuertaNot Xr}
   else nil
   end
end

local Xs = [1 0 1 0 1 1 1] in
   {Browse {CompuertaNot Xs}}
end

declare
fun {And X Y}
   X*Y
end

declare
fun {CompuertaAnd Xs Ys}
   case Xs#Ys
   of (X|Xr)#(Y|Yr) then
      {And X Y} | {CompuertaAnd Xr Yr}
   else nil
   end
end

local Xs = [1 0 1 0] Ys = [1 1 0 0] in
   {Browse {CompuertaAnd Xs Ys}}
end


declare
fun {Or X Y}
   X + Y - (X*Y)
end

declare
fun {CompuertaOr Xs Ys}
   case Xs#Ys
   of (X|Xr)#(Y|Yr) then
      {Or X Y} | {CompuertaOr Xr Yr}
   else nil
   end
end


local Xs = [1 0 1 0] Ys = [1 1 0 0] in
   {Browse {CompuertaOr Xs Ys}}
end

declare
fun {Xor X Y}
   X+Y-2*X*Y
end

declare
fun {CompuertaXor Xs Ys}
   case Xs#Ys
   of (X|Xr)#(Y|Yr) then
      {Xor X Y} | {CompuertaXor Xr Yr}
   end
end


declare
fun {Simulate G Ss}
   case G
   of gate(value:Op In1) then
      case Op
      of 'not' then
	 case In1
	 of input(V) then
	    {CompuertaNot Ss.V}
	 else
	    {CompuertaNot thread {Simulate In1 Ss} end}
	 end
      end
   [] gate(value:Op In1 In2) then
      case Op
      of 'and' then
	 case In1#In2
	 of input(V1)#input(V2) then
	    {CompuertaAnd Ss.V1 Ss.V2}
	 [] input(V1)#gate(...) then
	    {CompuertaAnd Ss.V1 thread {Simulate In2 Ss} end}
	 [] gate(...)#input(V2) then
	    {CompuertaAnd thread {Simulate In1 Ss} end Ss.V2}
	 else {CompuertaAnd thread {Simulate In1 Ss} end thread {Simulate In2 Ss} end}
	 end
      [] 'or' then
	 case In1#In2
	 of input(V1)#input(V2) then
	    {CompuertaOr Ss.V1 Ss.V2}
	 [] input(V1)#gate(...) then
	    {CompuertaOr Ss.V1 thread {Simulate In2 Ss} end}
	 [] gate(...)#input(V2) then
	    {CompuertaOr thread {Simulate In1 Ss} end Ss.V2}
	 else {CompuertaOr thread {Simulate In1 Ss} end thread {Simulate In2 Ss} end}
	 end
      [] 'xor' then
	 case In1#In2
	 of input(V1)#input(V2) then
	    {CompuertaXor Ss.V1 Ss.V2}
	 [] input(V1)#gate(...) then
	    {CompuertaXor Ss.V1 thread {Simulate In2 Ss} end}
	 [] gate(...)#input(V2) then
	    {CompuertaXor thread {Simulate In1 Ss} end Ss.V2}
	 else {CompuertaXor thread {Simulate In1 Ss} end thread {Simulate In2 Ss} end}
	 end
      end
   end
end




local
   G = gate(value: 'not' input(x))%gate(value: 'not' input(x)))
   Ss = input(x: 1|0|1|0|0|_ y: 1|0|0|1|1|_)
   G1 = gate(value: 'and' input(x) input(y))
in
   {Browse thread {Simulate gate(value:'and' G input(y)) Ss} end}
end


% Prueba
local
   G = gate(value: 'or'
	    gate(value: 'and'
		 input(x)
		 input(y))
	    gate(value: 'not'
		 input(z)))
   Ss = input(x: 1|0|1|0|_
	      y: 0|1|0|1|_
	      z: 1|1|0|0|_)
in
   {Browse thread {Simulate G input(x: 1|0|1|0|_ y: 0|1|0|1|_ z: 1|1|0|0|_)} end}
end


% d) Sumador Completo de la Sección 4.3.5.1 de CTM.
declare
proc {SumadorCompleto X Y Z ?C ?S}
   K L M
   Ss = input(x:X y:Y z:Z)
in
   K = thread {Simulate gate(value:'and' input(x) input(y)) Ss} end %{CompuertaAnd X Y}
   L = thread {Simulate gate(value:'and' input(y) input(z)) Ss} end %{CompuertaAnd Y Z}
   M = thread {Simulate gate(value:'and' input(x) input(z)) Ss} end %{CompuertaAnd X Z}
   C = thread {Simulate gate(value:'or'
			     input(k)
			     gate(value:'or' input(l) input(m)))
	       input(k:K l:L m:M)}
       end
   %{CompuertaOr K thread {CompuertaOr L M} end}
   S = thread {Simulate gate(value:'xor'
			     input(z)
			     gate(value:'xor' input(x) input(y)))
	       Ss}
       end
   %{CompuertaXor Z thread {CompuertaXor X Y} end}
end

% Prueba
declare
X = 1|1|0|_
Y = 0|1|0|_
Z = 1|1|1|_ C S in
{SumadorCompleto X Y Z C S}
{Browse ent(X Y Z)#suma(C S)}

local
   X = 1|_
   Y = 1|_
   Z = 0|_
   C S
in
   {SumadorCompleto X Y Z C S}
   {Browse ent(X Y Z)#suma(C S)}
end