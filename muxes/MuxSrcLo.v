module MuxSrcLo(SrcHiLo, LoMult, LoDiv, out);
	
	input SrcHiLo;
	input [31:0] LoMult;
	input [31:0] LoDiv;
	
	output [31:0] out;
	
	assign out = SrcHiLo ? LoDiv : LoMult;
	
endmodule
