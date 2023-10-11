`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: washing_tb
//////////////////////////////////////////////////////////////////////////////////
module WB_TB();
 reg clk, reset; 
 reg [255:0] closedoor;
 reg [127:0] startmachine;
 reg [127:0] filledmachine;
 reg [127:0] detergentadded;
 reg [127:0] machinecycle_timeout;
 reg [127:0] waterdrained; 
 reg [127:0] spin_timeout_check;
 wire [127:0] doorlock_check;
 wire [127:0] motoron_check;
 wire [127:0] fillvalue_check;
 wire [127:0] drainvalue_check;
 wire [127:0] done;
 wire [127:0] detergent_wash;
 wire [127:0] checkwater_wash;
 
 washingmachine machine1(clk, reset, closedoor, startmachine, filledmachine, detergentadded,machinecycle_timeout, 
waterdrained, spin_timeout_check, doorlock_check, motoron_check, fillvalue_check, drainvalue_check, done,detergent_wash, 
checkwater_wash);
 initial
 begin
 clk = 8'b0;
 reset = 8'b1;
 startmachine = 8'b0;
 closedoor = 8'b0;
 filledmachine = 8'b0;
 waterdrained = 8'b0;
 detergentadded = 8'b0;
 machinecycle_timeout = 8'b0;
 spin_timeout_check = 8'b0;
 #10 reset=8'b0;
 #10 startmachine=8'b1;closedoor=8'b1;
 #20 filledmachine=8'b1;
 #20 detergentadded=8'b1;
 #20 machinecycle_timeout=8'b1;
 #20 waterdrained=8'b1;
 #20 spin_timeout_check=8'b1;
 end
 always
 begin
 #10 clk = ~clk;
 end
endmodule