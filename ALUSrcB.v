module ALUSrcB(ALUSrcB,
               in_b,
               in_bit15a00SigExt, 
               in_bit15a00SigExtShiftL2, 
               in_bit15a00UnsigExt,
               in_memoryDataReg,
               out);
               
    parameter num4 = 32'd4;           
						
	input [2:0] ALUSrcB;
	input [31:0] in_b;
	input [31:0] in_bit15a00SigExt;
	input [31:0] in_bit15a00SigExtShiftL2;
	input [31:0] in_bit15a00UnsigExt;
	input [31:0] in_memoryDataReg;
	
	output reg [31:0] out;
	
	always @ (in_b or
              in_bit15a00SigExt or 
			  in_bit15a00SigExtShiftL2 or 
			  in_bit15a00UnsigExt or 
			  in_memoryDataReg or 
			  ALUSrcB) 
    
	begin
        case (ALUSrcB)
            3'b000 : out <= in_b;
            3'b001 : out <= num4;
            3'b010 : out <= in_bit15a00SigExt;
            3'b011 : out <= in_bit15a00SigExtShiftL2;
            3'b100 : out <= in_bit15a00UnsigExt;
			3'b101 : out <= in_memoryDataReg;
        endcase
    end
endmodule
