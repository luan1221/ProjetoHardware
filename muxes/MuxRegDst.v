module MuxRegDst(RegDst, in_rt, in_rd, in_rs, out);
						
	parameter RegRA = 5'd31;
	parameter RegSP = 5'd29;
	
	input [2:0] RegDst;
	input [4:0] in_rt;
	input [4:0] in_rd;
	input [4:0] in_rs;
	
	output [4:0] out;
	
	assign out = RegDst[2] ? (RegDst[1] ? (RegDst[0] ? 32'd0 : 32'd0) : (RegDst[0] ? 32'd0 : RegSP))
					: (RegDst[1] ? (RegDst[0] ? RegRA : in_rs) : (RegDst[0] ? in_rd : in_rt));

endmodule
