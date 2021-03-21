// Teenage Engineering Ortho Remote Controller
// Kerem Ergener, January 2021, Bangkok

MIDIClient.init;
MIDIIn.connectAll;
(
~count=0;
MIDIdef.noteOn(\buttonPress, {
	~count=~count+1;
	~count.postln;
	if(~count > 5, {~count = 0});
}, noteNum: 60).permanent_(true);

MIDIdef.cc(\knobValue, {
	arg val, num, chan, src;
	if(~count == 1, {~ctrlOne=val.postln});
	if(~count == 2, {~ctrlTwo=val.postln});
	if(~count == 3, {~ctrlThree=val.postln});
	if(~count == 4, {~ctrlFour=val.postln});
	x.set(\freq, ~ctrlFour.linexp(0, 127, 200, 1200));
	//Put the arg you want to manipulate here
	//ex: x.set(\freq, ~ctrlOne.linlin(0,127,200,1000));
},ccNum:1).permanent_(true)
)

(
SynthDef(\testTone, {
	arg freq=220, ffreq=400, q=0.0, mix=0.4;
	var sig, out;
	sig = Saw.ar(freq);
	sig = MoogFF.ar(sig, ffreq, q);
	sig = FreeVerb.ar(sig, mix);
	Out.ar(0, sig)
}).add)

x=Synth(\testTone)
