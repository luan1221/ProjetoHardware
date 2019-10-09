module MuxPCSource(PCSource, in_aluResult, in_aluOut, in_jumpAddress, in_EPC, out);
												
	input [1:0] PCSource;
	input [31:0] in_aluResult;
	input [31:0] in_aluOut;
	input [31:0] in_jumpAddress;
	input [31:0] in_EPC;
	
	output [31:0] out;
	
	assign out = PCSource[1] ? (PCSource[0] ? in_EPC : in_jumpAddress) : (PCSource[0] ? in_aluOut : in_aluResult);
	
endmodule
