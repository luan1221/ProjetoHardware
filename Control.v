/* UNIDADE DE CONTROLE PARA ENTREGA PARCIAL (incompleta) */
module Control(clk, reset, OpCode, Func, Overflow, Neg, Zero, EQ, GT, SrcAddressMem, MemOp, WriteMDR,
				IRWrite, RegDst, RegWrite, WriteA, WriteB, ALUSrcA, ALUSrcB, ALUOp, WriteALUOut,
				EPCWrite, PCSource, PCWrite, MemToReg);
	
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
	output reg [2:0] SrcAddressMem;
	output reg MemOp;
	output reg WriteMDR;
	output reg IRWrite;
	output reg [2:0] RegDst;
	output reg RegWrite;
	output reg WriteA;
	output reg WriteB;
	output reg [1:0] ALUSrcA;
	output reg [2:0] ALUSrcB;
	output reg [2:0] ALUOp;
	output reg WriteALUOut;
	output reg EPCWrite;
	output reg [1:0] PCSource;
	output reg PCWrite;
	output reg [2:0] MemToReg;
	
	/* PARAMETROS MAIS UTILIZADOS */
	parameter Fetch = 7'd0;
	parameter OverflowEXC = 7'd5;
	parameter WriteALURd = 7'd4;
	parameter WriteAddiRd = 7'd11;
	
	/* LEMBRAR DE USAR DECIMAIS PARA POUPAR TEMPO */
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			SrcAddressMem <= 3'd0;
			MemOp <= 1'd0;
			WriteMDR <= 1'd1;
			IRWrite <= 1'd0;
			RegDst <= 3'd3;
			RegWrite <= 1'd1;
			WriteA <= 1'd1;
			WriteB <= 1'd1;
			ALUSrcA <= 2'd0;
			ALUSrcB <= 3'd1;
			ALUOp <= 3'd1;
			WriteALUOut <= 1'd1; /* CHECAR SE PRECISA ESCREVER */
			EPCWrite <= 1'd0;
			PCSource <= 2'd0;
			PCWrite <= 1'd1;
			MemToReg <= 3'd7;
			state <= Fetch;
		end
		
		case (state)
			/* FETCH */
			7'd0: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd1;
				IRWrite <= 1'd0;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd1;
				WriteB <= 1'd1;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd1;
				ALUOp <= 3'd1;
				WriteALUOut <= 1'd1; /* CHECAR SE PRECISA ESCREVER */
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd1;
				MemToReg <= 3'd0;
				state <= 7'd11; /* WritingIR */
			end
			
			/* WAIT */
			7'd11: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd0;
				IRWrite <= 1'd0;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd0;
				WriteB <= 1'd0;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd0;
				ALUOp <= 3'd0;
				WriteALUOut <= 1'd0; /* CHECAR SE PRECISA ESCREVER */
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				state <= 7'd1; /* Decode */
			end
			
			/* WRITING IR */
			7'd1: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd0;
				IRWrite <= 1'd1;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd0;
				WriteB <= 1'd0;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd0;
				ALUOp <= 3'd0;
				WriteALUOut <= 1'd0; /* CHECAR SE PRECISA ESCREVER */
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				state <= 7'd2; /* Decode */
			end
			
			/* DECODE */
			7'd2: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd0;
				IRWrite <= 1'd1;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd0;
				WriteB <= 1'd0;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd0;
				ALUOp <= 3'd0;
				WriteALUOut <= 1'd0; /* CHECAR SE PRECISA ESCREVER */
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				if (OpCode == 6'h0) begin
					case (Func)  
						6'h20: state <= 7'd3; //Add
						6'h24: state <= 7'd8; //And
						6'h22: state <= 7'd9;
					endcase	
				end
				if (OpCode == 6'h8) begin
					state <= 7'd10;
				end
			end
			
			/* ADD */
			7'd3: begin
                SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd1; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                if (Overflow == 0)
					state <= WriteALURd;
                else
					state <= OverflowEXC;
            end
            
			/* WRITE ALU Rd */            
			7'd4: begin
                SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd1;
                RegWrite <= 1'd1;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd0;
                ALUSrcB <= 3'd0;
                ALUOp <= 3'd0;
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                state <= Fetch;
            end
            
			/*OVERFLOWEXC*/          
			7'd5: begin
                SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd0;
                ALUSrcB <= 3'd1;
                ALUOp <= 3'd2;
                WriteALUOut <= 1'd1;
                EPCWrite <= 1'd1;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
				state <= 7'd6; // CAUSE
            end
            
			/*CAUSE*/                    
			7'd6: begin
                SrcAddressMem <= 3'd3;
                MemOp <= 1'd0;
                WriteMDR <= 1'd1;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd3;
                ALUSrcB <= 3'd0;
                ALUOp <= 3'd0;
                WriteALUOut <= 1'd1;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                state <= 7'd7; // WriteCause
            end
            
			/*WriteCause*/          
			7'd7: begin
                SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd0; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd0; 
                WriteALUOut <= 1'd0; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd1;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                state <= Fetch;
            end
            
            /* And */
            7'd8: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd3; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                state <= WriteALURd; // Write ALU Rd
			end
			
			/* Sub */
			7'd9: begin	
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd2; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                if (Overflow == 0)
					state <= WriteALURd;
                else
					state <= OverflowEXC;
			end
			
			/* addi */
			7'd10: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd2; //*
                ALUOp <= 3'd1; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                if (Overflow == 0)
					state <= WriteAddiRd;
                else
					state <= OverflowEXC;
			end
			
			/* WriteAddiRd */
			7'd11: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd1;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd0;
                ALUSrcB <= 3'd0;
                ALUOp <= 3'd0;
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                state <= Fetch;
			end
		endcase
		
	end
	
endmodule
