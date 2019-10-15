module MuxDisRegShamt(DisRegS, in_bitShamt10a6, in_b4_0, out);

	input [1:0] DisRegS;
	input [4:0] in_bitShamt10a6;
	input [4:0] in_b4_0;	
	parameter num16 = 5'd16;
	
	output[31:0] out;

	assign out = DisRegS[1] ? (DisRegS[0] ? 32'd0 : num16) : (DisRegS[0] ? in_b4_0 : in_bitShamt10a6);
					
endmodule
		