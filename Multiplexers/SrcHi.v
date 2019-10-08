module SrcHi(SrcHi, HiMult, HiDiv, out);
	
	input SrcHi;
	input [31:0] LoMult;
	input [31:0] LoDiv;
	
	output reg [31:0] out;
	
	always @ (HiMult or HiDiv or SrcHi)
	begin
		case (SrcHi)
			1'b0 : out <= HiMult;
			1'b1 : out <= HiDiv;
		endcase
	end
endmodule
