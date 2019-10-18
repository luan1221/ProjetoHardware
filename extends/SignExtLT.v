module SignExtLT(in, out);

input wire in;

output[31:0] out;


assign out[31:0] = {31'd0, in};


endmodule
