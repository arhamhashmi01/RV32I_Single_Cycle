`include "type_decoder.v"
`include "control_decoder.v"
module controlunit (
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire fun7,

    output wire reg_write,
    output wire [1:0]imm_sel,
    output wire operand_b,
    output wire operand_a,
    output wire mem_to_reg,
    output wire Load,
    output wire Store,
    output wire Branch,
    output wire mem_en,
    output wire [3:0] alu_control
);

wire r_type;
wire i_type;
wire load;
wire store;

type_decoder u_typedec0 (
    .opcode(opcode),
    .r_type(r_type),
    .i_type(i_type),
    .load(load),
    .branch(branch),
    .jal(jal),
    .store(store)
);

control_decoder u_controldec0 (
    .fun3(fun3),
    .fun7(fun7),
    .i_type(i_type),
    .r_type(r_type),
    .load(load),
    .store(store),
    .branch(branch),
    .jal(jal),
    .next_sel(next_sel),
    .Branch(Branch),
    .Load(Load),
    .Store(Store),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .mem_en(mem_en),
    .operand_b(operand_b),
    .operand_a(operand_a),
    .imm_sel(imm_sel),
    .alu_control(alu_control)
);

endmodule