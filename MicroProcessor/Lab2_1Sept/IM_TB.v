`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 07:25:05 PM
// Design Name: 
// Module Name: IM_TB
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


module IM_TB();
reg [7:0] address;
wire [16:0] instruct;
reg [16:0] ml[0:255];
integer i;

Instruction_Mem IM(address,instruct);
initial begin

#10
for(i=0;i<=7;i=i+1)
begin
    #20
    ml[i]=i;
end
end
initial
begin
#250 $stop;
end
endmodule
