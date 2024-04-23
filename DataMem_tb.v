`timescale 1ns / 1ps

module DataMemory_tb;

    // Inputs
    reg [14:0] data_address;
    reg write_en;
    reg [31:0] write_data;

    // Outputs
    wire [31:0] read_data;

    // Instantiate the module under test
    DataMemory dut (
        .data_address(data_address),
        .write_en(write_en),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Test stimulus
    initial begin
        // Test case 1: Write enable is low, expect read_data to remain unchanged
        data_address = 8'h00; // Address 0
        write_en = 1'b0;
        write_data = 32'h12345678; // Data to be written
        #10; // Wait for 10 time units
        
        // Test case 2: Write enable is high, expect read_data to reflect the written data
        data_address = 8'h00; // Address 0
        write_en = 1'b1;
        write_data = 32'h12345678; // Data to be written
        #10; // Wait for 10 time units
        
        // Test case 3: Write to a different address, expect read_data to remain unchanged
        data_address = 8'h01; // Address 1
        write_en = 1'b1;
        write_data = 32'h87654321; // Data to be written
        #10; // Wait for 10 time units
        
        // Test case 4: Write to multiple addresses, expect read_data to reflect the latest write
        data_address = 8'h02; // Address 2
        write_en = 1'b1;
        write_data = 32'hABCDEF01; // Data to be written
        #10; // Wait for 10 time units
        data_address = 8'h03; // Address 3
        write_data = 32'h98765432; // Data to be written
        #10; // Wait for 10 time units
        
        // Test case 5: Write enable is low, expect read_data to remain unchanged
        data_address = 8'h04; // Address 4
        write_en = 1'b0;
        write_data = 32'hFFFFFFFF; // Data to be written
        #10; // Wait for 10 time units
        
        // End simulation
        $finish;
    end

endmodule