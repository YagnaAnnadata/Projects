`timescale 1ns / 1ps
module Q1_project6_combi();

reg x1,y1,y2;
wire z,Y2,Y1;
simulation_Q1_p6 uut(.x1(x1),.y1(y1),.y2(y2),.z(z), .Y1(Y1),.Y2(Y2));
initial begin
x1 <= 0; y1 <= 0; y2 <= 0;
#50
x1 <= 0; y1 <= 1; y2 <= 0;
#50
x1 <= 0; y1 <= 1; y2 <= 1;
#50
x1 <= 1; y1 <= 0; y2 <= 1;
#50
$finish;
end
endmodule