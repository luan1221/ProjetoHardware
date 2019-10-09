module MuxSrcAddressMem(srcAddMem, in_pc, in_aluOut, out);

	parameter NoOp = 32'd253;
	parameter Overflow = 32'd254;
	parameter Div0 = 32'd255;
	
	input [2:0] srcAddMem;
	input [31:0] in_pc;
	input [31:0] in_aluOut;
	
	output [31:0] out;
	
	assign out = srcAddMem[2] ? (srcAddMem[1] ? (srcAddMem[0] ? 32'd0 : 32'd0) : (srcAddMem[0] ? 32'd0 : Div0))
					: (srcAddMem[1] ? (srcAddMem[0] ? Overflow : NoOp) : (srcAddMem[0] ? in_aluOut : in_pc));
	
endmodule
