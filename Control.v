/* UNIDADE DE CONTROLE PARA ENTREGA PARCIAL (incompleta) */
module Control(clk, reset, OpCode, Func, Overflow, Neg, Zero, EQ, GT, SrcAddressMem, MemOp, WriteMDR,
				IRWrite, RegDst, RegWrite, WriteA, WriteB, ALUSrcA, ALUSrcB, ALUOp, WriteALUOut,
				EPCWrite, PCSource, PCWrite, MemToReg, DisRegEntry, DisRegShamt, DisRegOp);
	
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
	output reg [1:0] DisRegEntry;
	output reg [1:0] DisRegShamt;
	output reg [2:0] DisRegOp;
	
	
	
	/* PARAMETROS HEXADECIMAIS */
	parameter typeR = 6'h0;
	parameter Addi = 6'h8;
	parameter Addiu = 6'h9;
	parameter J = 6'h2;
	parameter Jal = 6'h3;
	parameter Beq = 6'h4;
	parameter Bne = 6'h5;
	parameter Ble = 6'h6;
	parameter Bgt = 6'h7;
	parameter Blm = 6'h1;
	
	/* PARAMETROS DECIMAIS */
	parameter Fetch = 7'd1;
	parameter Reset = 7'd0;
	parameter Wait = 7'd91;
	parameter WriteAluRd = 7'd93;
	parameter WriteAddiRd = 7'd94;
	parameter WriteSltRd = 7'd95;
	parameter OverflowExc = 7'd100;
	parameter Cause = 7'd101;
	parameter WriteCause = 7'd102;
	parameter Break = 7'd10;
	parameter Jump = 7'd16;
	parameter Branch = 7'd51;
	parameter LoadShiftSll = 7'd68;
	parameter LoadShiftSllv = 7'd67;
	parameter LoadShiftSra = 7'd66;
	parameter LoadShiftSrav = 7'd65;
	parameter LoadShiftSrl = 7'd64;
	parameter WriteShiftRd = 7'd63;
	
	/* REGISTRADOR AUXILIAR PARA CONTROLAR OS ESTADOS */
	reg [6:0] state;
	reg [6:0] nextstate;
	
	initial begin
		nextstate <= Fetch;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= Reset;
		else
			state <= nextstate;
	end

	always @(*) begin
		case (state)
			/* RESET */
			Reset: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd0;
				IRWrite <= 1'd0;
				RegDst <= 3'd3;
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
				MemToReg <= 3'd7;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= Fetch;
			end
			
			/* FETCH */
			Fetch: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd1;
				IRWrite <= 1'd0;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd0;
				WriteB <= 1'd0;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd1;
				ALUOp <= 3'd1;
				WriteALUOut <= 1'd0;
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd1;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= Wait;
			end
			
			/* WAIT */
			Wait: begin
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
				WriteALUOut <= 1'd0;
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= 7'd92;
			end
			
			/* WRITING IR */
			7'd92: begin
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
				WriteALUOut <= 1'd0;
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= 7'd2;
			end
			
			/* DECODE */
			7'd2: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd0;
				IRWrite <= 1'd0;
				RegDst <= 3'd0;
				RegWrite <= 1'd0;
				WriteA <= 1'd1;
				WriteB <= 1'd1;
				ALUSrcA <= 2'd0;
				ALUSrcB <= 3'd3;
				ALUOp <= 3'd1;
				WriteALUOut <= 1'd1;
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				case (OpCode) 
					typeR: begin
						case (Func) 
							6'h20: nextstate <= 7'd3; // add
							6'h22: nextstate <= 7'd4; // sub
							6'h24: nextstate <= 7'd5; // and
							6'h8: nextstate <= 7'd7;  // jr
							6'h2a: nextstate <= 7'd9; // slt (nao ta funfando)
							6'hd: nextstate <= 7'd10; // break
							6'h13: nextstate <= 7'd11;// rte
							6'h5: nextstate <= 7'd12; // xchg
							6'h0: nextstate <= LoadShiftSll; // sll
							6'h4: nextstate <= LoadShiftSllv; // sllv 
							6'h3: nextstate <= LoadShiftSra; // sra
							6'h7: nextstate <= LoadShiftSrav; // srav
							6'h2: nextstate <= LoadShiftSrl; // srl
						endcase
					end
					Addi: begin
						nextstate <=  7'd6;
					end
					Addiu: begin
						nextstate <= 7'd8;
					end
					J: begin
						nextstate <= 7'd16; 
					end
					Beq: begin
						nextstate <= 7'd50;
					end
					Bne: begin
						nextstate <= 7'd50;
					end
					Bgt: begin
						nextstate <= 7'd50;
					end
					Ble: begin
						nextstate <= 7'd50;
					end
					Jal: begin
						nextstate <= 7'd80;
					end
				endcase 
				
			end
			
			/* Add */
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                if (Overflow)
					nextstate <= OverflowExc;
                else
					nextstate <= WriteAluRd;
            end
            
            /* Sub */
            7'd4: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                if (Overflow)
					nextstate <= OverflowExc;
                else
					nextstate <= WriteAluRd;
            end
            
            /* And */
            7'd5: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= WriteAluRd;
            end
            
            /* Addi */
            7'd6: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                if (Overflow)
					nextstate <= OverflowExc;
                else
					nextstate <= WriteAddiRd;
            end
            
            /* Jr */
            7'd7: begin
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
                ALUOp <= 3'd0; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
            end
            
            /* Addiu */
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
                ALUSrcB <= 3'd4; //*
                ALUOp <= 3'd1; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                if (Overflow)
					nextstate <= OverflowExc;
                else
					nextstate <= WriteAddiRd;
			end
			
			/* Slt */
			7'd9: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd1;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd7; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= WriteSltRd;
			end
			
			/* Rte */
			7'd11: begin
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
                ALUOp <= 3'd0; //*
                WriteALUOut <= 1'd0; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd3;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* Xchg 1 */
			7'd12: begin
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
                ALUOp <= 3'd0; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= 7'd13;
			end
			
			/* Write A to rt */
			7'd13: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= 7'd14;
			end
			
			/* Xchg 2 */
			7'd14: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd2; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd0; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= 7'd15;
			end
			
			/* Write b to rs */
			7'd15: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd4;
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* Jump */
			Jump: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd1;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* WriteAluRd */     
			WriteAluRd: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
            end
            
            /* WriteAddiRd */
            WriteAddiRd: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
            end
            
            /* WriteSltRd */
            WriteSltRd: begin
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
                MemToReg <= 3'd6;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* Break */
			Break: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* Overflow Exc */
			OverflowExc: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= 7'd201;
			end
			
			/* Cause */
			Cause: begin
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
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= WriteCause;
			end
			
			/* Writing Cause Pc */
			WriteCause: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd1;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
			
			/* JAL */
			7'd80: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd1;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= 7'd81;
			end
			
			/* Wait Jal 1 */
			7'd81: begin
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
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= 7'd82; /* Decode */
			end
			
			/* Wait Jal 2 */
			7'd82: begin
				SrcAddressMem <= 3'd0;
				MemOp <= 1'd0;
				WriteMDR <= 1'd1;
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
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				nextstate <= 7'd83; /* Decode */
			end
			
			/* Writing RA */
			7'd83: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd2;
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
                MemToReg <= 3'd1;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Jump;
			end
			
			/* COMP */
			7'd50: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
				ALUSrcA <= 2'd1;
				ALUSrcB <= 3'd0;
				ALUOp <= 3'd7;
				WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                if (EQ == 1'd1 && OpCode == 6'h4) /* beq */
					nextstate <= Branch;
				else if (EQ == 1'd0 && OpCode == 6'h5) /* bne */
					nextstate <= Branch;
				else if (GT == 1'd0 && OpCode == 6'h6) /* ble */
					nextstate <= Branch;
				else if (GT == 1'd1 && OpCode == 6'h7) /* bgt */
					nextstate <= Branch;
				else 
					nextstate <= Fetch; /* nao da branch */
			end
			
			/* BRANCH */
			Branch: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd1;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end	
			
			/* Load Shift Sll */
			LoadShiftSll: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				nextstate <= 7'd70;					
			end
						
			/* Sll */
			7'd70: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd2;
                nextstate <= WriteShiftRd;
			end
			
			/* Load Shift Sllv */
			LoadShiftSllv: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd1;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				nextstate <= 7'd71;
			end
			
			/* Sllv */
			7'd71: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd1;
				DisRegShamt <= 2'd1;
				DisRegOp <= 3'd2;
                nextstate <= WriteShiftRd;
			end
			
			/* Load Shift Sra */
			LoadShiftSra: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				nextstate <= 7'd72;
			end

			
			/* Sra */
			7'd72: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd4;
                nextstate <= WriteShiftRd;
			end
			
			/* Load Shift Srav */
			LoadShiftSrav: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd1;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				nextstate <= 7'd73;
			end

			/* Srav */
			7'd73: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd1;
				DisRegShamt <= 2'd1;
				DisRegOp <= 3'd4;
                nextstate <= WriteShiftRd;
			end
			
			/* Load Shift Srl */
			LoadShiftSrl: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				nextstate <= 7'd74;
			end

			
			/* Srl */
			7'd74: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd3;
                nextstate <= WriteShiftRd;
			end
			
			/*WriteShiftRd*/
			WriteShiftRd: begin
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
                MemToReg <= 3'd4;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
                nextstate <= Fetch;
			end
		endcase
	end
endmodule
