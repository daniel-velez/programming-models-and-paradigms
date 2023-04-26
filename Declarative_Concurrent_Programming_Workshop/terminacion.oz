declare
L1 L2 L3 L4 T1 T2 T3
L1 = [1 2 3]
thread
   L2 = {Map L1 fun {$ X} {Delay 200} X*X end}
   T1 = done
end
thread
   L3 = {Map L1 fun {$ X} {Delay 200} 2*X end}
   T2 = done
end
thread
   L4 = {Map L1 fun {$ X} {Delay 200} 3*X end}
   T3 = done
end
{Wait T1}
{Wait T2}
{Wait T2}
{Show L2#L3#L4}