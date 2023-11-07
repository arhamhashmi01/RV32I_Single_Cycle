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
    wire load;
    wire store;
    wire next_sel;
    wire branch_result;
    wire [3:0] mask;
    wire [3:0] alu_control;
    wire [1:0] mem_to_reg;
    wire [31:0] op_b;
    wire [31:0] opa_mux_out;
    wire [31:0] opb_mux_out;
    wire [31:0] alu_res_out;
    wire [31:0] next_sel_address;
    wire [31:0] wrap_load_out;
    wire [31:0] rd_wb_data;

    //FETCH STAGE
    fetch u_fetchstage(
        .clk(clk),
        .rst(rst),
        .load(load),
        .next_sel(next_sel),
        .branch_reselt(branch_result),
        .next_address(alu_res_out),
        .instruction_fetch(instruction),
        .instruction(instruc_data_out),
        .address_in(0),
        .valid(data_mem_valid),
        .mask(instruc_mask_singal),
        .we_re(instruction_mem_we_re),
        .request(instruction_mem_request),
        .pre_address_pc(pre_address_pc),
        .address_out(pc_address)
    );


    //DECODE STAGE
    decode u_decodestage(
        .clk(clk),
        .rst(rst),
        .instruction(instruc_data_out),
        .pc_address(pre_address_pc),
        .rd_wb_data(rd_wb_data),
        .load(load),
        .store(store),
        .next_sel(next_sel),
        .mem_to_reg(mem_to_reg),
        .branch_result(branch_result),
        .opb_data(op_b),
        .alu_control(alu_control),
        .opa_mux_out(opa_mux_out),
        .opb_mux_out(opb_mux_out)
    );

    assign load_signal = load;

    //EXECUTE STAGE
    execute u_executestage(
        .a_i(opa_mux_out),
        .b_i(opb_mux_out),
        .pc_address(pre_address_pc),
        .alu_control(alu_control),
        .alu_res_out(alu_res_out),
        .next_sel_address(next_sel_address)
    );

    //MEMORY STAGE
    memory_stage u_memorystage(
        .rst(rst),
        .load(load),
        .store(store),
        .op_b(op_b),
        .instruction(instruc_data_out),
        .alu_out_address(alu_res_out),
        .wrap_load_in(load_data_in),
        .mask(mask),
        .valid(instruc_mem_valid),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .store_data_out(store_data_out),
        .wrap_load_out(wrap_load_out)
    );

    assign alu_out_address = alu_res_out ;
    assign mask_singal = mask ;

    //WRITE BACK STAGE
    write_back u_wbstage(
        .mem_to_reg(mem_to_reg),
        .alu_out(alu_res_out),
        .data_mem_out(wrap_load_out),
        .next_sel_address(next_sel_address),
        .rd_sel_mux_out(rd_wb_data)
    );
endmodule