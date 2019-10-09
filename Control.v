/* UNIDADE DE CONTROLE PARA ENTREGA PARCIAL (incompleta) */
module Control(clk, reset, OpCode, Func, Overflow, Neg, Zero, EQ, GT,
				PCWrite, PCLoad, SrcAddressMem, MemOp, IRWrite, RegWrite,
				WriteA, WriteB, ALUSrcA, ALUSrcB, ALUOp, WriteALUOut, PCSource, MemToReg, RegDst);
	
	/* SINAIS ENVIADOS PARA UNIDADE DE CONTROLE */		
	input clk;
	input reset;
	input [5:0] OpCode;
	input [5:0] Func;
	input Overflow;
	input Neg;
	input Zero;
	input EQ;
	input GT;
	
	/* REGISTRADOR AUXILIAR PARA CONTROLAR OS ESTADOS */
	reg [6:0] state;
	
	/* SINAIS ENVIADOS DA UNIDADE DE CONTROLE PARA OS COMPONENTES */
	output reg PCWrite;
	output reg PCLoad;
	output reg [2:0] SrcAddressMem;
	output reg MemOp;
	output reg IRWrite;
	output reg RegWrite;
	output reg WriteA;
	output reg WriteB;
	output reg [1:0] ALUSrcA;
	output reg [2:0] ALUSrcB;
	output reg [2:0] ALUOp;
	output reg WriteALUOut;
	output reg [1:0] PCSource;
	output reg [2:0] MemToReg;
	output reg [2:0] RegDst;
	
	/* LEMBRAR DE USAR DECIMAIS PARA POUPAR TEMPO */
	always @(posedge clk or negedge reset) begin
		if (~reset) begin
			/* IMPLEMENTAR RESET */
			state <= 7'd1;
		end
		
		case (state)
			/* FETCH */
			7'd1: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 2'd1;
				ALUOp <= 2'd1;
				WriteALUOut = 1'd1; /* CHECAR SE PRECISA ESCREVER NO ALUOut (mudar unidade de controle) */
				PCWrite = 1'd1;
				PCSource = 1'd0;
				/* IRWrite = 1'd1;	CHECAR SE O ESTADO WritingIR PODE VIR AQUI */
				state <= 7'd1;
			end
			
			/* DECODE */
			7'd2: begin
				WriteA <= 1'd1;
				WriteB <= 1'd1;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd3;
				ALUOp <= 3'd1;
				WriteALUOut <= 1'd1; /* CHECAR SE PRECISA ESCREVER NO ALUOut (mudar unidade de controle) */
			end
		endcase
	end
	
endmodule

	