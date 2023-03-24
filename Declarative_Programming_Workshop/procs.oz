declare
fun {Fact N}
   if N =< 0 then 1 end
end

declare
proc {FactProc N}
   if N =< 0 then {Browse 1} end
end


local A in
   A ={Fact 5}
   %A = 1
   {Browse A}
end


{FactProc 5}




   
   