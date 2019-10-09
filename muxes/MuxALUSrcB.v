module MuxALUSrcB(ALUSrcB,
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
	
	output [31:0] out;
    
    assign out = ALUSrcB[2] ? (ALUSrcB[1] ? (ALUSrcB[0] ? 32'd0 : 32'd0) : (ALUSrcB[0] ? in_memoryDataReg : in_bit15a00UnsigExt))
					: (ALUSrcB[1] ? (ALUSrcB[0] ? in_bit15a00SigExtShiftL2 : in_bit15a00SigExt) : (ALUSrcB[0] ? num4 : in_b));
					
endmodule
