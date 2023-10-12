`include "control_unit.v"
`include "mux1_2.v"
`include "mux2_4.v"
`include "mux3_8.v"
`include "alu.v"
`include "register_file.v"
`include "immediate_gen.v"
`include "instruction_memory.v"
`include "program_counter.v"
`include "data_memory.v"
`include "wrapper_memory.v"
`include "branch.v"
`include "adder.v"
module microprocessor (
    input wire clk,
    input wire en,
    input wire rst,
    input wire [31:0]instruction
    );

    wire [31:0] data;
    wire [31:0] i_immo;
    wire [31:0] s_immo;
    wire [31:0] sb_immo,uj_immo,u_immo;
    wire reg_write;
    wire [2:0] imm_sel;
    wire [1:0] mem_to_reg;
    wire mem_en;
    wire loaden,branchen;
    wire operand_b,operand_a,result;
    wire out_sel;
    wire next_sel;
    wire [31:0] next_sel_address;
    wire [3:0] mmaask;
    wire [3:0] alu_control;
    wire [31:0] op_a, op_b, out, outz,res_o;
    wire [31:0] inadd, outadd, m2out;
    wire [31:0] dmout,dmin, wlout,m3data;

        // PROGRAM COUNTER
    pc u_pc0 
    (
        .clk(clk),
        .rst(rst),
        .next_sel(next_sel),
        .next_address(res_o),
        .address_in(0),
        .address_out(inadd)
    );


        // INSTRUCTION MEMORY
    instructionmemory u_instruc_mem0 (
        .clk(clk),
        .enable(en),
        .address(inadd[9:2]),
        .data_in(instruction),
        .data_out(data)
    );


        // IMMEDIATE GENERATOR
    immediategen u_imm_gen0 (
        .instr(data),
        .i_imme(i_immo),
        .sb_imme(sb_immo),
        .s_imme(s_immo),
        .uj_imme(uj_immo),
        .u_imme(u_immo)
    );

        // CONTROL UNIT
    controlunit u_cu0 
    (
        .opcode(data[6:0]),
        .fun3(data[14:12]),
        .fun7(data[30]),
        .reg_write(reg_write),
        .imm_sel(imm_sel),
        .next_sel(next_sel),
        .operand_b(operand_b),
        .operand_a(operand_a),
        .mem_to_reg(mem_to_reg),
        .Load(loaden),
        .Store(Store),
        .Branch(branchen),
        .mem_en(mem_en),
        .alu_control(alu_control)
    );

        // REGISTER FILE
    registerfile u_regfile0 
    (
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .rs1(data[19:15]),
        .rs2(data[24:20]),
        .rd(data[11:7]),
        .data(m3data),
        .op_a(op_a),
        .op_b(op_b)
    );

        //IMMEDIATE GENERTAOR
    mux3_8 u_mux0(
        .a(i_immo),
        .b(s_immo),
        .c(sb_immo),
        .d(uj_immo),
        .e(u_immo),
        .sel(imm_sel),
        .out(m2out)
    );

    // OPERAND B OR IMMEDIATE     
    mux u_mux1(
        .a(op_b),
        .b(m2out),
        .sel(operand_b),
        .out(out)
    );

    //PROGRAM COUNTER OR OPERAND A
    mux u_mux4 
    (
        .a(op_a),
        .b(inadd),
        .sel(operand_a),
        .out(outz)
    );
        // ALU
    alu u_alu0 
    (
        .a_i(outz),
        .b_i(out),
        .op_i(alu_control),
        .res_o(res_o)
    );
        //adder
    adder u_adder0(
        .a(inadd),
        .adder_out(next_sel_address)
    );
        
        //BRANCH
    branch u_branch0(
        .en(branchen),
        .op_a(op_a),
        .op_b(op_b),
        .fun3(data[14:12]),
        .result(result)
    );

       //WRAPPER MEMORY MUX
    mux2_4 u_mux2 (
        .a(res_o),
        .b(wlout),
        .c(next_sel_address),
        .sel(mem_to_reg),
        .out(m3data)
    );  

        // WRAPPER MEMORY
    wrappermem u_wrap_mem0 (
        .data_i(op_b),
        .byteadd(res_o[1:0]),
        .fun3(data[14:12]),
        .mem_en(mem_en),
        .Load(loaden),
        .wrap_load_in(dmout),
        .masking(mmaask),
        .data_o(dmin),
        .wrap_load_out(wlout)
    );
        // DATA MEMORY
    datamemory u_data_mem0(
        .clk(clk),
        .mem_en(mem_en),
        .address(res_o[9:2]),
        .storein(dmin),
        .mask(mmaask),
        .loadout(dmout)
    );

endmodule