`timescale 1ns / 1ps
module Reg_f( input  clk,
                      input      [2:0] address_of_a,
                      input      [2:0] address_of_b,
                      input      [2:0] address_of_d,
                      input      [7:0] dataIn,
                      input            write,
                      output reg [7:0] data_of_a,
                      output reg [7:0] data_of_b );

    reg[7:0] registers[7:0];
    integer i;
    initial begin
        registers[0] = 8'b00000000;
    end
    always @(posedge clk ) begin
        if(write)begin
            if(address_of_d!= 0)
                registers[address_of_d] = dataIn;
        end
            data_of_a = registers[address_of_a];
            data_of_b = registers[address_of_b];
    end
endmodule 