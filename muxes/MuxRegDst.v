module MuxRegDst(RegDst,
			  in_rt,
              in_rd,  
              in_rs,
              out);
						
	parameter RegRA = 5'd31;
	parameter RegSP = 5'd29;
	
	input [2:0] RegDst;
	input [4:0] in_rt;
	input [4:0] in_rd;
	input [4:0] in_rs;
	
	output reg [4:0] out;
	
	always @* begin
        case (RegDst)
            3'b000 : out <= in_rt;
            3'b001 : out <= in_rd;
            3'b010 : out <= RegRA;
            3'b011 : out <= RegSP;
            3'b100 : out <= in_rs;
        endcase
    end
endmodule
