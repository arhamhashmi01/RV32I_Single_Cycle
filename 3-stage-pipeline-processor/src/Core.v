module core (
    input wire clk,
    input wire rst,
    input wire data_mem_valid,
    input wire instruc_mem_valid,
    input wire [31:0] instruction,
    input wire [31:0] load_data_in,

    output wire load_signal,
    output wire instruction_mem_we_re,
    output wire instruction_mem_request,
    output wire data_mem_we_re,
    output wire data_mem_request,
    output wire [3:0]  mask_singal,
    output wire [3:0]  instruc_mask_singal,
    output wire [31:0] store_data_out,
    output wire [31:0] alu_out_address,
    output wire [31:0] pc_address
    );

    wire [31:0] instruc_data_out;
    wire [31:0] pre_address_pc;
    wire [31:0] instruction_fetch , instruction_decode , instruction_execute;
    wire [31:0] pre_pc_addr_fetch , pre_pc_addr_decode , pre_pc_addr_execute;
    wire load_decode , load_execute;
    wire store_decode , store_execute;
    wire jalr_decode;
    wire next_sel_decode , next_sel_execute;
    wire reg_write_decode , reg_write_execute;
    wire branch_result_decode , branch_result_execute;
    wire [3:0] mask;
    wire [3:0] alu_control_decode , alu_control_execute;
    wire [1:0] mem_to_reg_decode , mem_to_reg_execute;
    wire [31:0] op_b_decode , op_b_execute;
    wire [31:0] opa_mux_out_decode , opa_mux_out_execute;
    wire [31:0] opb_mux_out_decode , opb_mux_out_execute;
    wire [31:0] alu_res_out_execute;
    wire [31:0] next_sel_address_execute;
    wire [31:0] wrap_load_out;
    wire [31:0] rd_wb_data;

    //FETCH STAGE
    fetch u_fetchstage(
        .clk(clk),
        .rst(rst),
        .load(load_decode),
        .jalr(jalr_execute),
        .next_sel(next_sel_execute),
        .branch_reselt(branch_result_execute),
        .next_address(alu_res_out_execute),
        .instruction_fetch(instruction),
        .instruction(instruction_fetch),
        .address_in(0),
        .valid(data_mem_valid),
        .mask(instruc_mask_singal),
        .we_re(instruction_mem_we_re),
        .request(instruction_mem_request),
        .pre_address_pc(pre_pc_addr_fetch),
        .address_out(pc_address)
    );

    //FETCH STAGE PIPELINE
    fetch_pipe u_fetchpipeline(
        .clk(clk),
        .pre_address_pc(pre_pc_addr_fetch),
        .instruction_fetch(instruction_fetch),
        .pre_address_out(pre_pc_addr_decode),
        .instruction(instruction_decode),
        .next_select(next_sel_decode),
        .branch_result(branch_result_decode),
        .jalr(jalr_decode),
        .load(load_decode)
    );

    //DECODE STAGE
    decode u_decodestage(
        .clk(clk),
        .rst(rst),
        .valid(data_mem_valid),
        .load_control_signal(load_execute),
        .reg_write_en_in(reg_write_execute),
        .instruction(instruction_decode),
        .pc_address(pre_pc_addr_decode),
        .rd_wb_data(rd_wb_data),
        .load(load_decode),
        .store(store_decode),
        .jalr(jalr_decode),
        .next_sel(next_sel_decode),
        .reg_write_en_out(reg_write_decode),
        .mem_to_reg(mem_to_reg_decode),
        .branch_result(branch_result_decode),
        .opb_data(op_b_decode),
        .instruction_rd(instruction_execute),
        .alu_control(alu_control_decode),
        .opa_mux_out(opa_mux_out_decode),
        .opb_mux_out(opb_mux_out_decode)
    );

    //DECODE STAGE PIPELINE
    decode_pipe u_decodepipeline(
        .clk(clk),
        .load_in(load_decode),
        .store_in(store_decode),
        .jalr_in(jalr_decode),
        .next_sel_in(next_sel_decode),
        .mem_to_reg_in(mem_to_reg_decode),
        .branch_result_in(branch_result_decode),
        .opb_data_in(op_b_decode),
        .alu_control_in(alu_control_decode),
        .opa_mux_in(opa_mux_out_decode),
        .opb_mux_in(opb_mux_out_decode),
        .pre_address_in(pre_pc_addr_decode),
        .instruction_in(instruction_decode),
        .reg_write_in(reg_write_decode),
        .reg_write_out(reg_write_execute),
        .jalr_out(jalr_execute),
        .load(load_execute),
        .store(store_execute),
        .next_sel(next_sel_execute),
        .mem_to_reg(mem_to_reg_execute),
        .branch_result(branch_result_execute),
        .opb_data_out(op_b_execute),
        .alu_control(alu_control_execute),
        .opa_mux_out(opa_mux_out_execute),
        .opb_mux_out(opb_mux_out_execute),
        .pre_address_out(pre_pc_addr_execute),
        .instruction_out(instruction_execute)
    );

    assign load_signal = load_execute;

    //EXECUTE STAGE
    execute u_executestage(
        .a_i(opa_mux_out_execute),
        .b_i(opb_mux_out_execute),
        .pc_address(pre_pc_addr_execute),
        .alu_control(alu_control_execute),
        .alu_res_out(alu_res_out_execute),
        .next_sel_address(next_sel_address_execute)
    );

    //MEMORY STAGE
    memory_stage u_memorystage(
        .rst(rst),
        .load(load_execute),
        .store(store_execute),
        .op_b(op_b_execute),
        .instruction(instruction_execute),
        .alu_out_address(alu_res_out_execute),
        .wrap_load_in(load_data_in),
        .mask(mask),
        .data_valid(data_mem_valid),
        .valid(instruc_mem_valid),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .store_data_out(store_data_out),
        .wrap_load_out(wrap_load_out)
    );

    assign alu_out_address = alu_res_out_execute;
    assign mask_singal = mask ;

    //WRITE BACK STAGE
    write_back u_wbstage(
        .mem_to_reg(mem_to_reg_execute),
        .alu_out(alu_res_out_execute),
        .data_mem_out(wrap_load_out),
        .next_sel_address(next_sel_address_execute),
        .rd_sel_mux_out(rd_wb_data)
    );
endmodule