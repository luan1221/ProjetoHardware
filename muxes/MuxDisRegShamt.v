module MuxDisRegShamt(DisRegS, 
				   in_bitShamt10a6,
				   in_bitShamtSignExtd,
				   in_b,
				   in_bSignExtend,
                   in_num16,
                   out);

	input [2:0] DisRegS;
	input [4:0] in_bitShamt10a6;
	input [4:0] in_bitShamtSignExtd;
	input [31:0] in_b;
	input [31:0] in_bSignExtend;
	input [31:0] in_num16;

	output reg [31:0] out;

	always @* begin 
		case (DisRegS)
			3'b000 : out <= in_bitShamt10a6;
            3'b001 : out <= in_bitShamtSignExtd;
            3'b010 : out <= in_b;
            3'b011 : out <= in_bSignExtend;
            3'b100 : out <= in_num16;
        endcase
    end
endmodule
		