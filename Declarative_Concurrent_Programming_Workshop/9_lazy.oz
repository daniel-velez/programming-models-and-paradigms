declare
fun lazy {HagaX} {Browse x} {Delay 3000} 1 end
fun lazy {HagaY} {Browse y} {Delay 6000} 2 end
fun lazy {HagaZ} {Browse z} {Delay 9000} 3 end
X={HagaX}
Y={HagaY}
Z={HagaZ}
{Browse (X+Y)+Z}
{Browse X+(Y+Z)}
{Browse thread X+Y end + Z}
