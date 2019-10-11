module ShiftLeftBranch(in, out);

input wire [31:0] in;
output [31:0] out;

assign out = in << 2;

endmodule
