`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 08:09:48 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
                input [7:0] A,B,  // ALU 8-bit Inputs                 
           input [3:0] ALU_Sel,// ALU Selection
           output [7:0] ALU_Out, // ALU 8-bit Output
           output CarryOut, // Carry Out Flag
           output reg zero, neg,
				output reg overflow);
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    reg [9:0] temp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[8]; // Carryout flag
    always @(*)
    begin
    
    //reset flags
    neg=1'b0;
    zero=1'b0;
    overflow=1'b0;
        case(ALU_Sel)
        4'b0000: // Addition
        begin
        temp = A + B ;
            if(temp>8'b011111111)
            begin
                overflow=1'b1;
            end
            else
            begin
                overflow=1'b0;
            end
        ALU_Result = A + B ; 
        end
        4'b0001:
        begin // Subtraction 
            if (A<B)
            begin
               neg=1'b1;
            end
            else
            begin
               neg=1'b0;
           end 
           ALU_Result=A-B;
        end
           
        4'b0010: // Multiplication
        begin
           ALU_Result = A * B;
         end
           
        4'b0011: // Division
        begin
           ALU_Result = A/B;
          end
        4'b0100: // Logical shift left
           ALU_Result = A<<1;
         4'b0101: // Logical shift right
           ALU_Result = A>>1;
         4'b0110: // Rotate left
           ALU_Result = {A[6:0],A[7]};
         4'b0111: // Rotate right
           ALU_Result = {A[0],A[7:1]};
          4'b1000: //  Logical and 
           ALU_Result = A & B;
          4'b1001: //  Logical or
           ALU_Result = A | B;
          4'b1010: //  Logical xor 
           ALU_Result = A ^ B;
          4'b1011: //  Logical nor
           ALU_Result = ~(A | B);
          4'b1100: // Logical nand 
           ALU_Result = ~(A & B);
          4'b1101: // Logical xnor
           ALU_Result = ~(A ^ B);
          4'b1110: // Greater comparison
           ALU_Result = (A>B)?8'd1:8'd0 ;
          4'b1111: // Equal comparison   
            ALU_Result = (A==B)?8'd1:8'd0 ;
          default: ALU_Result = A + B; 
        endcase   
            if(ALU_Result==8'h00)
           begin
           zero=1'b1;
           end

           else
            begin
            zero=1'b0;

            end      
    end    
endmodule
