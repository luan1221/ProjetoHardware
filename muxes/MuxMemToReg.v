module MuxMemToReg(MemToReg, in_aluOut, in_memoryDataReg, in_hi, in_lo, in_shiftRegOut, in_loadOut, in_lessThanFlag, in_num227, out);
						
	input [2:0] MemToReg;
	input [31:0] in_aluOut;
	input [31:0] in_memoryDataReg;
	input [31:0] in_hi;
	input [31:0] in_lo;
	input [31:0] in_shiftRegOut;
	input [31:0] in_loadOut;
	input [31:0] in_lessThanFlag;
	input [31:0] in_num227;
	
	output [31:0] out;
	
	assign out = MemToReg[2] ? (MemToReg[1] ? (MemToReg[0] ? in_num227 : in_lessThanFlag) : (MemToReg[0] ? in_loadOut : in_shiftRegOut))
					: (MemToReg[1] ? (MemToReg[0] ? in_lo : in_hi) : (MemToReg[0] ? in_memoryDataReg : in_aluOut));
					
endmodule
