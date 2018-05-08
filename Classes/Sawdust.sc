/*

Sawdust patterns

*/

// todo: some kind of named element.

PsawDustElement {
	var <>value, <>dur;

	*new { |value = 0, dur = 1|
		^this.multiChannelPerform(\new1, value, dur).unbubble
	}

	*new1 { |value, dur|
		^super.newCopyArgs(value, dur)
	}

	printOn { |stream|
		stream << this.class.name;
		stream << "(" <<* [value, dur]  << ")";
	}
}



PsawDustLink : Pattern {
	var <>elements, <>repeats;

	*new { |elements, repeats = 1|
		^super.newCopyArgs(elements, repeats)
	}

	embedInStream { |inval|
		repeats.do { inval = this.embedElementsInStream(inval) }
	}

	embedElementsInStream { |inval|
		elements.do { |each|
			inval = each.embedInStream(inval)
		}
		^inval
	}

}

PsawDustMingle : PsawDustLink {

	embedInStream { |inval|

		repeats.do {
			var linkRepeats, rep, i = 0, size;
			linkRepeats = elements.collect { |item| item.repeats };
			size = linkRepeats.size;
			while {
				linkRepeats.sum > 0
			} {
				rep = linkRepeats[i];
				if(rep > 0) {
					inval = elements[i].embedElementsInStream(inval);
					linkRepeats[i] = linkRepeats[i] - 1;
				};
				i = i + 1 % size
			}
		}

	}


}

PsawDustMerge : PsawDustLink {

	embedInStream { |inval|
		var streams, outval;
		repeats.do {
			streams = elements.collect { |x| x.asStream };
			while {
				streams.notEmpty
			} {
				streams.copy.do { |x|
					outval = x.next(inval);
					if(outval.isNil) {
						streams.remove(x)
					} {
						inval = outval.yield
					}
				}
			}
		}
	}
}

SawDust {


	*asBuffer { |pat, server, action|
		var list = List(1024);
		var size = 1;

		pat.asStream.do { |elem|
			var val = elem.value;
			var dur = try { elem.dur } ? 1;
			size = max(size, val.size);
			dur.do { list.add(val) };
		};

		^Buffer.loadCollection(
			server,
			list.lace(list.flatSize),
			size,
			action:action
		)
	}

}