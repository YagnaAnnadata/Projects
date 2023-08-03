`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/31 13:08:48
// Design Name: 
// Module Name: IM
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


module IM(
    input clk,
    input [31:0]PC,//memory address
    output [31:0]IR,//memory read data     
    input [31:0]mul1,
    input [31:0]mul2
    );
 //   `include "parameters.v"
    parameter NOP=0,ADD=7'b10,SUB=7'b101,
SLT=7'b1100101,
AND=7'b1000,
OR=7'b1010,
XOR=7'b1100,
ST=7'b1,
LD=7'b100001,
ADI=7'b100010,
SBI=7'b100101,
NOT=7'b101110,
ANI=7'b101000,
ORI=7'b101010,
XRI=7'b101100,
AIU=7'b1100010,
SIU=7'b1000101,
MOV=7'b1000000,
LSL=7'b110000,
LSR=7'b110001,
JMR=7'b1100001,
BZ=7'b100000,
BNZ=7'b1100000,
JMP=7'b1000100,
JML=7'b111,
R0=5'd0,
R1=5'd1,
R2=5'd2,
R3=5'd3,
R4=5'd4,
R5=5'd5,
R6=5'd6,
R7=5'd7,
R8=5'd8,
R9=5'd9,
R10=5'd10,
R11=5'd11,
R12=5'd12,
R13=5'd13,
R14=5'd14,
R15=5'd15,
R16=5'd16,
R17=5'd17;

///    parameter mul1=-32'h1;
//    parameter mul2=32'h2;
    reg [31:0] regi [1023:0];
    assign IR= regi[PC];
    
always @ (posedge clk)begin
    regi[0]=0;
    regi[1]={AIU,R1,R0,mul1[31:17]};
    regi[2]={AIU,R2,R0,mul2[31:17]};
    regi[3]={LSL,R1,R1,15'd15};
    regi[4]={LSL,R2,R2,15'd15};
    regi[5]={AIU,R1,R1,mul1[16:2]};
    regi[6]={AIU,R2,R2,mul2[16:2]};
    regi[7]={LSL,R1,R1,15'd2};
    regi[8]={LSL,R2,R2,15'd2};
    regi[9]={AIU,R1,R1,13'd0,mul1[1:0]};
    regi[10]={AIU,R2,R2,13'd0,mul2[1:0]};
    regi[11]={SLT,R16,R1,R0,10'b0};
    regi[12]={SLT,R17,R2,R0,10'd0};
    regi[13]=NOP;
regi[14]={MOV,R3,R0,15'b0};
regi[15]={MOV,R4,R0,15'b0};
regi[16]={MOV,R8,R0,15'b0};
regi[17]={BZ,R0,R16,15'd3};
regi[18]=NOP;
regi[19]=NOP;
regi[20]={SUB,R1,R0,R1,10'd0};
regi[21]={XOR,R16,R16,R17,10'd0};
regi[22]={BZ,R0,R17,15'd3};
regi[23]=NOP;
regi[24]=NOP;
regi[25]={SUB,R2,R0,R2,10'd0};
regi[26]={ANI,R6,R1,15'd1};
regi[27]={MOV,R7,R2,15'b0};
regi[28]=NOP;
regi[29]={BZ,R0,R6,15'd3};
regi[30]=NOP;
regi[31]=NOP;
regi[32]={MOV,R3,R2,15'b0};
regi[33]={MOV,R5,R1,15'b0};
regi[34]=NOP;
regi[35]={LSR,R5,R5,15'd1};
regi[36]=NOP;
regi[37]={BZ,R0,R5,15'd36};
regi[38]=NOP;
regi[39]=NOP;
regi[40]={LSL,R8,R8,15'd1};
regi[41]={SLT,R9,R7,R0,10'd0};
regi[42]={LSL,R7,R7,15'd1};
regi[43]={BZ,R0,R9,15'd3};
regi[44]=NOP;
regi[45]=NOP;
regi[46]={ADI,R8,R8,15'd1};
regi[47]={ANI,R6,R5,15'd1};
regi[48]=NOP;
regi[49]={BZ,R0,R6,-15'd15};
regi[50]=NOP;
regi[51]=NOP;
regi[52]={SLT,R9,R7,R0,10'd0};
regi[53]={SLT,R10,R3,R0,10'd0};
regi[54]={ADD,R3,R3,R7,10'd0};
regi[55]={XOR,R9,R9,R10,10'd0};
regi[56]={ADD,R4,R4,R8,10'd0};
regi[57]={SLT,R11,R3,R0,10'd0};
regi[58]={BNZ,R0,R9,15'd8};
regi[59]=NOP;
regi[60]=NOP;
regi[61]={BZ,R0,R10,-15'd27};
regi[62]=NOP;
regi[63]=NOP;
regi[64]={JMP,R0,R0,15'd5};
regi[65]=NOP;
regi[66]=NOP;
regi[67]={BNZ,R0,R11,-15'd33};
regi[68]=NOP;
regi[69]=NOP;
regi[70]={ADI,R4,R4,15'd1};
regi[71]={JMP,R0,R0,-15'd37};
regi[72]=NOP;
regi[73]=NOP;
regi[74]={BZ,R0,R16,15'd14};
regi[75]=NOP;
regi[76]=NOP;
regi[77]={SLT,R17,R3,R0,10'd0};
regi[78]={NOT,R4,R4,15'b0};
regi[79]={SUB,R3,R0,R3,10'd0};
regi[80]=NOP;
regi[81]={SLT,R16,R3,R0,10'd0};
regi[82]=NOP;
regi[83]={ADD,R16,R16,R17,10'd0};
regi[84]=NOP;
regi[85]={BNZ,R0,R16,15'd3};
regi[86]=NOP;
regi[87]=NOP;
regi[88]={ADI,R4,R4,15'd1};
regi[89]={MOV,R13,R3,15'D0};
regi[90]={MOV,R14,R4,15'D0};

end
endmodule
