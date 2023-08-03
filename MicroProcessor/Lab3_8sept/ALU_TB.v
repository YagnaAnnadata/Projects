`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 08:13:40 PM
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB();

//Inputs
 reg[7:0] A,B;
 reg[3:0] ALU_Sel;

//Outputs
 wire[7:0] ALU_Out;
 wire CarryOut;
 wire neg;
 wire zero;
 wire overflow;
 // Verilog code for ALU
 ALU test_unit(
            A,B,  // ALU 8-bit Inputs                 
            ALU_Sel,// ALU Selection
            ALU_Out, // ALU 8-bit Output
            CarryOut, // Carry Out Flag
            zero,
            neg,
            overflow 
     );
    initial begin
    // hold reset state for 100 ns.
    
         
        A = 8'hf9;
      B = 8'h0a;
      ALU_Sel = 4'b0000;
      #50;
       
       A=8'h00;
      B=8'h19;
      ALU_Sel=4'b0011;
      #50;
      
      
      A = 8'h01;
      B = 4'h09;
      ALU_Sel = 4'b0000;
      #10;
      ALU_Sel = 4'b0001;
      #10;
      ALU_Sel = 4'b0010;
      #10;
      ALU_Sel = 4'b0011;
      #10;
      ALU_Sel = 4'b0100;
      #10;
      ALU_Sel = 4'b0101;
      #10;
      ALU_Sel = 4'b0110;
      #10;
      ALU_Sel = 4'b0111;
       #10;
       ALU_Sel = 4'b1000;
       #10;
       ALU_Sel = 4'b1001;
       #10;
       ALU_Sel = 4'b1010;
       #10;
       ALU_Sel = 4'b1011;
       #10;
       ALU_Sel = 4'b1100;
       #10;
        ALU_Sel = 4'b1101;
       #10;
      ALU_Sel = 4'b1110;
       #10;
       ALU_Sel = 4'b1111;
       #10;
      
    end
endmodule
