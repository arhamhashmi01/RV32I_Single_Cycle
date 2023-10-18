`include "program_counter.v"
module fetch (
    input wire clk,
    input wire rst,
    input wire next_sel,
    input wire valid,
    input wire branch_reselt,
    input wire [31:0] next_address,
    input wire [31:0] address_in,
    input wire [31:0] instruction_fetch,

    output wire we_re,
    output wire request,
    output wire [3:0] mask,
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

    assign mask = 4'b1111; 
    assign we_re = 1'b0;
    assign request = 1'b1;
    
    always @ (*) begin
        instruction = instruction_fetch ;
    end
endmodule