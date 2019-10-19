module Div(clk, reset, InA, InB, DivControl, Hi, Lo, DivZero, DivEnd);

  input clk;
  input reset;
  input signed [31:0] InA;
  input signed [31:0] InB;
  input DivControl;
  
  output reg [31:0] Hi;
  output reg [31:0] Lo;    
  output reg DivZero;
  output reg DivEnd;
  
  reg [31:0] dividendo;
  reg [31:0] divisor;
  reg inicio;
  reg negacao;
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dividendo = 32'd0;
      divisor = 32'd0;
      Hi = 32'd0;
      Lo = 32'd0;
      DivZero = 1'd0;
      DivEnd = 1'd0;
      inicio = 1'd0;
      negacao = 1'd0;
    end
    else if (InB == 32'd0 && DivControl) begin
		DivZero = 1'd1;
	end
    else if(DivControl) begin
	  dividendo = InA;
	  divisor = InB;
      if(dividendo[31] == 1'd1) begin
        dividendo = ~dividendo + 1;
        negacao = 1'd1;
      end
      if(divisor[31] == 1'd1) begin
        divisor = ~divisor + 1;
        if(negacao) begin
          negacao = 1'd0;
        end
        else begin
          negacao = 1'd1;
        end
      end      
      Lo = 32'd0;
      inicio = 1'd1;
    end
    else if(inicio) begin
      if(dividendo >= divisor) begin
        dividendo = dividendo - divisor;
        Lo = Lo + 1;
      end
      else begin
        Hi = dividendo;
        if(negacao) begin
          Lo = ~Lo + 1;
        end
        DivEnd = 1'd1;
        inicio = 1'd0;
      end
    end
  end
  
endmodule
