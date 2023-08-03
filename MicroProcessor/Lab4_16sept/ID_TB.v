`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2022 02:25:35 PM
// Design Name: 
// Module Name: ID_TB
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


module ID_TB();
    reg [16:0] instruct;

    wire RW;
    wire da;
    wire [1:0] mds;
    wire [1:0] bs;
    wire ps1;
    wire [2:0] mw;
    wire [3:0] fsel;
    wire mas;
    wire mbs;
    wire [2:0] regaa;
    wire [2:0] regba;
    wire consel;


    Instruction_Decoder uut (
        .instruct(instruct),
        .RW(RW),
        .da(da),
        .mds(mds),
        .bs(bs),
        .ps1(ps1),
        .mw(mw),
        .fsel(fsel),
        .mas(mas),
        .mbs(mbs),
        .regaa(regaa),
        .regba(regba),
        .consel(consel)
    );



   initial begin
        // Initialize Inputs
        instruct = 0;



       // Wait 100 ns for global reset to finish
        #50;
        instruct = 17'b00000xxxxxxxxxxxx;
        #50;
        instruct = 17'b00001001010xxxxxx;
        #50;
        instruct = 17'b00010001010011xxx;
        #50;
        instruct = 17'b00011001010011xxx;
        #50;
        instruct = 17'b01010xxx010xxxxxx;
        #50
        instruct = 17'b01011xxx010011xxx;
        #50;
        instruct = 17'b01100001010xxxxxx;
        #50;
        instruct = 17'b10000001xxxxxxxxx;
        #50
        instruct = 17'b10001001010011xxx;
        #50
        instruct = 17'b10010001010xxxxxx;
        #50
        instruct = 17'b10011001010xxxxxx;
        #50
        instruct = 17'b10101001010xxxxxx;
        #50
        instruct = 17'b10110001010xxxxxx;
        #50
        instruct = 17'b11001001010011xxx;
        #50
        instruct = 17'b11010001010xxxxxx;
        #50
        instruct = 17'b11011001010011xxx;
        #50
        instruct = 17'b11100xxx010xxxxxx;
        #50
        instruct = 17'b11101xxx010xxxxxx;
        #50
        instruct = 17'b11111001010011xxx;
 



   end
endmodule
