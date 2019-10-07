module ALUSrcA(ALUSrcA,
                 in_pc, 
	        	 in_a, 
				 in_b, 
                 in_memoryDataReg,
 				 out);
						
	input [1:0] ALUSrcA;
	input [31:0] in_pc;
	input [31:0] in_a;
	input [31:0] in_b;
	input [31:0] in_memoryDataReg;
	
	
	output reg [31:0] out;
	
	always @ (in_pc or 
			  in_a or 
			  in_b or 
			  in_memoryDataReg or 
		      ALUSrcA) 
   
     begin
        case (ALUSrcA)
            2'b00 : out <= in_pc;
            2'b01 : out <= in_a;
            2'b10 : out <= in_b;
            2'b11 : out <= in_memoryDataReg;
        endcase
    end
endmodule
