`timescale 1ns / 1ps

module Data_mem( input            clk,
                    input      [7:0] address, 
                    input            write,
                    input      [7:0] dataIn, 
                    output reg[7:0]mem[255:0],              
                    output wire [7:0] dataOut ); 
    reg[8:0] addr_reg;
    always @(posedge clk ) begin
        if(write)
            mem[address] = dataIn;
			else
				addr_reg <= address;
        
    end
	 assign dataOut = mem[address];
endmodule
