

f = { |x| p = (x.asStream.all ++ (0 ! 5)).plot(minval:0, maxval:500); p.plotMode = \steps };

(
a = PsawDustLink([100, 200, 300], 6);
b = PsawDustLink([150, 400], 4);
c = PsawDustLink([450, 250, 350], 2);
x = PsawDustMingle([a, b, c]);
f.(x)
)

(
a = PsawDustLink([100, 200, 300], 2);
b = PsawDustLink([150, 400], 2);
x = PsawDustMerge([a, b]);
f.(x)
)



(
a = PsawDustLink([100, 200, 300], 6);
b = PsawDustLink([150, 400], 4);
c = PsawDustLink([450, 250, 350], 2);
x = PsawDustMingle([a, b, c]);

Pbind(\dur, 0.1, \freq, x).play;

)

(
a = PsawDustLink([100, 200, 300], 6);
b = PsawDustLink([150, 400], 4);
c = PsawDustLink([450, 250, 350], 2);
x = PsawDustMerge([a, b, c]);
Pbind(\dur, 0.1, \freq, x).play;
)


(
a = PsawDustLink([100, 200, 300], 6);
b = PsawDustLink([150, 400], 4);
c = PsawDustLink([450, 250, 350], 2);
x = Pseq([
	PsawDustMingle([a, b, c]),
	PsawDustMerge([a, b, c])
]);
Pbind(\dur, 0.1, \freq, x).play;
)

(
f = { |r1, r2, r3|
	var a, b, c;
	a = PsawDustLink([100, 200, 300], r1);
	b = PsawDustLink([150, 400], r2);
	c = PsawDustLink([450, 250, 350], r3);
	Pseq([
		PsawDustMingle([a, b, c]),
		PsawDustMerge([a, b, c])
	])
};

Pseq([
	Pbind(\dur, 0.1, \freq, f.(4, 7, 9)),
	Pbind(\dur, 0.1, \freq, f.(2, 1, 2)),
	Pbind(\dur, 0.1, \freq, f.(7, 9, 5))
]).play
)






// first tests, without durations

// swadust manual p. 13
a = PsawDustLink([100, 200, 300], 3);
b = PsawDustLink([450, 150, 350, 250], 3);
f = { |x| p = (x.asStream.all ++ (0 ! 5)).plot(minval:0, maxval:500); p.plotMode = \steps };

f.(a); // correct
f.(b); // correct

x = PsawDustMerge([a, b], 1); // almost correct: last three elements are missing
y = PsawDustMingle([a, b], 3); // correct

f.(x);
f.(y); // mingle.

a = PsawDustLink([100, 200, 300], 1);
b = PsawDustLink([150, 250, 350], 1);

f.(PsawDustMerge([a, b], 1)); // correct
f.(PsawDustMerge([b, a], 1)); // correct


a = PsawDustLink([100, 200, 300], 2);
b = PsawDustLink([150, 250, 350], 1);

f.(PsawDustMerge([a, b], 1)); // correct
f.(PsawDustMerge([b, a], 1)); // correct

a = PsawDustLink([100, 200, 300], 2);
b = PsawDustLink([150, 250, 350], 3);

f.(PsawDustMerge([a, b], 1)); // correct
f.(PsawDustMerge([b, a], 1)); // correct

// adding durations.

PsawDustElement(0, 1)
PsawDustElement([0, 2, 3], [1, 2])



s.boot;
a = PsawDustLink([100, 200, 300], 23);
b = PsawDustLink([450, 150, 350, 250], 28);
b = PsawDustLink([150, 150, 100], 14);
c = PsawDustMerge([a, b, a], 30);
x = SawDust.asBuffer(c);
x.plot

{ SinOsc.ar(PlayBuf.ar(1, x, 0.001, loop:1)) * 0.1 }.play;

{ PlayBuf.ar(1, x, MouseX.kr(1, 0.001, 1), loop:1).linlin(100, 450, -1, 1) * 0.1 }.play;

(
Ndef(\x, {
	var phase;
	phase = Phasor.ar(0, MouseX.kr(1, 0.001, 1), 0, BufFrames.kr(x));
	BufRd.ar(1, x, phase, loop:1, interpolation:1).linlin(100, 450, -1, 1) * 0.1
}).play;
)

x = SawDust.asBuffer(Pwhite(100.0, 450, 8000));




