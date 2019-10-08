module SrcAddressMem(srcAddMem, in_pc, in_aluOut, 
						in_causeNoOp, in_causeOvfl, 
                        in_causeDiv0, out);

	input [2:0] srcAddMem;
	input [31:0] in_pc;
	input [31:0] in_aluOut;
	input [31:0] in_causeNoOp;
	input [31:0] in_causeOvfl;
	input [31:0] in_causeDiv0;
	
	output reg [31:0] out;
	
	always @ (in_pc or in_aluOut or in_causeNoOp 
               or in_causeOvfl or in_causeDiv0 
               or srcAddMem) 
    begin
        case (srcAddMem)
            3'b000 : out <= in_pc;
            3'b001 : out <= in_aluOut;
            3'b010 : out <= in_causeNoOp;
            3'b011 : out <= in_causeOvfl;
            3'b100 : out <= in_causeDiv0;
        endcase
    end
endmodule
