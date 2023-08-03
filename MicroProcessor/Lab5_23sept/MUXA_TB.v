`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2022 11:11:18 PM
// Design Name: 
// Module Name: MUXA_TB
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


module MUXA_TB;
reg [7:0] registerA;
reg [7:0] pc_1;
reg MA;
wire [7:0] bus_A;

MUXA muxa(.registerA(registerA),
            .pc_1(pc_1),
            .MA(MA),
            .bus_A(bus_A));
initial
begin
    registerA = $random;
    pc_1=$random;
    #50;
    MA=0;
    #50
    MA=1;    
end        
endmodule
