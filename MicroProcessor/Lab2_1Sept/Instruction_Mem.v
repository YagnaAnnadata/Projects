`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 07:20:20 PM
// Design Name: 
// Module Name: Instruction_Mem
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


module Instruction_Mem(

    input      [7:0]  address, 
                       output wire [16:0] instruct );
  
   integer i;
	reg [16:0] ml[0:255];
	initial
	begin
    for(i=0;i<255;i=i+1)
        begin
            ml[i]<=0;
        end 
 end     
always @(address);
assign instruct=ml[address];
endmodule
