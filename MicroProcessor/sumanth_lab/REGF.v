`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/30 11:59:42
// Design Name: 
// Module Name: REGF
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


module REGF(
    input clk,
    input RW,
    input [2:0]DA ,
    input [7:0]BuD ,
    input [2:0]AA ,
    input [2:0]BA ,
    output [7:0]PoA ,
    output [7:0]PoB 
    );
//    `include  "parameters.v"
/*    DOF regf(
         .PoA(PoA)
    );*/
    
    reg [7:0] regi [7:0];
    assign {PoA,PoB}= {regi[AA],regi[BA]};
    always @ (posedge clk) begin
        if (RW)
            regi[DA]<=BuD;        
        regi[0]<=0;
    end
endmodule
