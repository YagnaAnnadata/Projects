`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/31 12:18:42
// Design Name: 
// Module Name: WB
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


module WB(
    input [7:0]FU,
    input [7:0]MEM,
    input [2:0]DA,
    input [1:0]MD,
    input LT,
    input RW,
    output [7:0]BuD,
    output [2:0]DAO,
    output RWO
    );

assign RWO=RW;
assign DAO=DA;
assign BuD=(MD==2)?{7'b0,LT}:(
            (MD==1)?MEM:(
            (MD==0)?FU:1'bx
            ));
endmodule
