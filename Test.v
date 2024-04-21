`timescale 1ns / 1ps

`include "CPU.v"

module Test(
      );
    reg clk = 0;
    CPU u_cpu(clk);
    
    always #10 clk=~clk;
    
endmodule

