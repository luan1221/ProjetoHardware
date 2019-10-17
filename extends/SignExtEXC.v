module SignExtEXC(in, out);

input [7:0] in;

output [31:0] out;

assign out[31:0] = {24'd0, in};

endmodule
