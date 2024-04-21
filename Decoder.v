`timescale 1ns / 1ps
/*
Decoder Module

Takes a 32-bit instruction as input and drives each
of the output based on the Instruction Set Architecture
given in the project instructions
*/

module Decoder(
    input [31:0] inst, 
    output [2:0] opcode,
    output [4:0] reg_addr_0,
    output [4:0] reg_addr_1,
    output [4:0] reg_addr_2,
    output [15:0] addr
    );
    
    // Use assign statements to redirect parts of the instruction to output
    assign opcode = inst[31:29];
    assign reg_addr_0 = inst[28:24];
    
    assign addr = ((opcode == 3'b000) || (opcode == 3'b001)) ? (inst[15:0]): // if 0 or 1, 16bits
                  ((opcode == 3'b010) || (opcode == 3'b011)) ? ({1'b0,inst[14:0]}): // if 2 or 3, 15 bits
                  ((opcode == 3'b100) || (opcode == 3'b101) || (opcode == 3'b110) || (opcode == 3'b111)) ? ({2'b00,inst[13:0]}): // if 4,5,6 or 7, 14bits
                  16'b0; // default
                                                
    assign reg_addr_1 = ((opcode == 3'b000) || (opcode == 3'b001)) ? (inst[23:16]): // if 0 or 1, 8bits
                        ((opcode == 3'b010) || (opcode == 3'b011) || (opcode == 3'b100) || (opcode == 3'b101) || (opcode == 3'b110) || (opcode == 3'b111)) ? (inst[23:19]): // if 2, 3, 4, 5, 6, 7, 5bits
                        4'bX; // default unknown
    
    assign reg_addr_2 = ((opcode == 3'b000) || (opcode == 3'b001)) ? (inst[23:16]): // if 0 or 1, 8bits
                        ((opcode == 3'b100) || (opcode == 3'b101) || (opcode == 3'b110) || (opcode == 3'b111)) ? (inst[18:14]): // if 4, 5, 6, 7, 5bits
                        4'bX; // default unknown
endmodule