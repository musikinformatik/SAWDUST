






// Ugens
(
a = SawDustLink([100, 200, 300], 3);
b = SawDustLink([450, 150, 350, 250], 3);

f = { |x| { Duty.ar(0.0006, 0, x) }.plot };
g = { |x| { DemandEnvGen.ar(x, 0.0006, 3) }.plot };

)

f.(a)
f.(b)

g.(a)
g.(b)

x = SawDustMerge([a, b], 1);
y = SawDustMingle([a, b], 2);
f.(x);
f.(y);

