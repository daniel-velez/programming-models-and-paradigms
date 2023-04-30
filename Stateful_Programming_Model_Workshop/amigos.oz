% ShowArray: procedimiento que muestra en el Browser el contenido del Array A.
declare
proc {ShowArray A}
   {Browse {Array.toRecord array A}}
end

% ListToArray: función que retorna un Array creado a partir de los elementos de una lista L ingresada
% L: lista no vacía
declare
fun {ListToArray L}
   Len = {List.length L}
   Array = {NewArray 1 Len 0}
in
   for I in 1..Len do
      Array.I := {List.nth L I}
   end
   Array
end

% Ejemplo de uso
local L = [1#2 2#3 3#4 4#5] in
   {ShowArray {ListToArray L}}
end


% ObtenerAmistades retorna un diccionario cuyos elementos son de la forma
% (Key, L) donde Key corresponde a la persona I y L a una lista de sus amistades.
% Amistades: La lista de parejas inicial del problema.
declare
fun {ObtenerAmistades Amistades}
   D = {NewDictionary}
in
   for I#J in Amistades do
      AuxI = {Dictionary.condGet D I nil}
      AuxJ = {Dictionary.condGet D J nil}
   in
      if AuxI \= nil then
	 D.I := {List.append AuxI [J]}
      else D.I := [J]
      end
      
      if AuxJ \= nil then
	 D.J := {List.append AuxJ [I]}
      else D.J := [I]
      end
   end
   D
end

% Ejemplo
local
   L = [1#2 3#1 1#4 5#1]
   A = {ObtenerAmistades L}
in
   {Browse A.3} % Lista de los amigos de 1.
end

% Cobrar: procedimiento utilizado para que la persona I pueda cobrar el dinero que le corresponde
% Amistades: Diccionario cuya clave corresponde a una persona (número) y el valor a una lista de sus amistades.
% Deudas: Array obtenido de transformar la tupla original de Deudas del problema con el fin de modificar sus valores.
declare
proc {Cobrar I Amistades Deudas}
   RelacionesI = Amistades.I
   H = {List.length RelacionesI}
   Monto = {NewCell Deudas.I}
in
   %for J in {List.nth RelacionesI @N}; {And (@Monto \= 0) (@N =< H)}  ; {List.nth RelacionesI @N}  do
   for Index in 1..H  do
      J = {List.nth RelacionesI Index}
   in
      if @Monto \= 0 then
	 if Deudas.J > 0 then % La persona J debe dinero
	    Monto := Deudas.J + @Monto
	    if @Monto >= 0 then % I cobra completamente su dinero y se actualiza el dinero de J
	       Deudas.J := @Monto
	       Monto := 0
	       Deudas.I := 0
	    else
	       Deudas.J := 0 % Se terminó el dinero de J pero I no ha cobrado completamente
	       % Cobro mediante relaciones indirectas
	       AmigosJ = Amistades.J
	    in
	       for AJ in AmigosJ do
		  if @Monto \= 0 then
		     if Deudas.AJ > 0 then
			Monto := Deudas.AJ + @Monto
			if @Monto >= 0 then
			   Deudas.AJ := @Monto
			   Monto := 0
			   Deudas.I := 0
			else
			   Deudas.AJ := 0
			end
		     end
		  end
	       end
	    end
	 else
	    AmigosJ = Amistades.J
	 in
	    for AJ in AmigosJ do
	       if @Monto \= 0 then
		  if Deudas.AJ > 0 then
		     Monto := Deudas.AJ + @Monto
		     if @Monto >= 0 then
			Deudas.AJ := @Monto
			   Monto := 0
			Deudas.I := 0
		     else
			Deudas.AJ := 0
		     end
		  end
	       end
	    end
	 end % else
      end % monto \= 0
   end
end


% ValidarPagos: función utilizada para comprobar que todos los pagos se han efectuado,
% retorna true en de ser así y false en caso contrario.
% Pagos: Array de los montos de las Deudas (modificado).
declare
fun {ValidarPagos Pagos}
   Exito = {NewCell true}
   L = {Array.low Pagos}
   H = {Array.high Pagos}
in
   for I in L..H do
      if Pagos.I \= 0 then
	 Exito := false
      end
   end
   @Exito
end

% PagoDeuda: función que determina si es posible que todas las deudas sean pagadas entre las
% personas si solo se pasa dinero entre personas que aún son amigas.
% Amistades: corresponde a una lista de parejas I#J que representan que la persona I mantiene
% una relación de amistad con la persona J
% Deudas:  corresponde a una tupla de valores enteros (positivos y negativos) donde la
% posición I en esta tupla corresponde al dinero que debe o le es debido a la persona I
% (positivo si debe dinero y negativo si le es debido).
declare
fun {PagoDeuda Amistades Deudas}
   DAmistades = {ObtenerAmistades Amistades}
   ADeudas = {Tuple.toArray Deudas}
   L = {Array.low ADeudas}
   H = {Array.high ADeudas}
in
   for I in L..H do
      if ADeudas.I < 0 then % le deben a I.
	 {Cobrar I DAmistades ADeudas}
      end
   end
   {ValidarPagos ADeudas}
end

% Pruebas
{Browse {PagoDeuda [1#2 2#3 4#5] s(100 ~75 ~25 ~42 42)}}
{Browse {PagoDeuda [1#3 2#4] s(15 20 ~10 ~25)}}



