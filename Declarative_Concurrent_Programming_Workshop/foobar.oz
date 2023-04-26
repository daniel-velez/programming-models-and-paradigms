%Bar
declare
proc {Bar N Xs}
   case Xs of X|Xr then
      {Delay 3000} %3000
      X = N
      {Bar N Xr}
   end
end

% Foo
declare
proc {Foo Xs Limite}
   {Delay 1000}
   if Limite > 0 then
      X|Xr = Xs
   in
      {Delay 24000} % 24000
      {Foo Xr Limite-1}
   end
end


%Mesa
declare
proc {Mesa N ?Xs Ys}
   fun {Iniciar N ?Xs}
      if N == 0 then Xs
      else Xr in
	 Xs = _|Xr
	 {Iniciar (N-1) Xr}
      end
   end
   proc {CicloAtender Ys ?Xs ?Final}
      case Ys
      of Y|Yr then
	 Xr Final2 in
	 Xs = Y|Xr
	 Final = _|Final2
	 {CicloAtender Yr Xr Final2}
      end
   end
   Final = {Iniciar N Xs} 
in
   {CicloAtender Ys Xs Final}
end
   

local Xs Ys in
   thread {Bar c Xs} end 
   thread {Mesa 5 Xs Ys} end
   thread {Foo Ys 15} end
   {Browse inicia_la_sesion}
   {Browse Xs}
   {Browse Ys}
end 
      