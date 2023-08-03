module regfile_tb();
                      reg  clk;
                      reg      [2:0] address_of_a;
                      reg      [2:0] address_of_b;
                      reg      [2:0] address_of_d;
                      reg      [7:0] dataIn;
                      reg            write;
                      wire [7:0] data_of_a;
                      wire [7:0] data_of_b;
                      
Reg_f uut(.clk(clk), .address_of_a(address_of_a), .address_of_b(address_of_b), .address_of_d(address_of_d), .dataIn(dataIn), .write(write), 
.data_of_a(data_of_a), .data_of_b(data_of_b));
 
 always #5 clk = ~clk;
 initial 
 begin
 write=0;
 address_of_a=0;
 address_of_b=0;
 address_of_d=0;
 dataIn=0;
 clk=1;
  #20
  write=0;
 address_of_a=0;
 address_of_b=0;
 #20
    write=1;
    address_of_d=1;
    dataIn=4;
    #20
  write=0;
    address_of_a=1;
    address_of_b=1;
 #20
    write=1;
    address_of_d=2;
    dataIn=15;
  #20
  write=0;
    address_of_a=2;
    address_of_b=1;
  #20
  
    write=1;
    address_of_d=3;
    dataIn=1;
    #20
  write=0;
    address_of_a=3;
    address_of_b=1; 
    
 #20
    write=1;
    address_of_d=4;
    dataIn=4;
    #20
  write=0;
    address_of_a=4;
    address_of_b=1;
    
#100 $finish;
end
endmodule