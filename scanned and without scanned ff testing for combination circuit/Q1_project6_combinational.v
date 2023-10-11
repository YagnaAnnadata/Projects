`timescale 1ns / 1ps
module Q1_project6_combinational(x1,z,y1,y2,Y1,Y2);
input x1,y1,y2;
output z,Y1,Y2;

wire c1,c2,c3,c4,c5;

GTECH_NOT (y1,c1);
GTECH_NOT (y2,c2);
GTECH_AND3 (c1,x1,c2,c4);
GTECH_AND3 (y1,x1,y2,c3);
GTECH_OR2 (c4,c3,c5);
assign Y1 = c5;
assign Y2 = y1;
GTECH_OR2 (y1,y2,z);

endmodule