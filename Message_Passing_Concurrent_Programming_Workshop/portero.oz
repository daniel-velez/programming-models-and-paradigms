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
fun {Portero}
   P = {NuevoObjetoPuerto
	fun {$ Msg Estado}
	   case Msg
	   of getIn(N) then Estado+N
	   [] getOut(N) then Estado-N
	   [] getCount(N) then N = Estado
	   end
	end
	0}
in
   proc {$ Msg}
      {Send P Msg}
   end
end


declare Port = {Portero} N
{Port getIn(4)}
{Port getOut(2)}
{Port getCount(N)}
{Browse N} %2
