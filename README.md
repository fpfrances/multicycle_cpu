# Multi-Cycle CPU Implementation in Verilog

### Project Description: Implement a simplified multi-cycle CPU with Verilog/SystemVerilog. The CPU is intended to execute arithmetic, memory, and control-related instructions, providing hands-on experience with a critical component of modern computer systems.


## Instruction Set Architecture:
The CPU can execute the following instructions:

## Memory Instructions:
- `lw`: Transfer a 32-bit value from memory to a register.
- `sw`: Write a 32-bit value from a register to memory.

## Control Instructions:
- `beq`: Branch when two register values are equal.
- `blt`: Branch if one register's value is less than another.

## Arithmetic Instructions:
- `add`: Perform the addition operation.
- `sub`: Perform a subtraction operation.
- `and`: Perform the bitwise AND operation.
- `or`: Perform the bitwise OR operation.


# CPU components:
The CPU consists of several Verilog modules:

** Memory: Uses a 256x32 bit single read/write port RAM.
** The Register File uses a 16x32 bit dual read/single write port RAM.
** Decoder: Uses Instruction Set Architecture to break down instructions into signals.
** ALU (Arithmetic Logic Unit): Performs arithmetic operations using opcodes.


## CPU Execution Stages: The CPU processes instructions in four stages:

1. Fetch: Reads a new instruction from memory and increments program counter.
2. Decode: Decodes instructions and generates execution signals. Reads operands from the register file.
3. Execute: Performs arithmetic operations and updates the register file. Changes the program counter to reflect branch operations.
4. Memory: Loads or stores data from register files and memory.


## Files Included:
`CPU.v`: Verilog module for the CPU top-level design.

`InstructionMemory.v`: Verilog module for the instruction memory component.

`DataMemory.v`: Verilog module for the data memory component.

`Decoder.v`: Verilog module for the decoder component.

`RegisterFile.v`: Verilog module for the register file component.

`ALU.v`: Verilog module for the ALU component.

`top_tb.v`: Top-level testbench for the entire CPU.

`InstMem_tb.v`: Testbench for the instruction memory component.

`DataMem_tb.v`: Testbench for the data memory component.

`Decoder_tb.v`: Testbench for the decoder component.

`Register_tb.v`: Testbench for the register file component.

`ALU_tb.v`: Testbench for the ALU component.

`README.md`: This file.


## Usage:
1. Simulate the CPU components using their respective testbenches to ensure individual functionality.
2. Simulate the entire CPU using the provided testbench for comprehensive testing of all instructions and execution stages.
3. Verify the waveform outputs to confirm correct behavior and performance.


## Contributors:
`Filipe Pestana Frances`
