
declare
proc {ClauTransEstado GM}
   L = {Array.low GM}
   H = {Array.high GM}
in
   for K in L..H do
      for I in L..H do
	 if GM.I.K then
	    for J in L..H do
	       if GM.K.J then
		  GM.I.J := true
	       end
	    end
	 end
      end
   end
end

declare
proc {ShowGraph GM}
   L = {Array.low GM}
   H = {Array.high GM}
in
   for I in L..H do
      for J in L..H do
	 {Browse I#J#GM.I.J}
      end
   end
end

local G = {Array.new 1 6 {Array.new 1 6 false}}
in
   G.1.2 := true
   G.2.3 := true
   G.3.4 := true
   G.4.5 := true
   G.5.2 := true
   G.6.2 := true
   {ShowGraph G}
   {ClauTransEstado G}
end

