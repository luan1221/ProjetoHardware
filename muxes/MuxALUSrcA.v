module MuxALUSrcA(ALUSrcA,
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
	
	output [31:0] out;
	
	assign out = ALUSrcA[1] ? (ALUSrcA[0] ? in_memoryDataReg : in_b) : (ALUSrcA[0] ? in_a : in_pc);
	
endmodule
