module CPU(input clk, input reset, output reg [31:0] PCOut, output reg [31:0] MDRout,
			output reg [31:0] OutA, output reg [31:0] OutB, output reg [31:0] ALUResult,
			output reg [31:0] EPCout, output reg [31:0] ALUOutSaida);

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
	
	// Fios do PC
	wire [31:0] Compilar = 32'd0; /* Resolver isso depois (inserido para completar os mux) */
	// output reg [31:0] PCOut;
	wire [31:0] PCin;
	
	// Fios da Memória
	wire [31:0] Address;
	wire [31:0] MemData;
	// output reg [31:0] MDRout;
	
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
	wire [31:0] LTExt;
	SignExtLT SElt(LT, LTExt); // sign extend do sinal LT
	
	// ULA
	// output reg [31:0] OutA;
	// output reg [31:0] OutB;
	wire [31:0] immediate;
	//assign immediate = {16'd0, inst15_0};
	SignExtImmediate SEimdt(inst15_0, immediate); // sign extend do imediato
	wire [31:0] branch;
	//assign branch = immediate << 2;
	wire [31:0] uImmediate;
	unSignExtImmediate USEimdt(inst15_0, uImmediate);
	ShiftLeftBranch SLbranch(immediate, branch); // end do branch
	wire [31:0] OutSrcA;
	wire [31:0] OutSrcB;
	// output reg [31:0] ALUResult;
	wire Overflow;
	wire Neg;
	wire Zero;
	wire EQ;
	wire GT;
	wire LT;
	
	// EXC
	wire [7:0] ByteEXC = MemData[7:0];
	wire [31:0] EndEXC;
	SignExtEXC SEexc(ByteEXC, EndEXC); // sign extend do end da excecao
	wire [31:0] EPCin = ALUOutSaida;
	// output reg [31:0] EPCout;
	
	// Registradores
	Registrador PC(clk, reset, PCWrite, PCin, PCOut);
	Registrador MDR(clk, reset, WriteMDR, MemData, MDRout);
	Registrador A(clk, reset, WriteA, ReadDataA, OutA);
	Registrador B(clk, reset, WriteB, ReadDataB, OutB);
	Registrador ALUOut(clk, reset, WriteALUOut, ALUResult, ALUOutSaida);
	Registrador EPC(clk, reset, EPCWrite, EPCin, EPCout);
	
	// Componentes
	ula32 ALU(OutSrcA, OutSrcB, ALUOp, ALUResult,Overflow, Neg, Zero, EQ, GT, LT);
	Banco_reg Bank(clk, reset, RegWrite, rs, rt, WriteReg, WriteData, ReadDataA, ReadDataB);
	Instr_Reg IR(clk, reset, IRWrite, MemData, OpCode, rs, rt, inst15_0);
	Memoria Memory(Address, clk, MemOp, Compilar, MemData); // *
	
	// Multiplexadores
	MuxSrcAddressMem SrcAddMem(SrcAddressMem, PCOut, ALUOutSaida, Address);
	MuxRegDst RegDest(RegDst, rt, rd, rs, WriteReg);
	MuxALUSrcA SrcA(ALUSrcA, PCOut, OutA, OutB, EndEXC, OutSrcA); // *
	MuxALUSrcB SrcB(ALUSrcB, OutB, immediate, branch, uImmediate, Compilar, OutSrcB); // * (ENTRADAS: B, imediato, branch, unsignext, memdata) 
	MuxPCSource PCfonte(PCSource, ALUResult, ALUOutSaida, jump, EPCout, PCin); // *
	MuxMemToReg DataToReg(MemToReg, ALUOutSaida, MemData, Compilar, Compilar, Compilar, Compilar, LTExt, WriteData); // *
	
	// Unidade de Controle
	Control Maquina(clk, reset, OpCode, Func, Overflow, Neg, Zero, EQ, GT, SrcAddressMem, MemOp, WriteMDR,
					IRWrite, RegDst, RegWrite, WriteA, WriteB, ALUSrcA, ALUSrcB, ALUOp, WriteALUOut,
					EPCWrite, PCSource, PCWrite, MemToReg);

endmodule
