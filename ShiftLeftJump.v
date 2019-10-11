module ShiftLeftJump(in, out);

input wire [25:0] in;
output [27:0] out;

assign out = in << 2;

endmodule
