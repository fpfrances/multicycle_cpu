`timescale 1ns / 1ps

module Decoder_tb;

    // Inputs
    reg [31:0] inst;

    // Outputs
    wire [2:0] opcode;
    wire [4:0] reg_addr_0;
    wire [4:0] reg_addr_1;
    wire [4:0] reg_addr_2;
    wire [15:0] addr;

    // Instantiate the module under test
    Decoder dut (
        .inst(inst),
        .opcode(opcode),
        .reg_addr_0(reg_addr_0),
        .reg_addr_1(reg_addr_1),
        .reg_addr_2(reg_addr_2),
        .addr(addr)
    );

    // Test stimulus
    initial begin
        // Test case 1: opcode = 0, addr = 16 bits, reg_addr_0 = 8 bits, reg_addr_1 = 8 bits, reg_addr_2 = unknown
        inst = 32'b000_0000_0000_0000_0000_0000_0000_0000;
        #5; // Wait for 10 time units
        
        // Test case 2: opcode = 1, addr = 16 bits, reg_addr_0 = 8 bits, reg_addr_1 = 8 bits, reg_addr_2 = unknown
        inst = 32'b001_0000_0000_0000_0000_0000_0000_0000;
        #5; // Wait for 10 time units
        
        // Test case 3: opcode = 2, addr = 15 bits, reg_addr_0 = 5 bits, reg_addr_1 = 8 bits, reg_addr_2 = unknown
        inst = 32'b010_0_0000_0000_0000_0000_0000_0000_0000;
        #5; // Wait for 10 time units

        // Test case 4: opcode = 4, addr = 14 bits, reg_addr_0 = unknown, reg_addr_1 = 5 bits, reg_addr_2 = 5 bits
        inst = 32'b100_00_0000_0000_0000_0000_0000_0000_0000;
        #5; // Wait for 10 time units

        // End simulation
        $finish;
    end

endmodule