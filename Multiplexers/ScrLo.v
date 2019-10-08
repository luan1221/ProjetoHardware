module SrcLo(ScrHiLo, LoMult, LoDiv, out);
	
	input ScrHiLo;
	input [31:0] LoMult;
	input [31:0] LoDiv;
	
	output reg [31:0] out;
	
	always @ (LoMult or LoDiv or ScrHiLo)
	begin
		case (ScrHiLo)
			1'b0 : out <= LoMult;
			1'b1 : out <= LoDiv;
	end
endmodule
