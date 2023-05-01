% ShowArray: procedimiento que muestra en el Browser el contenido del Array A.
%
declare
proc {ShowArray A}
   {Browse {Array.toRecord array A}}
end

% ListToArray: función que retorna un Array creado a partir de los elementos de una lista L ingresada.
%
% L: lista no vacía
%
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
local
   L = [1#2 2#3 3#4 4#5]
   A = {ListToArray L}
in
   {Browse a_1#A.1}
   {ShowArray A}
end


% ObtenerAmistades retorna un diccionario cuyos elementos son de la forma
% (Key, L) donde Key corresponde a la persona I y L a una lista de sus amistades.
%
% Amistades: La lista de parejas inicial del problema.
%
declare
fun {ObtenerAmistades Amistades}
   D = {NewDictionary}
in
   for I#J in Amistades do
      AuxI = {Dictionary.condGet D I nil}
      AuxJ = {Dictionary.condGet D J nil}
   in
      % I es amigo de J.
      if AuxI \= nil then
	 D.I := {List.append AuxI [J]}
      else D.I := [J]
      end
      % J es amigo de A.
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
   {Browse A.1} % Lista de los amigos de 1.
end

% EsAmigo: Función utilizada para comprobrar que J es amigo de I, retorna true
% en caso afirmativo y false en caso contrario.
%
% I: Persona I
%
% J: Persona J
%
% Amigos: Lista de amigos de I.
%
declare
fun {EsAmigo I J Amigos}
   case Amigos
   of A|Js then
      if A == J then true
      else {EsAmigo I J Js}
      end
   else false
   end
end

% Ejemplo
local
   I = 1
   J = 4
   CD = 274
   AmigosI = [2 3 4 5]
in
   {Browse {EsAmigo I J AmigosI}} % true
   {Browse {EsAmigo I CD AmigosI}} % false
end

% CobrarTerceros: Procedimiento utilizado para que la persona I pueda cobrar su dinero mediante
% sus relaciones indirectas con las otras personas, i.e. amigos de sus amigos.
%
% I: Persona que va a cobrar su dinero.
%
% J: Amigo o persona relacionada indirectamente con I.
%
% Monto: Celda cuyo contenido corresponde al monto que va a cobrar I.
%
% Deudas: Array obtenido de transformar la tupla original de Deudas del problema con el fin de modificar sus valores.
%
% Amistades: Diccionario cuya clave corresponde a una persona (número) y el valor a una lista de sus amistades.
%
% Consultados: Diccionario cuya clave corresponde a una persona a la que I ya ha intentado cobrarle y
% cuyo valor es true.
%
declare
proc {CobrarTerceros I J Monto Deudas Amistades Consultados}
   AmigosJ = Amistades.J
in
   {Show amigos#J#AmigosJ}
   for AJ in AmigosJ do
      if {Not {Dictionary.condGet Consultados AJ false}} then
	 Consultados.AJ := true
	 if {And (AJ \= I) (@Monto \= 0)} then
	    % AJ debe dinero.
	    if Deudas.AJ > 0 then 
	       Monto := Deudas.AJ + @Monto
	       if @Monto >= 0 then
		  Deudas.AJ := @Monto
		  Monto := 0
		  Deudas.I := 0
	       else
		  Deudas.AJ := 0
	       end
            % AJ no debe dinero.
	    else
	       {CobrarTerceros I AJ Monto Deudas Amistades Consultados}
	    end
	 end
      end
   end
end


% Cobrar: procedimiento utilizado para que la persona I pueda cobrar el dinero que le corresponde.
%
% Amistades: Diccionario cuya clave corresponde a una persona (número) y el valor a una lista de sus amistades.
%
% Deudas: Array obtenido de transformar la tupla original de Deudas del problema con el fin de modificar sus valores.
declare
proc {Cobrar I Amistades Deudas}
   RelacionesI = Amistades.I
   H = {List.length RelacionesI}
   Monto = {NewCell Deudas.I}
   Consultados = {NewDictionary} 
in
   %for J in {List.nth RelacionesI @N}; {And (@Monto \= 0) (@N =< H)}  ; {List.nth RelacionesI @N}  do
   for Index in 1..H  do
      J = {List.nth RelacionesI Index}
   in
      {Dictionary.put Consultados J true}
      if @Monto \= 0 then
	 % La persona J debe dinero.
	 if Deudas.J > 0 then
	    Monto := Deudas.J + @Monto
	    % I cobra completamente su dinero y se actualiza el dinero de J.
	    if @Monto >= 0 then 
	       Deudas.J := @Monto
	       Monto := 0
	       Deudas.I := 0
	    else
	       % Se terminó el dinero de J pero I no ha cobrado completamente.
	       Deudas.J := 0
	       % Trata de cobrar por medio de los amigos de J.
	       {CobrarTerceros I J Monto Deudas Amistades Consultados} 
	    end
	 % A J le deben dinero.
	 else 
	    % I trata de cobrar por medio de los amigos de J.
	    {CobrarTerceros I J Monto Deudas Amistades Consultados} 
	 end 
      end % monto \= 0
   end
end


% ValidarPagos: función utilizada para comprobar que todos los pagos se han efectuado,
% retorna true en de ser así y false en caso contrario.
%
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
%
% Amistades: corresponde a una lista de parejas I#J que representan que la persona I mantiene
% una relación de amistad con la persona J
%
% Deudas:  corresponde a una tupla de valores enteros (positivos y negativos) donde la
% posición I en esta tupla corresponde al dinero que debe o le es debido a la persona I
% (positivo si debe dinero y negativo si le es debido).
declare
fun {PagoDeuda Amistades Deudas}
   DAmistades = {ObtenerAmistades Amistades}
   ADeudas = {ListToArray Deudas}
   L = {Array.low ADeudas}
   H = {Array.high ADeudas}
in
   for I in L..H do
      % le deben a I.
      if ADeudas.I < 0 then 
	 {Cobrar I DAmistades ADeudas}
      end
   end
   {ValidarPagos ADeudas}
end

% Pruebas
{Browse {PagoDeuda [1#2 2#3 4#5] [100 ~75 ~25 ~42 42]}} %true
{Browse {PagoDeuda [1#3 2#4] [15 20 ~10 ~25]}} %false

{Browse {PagoDeuda [1#2 2#3 3#4] [~100 ~10 ~15 125]}} % true
{Browse {PagoDeuda [1#2 3#4 5#1] [~10 ~20 ~100 100 30]}} % true
{Browse {PagoDeuda [1#4 4#2 3#5] [100 5 ~100 ~15 10]}} % false