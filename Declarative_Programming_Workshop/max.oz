fun {Max L}
   fun {MaxLoop L M}
      case L of nil then M
      [] H|T then
	 if M > H then {MaxLoop T M}
	 else {MaxLoop T H} end
      end
   end
in
   if L == nil then error
   else {MaxLoop L.2 L.1} end
end