module MuxMemToReg(MemToReg,
				in_aluOut,
				in_memoryDataReg,
				in_hi, 
				in_lo, 
				in_shiftRegOut, 
				in_loadOut,
				in_lessThanFlag,
				in_num227,
				out);
						
	input [2:0] MemToReg;
	input [31:0] in_aluOut;
	input [31:0] in_memoryDataReg;
	input [31:0] in_hi;
	input [31:0] in_lo;
	input [31:0] in_shiftRegOut;
	input [31:0] in_loadOut;
	input [31:0] in_lessThanFlag;
	input [31:0] in_num227;
	
	output reg [31:0] out;
	
	always @* begin
        case (MemToReg)
		    3'b0000 : out <= in_aluOut;
            3'b0001 : out <= in_memoryDataReg;
            3'b0010 : out <= in_hi;
            3'b0011 : out <= in_lo;
            3'b0100 : out <= in_shiftRegOut;
			3'b0101 : out <= in_loadOut;
			3'b0110 : out <= in_lessThanFlag;
			3'b0111 : out <= in_num227;

        endcase
    end
endmodule
