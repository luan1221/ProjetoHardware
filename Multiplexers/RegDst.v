module RegDst(RegDst,
			  in_bit20a16,
              in_bit15a11, 
              in_regRA, 
              in_regSP, 
              in_bit25a21,
              out);
						

	input [2:0] RegDst;
	input [4:0] in_bit20a16;
	input [4:0] in_bit15a11;
	input [31:0] in_regRA;
	input [31:0] in_regSP;
	input [4:0] in_bit25a21;
	
	output reg [31:0] out;
	
	always @ (in_bit20a16 or 
	          in_bit15a11 or 
	          in_regRA or 
	          in_regSP or 
			  in_bit25a21 or 
		      RegDst) 
    
	begin
        case (RegDst)
            3'b000 : out <= in_bit20a16;
            3'b001 : out <= in_bit15a11;
            3'b010 : out <= in_regRA;
            3'b011 : out <= in_regSP;
            3'b100 : out <= in_bit25a21;
        endcase
    end
endmodule
