module SignExtd8a32(in, out);

input [7:0] in;

output [31:0] out;

assign out[7:0] = in;
assign out[31:8] = (in[7] == 1) ? 24'd16777216:24'd0;

endmodule
