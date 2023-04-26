declare A B C D in
thread {Delay 2000} D = C + 1 {Browse t1#d#D} end
thread {Delay 2000} C = B + 1 {Browse t2#c#C} end
thread {Delay 2000} A = 1 {Browse t3#a#A} end
thread {Delay 2000} B = A + 1 {Browse t4#b#B} end
{Browse D}