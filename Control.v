/* UNIDADE DE CONTROLE PARA ENTREGA PARCIAL (incompleta) */
module Control(clk, reset, OpCode, Func, Overflow, Neg, Zero, LT, EQ, GT, DivZero, MultEnd, DivEnd,
				SrcAddressMem, MemOp, WriteMDR, IRWrite, RegDst, RegWrite, WriteA, WriteB, ALUSrcA,
				ALUSrcB, ALUOp, WriteALUOut, EPCWrite, PCSource, PCWrite, MemToReg, DisRegEntry,
				DisRegShamt, DisRegOp, MultControl, DivControl, SrcHiLo, HiLoWrite, LoadOp, StoreOp);
	
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
	input LT;
	input DivZero;
	input MultEnd;
	input DivEnd;
	
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
	output reg MultControl;
	output reg DivControl;
	output reg SrcHiLo;
	output reg HiLoWrite;
	output reg [1:0] LoadOp;
	output reg [1:0] StoreOp;

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
	parameter Slti = 6'ha;
	parameter Lui = 6'hf;
	parameter Sw = 6'h2b;
	parameter Sh = 6'h29;
	parameter Sb = 6'h28;
	parameter Lw = 6'h23;
	parameter Lh = 6'h21;
	parameter Lb = 6'h20;
	
	/* PARAMETROS DECIMAIS */
	parameter Fetch = 7'd1;
	parameter Reset = 7'd0;
	parameter Wait = 7'd91;
	parameter WriteAluRd = 7'd93;
	parameter WriteAddiRd = 7'd94;
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
	parameter NoOpcodeExc = 7'd18;
	
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= Fetch;
			end
			
			/* FETCH */
			Fetch: begin
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
				ALUOp <= 3'd1;
				WriteALUOut <= 1'd0;
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd1;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				case (OpCode) 
					typeR: begin
						case (Func) 
							6'h20: nextstate <= 7'd3; // add
							6'h22: nextstate <= 7'd4; // sub
							6'h24: nextstate <= 7'd5; // and
							6'h8: nextstate <= 7'd7;  // jr
							6'h2a: nextstate <= 7'd9; // slt 
							6'hd: nextstate <= 7'd10; // break
							6'h13: nextstate <= 7'd11;// rte
							6'h5: nextstate <= 7'd12; // xchg
							6'h0: nextstate <= LoadShiftSll; // sll
							6'h4: nextstate <= LoadShiftSllv; // sllv 
							6'h3: nextstate <= LoadShiftSra; // sra
							6'h7: nextstate <= LoadShiftSrav; // srav
							6'h2: nextstate <= LoadShiftSrl; // srl
							6'h10: nextstate <= 7'd34; // mfhi
							6'h12: nextstate <= 7'd35; // mflo
							6'h18: nextstate <= 7'd85; // mult
							6'h1a: nextstate <= 7'd95; // div
						endcase
					end
					Addi: begin
						nextstate <=  7'd6;
					end
					Addiu: begin
						nextstate <= 7'd8;
					end
					J: begin
						nextstate <= Jump; 
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
					Slti: begin
						nextstate <= 7'd45;
					end
					Lui: begin
						nextstate <= 7'd32;
					end
					Sw: begin
						nextstate <= 7'd110;
					end
					Sh: begin
						nextstate <= 7'd110;
					end
					Sb: begin
						nextstate <= 7'd110;
					end
					Lw: begin
						nextstate <= 7'd115;
					end
					Lh: begin
						nextstate <= 7'd115;
					end
					Lb: begin
						nextstate <= 7'd115;
					end
					Blm: begin
						nextstate <= 7'd23;
					end
					default: begin
						nextstate <= NoOpcodeExc;
					end
				endcase 
				
			end
			
			/* No Op */
			7'd18: begin
                SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd0; //*
                ALUSrcB <= 3'd1; //*
                ALUOp <= 3'd2; //*
                WriteALUOut <= 1'd1; //*
                EPCWrite <= 1'd1;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= 7'd88;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
			end
			
			/* Slt */
			7'd9: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd1;
                RegWrite <= 1'd1;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1; //*
                ALUSrcB <= 3'd0; //*
                ALUOp <= 3'd7; //*
                WriteALUOut <= 1'd0; //*
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd6;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
                PCSource <= 2'd2;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd88;
			end
			
			/*WriteEPC */
			7'd88: begin
				if (Overflow == 1'd1) begin
					SrcAddressMem <= 3'd3;
				end
				else if (DivZero == 1'd1) begin
					SrcAddressMem <= 3'd4;
				end
				else begin
					SrcAddressMem <= 3'd2;
				end
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
				EPCWrite <= 1'd1;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= 7'd77;
			end
			
			/* Wait */
			7'd77: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Cause;
			end
			
			/* Wait2 */
			Cause: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
                ALUSrcA <= 2'd3;
                ALUSrcB <= 3'd0;
                ALUOp <= 3'd0;
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd1;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Jal */
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
                WriteALUOut <= 1'd1;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd81;
			end
			
			/* Write Ra & PC */
			7'd81: begin
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
				PCSource <= 2'd2;
				PCWrite <= 1'd1;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= Fetch; 
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Slti */
			7'd45: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd1;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1;
                ALUSrcB <= 3'd2;
                ALUOp <= 3'd7;
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd6;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Mfhi*/
            7'd34: begin
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
                MemToReg <= 3'd2;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Mflo */
			7'd35: begin
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
                MemToReg <= 3'd3;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Lui Load */
			7'd32: begin
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
                DisRegEntry <= 2'd2;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd1;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd33;
			end
			
			/* Lui Op */
			7'd33: begin
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
				DisRegShamt <= 2'd2;
				DisRegOp <= 3'd2;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd31;
			end
			
			/* WriteLuiRt */
			7'd31: begin
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
                MemToReg <= 3'd4;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
            end
            
            /* Store */
			7'd110: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1;
                ALUSrcB <= 3'd2;
                ALUOp <= 3'd1;
                WriteALUOut <= 1'd1;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd111;
			end
			
			/* Store Address */			
			7'd111: begin
				SrcAddressMem <= 3'd1;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd112;
			end
			
			/* Store Wait */
			7'd112: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd113;
			end
			
			/* Store Write MDR */
			7'd113: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				case (OpCode)
					Sw: nextstate <= 7'd114;
					Sh: nextstate <= 7'd120;
					Sb: nextstate <= 7'd121;
				endcase
				
			end
			
			
			/* Store w Memory */
			7'd114: begin
				SrcAddressMem <= 3'd1; //
                MemOp <= 1'd1; //
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
				LoadOp <= 2'd0; //
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Store h Memory */
			7'd120: begin
				SrcAddressMem <= 3'd1;
                MemOp <= 1'd1;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd1;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Store b Memory */			
			7'd121: begin
				SrcAddressMem <= 3'd1;
                MemOp <= 1'd1;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd2;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Load */
			7'd115: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1;
                ALUSrcB <= 3'd2;
                ALUOp <= 3'd1;
                WriteALUOut <= 1'd1;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd116;
			end
            
            /* Load Address */
			7'd116: begin
				SrcAddressMem <= 3'd1;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd117;
			end
			
			/* Load Wait */
			7'd117: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd118;
			end
            
            /* Load Write MDR */
            7'd118: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				case (OpCode)
					Lw: nextstate <= 7'd119;
					Lh: nextstate <= 7'd122;
					Lb: nextstate <= 7'd123;
				endcase
                
			end
			
			/* Load w */
			7'd119: begin
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
                MemToReg <= 3'd5;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Load h */
			7'd122: begin
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
                MemToReg <= 3'd5;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd1;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
			/* Load b */
			7'd123: begin
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
                MemToReg <= 3'd5;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd2;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= Fetch;
			end
			
            /* Mult */    
            7'd85: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd1;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd86;
			end
			
			/* Mult wait */
			7'd86: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				if (MultEnd == 0)
					nextstate <= 7'd86;
                else
					nextstate <= 7'd87;
			end
			
			/* WriteMult */
			7'd87: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd1;
                nextstate <= Fetch;
			end
			
			/* Blm init */ // Carrega o valor de Rs em
			7'd23: begin
				SrcAddressMem <= 3'd5; //
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd1;
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd24;
			end
			
			/* Blm Wait */ // Espera a memória ler o endereço Rs
			7'd24: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd25;
			end
			
			/* Blm Wait */ // Espera a memória ler o endereço Rs
			7'd25: begin
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
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
                nextstate <= 7'd26;
			end
			
			/* Blm */
			7'd26: begin
				SrcAddressMem <= 3'd0;
                MemOp <= 1'd0;
                WriteMDR <= 1'd0;
                IRWrite <= 1'd0;
                RegDst <= 3'd0;
                RegWrite <= 1'd0;
                WriteA <= 1'd0;
                WriteB <= 1'd0;
                ALUSrcA <= 2'd2; // A = B
                ALUSrcB <= 3'd5; // B = Mem[A]
                ALUOp <= 3'd7; // B > Mem[A]
                WriteALUOut <= 1'd0;
                EPCWrite <= 1'd0;
                PCSource <= 2'd0;
                PCWrite <= 1'd0;
                MemToReg <= 3'd0;
                DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				if (LT == 1'b0 && EQ == 1'b0 && GT == 1'b1) begin
					nextstate <= Branch;
				end
				else begin
					nextstate <= Fetch;
				end
			end
						
			/* Div */
			7'd95: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd1;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= 7'd96;
			end
			
			/* Div wait */
			7'd96: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				if (DivZero == 1)
					nextstate <= 7'd98;
				else if (DivEnd == 0)
					nextstate <= 7'd96;
				else if (DivEnd == 1)
					nextstate <= 7'd97;
					
			end
			
			/* Write Div */
			7'd97: begin
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
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd1;
				HiLoWrite <= 1'd1;
				nextstate <= Fetch;
			end
			
			 /* exc div */
			7'd98: begin
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
				EPCWrite <= 1'd0;
				PCSource <= 2'd0;
				PCWrite <= 1'd0;
				MemToReg <= 3'd0;
				DisRegEntry <= 2'd0;
				DisRegShamt <= 2'd0;
				DisRegOp <= 3'd0;
				LoadOp <= 2'd0;
				StoreOp <= 2'd0;
				MultControl <= 1'd0;
				DivControl <= 1'd0;
				SrcHiLo <= 1'd0;
				HiLoWrite <= 1'd0;
				nextstate <= 7'd88;
			end 
			
		endcase
	end
endmodule
