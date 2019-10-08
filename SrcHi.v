module SrcHi(SrcHiLo, HiMult, HiDiv, out);
	
	input SrcHiLo;
	input [31:0] HiMult;
	input [31:0] HiDiv;
	
	output reg [31:0] out;
	
	always @ (HiMult or HiDiv or SrcHiLo)
	begin
		case (SrcHiLo)
			1'b0 : out <= HiMult;
			1'b1 : out <= HiDiv;
		endcase
	end
endmodule
