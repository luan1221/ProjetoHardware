module MuxDisRegShamt(DisRegS, 
				   in_bitShamt10a6,
				   in_bitShamtSignExtd,
				   in_b,
				   in_bSignExtend,
                   in_num16,
                   out);

	input [2:0] DisRegS;
	input [4:0] in_bitShamt10a6;
	input [31:0] in_bitShamtSignExtd;
	input [31:0] in_b;
	input [31:0] in_bSignExtend;
	input [31:0] in_num16;

	output[31:0] out;

	assign out = DisRegS[2] ? (DisRegS[1] ? (DisRegS[0] ? 32'd0 : 32'd0) : (DisRegS[0] ? 32'd0 : in_num16))
					: (DisRegS[1] ? (DisRegS[0] ? in_bSignExtend : in_b) : (DisRegS[0] ? in_bitShamtSignExtd : in_bitShamt10a6));
					
endmodule
		