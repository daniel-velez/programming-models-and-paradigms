declare A B C D in
thread D = C + 1 {Browse t1#d#D} end
thread C = B + 1 {Browse t2#c#C} end
thread A = 1 {Browse t3#a#A} end
thread B = A + 1 {Browse t4#b#B} end
{Browse D}