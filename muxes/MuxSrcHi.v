module MuxSrcHi(SrcHiLo, HiMult, HiDiv, out);
	
	input SrcHiLo;
	input [31:0] HiMult;
	input [31:0] HiDiv;
	
	output [31:0] out;
	
	assign out = SrcHiLo ? HiDiv : HiMult;
	
endmodule
