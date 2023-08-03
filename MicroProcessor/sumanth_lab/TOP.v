`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/30 23:19:01
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP(
input clk,
input reset,//reset PC
input [31:0]mul1,
input [31:0]mul2,
output [31:0]PC,
output [31:0]PC_1,
output [31:0]PC_2,
output [31:0]IR,
output [31:0]BuA,
output [31:0]BuB,
output [4:0]FS,
output [31:0]FU,
output [4:0]DA,
output [31:0]BuD,
output RW,
output Z,
output V,
output N,
output C
    );
    
wire [31:0] DOF_EX_BuA;
wire [31:0] DOF_EX_BuB;
wire [31:0] DOF_EX_PC_2;
wire [4:0] DOF_EX_DA;
wire [4:0] DOF_EX_FS;
wire [4:0] DOF_EX_SH;
wire [1:0] DOF_EX_MD;
wire [1:0] DOF_EX_BS;
wire  DOF_EX_RW;
wire  DOF_EX_PS;
wire  DOF_EX_MW;
wire [31:0] EX_WB_FU;
wire [31:0] EX_WB_MEM;
wire [4:0] EX_WB_DA;
wire [1:0] EX_WB_MD;
wire  EX_WB_LT;
wire  EX_WB_RW;
wire [31:0] EX_IF_BrA;
wire [31:0] EX_IF_RAA;
wire [1:0] EX_IF_BS;
wire  EX_IF_PS;
wire  EX_IF_Zw;
wire [31:0] IF_DOF_IR;
wire [31:0] IF_DOF_PC_1;
wire [31:0] EX_MEM_MEA;
wire [31:0] EX_MEM_MWD;
wire  EX_MEM_MW;
wire [31:0] MEM_EX_MRD;
wire [4:0] DOF_REGF_AA;
wire [4:0] DOF_REGF_BA;
wire [31:0] REGF_DOF_PoA;
wire [31:0] REGF_DOF_PoB;
wire [31:0] WB_REGF_BuD;
wire [4:0] WB_REGF_DA;
wire  WB_REGF_RW;
wire [31:0] IF_IM_PC;
wire [31:0] IM_IF_IR;

DOF dof(
.clk(clk),
.IR(IF_DOF_IR),
.PC_1(IF_DOF_PC_1),
.PoA(REGF_DOF_PoA),
.PoB(REGF_DOF_PoB),
.BuA(DOF_EX_BuA),
.BuB(DOF_EX_BuB),
.PC_2(DOF_EX_PC_2),
.DA(DOF_EX_DA),
.FS(DOF_EX_FS),
.SH(DOF_EX_SH),
.MD(DOF_EX_MD),
.BS(DOF_EX_BS),
.RW(DOF_EX_RW),
.PS(DOF_EX_PS),
.MW(DOF_EX_MW),
.AA(DOF_REGF_AA),
.BA(DOF_REGF_BA)
);

EX ex(
.clk(clk),
.BuA(DOF_EX_BuA),
.BuB(DOF_EX_BuB),
.PC_2(DOF_EX_PC_2),
.DA(DOF_EX_DA),
.FS(DOF_EX_FS),
.SH(DOF_EX_SH),
.MD(DOF_EX_MD),
.BS(DOF_EX_BS),
.RW(DOF_EX_RW),
.PS(DOF_EX_PS),
.MW(DOF_EX_MW),
.MRD(MEM_EX_MRD),
.FU(EX_WB_FU),
.MEM(EX_WB_MEM),
.DAO(EX_WB_DA),
.MDO(EX_WB_MD),
.LT(EX_WB_LT),
.RWO(EX_WB_RW),
.BrA(EX_IF_BrA),
.RAA(EX_IF_RAA),
.BSO(EX_IF_BS),
.PSO(EX_IF_PS),
.Zw(EX_IF_Zw),
.MEA(EX_MEM_MEA),
.MWD(EX_MEM_MWD),
.MWO(EX_MEM_MW),

.Z(Z),
.V(V),
.N(N),
.C(C)
);

IF iif(
.clk(clk),
.reset(reset),
.BrA(EX_IF_BrA),
.RAA(EX_IF_RAA),
.BS(EX_IF_BS),
.PS(EX_IF_PS),
.Zw(EX_IF_Zw),
.IR(IM_IF_IR),
.IRO(IF_DOF_IR),
.PC_1(IF_DOF_PC_1),
.PC(IF_IM_PC)
);

WB wb(
.FU(EX_WB_FU),
.MEM(EX_WB_MEM),
.DA(EX_WB_DA),
.MD(EX_WB_MD),
.LT(EX_WB_LT),
.RW(EX_WB_RW),
.BuD(WB_REGF_BuD),
.DAO(WB_REGF_DA),
.RWO(WB_REGF_RW)
);

IM im(
.clk(clk),
.mul1(mul1),
.mul2(mul2),
.PC(IF_IM_PC),
.IR(IM_IF_IR)
);

MEM mem(
.clk(clk),
.MEA(EX_MEM_MEA),
.MWD(EX_MEM_MWD),
.MW(EX_MEM_MW),
.MRD(MEM_EX_MRD)
);

REGF regf(
.clk(clk),
.AA(DOF_REGF_AA),
.BA(DOF_REGF_BA),
.BuD(WB_REGF_BuD),
.DA(WB_REGF_DA),
.RW(WB_REGF_RW),
.PoA(REGF_DOF_PoA),
.PoB(REGF_DOF_PoB)
);

assign PC=IF_IM_PC;
assign PC_1=IF_DOF_PC_1;
assign PC_2=DOF_EX_PC_2;
assign IR=IF_DOF_IR;
assign BuA=DOF_EX_BuA;
assign BuB=DOF_EX_BuB;
assign FS=DOF_EX_FS;
assign FU=EX_WB_FU;
assign DA=EX_WB_DA;
assign RW=WB_REGF_RW;
assign BuD=WB_REGF_BuD;

endmodule
