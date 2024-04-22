`timescale 1ns / 1ps
/*
Instruction Module

A 2-d register array with one read port
*/

module  InstructionMemory(
    input [15:0] inst_address,
    output [31:0] read_data
    );
    integer i;
    reg [31:0] ram [255:0];
    
    // Initialize Instructions in the memory for testing
   initial begin
       for (i = 0; i < 256; i = i + 1) begin
        ram[i] = i; //if run without the loop ram[i] = 0;
      end
        //ram[0] <= 32'b000_00000_00000000_0000000000000000; //Load register 0 with data[0]
        //ram[1] <= 32'b000_00001_00000000_0000000000000001; //Load register 1 with data[1]
        //ram[2] <= 32'b000_00100_00000000_0000000001100100; //Load register 4 with data[100]
        //ram[3] <= 32'b000_00011_00000000_0000000000000001; //Load register 3 with data[1]
        //ram[4] <= 32'b100_00000_00001_00000_00000000000000; //Register0 = register0 + register1
        //ram[5] <= 32'b001_00000_00000000_0000000000000010; //data[2] = register0;
        //ram[6] <= 32'b100_00001_00000_00001_00000000000000; //Register1 = register1 + register0
        //ram[7] <= 32'b001_00001_00000000_0000000000000011; //data[3] = register1;
        //ram[8] <= 32'b100_00010_00011_00010_00000000000000; //Register2 = register2 + register3
        //ram[9] <= 32'b011_00010_00100_0000_000000000000100;//Branch if R2 < R4 to address 4.
    end  
    
    // Assign statement to read ram based on inst_address
    assign read_data = ram[inst_address];
endmodule