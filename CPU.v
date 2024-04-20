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
    
     
    reg [15:0]  pc_q = 0;      // Program Counter
    reg [31:0]  instruction_q; // Holds instruction binary 
    reg [1:0]   state_q = 0;   // State of CPU
    
    // Instantiate decoder, Instruction Memory,
    // Data Memory, Register File and ALU
    Decoder u_decoder ()	    ;
   InstructionMemory u_InstructionMemory () ;
   DataMemory u_DataMemory ()		    ;
   RegisterFile u_RegisterFile()	    ;
   ALU u_ALU()				    ;
    
    reg [31:0] instruction;  // Output of instruction memory
    reg [31:0] read_data_0, read_data_1;  // Outputs of register file
    reg [31:0] write_data;
    reg [2:0] opcode;
    reg [4:0] reg_addr_0, reg_addr_1, reg_addr_2;
    reg [14:0] addr;
    reg [31:0] alu_result;
    reg change_pc;
    reg write_en;
  
   assign u_InstructionMemory.inst_address = pc_q; 
   assign u_decoder.inst = instruction_q; 
   assign u_ALU.ip_0 = reg_addr_0; 
   assign u_ALU.ip_1 = reg_addr_1; 
   assign u_ALU.opcode = opcode; 
   assign u_RegisterFile.write_address_0 = addr; 
   assign u_RegisterFile.write_data = alu_result; 
   assign u_RegisterFile.write_en = write_en;
           
    always@(posedge clk)
    begin
        if(state_q == 0) begin 
            write_en = 1'b0; // Fetch Stage
            instruction_q = u_InstructionMemory.read_data; // Read instruction from instruction memory
            pc_q = pc_q + 1; // increment PC
            state_q = 1; // increment state
        end else if(state_q == 1) begin  // Decode Stage       
            // Instruction Decode and read data from register/memory
            // store all data necessary for next stages in a register
            opcode        = u_decoder.opcode     ;	     // store all data necessary for next stages in a register
	        reg_addr_0    = u_decoder.reg_addr_0 ;
	        reg_addr_1    = u_decoder.reg_addr_1 ;
	        reg_addr_2    = u_decoder.reg_addr_2 ;
	        addr          = u_decoder.addr;
	        state_q = 2;  //update state
        end else if(state_q == 2) begin  // Execute Stage        
            // Perform ALU operations
            if (opcode == (3'd2||3'd3||3'd4||3'd5||3'd6||3'd7)) begin
            alu_result = u_ALU.op_0	 ;  
	    end
	    if(u_ALU.change_pc) begin
	       pc_q 	   = addr 		 		;  
   	    end
            state_q <= 3; //update state
        end else if(state_q == 3) begin  // Memory Stage
            // Access Memory and register file(for load)
            state_q <= 0;
            if(opcode == (3'b000 || 3'b001)) begin
               write_en = 1'b1;
            end
        end    
    end
    
endmodule
