`timescale 1ns / 1ps

module InstructionMemory_tb;

    // Signals
    reg [7:0] inst_address;
    wire [31:0] read_data;

    // Instantiate the module under test
    InstructionMemory dut (
        .inst_address(inst_address),
        .read_data(read_data)
    );

    // Clock generation
    reg clk;
    always #1 clk = ~clk;

    // Test stimulus
    initial begin
    // Load initial values into the memory
     dut.load_initial_values;

    // Test stimulus
        // Initialize address
        inst_address = 8'h00; // Start from address 0
        
        // Apply stimuli and monitor outputs
        repeat (50) begin
            #5; // Wait for one time unit
            
            // Increment address for next cycle
            inst_address = inst_address + 1;
        end

        // End simulation
        $finish;
    end

endmodule