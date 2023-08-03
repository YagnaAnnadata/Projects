`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2022 11:06:43 PM
// Design Name: 
// Module Name: MUXA
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


module MUXA(registerA,pc_1,bus_A,MA);
input [7:0] registerA;
input [7:0] pc_1;
input MA;
output reg [7:0] bus_A;
always@(MA or pc_1 or registerA)
begin
    if(MA==0)
    begin
        bus_A=  registerA;
    end
    else
    begin
        bus_A = pc_1;
    end
end
endmodule
