module Load(clk, reset, LoadOp, LoadIn, LoadOut);

	input clk;
	input reset;
	input [1:0] LoadOp;
	input [31:0] LoadIn;
	
	output reg [31:0] LoadOut;
	
	always @(posedge clk or posedge reset) begin
		case (LoadOp)
			2'd0: begin 
				LoadOut <= LoadIn;
			end
			2'd1: begin
				LoadOut[31:16] <= 16'd0;
				LoadOut[15:0] <= LoadIn[15:0];
			end
			2'd2: begin
				LoadOut[31:8] <= 24'd0;
				LoadOut[7:0] <= LoadIn[7:0];
			end
		endcase
	end
endmodule
