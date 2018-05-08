

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

//////////////////




a = PsawDustLink([(value:100, dur: 1), (value:200, dur: 4), (value:300, dur: 2)], 6);
a.asStream.all

Pbindf(a, \freq, Pkey(\value)).collect { |item| item[\dur] = item[\dur] * 0.1 }.play



a = PsawDustLink([PsawDustElement(100, 1), PsawDustElement(200, 4), PsawDustElement(300, 2)], 6);
a.asStream.all


PsawDustLink(PsawDustElement([100, 200, 300], [1, 4, 2]), 6).asStream.all

(
d = (
	a1: PsawDustElement(200, 2),
	a2: PsawDustElement(800, 4)
);

x = PsawDustLink([\a1, \a1, \a2], 2);

Pdict(d, x).asStream.all;
)



////////////////////////

(
a = PsawDustLink(PsawDustElement([0, 1, 2, 3], [2, 1, 6, 2]), 123);
b = PsawDustLink(PsawDustElement([0, 1, 2, 3], [4, 17, 1, 1]), 7);
c = PsawDustLink(PsawDustElement([-1, 1, -0.5, 0.5, 0.4], [11, 6, 11, 5, 8]), 8);
d = PsawDustLink(PsawDustElement([0, 1, 2, 3], [1, 16, 2, 5]), 8);
e = PsawDustMerge([a, b, a, c, a, b, d, a, b], 30);
f = PsawDustMerge([a, b, b, b, d, a, b], 24);
c = PsawDustMerge([e, f, PsawDustMingle([a, e, f, d], 2)]);
x = SawDust.asBuffer(c);
)

(
Ndef(\x, {
	var phase;
	phase = Phasor.ar(0, 1, 0, BufFrames.kr(x));
	BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1) * 0.1
}).play;
)


(
a = PsawDustLink(PsawDustElement([0, 1, 2, 3], [2, 1, 6, 2]), 123);
b = PsawDustLink(PsawDustElement([0, 1, 2, 3], [4, 17, 1, 1]), 7);
c = PsawDustLink(PsawDustElement([0, 1, 2, 3, 4], [11, 6, 11, 5, 8]), 8);
d = PsawDustLink(PsawDustElement([0, 1, 2, 3], [1, 16, 2, 5]), 8);
e = PsawDustMerge([a, b, a, c, a, b, d, a, b], 30);
f = PsawDustMerge([a, b, b, b, d, a, b], 24);
c = PsawDustMerge([e, f, PsawDustMingle([a, e, f, d], 2), PsawDustMingle([b, d, e], 1)]);
x = SawDust.asBuffer(c);
)

(
Ndef(\x, {
	var phase, which;
	phase = Phasor.ar(0, 1, 0, BufFrames.kr(x));
	which = BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1);
	Select.ar(which, DC.ar([-1, 1, -0.5, 0.5, 0.3])) * 0.1
}).play;
)



(
Ndef(\x, {
	var phase, which, list;
	phase = Phasor.ar(0, 1, 0, BufFrames.kr(x));
	which = BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1);
	list = { K2A.ar(MouseX.kr(-100.rand, 100.rand) % 30 * 0.1) } ! 5;
	Select.ar(which, list) * 0.1
}).play;
)



(
Ndef(\x, {
	var phase, which, list;
	phase = Phasor.ar(0, 1, 0, BufFrames.kr(x));
	which = BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1);
	list = { LFNoise1.ar(0.01) } ! 5;
	Select.ar(which, list) * 0.1
}).play;
)

(
Ndef(\x, {
	var phase, phase2, which, which2, list;
	phase = Phasor.ar(0, 1, 0, BufFrames.kr(x));
	phase2 = Phasor.ar(0, 1/4, 0, BufFrames.kr(x));
	which = BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1);
	which2 = BufRd.ar(x.numChannels, x, phase2, loop:1, interpolation:2);
	list = { LFNoise1.ar(0.01) } ! 5;
	PanAz.ar(8,
		Select.ar(which, list) * 0.1,
		which2.linlin(0, 4, -1, 1) + LFNoise1.kr(0.1)
	)
}).play;
)

x.plot

(
Ndef(\x, {
	var phase, which, list;
	phase = Phasor.ar(0, 1/16, 0, BufFrames.kr(x));
	which = BufRd.ar(x.numChannels, x, phase, loop:1, interpolation:1);
	list = { SinOsc.ar({ exprand(100, 7000) } ! 8) } ! 5;
	Splay.ar(SelectX.ar(which.lag(0.001), list)) * 0.1
}).play;
)




