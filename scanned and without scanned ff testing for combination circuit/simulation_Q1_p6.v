`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2023 05:01:26 PM
// Design Name: 
// Module Name: simulation_Q1_p6
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


module simulation_Q1_p6(x1,z,y1,y2,Y1,Y2);
input x1,y1,y2;
output z,Y1,Y2;

wire c1,c2,c3,c4,c5,y1,y2;

assign c1= ~y1;
assign c2= ~y2;
assign c4= (c1&x1&c2);
assign c3= (y1&x1&y2);
assign c5= (c4|c3);
assign Y1 = c5;
assign Y2 = y1;
assign z= (y1|y2);

endmodule
