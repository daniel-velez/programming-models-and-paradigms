declare
proc {DGenerar N Xs}
   case Xs of X|Xr then
      X = N
      {DGenerar N+1 Xr}
   end
end

declare
fun {DSuma ?Xs A Limit}
   {Delay 1000}
   if Limit > 0 then
      X|Xr = Xs
   in
     {DSuma Xr A+X Limit-1}
   else A end
end

declare
proc {MemIntermedia N ?Xs Ys}
   fun {Iniciar N ?Xs}
      if N == 0 then Xs
      else Xr in Xs = _|Xr {Iniciar N-1 Xr} end
   end
   proc {CicloAtender Ys ?Xs ?Final}
      case Ys of Y|Yr then Xr Final2 in
	 Xs = Y|Xr
	 Final = _|Final2
	 {CicloAtender Yr Xr Final2}
      end
   end
   Final = {Iniciar N Xs}
in
   {CicloAtender Ys Xs Final}
end


local Xs Ys S in
   thread {DGenerar 0 Xs} end
   thread {MemIntermedia 4 Xs Ys} end
   thread S = {DSuma Ys 0 /*15000*/ 15} end
   {Browse Xs} {Browse Ys}
   {Browse S}
end