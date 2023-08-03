`timescale 1ns / 1ps
//////Level 1 
module IF(
    input reset,
    input clk,
    input [7:0]BrA,
    input [7:0]RAA,
    input [16:0]IR,
    input [1:0]BS,
    input PS,
    input Zw,
    output reg [16:0]IRO,
    output reg [7:0]PC,
    output reg [7:0]PC_1
    );
    
    

always @(negedge clk)begin
    if (reset==1)
        PC<=0;
    else if (BS==3)
        PC<=BrA;
    else if (BS==2)
        PC<=RAA;
    else if ((BS==1)&(PS^Zw))
        PC<=BrA;
    else
        PC<=PC+1;
    PC_1<=PC+1;
    IRO<=IR;
end
endmodule
