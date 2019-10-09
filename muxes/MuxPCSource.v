module MuxPCSource(PCSource, in_aluResult, in_aluOut, in_jumpAddress, in_EPC, out);
												
	input [1:0] PCSource;
	input [31:0] in_aluResult;
	input [31:0] in_aluOut;
	input [31:0] in_jumpAddress;
	input [31:0] in_EPC;
	
	output reg [31:0] out;
	
	always @* begin
        case (PCSource)
            2'b00 : out <= in_aluResult;
            2'b01 : out <= in_aluOut;
            2'b10 : out <= in_jumpAddress;
            2'b11 : out <= in_EPC;
        endcase
    end
endmodule
