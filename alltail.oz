declare
proc {ForAllTail Xs P}
   case Xs of nil then skip
   [] H|T then
      {P Xs}{ForAllTail T P}
   end
end

local
   L = [1 2 3 4]
in
   {ForAllTail L Browse}
end