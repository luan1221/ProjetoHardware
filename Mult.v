module Mult(input clock, input reset, input[31:0] InA, input[31:0] InB, input MultControl,
            output reg[31:0] Hi, output reg[31:0] Lo, output reg MultExit);
 
    integer i = -1;
    reg [64:0] A;
    reg [64:0] S;
    reg [64:0] P;
    reg [31:0] TwoComp;
 
    always @(posedge clock) begin
        if (reset) begin
            Hi = 32'd0; // ZERANDO $HI
            Lo = 32'd0; // ZERANDO $LO
            A = 65'd0; // Zerando A
            S = 65'd0; // Zerando S
            P = 65'd0; // Zerando P
            i = -1; // Zerando o iterador
        end
 
        if (MultControl == 1'd1) begin  //Sinal de comeco
            i = 0;
            A = {InA, 33'd0};
            TwoComp = (~InA + 1'd1);
            S = {TwoComp, 33'd0};
            P = {32'd0, InB, 1'd0};
            MultExit = 1'd0; //Sinal de Saida = 0
        end
 
        case (P[1:0])
			2'd01: P = P + A;
			2'd10: P = P + S;
        endcase
        
        P = P >> 1; 
        
        if(P[63] == 1'd1) // Caso do Numero Negativo
            P[64] = 1'd1;
       
        if(i < 32)
            i = i + 1;
 
        if(i == 32) begin // Algum momento i sera 32, ai os registradores serao setados e os valores resetados
            Hi = P[64:33]; // Assign do Hi
            Lo = P[32:1]; // Assign do Lo
            MultExit = 1'd1; // sinal de saida = 1
 
            i = -1; // RESETANDO i
            A = 65'd0; // RESETANDO A
            S = 65'd0; // RESETANDO S
            P = 65'd0;  // RESETANDO P
        end
    end
 
endmodule
