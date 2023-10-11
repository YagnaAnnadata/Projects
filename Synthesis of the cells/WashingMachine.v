`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Module Name: washingmachine 
//////////////////////////////////////////////////////////////////////////////////
module washingmachine(clk, reset, closedoor, startmachine, filledmachine, detergentadded,machinecycle_timeout, 
waterdrained, spin_timeout_check, doorlock_check, motoron_check, fillvalue_check, drainvalue_check, done,
detergent_wash,checkwater_wash);
 input clk, reset;
 input  [255:0] closedoor;
 input [127:0] startmachine;
 input  [127:0] filledmachine;
 input [127:0] detergentadded;
 input  [127:0] machinecycle_timeout; 
 input [127:0] waterdrained;
 input  [127:0] spin_timeout_check;
 output reg [127:0] doorlock_check;
 output reg [127:0] motoron_check;
 output reg [127:0] fillvalue_check;
 output reg [127:0] drainvalue_check;
 output reg [127:0] done;
 output reg [127:0] detergent_wash;
 output reg [127:0] checkwater_wash;


 
 
 //defining the states
 
 parameter checkdoor = 3'b000;
 parameter fillwater = 3'b001;
 parameter detergentadder = 3'b010;
 parameter cycling = 3'b011;
 parameter waterdraining = 3'b100;
 parameter spinning = 3'b101;
 reg[2:0] currentstatecheck, nextstatecheck;
 
 always@(currentstatecheck or startmachine or closedoor or filledmachine or detergentadded or waterdrained or
 machinecycle_timeout or spin_timeout_check)
 begin
    case(currentstatecheck)
 
 //checking the door if it is locked and closed.
 //machine is started at this stage.
 checkdoor:
 if(startmachine==1'b1 && closedoor==1'b1)
 begin
 nextstatecheck = fillwater;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b0;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b0;
 detergent_wash = 1'b0;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 
 //Water is filled for soaking the clothes.
 fillwater:
 if (filledmachine==1'b1)
 begin
 if(detergent_wash == 1'b0)
 begin
 nextstatecheck = detergentadder;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 else
 begin
 nextstatecheck = cycling;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b0;
 fillvalue_check = 1'b1;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b0;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 //detergent/soap will be added.
 detergentadder:
 if(detergentadded==1'b1)
 begin
 nextstatecheck = cycling;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b0;
 done = 1'b0;
 end
 
 //Washing cycle for the cleaning the clothes
 cycling:
 if(machinecycle_timeout == 1'b1)
 begin
 nextstatecheck = waterdraining;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b1;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 
 //draining the water from wet clothes
 waterdraining:
 if(waterdrained==1'b1)
 begin
 if(checkwater_wash==1'b0)
 begin
 nextstatecheck = fillwater;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 else
 begin
 nextstatecheck = spinning;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 end 
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b1;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 
 //drying the clothes which are drained.
 spinning:
 if(spin_timeout_check==1'b1)
 begin
 nextstatecheck = checkdoor;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b1;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b1;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b0;
 end
 default:
 begin
 nextstatecheck = checkdoor;
 motoron_check = 1'b0;
 fillvalue_check = 1'b0;
 drainvalue_check = 1'b0;
 doorlock_check = 1'b1;
 detergent_wash = 1'b1;
 checkwater_wash = 1'b1;
 done = 1'b1;
 end
 endcase
 end
 always@(posedge clk or posedge reset)
 begin
 if(reset)
 begin
 currentstatecheck<=3'b000;
 end
 else
 begin
 currentstatecheck<=nextstatecheck;
 end
 end
endmodule