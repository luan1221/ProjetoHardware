module Mult(clk, reset, EntrA, EntrB, MultControl, Hi, Lo);
    /* ENTRADAS */
	input signed [31:0] EntrA; // multiplicador
	input signed [31:0] EntrB; // multiplicando
	input wire reset;		// sinal de reset
	input wire MultControl;	// 
	input wire clk;
	
	/* INTERNOS */
	reg MultStart;      // 
	reg [5:0] count;    // contador de ciclos
	reg [31:0] m;
	reg [31:0] nm;
	reg [31:0] Multiplier;
	reg [64:0] A;
	reg [64:0] S;
	reg signed[64:0] P;       // 65 bits
	
	/* SAIDAS */
	output reg signed [31:0] Hi;
	output reg signed [31:0] Lo;
		
	initial begin
	  count = 6'd32;
	  MultStart = 1'b0;
	  Hi = 32'd0;
	  Lo = 32'd0;
	  m = 32'd0;
	  nm = 32'd0;
	  Multiplier = 32'd0;
	  P = 65'd0;
	  A = 65'd0;
	  S = 65'd0;
	end
	
	always @ ( posedge clk or posedge reset) begin
      if(reset) begin
	    count = 6'd32;
	    MultStart = 1'b0;
	    Hi = 32'd0;
	    Lo = 32'd0;
	    m = 32'd0;
	    nm = 32'd0;
	    Multiplier = 32'd0;
	    P = 65'd0;
	    A = 65'd0;
	    S = 65'd0;
	  end
	  else if(MultControl) begin
	    A = 65'd0;
	    S = 65'd0;
	    P = 65'd0;
	    P = {P[64:33], EntrB, P[0]};
	    m = EntrA;
	    nm = ~m + 1;
	    A = {m,33'd0};
	    S = {nm,33'd0};
	    MultStart = 1'b1;
	    count = 6'd32;
	  end
	  else if(MultStart) begin
		  /* 01 - P = P - EntrA*/
	    if(P[1:0] == 2'b01) begin
		  P = P + A;
	    end
	    else if (P[1:0] == 2'b10) begin
		  P = P + S;
	    end
	    /* P shift right aritmetico de uma unidade */
	    P = P >>> 1;
	    count = count - 1;
	    if(count == 6'd0) begin
	      Hi = P[64:33];
	      Lo = P[32:1];
	      MultStart = 1'b0;
	    end
	  end
	end

endmodule
