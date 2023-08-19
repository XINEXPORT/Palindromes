(
SynthDef("pali", {arg out = 0, freq=900, pan = 0, rate=4, amp=0.2, gate=1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.8,
		sustainLevel:0.3,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = BRF.ar(
		in: Pulse.ar(freq: [freq,300,200,4]));
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = Dust.ar(
		density:2,
		mul:1,
		add:3,);
	snd = LPF.ar(
		in: Pulse.ar(freq: [freq,80,400, 70]));
		Out.ar(0,Pan2.ar (snd, pan, amp));
}).add;
)

(
SynthDef("pali2", {arg out = 0, freq=80, pan = 0, rate=5, amp=0.2, gate=1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.8,
		sustainLevel:0.3,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = BPF.ar (freq: freq, mul: 1);
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = Dust.ar(
		density:2,
		mul:1,
		add:3,);
	snd = HPF.ar(
		in: LFSaw.ar(freq: [freq,40]));
		Out.ar(0,Pan2.ar (snd, pan, amp));
}).add;
)


(
Synth (\pali2);
)


(
Synth (\pali);
)



//  FORK //
(
{
a = Pbind(
	TempoClock (120/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Pseq([8, 13,18,18,13,8],inf),
	\dur, 0.3,
	\mul, 2,
	\amp, 0.2,
	\legato, 1,
	\ctranspose, 0.8
).play;
3.wait;

b = Pbind(
	TempoClock (120/60);
	\scale, Scale.harmonicMajor,
	\instrument, \pali,
	\degree, Pseq([8, 14,18,18,14,8],inf),
	\dur, 0.3,
	\mul, 2,
	\amp, 0.2,
	\legato, 1,
	\ctranspose, 0.8
).play;
4.wait;
b.stop;

c = Pbind(
	TempoClock (120/60);
	\scale, Scale.dorian,
	\instrument, \eerie,
	\degree, Pseq([8, 15,18,18,15,8],inf),
	\dur, 0.3,
	\mul, 2,
	\amp, 0.2,
	\legato, 4,
	\ctranspose, 0.8
).play;
3.5.wait;
c.stop;

d = Pbind(
	TempoClock (120/60);
	\scale, Scale.harmonicMinor,
	\instrument, \pali,
	\degree, Pseq([30, 20,55,60,36,8],inf),
	\dur, 0.1,
	\mul, 2,
	\amp, 0.2,
	\legato, 4,
	\ctranspose, 0.8
).play;
4.wait;
d.stop;

e = Pbind(
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Pseq([8, 17,18,18,17,8],inf),
	\dur, 1,
	\mul, 2,
	\amp, 0.2,
	\legato, 2,
	\ctranspose, 0.8
).play;
2.wait;
a.stop
}.fork;
)


