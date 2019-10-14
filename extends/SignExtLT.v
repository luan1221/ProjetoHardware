module SignExtLT(in, out);

input wire in;

output[31:0] out;

assign out[0] = in;
assign out[31:1] = 31'd0;


endmodule
