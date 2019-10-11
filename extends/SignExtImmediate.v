module SignExtImmediate(in, out);

input [15:0] in;

output [31:0] out;

assign out[15:0] = in;

assign out[31:16] = (in[15] == 1) ? 16'b1111111111111111 : 16'd0;

endmodule
