module Load( LoadOp, InMem, LoadOut);

	input [1:0] LoadOp;
	input [31:0] InMem;
	
	output [31:0] LoadOut;
		
	assign LoadOut = LoadOp[1] ? {24'd0, InMem[7:0]} : (LoadOp[0] ? {16'd0, InMem[15:0]} : InMem);
		
endmodule
