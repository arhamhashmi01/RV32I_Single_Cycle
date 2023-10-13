`include "wrapper_memory.v"
module memory (
    input wire load,
    input wire store,
    input wire [31:0] op_b,
    input wire [31:0] alu_out_address,
    input wire [31:0] instruction,
    input wire [31:0] wrap_load_in,

    output wire [3:0]  mask,
    output wire [31:0] store_data_out,
    output wire [31:0] wrap_load_out
    );

    // WRAPPER MEMORY
    wrappermem u_wrap_mem0 (
        .data_i(op_b),
        .byteadd(alu_out_address [1:0]),
        .fun3(instruction [14:12]),
        .mem_en(store),
        .Load(load),
        .wrap_load_in(wrap_load_in),
        .masking(mask),
        .data_o(store_data_out),
        .wrap_load_out(wrap_load_out)
    );
endmodule