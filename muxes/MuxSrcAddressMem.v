module MuxSrcAddressMem(srcAddMem, in_pc, in_aluOut, out);

	parameter NoOp = 32'd253;
	parameter Overfl = 32'd254;
	parameter Div0 = 32'd255;
	
	input [2:0] srcAddMem;
	input [31:0] in_pc;
	input [31:0] in_aluOut;
	
	output reg [31:0] out;
	
	always @* begin
        case (srcAddMem)
            3'b000 : out <= in_pc;
            3'b001 : out <= in_aluOut;
            3'b010 : out <= NoOp;
            3'b011 : out <= Overfl;
            3'b100 : out <= Div0;
        endcase
    end
endmodule
