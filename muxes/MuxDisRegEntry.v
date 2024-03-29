module MuxDisRegEntry(DisRegE, in_b, in_a, in_immediate, out);
	
	input [1:0] DisRegE;
    input [31:0] in_b;
    input [31:0] in_a;
    input [31:0] in_immediate;

    output [31:0] out;

    assign out = DisRegE[1] ? (DisRegE[0] ? 32'd0 : in_immediate) : (DisRegE[0] ? in_a : in_b);
    
endmodule
