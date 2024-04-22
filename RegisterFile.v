`timescale 1ns / 1ps

/*
RegisterFile Module

A 2-d register array with two read ports
and one write port
*/

module  RegisterFile(
    input [4:0] read_address_0,
    input [4:0] read_address_1,
    input [15:0] write_address_0,
    input write_en,
    input [31:0] write_data,
    output [31:0] read_data_0,
    output [31:0] read_data_1
    );
    
    reg [31:0] ram [255:0];
    integer i;
    
    // Initialize the entire ram to zero
    initial begin
        for(i = 0; i < 256; i = i + 1) begin
            ram[i] = 32'b0;
        end
    end

// Use assign statment to read data from ram 
// based on read_address_1 and assign it to 
// read_data_1. See example below   

    assign read_data_0 = ram[read_address_0];
    assign read_data_1 = ram[read_address_1];
    
    always @* begin
        if(write_en) begin
            // When write_en is high write the write_data 
            // to the ram based on address write_address_0
            ram[write_address_0] <= write_data;
        end
    end
    
endmodule