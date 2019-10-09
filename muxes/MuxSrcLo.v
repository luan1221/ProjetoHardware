module MuxSrcLo(SrcHiLo, LoMult, LoDiv, out);
	
	input SrcHiLo;
	input [31:0] LoMult;
	input [31:0] LoDiv;
	
	output reg [31:0] out;
	
	always @* begin
		case (SrcHiLo)
			1'b0 : out <= LoMult;
			1'b1 : out <= LoDiv;
		endcase
	end
endmodule
