`timescale 1ns / 1ps
module MEM(
    input clk,
    input MW,//memory write
    input [7:0]MEA,//memory address
    input [7:0]MWD,//momory write data
    output [7:0]MRD//memory read data
    );
    
    reg [7:0] regi [255:0];
    assign MRD= regi[MEA];
    always @ (posedge clk) begin
        if (MW)
            regi[MEA]<=MWD;        
        regi[0]<=0;
    end
endmodule
