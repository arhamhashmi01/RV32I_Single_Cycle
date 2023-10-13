`include "Core.v"
`include "instruction_memory.v"
`include "data_memory.v"
module microprocessor (
    input wire clk,
    input wire enable,
    input wire rst,
    input wire [31:0]instruction
    );

    wire [31:0] instruction_data;
    wire [31:0] pc_address;
    wire [31:0] load_data_out;
    wire [31:0] alu_out_address;
    wire [31:0] store_data;
    wire [3:0]  mask;
    wire store;

    // INSTRUCTION MEMORY
    instruction_memory u_instruction_mem0 (
        .clk(clk),
        .enable(enable),
        .address(pc_address[9:2]),
        .data_in(instruction),
        .data_out(instruction_data)
    );

    //CORE
    core u_core(
        .clk(clk),
        .rst(rst),
        .instruction(instruction_data),
        .load_data_in(load_data_out),
        .write(store),
        .mask_singal(mask),
        .store_data_out(store_data),
        .pc_address(pc_address),
        .alu_out_address(alu_out_address)
    );


    // DATA MEMORY
    datamemory u_data_mem0(
        .clk(clk),
        .mem_en(store),
        .address(alu_out_address[9:2]),
        .storein(store_data),
        .mask(mask),
        .loadout(load_data_out)
    );
endmodule