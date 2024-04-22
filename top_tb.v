`timescale 1ns / 1ns

module top_tb();
  
  reg clk = 0;
  
  CPU clk_CPU (.clk(clk));
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top_tb);
    repeat(1000) begin
      clk_CPU.instruction_q = $urandom;
      #1;
    end
    
    $finish;
  end
  
endmodule