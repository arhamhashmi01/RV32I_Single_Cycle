# RV32I Fetch Stage Pipeline Processor with Synchronous Memory in Verilog

Welcome to the repository containing a synthesizable implementation of a RISC-V RV32I (32-bit Integer) processor's fetch stage pipeline written in Verilog. This project presents a comprehensive design that includes a synchronous memory module capable of handling control hazards and executing all types of instructions specified in the RV32I ISA.

## Overview
The RV32I processor is a RISC-V architecture-based design that adheres to the RV32I ISA, supporting integer arithmetic and logical operations, control flow instructions, and memory access operations. This project focuses specifically on the fetch stage of the processor's pipeline, responsible for fetching instructions from memory and preparing them for subsequent stages of execution.
## Features
# Fetch Stage Pipeline
**Multi-Stage Pipeline Architecture:** The fetch stage is part of a multi-stage pipeline architecture designed for efficient instruction processing.

**Instruction Fetching:** Fetches instructions from memory based on the program counter (PC) and prepares them for decoding and execution.

**Control Hazard Handling:** Implements mechanisms to handle control hazards, ensuring correct program execution even in the presence of branch and jump instructions.

# Synchronous Memory
**Synchronous Memory Module:** Includes a synchronous memory module designed to meet the timing requirements of the processor.

**Control Hazard Handling:** Incorporates techniques such as branch prediction or stall mechanisms to mitigate control hazards and maintain pipeline efficiency.

**Instruction Execution:** Supports the execution of all types of instructions specified in the RV32I ISA, including arithmetic, logical, control flow, and memory access instructions.

# Verilog Implementation
**Verilog HDL:** Developed entirely in Verilog Hardware Description Language (HDL) for synthesis on FPGA or ASIC platforms.

**Modular Design:** Organized into modular components for ease of understanding, scalability, and potential reuse in larger processor designs.

**Testbench:** Includes a comprehensive testbench for functional verification of the fetch stage processor implementation, including synchronous memory operation and hazard handling.

## Getting Started

To begin using or contributing to this project, follow these steps:

  **Clone the Repository:** git clone https://github.com/arhamhashmi01/RV32I_Single_Cycle.git.
  
  **Explore the Code:** Review the Verilog source files to understand the implementation details of the fetch stage processor and synchronous memory module.
  
  **Simulation:** Run simulations using the provided testbench to verify the functionality of the processor implementation, including memory operation and hazard handling.
  
  **Contribute:** Feel free to contribute enhancements, bug fixes, or additional features by submitting pull requests.
