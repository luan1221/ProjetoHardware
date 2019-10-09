module MuxDisRegEntry(DisRegE, 
                    in_b,
                    in_a,
                    in_bit15a00SignExtShitL2,
                    out);
	
	input [1:0] DisRegE;
    input [31:0] in_b;
    input [31:0] in_a;
    input [31:0] in_bit15a00SignExtShitL2;

    output reg [31:0] out;

    always @* begin
        case (DisRegE)
            2'b00 : out <= in_b;
            2'b01 : out <= in_a;
            2'b10 : out <= in_bit15a00SignExtShitL2; 
        endcase
    end
endmodule
