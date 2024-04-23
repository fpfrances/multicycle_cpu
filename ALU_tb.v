`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [31:0] ip_0;
    reg [31:0] ip_1;
    reg [2:0] opcode;

    // Outputs
    wire [31:0] op_0;
    wire change_pc;

    // Instantiate the module under test
    ALU dut (
        .ip_0(ip_0),
        .ip_1(ip_1),
        .opcode(opcode),
        .op_0(op_0),
        .change_pc(change_pc)
    );

    // Test stimulus
    initial begin
        // Test case 1: Addition
        ip_0 = 32'h00000002;
        ip_1 = 32'h00000003;
        opcode = 3'b100; // Addition
        #5; // Wait for 5 time units

        // Test case 2: Subtraction
        ip_0 = 32'h00000003;
        ip_1 = 32'h00000001;
        opcode = 3'b101; // Subtraction
        #5; // Wait for 5 time units

        // Test case 3: Bitwise AND
        ip_0 = 32'h0000000F;
        ip_1 = 32'h00000003;
        opcode = 3'b110; // Bitwise AND
        #5; // Wait for 5 time units

        // Test case 4: Bitwise OR
        ip_0 = 32'h0000000F;
        ip_1 = 32'h00000003;
        opcode = 3'b111; // Bitwise OR
        #5; // Wait for 5 time units

        // Test case 5: Branch if equal (beq)
        ip_0 = 32'h00000003;
        ip_1 = 32'h00000003;
        opcode = 3'b010; // Branch if equal
        #5; // Wait for 5 time units

        // Test case 6: Branch if less than (blt)
        ip_0 = 32'h00000002;
        ip_1 = 32'h00000003;
        opcode = 3'b011; // Branch if less than
        #5; // Wait for 5 time units

        // End simulation
        $finish;
    end

endmodule