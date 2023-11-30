module execute_pipe(
  input wire clk,
  input wire [31:0] alu_res,
  input wire [31:0] next_sel_addr,

  output wire [31:0] alu_res_out,
  output wire [31:0] next_sel_address
  );

  reg [31:0] alu_result , nextsel_addr;

  always @ (posedge clk) begin
    alu_result <= alu_res;
    nextsel_addr <= next_sel_addr;
  end

  assign alu_res_out = alu_result;
  assign next_sel_address = nextsel_addr;
endmodule