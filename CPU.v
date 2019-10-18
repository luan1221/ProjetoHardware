module CPU(input clk, input reset, output reg [31:0] PCOut, output reg [31:0] MDRout,
			output reg [31:0] OutA, output reg [31:0] OutB, output reg [31:0] ALUResult,
			output reg [31:0] EPCout, output reg [31:0] ALUOutSaida, output reg EQ, 
			output reg LT, output reg [31:0] LTExt, output reg [31:0] ShiftOut,
			output [31:0] StoreOut, output [31:0] LoadOut, output reg GT);

	// Sinais de controle
	wire PCWrite;
	wire [2:0] SrcAddressMem;
	wire MemOp;
	wire WriteMDR;
	wire IRWrite;
	wire RegWrite;
	wire WriteA;
	wire WriteB;
	wire [1:0] ALUSrcA;
	wire [2:0] ALUSrcB;
	wire [2:0] ALUOp;
	wire WriteALUOut;
	wire EPCWrite;
	wire [1:0] PCSource;
	wire [2:0] MemToReg;
	wire [2:0] RegDst;
	wire [1:0] DisRegEntry;
	wire [1:0] DisRegShamt;
	wire [2:0] DisRegOp;
	wire MultControl;
	wire DivControl;
	wire SrcHiLo;
	wire HiLoWrite;
	wire [1:0] LoadOp;
	wire [1:0] StoreOp;
	wire MultEnd;
	
	// Fios do PC
	wire [31:0] Compilar = 32'd0; /* Resolver isso depois (inserido para completar os mux) */
	wire [31:0] PCin;
	
	// Fios da Memória
	wire [31:0] Address;
	wire [31:0] MemData;
	
	// IR (registrador de instruções)
	wire [15:0] inst15_0;
	wire [4:0] rd = inst15_0[15:11];
	wire [4:0] rt;
	wire [4:0] rs;
	wire [25:0] endJump = {rs, rt, inst15_0};
	wire [27:0] ShiftJump;
	ShiftLeftJump SLjump(endJump, ShiftJump); // shift left do jump
	wire [31:0] jump = {PCOut[31:28], ShiftJump};
	
	// Unidade de Controle
	wire [5:0] OpCode;
	wire [5:0] Func;
	assign Func = inst15_0[5:0];
	
	// Banco de Registradores
	wire [31:0] ReadReg1;
	wire [31:0] ReadReg2;
	wire [4:0] WriteReg;
	wire [31:0] WriteData;
	wire [31:0] ReadDataA;
	wire [31:0] ReadDataB;
	wire [31:0] LTaux = LTExt;
	SignExtLT SElt(LT, LTaux); // sign extend do sinal LT
	
	// ULA
	wire [31:0] immediate;
	SignExtImmediate SEimdt(inst15_0, immediate); // sign extend do imediato
	wire [31:0] branch;
	wire [31:0] uImmediate;
	unSignExtImmediate USEimdt(inst15_0, uImmediate);
	ShiftLeftBranch SLbranch(immediate, branch); // end do branch
	wire [31:0] OutSrcA;
	wire [31:0] OutSrcB;
	wire Overflow;
	wire Neg;
	wire Zero;
	
	// RegDesloc
	wire [31:0] outDisRegE;
	wire [4:0] outDisRegS;
	wire [4:0] bitsShamt = inst15_0[10:6];
	wire [4:0] bShamt = OutB[4:0];
	
	
	//Load e Store
	//wire [31:0] LoadOut;
	Load LoadBox(LoadOp, MDRout, LoadOut);
	//wire [31:0] StoreOut;
	Store StoreBox(StoreOp, OutB, MDRout, StoreOut);
	
	// Div e Mult
	wire[31:0] SrcHiOut;
	wire[31:0] SrcLoOut;
	wire[31:0] M_OutHi;
	wire[31:0] M_OutLo;
	wire[31:0] D_OutHi;
	wire[31:0] D_OutLo;
	wire DivZero;
	wire [31:0] HiOut;
	wire[31:0] LoOut;
	
	// EXC
	wire [7:0] ByteEXC = MemData[7:0];
	wire [31:0] EndEXC;
	SignExtEXC SEexc(ByteEXC, EndEXC); // sign extend do end da excecao
	wire [31:0] EPCin = ALUOutSaida;
	
	// Registradores
	Registrador PC(clk, reset, PCWrite, PCin, PCOut);
	Registrador MDR(clk, reset, WriteMDR, MemData, MDRout);
	Registrador A(clk, reset, WriteA, ReadDataA, OutA);
	Registrador B(clk, reset, WriteB, ReadDataB, OutB);
	Registrador ALUOut(clk, reset, WriteALUOut, ALUResult, ALUOutSaida);
	Registrador EPC(clk, reset, EPCWrite, EPCin, EPCout);
	Registrador Hi(clk, reset, HiLoWrite, SrcHiOut, HiOut);
	Registrador Lo(clk, reset, HiLoWrite, SrcLoOut, LoOut);
	
	// Componentes
	ula32 ALU(OutSrcA, OutSrcB, ALUOp, ALUResult, Overflow, Neg, Zero, EQ, GT, LT);
	Banco_reg Bank(clk, reset, RegWrite, rs, rt, WriteReg, WriteData, ReadDataA, ReadDataB);
	Instr_Reg IR(clk, reset, IRWrite, MemData, OpCode, rs, rt, inst15_0);
	Memoria Memory(Address, clk, MemOp, StoreOut, MemData); // *
	RegDesloc ShiftReg(clk, reset, DisRegOp, outDisRegS, outDisRegE, ShiftOut);
	Mult Multiplier(clk, reset, OutA, OutB, MultControl, M_OutHi, M_OutLo, MultEnd);
	// Div Divisor(clk, reset, OutA, OutB, DivControl, D_OutHi, D_OutLo, DivZero);
	
	// Multiplexadores
	MuxSrcAddressMem SrcAddMem(SrcAddressMem, PCOut, ALUOutSaida, ALUResult, Address);
	MuxRegDst RegDest(RegDst, rt, rd, rs, WriteReg);
	MuxALUSrcA SrcA(ALUSrcA, PCOut, OutA, OutB, EndEXC, OutSrcA); // *
	MuxALUSrcB SrcB(ALUSrcB, OutB, immediate, branch, uImmediate, MemData, OutSrcB); // * (ENTRADAS: B, imediato, branch, unsignext, memdata) 
	MuxPCSource PCfonte(PCSource, ALUResult, ALUOutSaida, jump, EPCout, PCin); // *
	MuxMemToReg DataToReg(MemToReg, ALUOutSaida, MemData, HiOut, LoOut, ShiftOut, LoadOut, LTExt, WriteData); // *
	MuxDisRegEntry DisRegE(DisRegEntry, OutB, OutA, immediate, outDisRegE);
	MuxDisRegShamt DisRegS(DisRegShamt, bitsShamt, bShamt, outDisRegS);
	MuxSrcHi SrcHi(SrcHiLo, M_OutHi, D_OutHi, SrcHiOut); // *
	MuxSrcLo SrcLo(SrcHiLo, M_OutLo, D_OutLo, SrcLoOut); // *
	
	// Unidade de Controle
	Control Maquina(clk, reset, OpCode, Func, Overflow, Neg, Zero, LT, EQ, GT, DivZero, MultEnd, SrcAddressMem, MemOp, WriteMDR,
					IRWrite, RegDst, RegWrite, WriteA, WriteB, ALUSrcA, ALUSrcB, ALUOp, WriteALUOut,
					EPCWrite, PCSource, PCWrite, MemToReg, DisRegEntry, DisRegShamt, DisRegOp, MultControl,
					DivControl, SrcHiLo, HiLoWrite, LoadOp, StoreOp);

endmodule
