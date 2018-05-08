


/*

Sawdust UGens
(work in progress)

*/



SawDustLink : AbstractFunction {
	var <>elements, <>repeats;

	*new { |elements, repeats = 1|
		^super.newCopyArgs(elements, repeats)
	}

	asUGenInput {
		^Dseq(elements, repeats)
	}

	singleIteration {
		^Dseq(elements, 1)
	}

}

SawDustMingle : SawDustLink {

	asUGenInput {
		var list = elements.collect(_.singleIteration);
		^Dseq(list, repeats)
	}

}

SawDustMerge : SawDustLink {

	asUGenInput {
		^Dseq(
			{
				var indexLoop = Dseq([Dseries(0, 1, elements.size - 1)], inf);
				var list = elements.collect(_.asUGenInput);
				Dswitch1(elements, indexLoop)
			}.dup(repeats)
		)
	}
}





