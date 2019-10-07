module SrcLo(SrcLo, LoMult, LoDiv, out);
	
	input SrcLo;
	input [31:0] LoMult;
	input [31:0] LoDiv;
	
	output reg [31:0] out;
	
	always @ (LoMult or LoDiv or SrcLo)
	begin
		case (SrcLo)
			1'b0 : out <= LoMult;
			1'b1 : out <= LoDiv;
		endcase
	end
endmodule
