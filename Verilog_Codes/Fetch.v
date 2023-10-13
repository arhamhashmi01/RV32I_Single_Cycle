`include "program_counter.v"
module fetch (
    input wire clk,
    input wire rst,
    input wire next_sel,
    input wire branch_reselt,
    input wire [31:0] next_address,
    input wire [31:0] address_in,
    input wire [31:0] instruction_fetch,

    output wire [31:0] address_out,
    output reg  [31:0] instruction
    );

    // PROGRAM COUNTER
    pc u_pc0 
    (
        .clk(clk),
        .rst(rst),
        .next_sel(next_sel),
        .next_address(next_address),
        .branch_reselt(branch_reselt),
        .address_in(0),
        .address_out(address_out)
    );

    always @ (*) begin 
        instruction = instruction_fetch ;
    end
endmodule