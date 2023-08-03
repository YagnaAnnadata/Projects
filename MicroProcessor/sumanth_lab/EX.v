`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/31 03:38:08
// Design Name: 
// Module Name: EX
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


module EX(
input clk,
input [7:0]PC_2,
input [7:0]BuA,
input [7:0]BuB,
input [7:0]MRD,
input [3:0]FS,
input [2:0]SH,
input [2:0]DA,
input [1:0]MD,
input RW,
input [1:0]BS,
input PS,
input MW,
output [7:0]BrA,
output [7:0]RAA,
output [7:0]MEA,
output [7:0]MWD,
output [1:0]BSO,
output MWO,
output PSO,
output Zw,
output reg [7:0]FU,
output reg [7:0]MEM,
output reg [2:0]DAO,
output reg [1:0]MDO,
output reg RWO,
output reg Z,
output reg C,
output reg N,
output reg V,
output reg LT);

//wire Zw;
wire Cw;
wire Nw;
wire Vw;
wire [7:0]F;

assign BrA=PC_2+BuB; //BrA
assign MEA=BuA;//memory read address
assign MWD=BuB;//memory write data
assign MWO=MW;//MW to memory

//to the PC in IF
assign RAA=BuA;
assign BSO=BS;
assign PSO=PS;

//output of function unit
assign {Cw,F}=(FS==4'b00010)?(BuA+BuB):(
                (FS==4'b101)?(BuA-BuB):(
                (FS==4'b1000)?(BuA&BuB):(
                (FS==4'b1010)?(BuA|BuB):(
                (FS==4'b1100)?(BuA^BuB):(
                (FS==4'b1110)?(~BuA):(
                (FS==4'b0)?(BuA):(
                (FS==4'b100)?(BuA<<SH):(
                (FS==4'b1001)?(BuA>>SH):(
                (FS==4'b111)?(BuA):(
                4'bxxxxx))))))))));
assign Nw=F[7];//N flag
assign Zw=~|F;//Z flag
assign Vw= FS[2]? (( BuA[7] & ~BuB[7] & ~F[7] )|(~BuA[7] & BuB[7] & F[7])):
                 (( ~BuA[7] & ~BuB[7] & F[7])|(BuA[7] & BuB[7] & ~F[7]));//V flag

always @(negedge clk) begin
//ZVNC
    Z<=Zw;
    C<=Cw;
    N<=Nw;
    V<=Vw;
    
    FU<=F;//function unit
    RWO<=RW;//output RW
    DAO<=DA;//output DA
    MDO<=MD;//output MD
    MEM<=MRD;///output memory data
    LT<=Nw^Vw;//less than bit
    
end
endmodule
