module Store(StoreOp, InB, MemIn, StoreOut);

	input [1:0] StoreOp;
	input [31:0] InB;
	input [31:0] MemIn;

	output [31:0] StoreOut;

	assign StoreOut = StoreOp[1] ? {MemIn[31:8], InB[7:0]} : (StoreOp[0] ? {MemIn[31:16], InB[15:0]} : InB);


endmodule
