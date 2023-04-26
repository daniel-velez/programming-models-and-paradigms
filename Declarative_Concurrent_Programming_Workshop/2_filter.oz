declare
fun {Filter En F}
   case En of
      X|En2 then
      if {F X} then X|{Filter En2 F}
      else {Filter En2 F} end
   else nil
   end
end

{Show {Filter [5 1 2 4 0] fun {$ X} X>2 end}}

local A in
   {Show A}
   A = 1
   {Show A}
end

% a)
declare A
{Browse A>2}
A = 3
{Show {Filter [5 1 A 4 0] fun {$ X} {Browse x#X} X>2 end}}
A = 6

% b)
declare Sal A
thread Sal = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end
{Show Sal}
A=3
{Show Sal}

% c)
declare Sal A
thread Sal = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end
{Delay 1000}
{Show Sal}

% d)
declare Sal A
thread Sal = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end
thread A = 6 end
{Delay 1000}
{Show Sal}

