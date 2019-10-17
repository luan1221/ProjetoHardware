module Div(clk, reset,EntrA, EntrB,DivControl, RestoDiv/*Hi*/,QuoDiv/*Lo*/,DivZero);
  /* ENTRADAS */
  input wire clk;
  input wire reset;
  input wire signed [31:0] EntrA;
  input wire signed [31:0] EntrB;
  input wire DivControl;
  /* INTERNOS */
  reg [31:0] dividend; // no fim ? o resto
  reg [31:0] divisor;
  reg DivStart;        // registrador que controla a execu??o do Div
  reg neg;             // registrador que armazena se o resultado e negativo
  
  /* SAIDAS */
  output reg [31:0] RestoDiv;  // resto da divis?o
  output reg [31:0] QuoDiv;    // quociente da divis?o
  output reg DivZero;          // sinal para tratamento de divis?o por zero
  
  always @( posedge clk or posedge reset) begin
    if(reset) begin
      dividend = 32'd0;
      divisor = 32'd0;
      RestoDiv = 32'd0;
      QuoDiv = 32'd0;
      DivZero = 1'b0;
      DivStart = 1'b0;
      neg = 1'b0;
    end
    
    else if(DivControl) begin
	  dividend = EntrA;
	  divisor = EntrB;
      if(dividend[31] == 1'b1) begin  // checa se o bit de sinal do dividendo ? "1"
        dividend = ~dividend + 1;
        neg = 1'b1;
      end
      if(divisor[31] == 1'b1) begin  // checa se o bit de sinal do divisor ? "1"
        divisor = ~divisor + 1;
        if(neg) begin                // se o registrador de 1 bit de checagem de n?mero
          neg = 1'b0;                // negativo for 1 ent?o muda-se para zero e trata como divis?o de inteiros
        end
        else begin
          neg = 1'b1;
        end
      end      
      QuoDiv = 32'd0;
      DivStart = 1'b1;
    end
    else if(DivStart) begin
      if(dividend >= divisor) begin
        dividend = dividend - divisor;
        QuoDiv = QuoDiv + 1;
      end
      else begin
        RestoDiv = dividend;
        if(neg) begin
          QuoDiv = ~QuoDiv + 1;
        end
        DivStart = 1'b0;
      end
    end
  end 
endmodule
