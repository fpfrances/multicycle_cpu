`timescale 1ns / 1ps

/*
CPU Module

Top Module for CPU.

*/

`include "Decoder.v"
`include "ALU.v"
`include "InstructionMemory.v"
`include "DataMemory.v"
`include "RegisterFile.v"

module CPU(
    input clk
    );
         
    reg [15:0] pc_q = 0;      // Program Counter
    reg [31:0] instruction_q; // Holds instruction binary 
    reg [1:0] state_q = 0;   // State of CPU
 
    // Instantiate decoder, Instruction Memory,
    // Data Memory, Register File and ALU
    Decoder u_decoder();
    InstructionMemory u_InstructionMemory();
    DataMemory u_DataMemory();
    RegisterFile u_RegisterFile();
    ALU u_Alu();
    
    reg [2:0] opcode;
    reg [4:0] reg_addr_0, reg_addr_1, reg_addr_2;
    reg [15:0] addr;
    reg [31:0] alu_result;
    reg write_enable_reg;
    reg write_en_memory;
    reg [31:0] mem_stage;

    assign u_InstructionMemory.inst_address = pc_q; 
    assign u_decoder.inst = instruction_q; 
    assign u_Alu.ip_0 = reg_addr_0;
    assign u_Alu.ip_1 = reg_addr_1; 
    assign u_Alu.opcode = opcode; 
    assign u_RegisterFile.write_address_0 = reg_addr_0;
    assign u_RegisterFile.write_data = alu_result;
    assign u_RegisterFile.write_en = write_enable_reg;
    assign u_DataMemory.data_address = addr;
    assign u_DataMemory.write_en = write_en_memory;
  
    always@(posedge clk)
    begin
        if(state_q == 0) begin 
            // Fetch Stage
            write_en_memory <= 0;
            write_enable_reg <= 0;
            instruction_q <= u_InstructionMemory.read_data; // Read instruction from instruction memory
            pc_q <= pc_q + 1;// increment PC
            state_q <= state_q + 1;// increment state
        end else if(state_q == 1) begin  
            // Decode Stage
            // Instruction Decode and read data from register/memory
            // store all data necessary for next stages in a register
            opcode <= u_decoder.opcode;  
            reg_addr_0 <= u_decoder.reg_addr_0;
	        reg_addr_1 <= u_decoder.reg_addr_1;
	        reg_addr_2 <= u_decoder.reg_addr_2;
	        addr <= u_decoder.addr;
            state_q <= 2;  //update state
        end else if(state_q == 2) begin  
            // Execute Stage        
            // Perform ALU operations
            if (opcode == 3'b100 || opcode == 3'b101 || opcode == 3'b110 || opcode == 3'b111) begin
                alu_result <= u_Alu.op_0;
         end
            if (opcode == 3'b010 || opcode == 3'b011) begin
                pc_q <= u_Alu.change_pc;
            end
            state_q <= 3; //update state
        end else if(state_q == 3) begin  
            // Memory Stage
            // Access Memory and register file(for load)
            if (opcode == 0) begin
                mem_stage <= u_DataMemory.read_data;
                write_enable_reg <= 1;
            end 
            if (opcode == 1) begin
                mem_stage = u_RegisterFile.read_data_0;
                #10;
                write_en_memory = 1;
           end
           state_q <= 0;
       end  
     end
endmodule