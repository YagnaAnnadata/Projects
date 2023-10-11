`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Module Name: washingmachine 
//////////////////////////////////////////////////////////////////////////////////
module washingmachine(clk, reset, closedoor, startmachine, filledmachine, detergentadded,machinecycle_timeout, 
waterdrained, spin_timeout_check, doorlock_check, motoron_check, fillvalue_check, drainvalue_check, done,
detergent_wash, checkwater_wash);
 input clk, reset, closedoor, startmachine, filledmachine, detergentadded, machinecycle_timeout, 
waterdrained,spin_timeout_check;
 output reg doorlock_check, motoron_check, fillvalue_check, drainvalue_check, done, detergent_wash, checkwater_wash;
 
 
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
 if(startmachine==1 && closedoor==1)
 begin
 nextstatecheck = fillwater;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 0;
 checkwater_wash = 0;
 done = 0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 0;
 detergent_wash = 0;
 checkwater_wash = 0;
 done = 0;
 end
 
 //Water is filled for soaking the clothes.
 fillwater:
 if (filledmachine==1)
 begin
 if(detergent_wash == 0)
 begin
 nextstatecheck = detergentadder;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 0;
 done = 0;
 end
 else
 begin
 nextstatecheck = cycling;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 1;
 done = 0;
 end
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 0;
 fillvalue_check = 1;
 drainvalue_check = 0;
 doorlock_check = 1;
 done = 0;
 end
 //detergent/soap will be added.
 detergentadder:
 if(detergentadded==1)
 begin
 nextstatecheck = cycling;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 done = 0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 0;
 done = 0;
 end
 
 //Washing cycle for the cleaning the clothes
 cycling:
 if(machinecycle_timeout == 1)
 begin
 nextstatecheck = waterdraining;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 //detergent_wash = 1;
 done = 0;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 1;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 //detergent_wash = 1;
 done = 0;
 end
 
 //draining the water from wet clothes
 waterdraining:
 if(waterdrained==1)
 begin
 if(checkwater_wash==0)
 begin
 nextstatecheck = fillwater;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 //checkwater_wash = 1;
 done = 0;
 end
 else
 begin
 nextstatecheck = spinning;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 1;
 done = 0;
 end
 end 
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 1;
 doorlock_check = 1;
 detergent_wash = 1;
 //checkwater_wash = 1;
 done = 0;
 end
 
 //drying the clothes which are drained.
 spinning:
 if(spin_timeout_check==1)
 begin
 nextstatecheck = closedoor;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 0;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 1;
 done = 1;
 end
 else
 begin
 nextstatecheck = currentstatecheck;
 motoron_check = 0;
 fillvalue_check = 0;
 drainvalue_check = 1;
 doorlock_check = 1;
 detergent_wash = 1;
 checkwater_wash = 1;
 done = 0;
 end
 default:
 nextstatecheck = checkdoor;
 endcase
 end
 always@(posedge clk or negedge reset)
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