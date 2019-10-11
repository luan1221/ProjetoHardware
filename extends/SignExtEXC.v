module SignExtEXC(in, out);

input [7:0] in;

output [31:0] out;

assign out[7:0] = in;
assign out[31:8] = (in[7] == 1) ? 24'b111111111111111111111111 : 24'd0;

endmodule
