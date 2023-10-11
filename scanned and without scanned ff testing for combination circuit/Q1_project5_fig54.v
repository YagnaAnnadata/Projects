`timescale 1ns / 1ps
module Q1_project5_fig54(x1,z,clk );
input x1,clk;
output z;

wire c1,c2,c3,c4,c5,y1,y2;

GTECH_NOT (y1,c1);
GTECH_NOT (y2,c2);
GTECH_AND3 (c1,x1,c2,c4);
GTECH_AND3 (y1,x1,y2,c3);
GTECH_OR2 (c4,c3,c5);
GTECH_FD1 (c5,clk,y1);
GTECH_FD1 (y1,clk,y2);
GTECH_OR2 (y1,y2,z);

endmodule
