`timescale 1ns / 1ps

module RegisterFile_tb;

    // Inputs
    reg [4:0] read_address_0;
    reg [4:0] read_address_1;
    reg [15:0] write_address_0;
    reg write_en;
    reg [31:0] write_data;

    // Outputs
    wire [31:0] read_data_0;
    wire [31:0] read_data_1;

    // Instantiate the module under test
    RegisterFile dut (
        .read_address_0(read_address_0),
        .read_address_1(read_address_1),
        .write_address_0(write_address_0),
        .write_en(write_en),
        .write_data(write_data),
        .read_data_0(read_data_0),
        .read_data_1(read_data_1)
    );

    // Test stimulus
    initial begin
        // Test case 1: Write enable is low, expect read_data_0 and read_data_1 to remain unchanged
        read_address_0 = 5'b00000; // Address 0
        read_address_1 = 5'b00001; // Address 1
        write_address_0 = 16'b0000_0000_0000_0000; // Address 0
        write_en = 1'b0;
        #10; // Wait for 10 time units

        // Test case 2: Write enable is high, expect read_data_0 to reflect the written data
        read_address_0 = 5'b00000; // Address 0
        read_address_1 = 5'b00001; // Address 1
        write_address_0 = 16'b0000_0000_0000_0000; // Address 0
        write_en = 1'b1;
        #10; // Wait for 10 time units

        // Test case 3: Write to a different address, expect read_data_1 to remain unchanged
        read_address_0 = 5'b00000; // Address 0
        read_address_1 = 5'b00001; // Address 1
        write_address_0 = 16'b0000_0000_0000_0001; // Address 1
        write_en = 1'b1;
        #10; // Wait for 10 time units

        // Test case 4: Write to multiple addresses, expect read_data_0 and read_data_1 to reflect the latest writes
        read_address_0 = 5'b00000; // Address 0
        read_address_1 = 5'b00001; // Address 1
        write_address_0 = 16'b0000_0000_0000_0010; // Address 2
        write_data = 32'h87654321; // Data to be written
        write_en = 1'b1;
        #10; // Wait for 10 time units
        write_address_0 = 16'b0000_0000_0000_0011; // Address 3
        write_data = 32'hABCDEF01; // Data to be written
        #10; // Wait for 10 time units

        // End simulation
        $finish;
    end

endmodule
