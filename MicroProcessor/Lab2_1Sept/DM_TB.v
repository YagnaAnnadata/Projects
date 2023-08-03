`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 07:52:57 PM
// Design Name: 
// Module Name: DM_TB
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


module DM_TB();

reg clk;
reg      [7:0] address;
reg      [7:0] dataIn;
reg      write;
wire      [7:0]mem[0:255];
wire [7:0] dataOut;

reg[8:0] addr_reg;

Data_mem DM(clk,address,write,datain,mem,dataOut,addr_reg);
initial 
begin
clk=0;
write=1;
end
always #50 clk=~clk;
endmodule
